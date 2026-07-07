package controller.member;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;

import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dto.member.MemberDTO;
import dto.member.MembershipRegistrationDTO;
import dto.member.PaymentDTO;
import dto.member.TossDTO;
import dto.common.TrainerDTO;
import dto.common.UserDTO;
import util.MybatisSqlSessionFactory;

@WebServlet("/member/paymentSuccess")
public class PaymentSuccessController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String TOSS_SECRET_KEY = "test_sk_Ba5PzR0ArnB5zP0Dd4jGrvmYnNeD";

    private static final double FEE_RATE = 0.10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("loginUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/member/login");
            return;
        }

        String paymentKey = req.getParameter("paymentKey");
        String orderId    = req.getParameter("orderId");
        String amountStr  = req.getParameter("amount");

        if (paymentKey == null || orderId == null || amountStr == null) {

            req.setAttribute("errorMsg", "결제 승인에 필요한 값이 없습니다.");

            req.getRequestDispatcher("/member/paymentSuccess.jsp")
                    .forward(req, resp);

            return;
        }

        if (!orderId.startsWith("PT-")) {

            resp.sendRedirect(req.getContextPath() + "/member/main");

            return;
        }

        // PT-{trainerId}-{count}-{trainerType}-{timestamp}
        String[] parts = orderId.split("-", 5);

        if (parts.length < 5) {

            req.setAttribute("errorMsg", "잘못된 주문 ID 형식입니다.");

            req.getRequestDispatcher("/member/paymentSuccess.jsp")
                    .forward(req, resp);

            return;
        }

        int trainerId;
        int sessionCount;
        String trainerType;
        double amount;

        try {

            trainerId    = Integer.parseInt(parts[1]);
            sessionCount = Integer.parseInt(parts[2]);
            trainerType  = parts[3];
            amount       = Double.parseDouble(amountStr);

        } catch (Exception e) {

            req.setAttribute("errorMsg", "주문 정보 파싱 실패");

            req.getRequestDispatcher("/member/paymentSuccess.jsp")
                    .forward(req, resp);

            return;
        }

        // ==========================
        // 토스 결제 승인 API
        // ==========================

        JSONObject approveResult;

        try {

            approveResult =
                    confirmTossPayment(
                            paymentKey,
                            orderId,
                            amountStr
                    );

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute(
                    "errorMsg",
                    "토스 결제 승인 실패 : " + e.getMessage()
            );

            req.getRequestDispatcher("/member/paymentSuccess.jsp")
                    .forward(req, resp);

            return;
        }

        String status = approveResult.optString("status");

        if (!"DONE".equals(status)) {

            req.setAttribute(
                    "errorMsg",
                    "결제가 승인되지 않았습니다."
            );

            req.setAttribute(
                    "tossResponse",
                    approveResult.toString()
            );

            req.getRequestDispatcher("/member/paymentSuccess.jsp")
                    .forward(req, resp);

            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("loginUser");

        int userId = user.getId();

        String userName =
                user.getName() != null
                        ? user.getName()
                        : user.getNickname();

        double fee =
                Math.round(amount * FEE_RATE * 100.0) / 100.0;

        TrainerDTO trainer = null;

        SqlSession sql = null;

        try {

            sql =
                    MybatisSqlSessionFactory
                            .getSqlSessionFactory()
                            .openSession();

            // ==========================
            // MEMBER 조회
            // ==========================

            MemberDTO memberDto =
                    sql.selectOne(
                            "mapper.MemberMapper.findByUserId",
                            userId
                    );

            if (memberDto == null) {

                req.setAttribute(
                        "errorMsg",
                        "회원 정보를 찾을 수 없습니다."
                );

                req.getRequestDispatcher("/member/paymentSuccess.jsp")
                        .forward(req, resp);

                return;
            }

            int memberId = memberDto.getId();

            // ==========================
            // 트레이너 조회
            // ==========================

            Map<String, Object> trainerMap =
                    sql.selectOne(
                            "mapper.TrainerMapper.findById",
                            trainerId
                    );

            if (trainerMap != null) {

                trainer = new TrainerDTO();

                trainer.setId(trainerId);

                if (trainerMap.get("name") != null) {

                    trainer.setName(
                            String.valueOf(
                                    trainerMap.get("name")
                            )
                    );
                }

                if (trainerMap.get("gym_id") != null) {

                    trainer.setGymId(
                            ((Number) trainerMap.get("gym_id"))
                                    .intValue()
                    );
                }
            }

            // ==========================
            // gym/trainer 분기
            // ==========================

            Integer mpGymId     = null;
            Integer mpTrainerId = null;

            switch (trainerType) {

                case "GYM_EMPLOYED":
                case "GYM_RENTAL":

                    mpGymId =
                            (trainer != null
                                    && trainer.getGymId() != null
                                    && trainer.getGymId() > 0)
                                    ? trainer.getGymId()
                                    : null;

                    mpTrainerId = trainerId;

                    break;

                case "FREELANCE":
                default:

                    mpGymId = null;
                    mpTrainerId = trainerId;

                    break;
            }

            // ==========================
            // TOSS 저장
            // ==========================

            TossDTO tossDto = new TossDTO();

            tossDto.setUserId(userId);

            tossDto.setPaymentKey(paymentKey);

            tossDto.setOrderId(orderId);

            tossDto.setAmount((long) amount);

            tossDto.setStatus(status);

            sql.insert(
                    "mapper.TossMapper.insert",
                    tossDto
            );

            // ==========================
            // membership_id 조회
            // FK 문제 해결
            // ==========================

            Map<String, Object> param =
                    new HashMap<>();

            param.put("trainerId", trainerId);

            param.put("sessionCount", sessionCount);

            Integer membershipId =
                    sql.selectOne(
                            "mapper.MembershipMapper.findByTrainerAndCount",
                            param
                    );

            if (membershipId == null) {

                throw new RuntimeException(
                        "membership 테이블에 일치하는 이용권이 없습니다."
                );
            }

            // ==========================
            // MEMBERSHIP_PT 저장
            // ==========================

            MembershipRegistrationDTO mpDto =
                    new MembershipRegistrationDTO();

            mpDto.setMemberId(memberId);

            mpDto.setMembershipId(membershipId);

            mpDto.setGymId(mpGymId);

            mpDto.setTrainerId(mpTrainerId);

            mpDto.setRegisterDate(
                    LocalDate.now().toString()
            );

            mpDto.setStartDate(
                    LocalDate.now().toString()
            );

            mpDto.setEndDate(
                    LocalDate.now()
                            .plusMonths(3)
                            .toString()
            );

            mpDto.setStatus("active");

            mpDto.setLessonCount(sessionCount);

            sql.insert(
                    "mapper.MembershipMapper.insertRegistration",
                    mpDto
            );

            // ==========================
            // PAYMENT 저장
            // ==========================

            PaymentDTO payment = new PaymentDTO();

            payment.setUserId(userId);

            payment.setUserName(userName);

            payment.setTrainerId(mpTrainerId);

            payment.setGymId(mpGymId);

            payment.setMpId(mpDto.getId());

            payment.setPaymentPrice(amount);

            payment.setPaymentFee(fee);

            payment.setMethod("카드");

            payment.setStatus("결제완료");

            payment.setPaymentType("PT");

            sql.insert(
                    "mapper.PaymentMapper.insert",
                    payment
            );

            sql.commit();

            // ==========================
            // 세션 갱신
            // ==========================

            MemberDAO memberDao =
                    new MemberDAOImpl();

            Map<String, Object> freshMember =
                    memberDao.findByEmail(
                            user.getEmail()
                    );

            if (freshMember != null) {

                session.setAttribute(
                        "memberInfo",
                        freshMember
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            if (sql != null) {
                sql.rollback();
            }

            req.setAttribute(
                    "errorMsg",
                    "DB 저장 중 오류 발생 : "
                            + e.getMessage()
            );

            req.getRequestDispatcher("/member/paymentSuccess.jsp")
                    .forward(req, resp);

            return;

        } finally {

            if (sql != null) {
                sql.close();
            }
        }

        req.setAttribute(
                "trainerName",
                trainer != null
                        ? trainer.getName()
                        : "트레이너"
        );

        req.setAttribute(
                "sessionCount",
                sessionCount
        );

        req.setAttribute(
                "amount",
                (long) amount
        );

        req.setAttribute(
                "fee",
                (long) fee
        );

        req.setAttribute(
                "trainerType",
                trainerType
        );

        req.getRequestDispatcher("/member/paymentSuccess.jsp")
                .forward(req, resp);
    }

    // ==========================
    // 토스 결제 승인 API
    // ==========================

    private JSONObject confirmTossPayment(
            String paymentKey,
            String orderId,
            String amount
    ) throws Exception {

        URL url =
                new URL(
                        "https://api.tosspayments.com/v1/payments/confirm"
                );

        HttpURLConnection conn =
                (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");

        conn.setRequestProperty(
                "Authorization",
                getBasicToken()
        );

        conn.setRequestProperty(
                "Content-Type",
                "application/json"
        );

        conn.setDoOutput(true);

        JSONObject body =
                new JSONObject();

        body.put("paymentKey", paymentKey);

        body.put("orderId", orderId);

        body.put(
                "amount",
                Integer.parseInt(amount)
        );

        try (OutputStream os =
                     conn.getOutputStream()) {

            byte[] input =
                    body.toString()
                            .getBytes(StandardCharsets.UTF_8);

            os.write(input, 0, input.length);
        }

        int responseCode =
                conn.getResponseCode();

        InputStream is =
                (responseCode >= 200
                        && responseCode < 300)
                        ? conn.getInputStream()
                        : conn.getErrorStream();

        BufferedReader br =
                new BufferedReader(
                        new InputStreamReader(
                                is,
                                StandardCharsets.UTF_8
                        )
                );

        StringBuilder sb =
                new StringBuilder();

        String line;

        while ((line = br.readLine()) != null) {

            sb.append(line.trim());
        }

        JSONObject result =
                new JSONObject(sb.toString());

        if (responseCode != 200) {

            throw new RuntimeException(
                    result.toString()
            );
        }

        return result;
    }

    // ==========================
    // 토스 인증 토큰
    // ==========================

    private String getBasicToken() {

        String auth =
                TOSS_SECRET_KEY + ":";

        return "Basic "
                + Base64.getEncoder()
                .encodeToString(
                        auth.getBytes(StandardCharsets.UTF_8)
                );
    }
}