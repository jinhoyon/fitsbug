package controller.trainer;

import dto.gym.Gym;
import dto.trainer.PayoutAccountDTO;
import dto.trainer.TrainerDTO;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/trainer/signup/step3")
public class SignupController3 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pendingTrainerUserId") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/signup");
            return;
        }

        int userId = (int) session.getAttribute("pendingTrainerUserId");
        TrainerService trainerService = new TrainerServiceImpl();
        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);
        if (trainer != null) {
            PayoutAccountDTO payout = trainerService.getPayoutAccountByTrainerId(trainer.getTrainerId());
            if (payout != null) {
                request.setAttribute("prefillPayout", payout);
            }
        }

        request.getRequestDispatcher("/trainer/signup3.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("pendingTrainerUserId") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/signup");
            return;
        }

        int userId = (int) session.getAttribute("pendingTrainerUserId");

        // Resolve the final trainer_type from the two-level radio selection
        String baseType = request.getParameter("baseType");
        String trainerType;

        if ("FREELANCE".equals(baseType)) {
            trainerType = request.getParameter("freelanceType"); // FREELANCE_BUSINESS or FREELANCE_INDIVIDUAL
        } else {
            trainerType = request.getParameter("gymType"); // GYM_EMPLOYEE, GYM_COMMISSION, GYM_RENTAL
        }

        String gymCode                = request.getParameter("gymCode");
        String commissionRateStr      = request.getParameter("commissionRate");
        String businessRegistrationNum = request.getParameter("businessRegistrationNum");
        String residentRegistrationNum = request.getParameter("residentRegistrationNum");
        String bankName               = request.getParameter("bankName");
        String accountNumber          = request.getParameter("accountNumber");

        // Look up trainer record to get trainerId
        TrainerService trainerService = new TrainerServiceImpl();
        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);

        if (trainer == null) {
            request.setAttribute("error", "트레이너 정보를 찾을 수 없습니다.");
            request.getRequestDispatcher("/trainer/signup3.jsp").forward(request, response);
            return;
        }

        PayoutAccountDTO payout = new PayoutAccountDTO();
        payout.setTrainerId(trainer.getTrainerId());
        payout.setTrainerType(trainerType);

        // Map granular payout type → display trainer_type on the trainer record
        // GYM_RENTAL operates independently (own business, rents space) — different from employed
        String displayTrainerType;
        if ("GYM_RENTAL".equals(trainerType)) {
            displayTrainerType = "GYM_RENTAL";
        } else if (trainerType != null && trainerType.startsWith("GYM_")) {
            displayTrainerType = "GYM_EMPLOYED";
        } else {
            displayTrainerType = "FREELANCE";
        }
        trainer.setTrainerType(displayTrainerType);

        // Resolve gym_code → gym_id for gym-associated types
        if (gymCode != null && !gymCode.isEmpty()) {
            Integer gymId = trainerService.findGymIdByGymCode(gymCode);
            if (gymId == null) {
                request.setAttribute("error", "유효하지 않은 헬스장 코드입니다.");
                request.getRequestDispatcher("/trainer/signup3.jsp").forward(request, response);
                return;
            }
            payout.setGymId(gymId);

            // Set gym_id on trainer record and copy gym's location
            trainer.setGymId(gymId);
            Gym gym = trainerService.getGymInfoById(gymId);
            if (gym != null) {
                trainer.setAddress(gym.getAddress());
                trainer.setAddressDetail(gym.getAddressDetail());
                trainer.setPostcode(gym.getPostcode());
                if (gym.getLatitude() != null) {
                    trainer.setLatitude(new BigDecimal(gym.getLatitude().toString()));
                }
                if (gym.getLongitude() != null) {
                    trainer.setLongitude(new BigDecimal(gym.getLongitude().toString()));
                }
            }
        }
        if ("GYM_COMMISSION".equals(trainerType) && commissionRateStr != null && !commissionRateStr.isEmpty()) {
            payout.setCommissionRate(new BigDecimal(commissionRateStr));
        }

        // Identity fields — also copy business_registration_num to trainer table for verification badge
        if ("FREELANCE_BUSINESS".equals(trainerType) && businessRegistrationNum != null && !businessRegistrationNum.isEmpty()) {
            payout.setBusinessRegistrationNum(businessRegistrationNum);
            trainer.setBusinessRegistrationNum(businessRegistrationNum);
        }
        if ("FREELANCE_INDIVIDUAL".equals(trainerType) && residentRegistrationNum != null && !residentRegistrationNum.isEmpty()) {
            payout.setResidentRegistrationNum(residentRegistrationNum);
        }

        // Persist trainer profile changes (type, gym_id, address, business_registration_num)
        trainerService.updateTrainer(trainer);

        payout.setBankName(bankName);
        payout.setAccountNumber(accountNumber);

        try {
            trainerService.replacePayoutAccount(payout);
            response.sendRedirect(request.getContextPath() + "/trainer/signup/step4");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "정산 정보 저장에 실패했습니다.");
            request.getRequestDispatcher("/trainer/signup3.jsp").forward(request, response);
        }
    }
}
