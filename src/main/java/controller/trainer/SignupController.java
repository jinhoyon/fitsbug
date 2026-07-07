package controller.trainer;

import dto.common.AvailabilityDTO;
import dto.common.Gym;
import dto.common.PayoutAccountDTO;
import dto.common.PricingDTO;
import dto.common.TrainerDTO;
import dto.common.UserDTO;
import service.trainer.SignupService;
import service.trainer.SignupServiceImpl;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;
import util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(urlPatterns = {
        "/trainer/signup",
        "/trainer/signup/step2",
        "/trainer/signup/step3",
        "/trainer/signup/step4",
        "/trainer/signup/step5"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class SignupController extends HttpServlet {

    private static final String SESSION_PENDING_USER = "pendingTrainerUserId";

    private String uploadDir;
    private final SignupService signupService = new SignupServiceImpl();
    private final TrainerService trainerService = new TrainerServiceImpl();

    @Override
    public void init() {
        uploadDir = getServletContext().getRealPath("/uploads");
        new File(uploadDir).mkdirs();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (resolveStep(request)) {
            case 1:
                doGetStep1(request, response);
                break;
            case 2:
                doGetStep2(request, response);
                break;
            case 3:
                doGetStep3(request, response);
                break;
            case 4:
                doGetStep4(request, response);
                break;
            case 5:
                doGetStep5(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (resolveStep(request)) {
            case 1:
                doPostStep1(request, response);
                break;
            case 2:
                doPostStep2(request, response);
                break;
            case 3:
                doPostStep3(request, response);
                break;
            case 4:
                doPostStep4(request, response);
                break;
            case 5:
                doPostStep5(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private int resolveStep(HttpServletRequest request) {
        String path = request.getServletPath();
        if ("/trainer/signup".equals(path)) {
            return 1;
        }
        if (path.endsWith("/step2")) {
            return 2;
        }
        if (path.endsWith("/step3")) {
            return 3;
        }
        if (path.endsWith("/step4")) {
            return 4;
        }
        if (path.endsWith("/step5")) {
            return 5;
        }
        return 0;
    }

    private Integer requirePendingUserId(HttpSession session) {
        if (session == null) {
            return null;
        }
        Object value = session.getAttribute(SESSION_PENDING_USER);
        if (value instanceof Integer) {
            return (Integer) value;
        }
        return null;
    }

    private void redirectToStep1(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/trainer/signup");
    }

    // ── Step 1: account credentials ─────────────────────────────────────────

    private void doGetStep1(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute(SESSION_PENDING_USER) != null) {
            int userId = (int) session.getAttribute(SESSION_PENDING_USER);
            UserDTO existing = signupService.getUserById(userId);
            if (existing != null) {
                request.setAttribute("prefill", existing);
            }
        }
        request.getRequestDispatcher("/trainer/signup.jsp").forward(request, response);
    }

    private void doPostStep1(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) {
            email = request.getParameter("emailId");
        }
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String nickname = request.getParameter("nickname");
        int age = 0;
        try {
            age = Integer.parseInt(request.getParameter("age"));
        } catch (Exception ignored) {
        }
        String gender = request.getParameter("gender");
        String provider = request.getParameter("provider");
        String providerId = request.getParameter("providerId");
        if (provider != null && provider.isEmpty()) {
            provider = null;
        }
        if (providerId != null && providerId.isEmpty()) {
            providerId = null;
        }

        UserDTO dto = new UserDTO();
        dto.setName(name);
        dto.setEmail(email);
        dto.setPassword(PasswordUtil.hash(password));
        dto.setPhone(phone);
        dto.setNickname(nickname);
        dto.setAge(age);
        dto.setGender(gender);
        dto.setRole("TRAINER");
        dto.setProvider(provider);
        dto.setProviderId(providerId);

        HttpSession session = request.getSession();
        Integer existingUserId = (Integer) session.getAttribute(SESSION_PENDING_USER);

        try {
            if (existingUserId != null) {
                dto.setId(existingUserId);
                signupService.updateUser(dto);
            } else {
                int result = signupService.signupTrainer(dto);
                if (result <= 0) {
                    request.setAttribute("error", "회원가입 실패");
                    request.getRequestDispatcher("/trainer/signup.jsp").forward(request, response);
                    return;
                }
                session.setAttribute(SESSION_PENDING_USER, dto.getId());
            }
            response.sendRedirect(request.getContextPath() + "/trainer/signup/step2");
        } catch (Exception e) {
            e.printStackTrace();
            String cause = e.getMessage() != null ? e.getMessage() : "";
            if (cause.contains("Duplicate entry") || cause.contains("1062")) {
                request.setAttribute("isDuplicate", true);
                request.setAttribute("error", "이미 사용 중인 이메일입니다. 다른 이메일을 사용하거나 로그인해 주세요.");
            } else {
                request.setAttribute("error", "서버 오류로 회원가입에 실패했습니다. 잠시 후 다시 시도해 주세요.");
            }
            request.getRequestDispatcher("/trainer/signup.jsp").forward(request, response);
        }
    }

    // ── Step 2: profile, tags, image ────────────────────────────────────────

    private void doGetStep2(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = requirePendingUserId(request.getSession(false));
        if (userId == null) {
            redirectToStep1(request, response);
            return;
        }

        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);
        if (trainer != null) {
            request.setAttribute("prefillTrainer", trainer);
            request.setAttribute("prefillSpecs", trainerService.getSpecializationsByTrainerId(trainer.getTrainerId()));
            request.setAttribute("prefillTraits", trainerService.getTraitsByTrainerId(trainer.getTrainerId()));
        }
        request.getRequestDispatcher("/trainer/signup2.jsp").forward(request, response);
    }

    private void doPostStep2(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Integer userId = requirePendingUserId(request.getSession(false));
        if (userId == null) {
            redirectToStep1(request, response);
            return;
        }

        String description = request.getParameter("description");
        String[] specializations = request.getParameterValues("specializations");
        String[] traits = request.getParameterValues("traits");
        if (specializations == null) {
            specializations = new String[0];
        }
        if (traits == null) {
            traits = new String[0];
        }

        String fileName = null;
        Part filePart = request.getPart("profileImage");
        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            filePart.write(uploadDir + File.separator + fileName);
        }

        TrainerDTO trainer = new TrainerDTO();
        trainer.setUserId(userId);
        trainer.setDescription(description);

        try {
            trainerService.updateProfileWithTagsAndImage(trainer, specializations, traits, fileName);
            response.sendRedirect(request.getContextPath() + "/trainer/signup/step3");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "프로필 저장에 실패했습니다.");
            request.getRequestDispatcher("/trainer/signup2.jsp").forward(request, response);
        }
    }

    // ── Step 3: payout / trainer type ───────────────────────────────────────

    private void doGetStep3(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = requirePendingUserId(request.getSession(false));
        if (userId == null) {
            redirectToStep1(request, response);
            return;
        }

        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);
        if (trainer != null) {
            PayoutAccountDTO payout = trainerService.getPayoutAccountByTrainerId(trainer.getTrainerId());
            if (payout != null) {
                request.setAttribute("prefillPayout", payout);
            }
        }
        request.getRequestDispatcher("/trainer/signup3.jsp").forward(request, response);
    }

    private void doPostStep3(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Integer userId = requirePendingUserId(request.getSession(false));
        if (userId == null) {
            redirectToStep1(request, response);
            return;
        }

        String baseType = request.getParameter("baseType");
        String trainerType;
        if ("FREELANCE".equals(baseType)) {
            trainerType = request.getParameter("freelanceType");
        } else {
            trainerType = request.getParameter("gymType");
        }

        String gymCode = request.getParameter("gymCode");
        String commissionRateStr = request.getParameter("commissionRate");
        String businessRegistrationNum = request.getParameter("businessRegistrationNum");
        String residentRegistrationNum = request.getParameter("residentRegistrationNum");
        String bankName = request.getParameter("bankName");
        String accountNumber = request.getParameter("accountNumber");

        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);
        if (trainer == null) {
            request.setAttribute("error", "트레이너 정보를 찾을 수 없습니다.");
            request.getRequestDispatcher("/trainer/signup3.jsp").forward(request, response);
            return;
        }

        PayoutAccountDTO payout = new PayoutAccountDTO();
        payout.setTrainerId(trainer.getTrainerId());
        payout.setTrainerType(trainerType);

        String displayTrainerType;
        if ("GYM_RENTAL".equals(trainerType)) {
            displayTrainerType = "GYM_RENTAL";
        } else if (trainerType != null && trainerType.startsWith("GYM_")) {
            displayTrainerType = "GYM_EMPLOYED";
        } else {
            displayTrainerType = "FREELANCE";
        }
        trainer.setTrainerType(displayTrainerType);

        if (gymCode != null && !gymCode.isEmpty()) {
            Integer gymId = trainerService.findGymIdByGymCode(gymCode);
            if (gymId == null) {
                request.setAttribute("error", "유효하지 않은 헬스장 코드입니다.");
                request.getRequestDispatcher("/trainer/signup3.jsp").forward(request, response);
                return;
            }
            payout.setGymId(gymId);
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
        if ("FREELANCE_BUSINESS".equals(trainerType) && businessRegistrationNum != null && !businessRegistrationNum.isEmpty()) {
            payout.setBusinessRegistrationNum(businessRegistrationNum);
            trainer.setBusinessRegistrationNum(businessRegistrationNum);
        }
        if ("FREELANCE_INDIVIDUAL".equals(trainerType) && residentRegistrationNum != null && !residentRegistrationNum.isEmpty()) {
            payout.setResidentRegistrationNum(residentRegistrationNum);
        }

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

    // ── Step 4: certifications ──────────────────────────────────────────────

    private void doGetStep4(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (requirePendingUserId(request.getSession(false)) == null) {
            redirectToStep1(request, response);
            return;
        }
        request.getRequestDispatcher("/trainer/signup4.jsp").forward(request, response);
    }

    private void doPostStep4(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Integer userId = requirePendingUserId(request.getSession(false));
        if (userId == null) {
            redirectToStep1(request, response);
            return;
        }

        String[] certNames = request.getParameterValues("certName");
        String[] issuingOrgs = request.getParameterValues("issuingOrg");
        String[] issueDates = request.getParameterValues("issueDate");
        String[] expiryDates = request.getParameterValues("expiryDate");

        List<Part> fileParts = new ArrayList<>();
        for (Part part : request.getParts()) {
            if ("certFile".equals(part.getName())) {
                fileParts.add(part);
            }
        }

        String[] fileNames = new String[certNames == null ? 0 : certNames.length];
        for (int i = 0; i < fileNames.length; i++) {
            if (i < fileParts.size()) {
                Part part = fileParts.get(i);
                if (part.getSize() > 0) {
                    String original = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String saved = "cert_" + userId + "_" + i + "_" + original;
                    part.write(uploadDir + File.separator + saved);
                    fileNames[i] = saved;
                }
            }
        }

        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);
        try {
            if (certNames != null && certNames.length > 0) {
                trainerService.insertCertifications(
                        trainer.getTrainerId(), certNames, issuingOrgs, issueDates, expiryDates, fileNames);
            }
            response.sendRedirect(request.getContextPath() + "/trainer/signup/step5");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "자격증 저장에 실패했습니다. 다시 시도해 주세요.");
            request.getRequestDispatcher("/trainer/signup4.jsp").forward(request, response);
        }
    }

    // ── Step 5: pricing and availability ──────────────────────────────────────

    private void doGetStep5(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (requirePendingUserId(request.getSession(false)) == null) {
            redirectToStep1(request, response);
            return;
        }
        request.getRequestDispatcher("/trainer/signup5.jsp").forward(request, response);
    }

    private void doPostStep5(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Integer userId = requirePendingUserId(session);
        if (userId == null) {
            redirectToStep1(request, response);
            return;
        }

        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);
        try {
            String[] labels = request.getParameterValues("pricingLabel");
            String[] sessionCounts = request.getParameterValues("sessionCount");
            String[] prices = request.getParameterValues("price");
            String[] popularRows = request.getParameterValues("popularRow");

            Set<String> popularSet = new HashSet<>();
            if (popularRows != null) {
                Collections.addAll(popularSet, popularRows);
            }

            List<PricingDTO> pricingList = new ArrayList<>();
            if (labels != null) {
                for (int i = 0; i < labels.length; i++) {
                    if (labels[i] == null || labels[i].trim().isEmpty()) {
                        continue;
                    }
                    PricingDTO p = new PricingDTO();
                    p.setLabel(labels[i].trim());
                    p.setSessionCount(parseIntSafe(sessionCounts, i, 1));
                    p.setPrice(parseIntSafe(prices, i, 0));
                    p.setPopular(popularSet.contains(String.valueOf(i)));
                    pricingList.add(p);
                }
            }

            String[] allDays = {"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"};
            List<AvailabilityDTO> availabilityList = new ArrayList<>();
            for (String day : allDays) {
                if (request.getParameter("availEnabled_" + day) != null) {
                    AvailabilityDTO a = new AvailabilityDTO();
                    a.setDayOfWeek(day);
                    String start = request.getParameter("startTime_" + day);
                    String end = request.getParameter("endTime_" + day);
                    a.setStartTime(start != null && !start.isEmpty() ? start : "09:00");
                    a.setEndTime(end != null && !end.isEmpty() ? end : "18:00");
                    availabilityList.add(a);
                }
            }

            trainerService.savePricingAndAvailability(trainer.getTrainerId(), pricingList, availabilityList);
            session.removeAttribute(SESSION_PENDING_USER);
            response.sendRedirect(request.getContextPath() + "/trainer/login");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "저장에 실패했습니다. 다시 시도해 주세요.");
            request.getRequestDispatcher("/trainer/signup5.jsp").forward(request, response);
        }
    }

    private int parseIntSafe(String[] arr, int i, int defaultVal) {
        if (arr == null || i >= arr.length || arr[i] == null || arr[i].isEmpty()) {
            return defaultVal;
        }
        try {
            return Integer.parseInt(arr[i]);
        } catch (NumberFormatException e) {
            return defaultVal;
        }
    }
}
