package controller.trainer;

import dto.trainer.AvailabilityDTO;
import dto.trainer.PricingDTO;
import dto.trainer.TrainerDTO;
import dto.common.UserDTO;
import service.trainer.SignupService;
import service.trainer.SignupServiceImpl;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet("/trainer/profileEdit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 1024 * 1024 * 10,
        maxRequestSize    = 1024 * 1024 * 50
)
public class ProfileEditController extends HttpServlet {

    private String uploadDir;

    @Override
    public void init() {
        uploadDir = getServletContext().getRealPath("/uploads");
        new File(uploadDir).mkdirs();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        TrainerService trainerService = new TrainerServiceImpl();

        if (trainer != null) {
            int tid = trainer.getTrainerId();
            request.setAttribute("trainer", trainer);
            request.setAttribute("specializations",  trainerService.getSpecializationsByTrainerId(tid));
            request.setAttribute("traits",           trainerService.getTraitsByTrainerId(tid));
            request.setAttribute("certifications",   trainerService.getCertificationsByTrainerId(tid));
            request.setAttribute("pricingList",      trainerService.getPricingByTrainerId(tid));
            request.setAttribute("availabilityList", trainerService.getAvailabilityByTrainerId(tid));
            if (trainer.getGymId() != null) {
                dto.gym.Gym currentGym = trainerService.getGymInfoById(trainer.getGymId());
                request.setAttribute("currentGym", currentGym);
            }
        }

        request.getRequestDispatcher("/trainer/profileEdit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginTrainer") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/login");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        TrainerDTO trainer = (TrainerDTO) session.getAttribute("loginTrainer");
        TrainerService trainerService = new TrainerServiceImpl();

        if (trainer == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/profile");
            return;
        }

        try {
            // 1. Update user basic info (name, phone, nickname, age, gender)
            int age = 0;
            try { age = Integer.parseInt(request.getParameter("age")); } catch (Exception ignored) {}
            String gender = request.getParameter("gender");

            UserDTO userUpdate = new UserDTO();
            userUpdate.setId(loginUser.getId());
            userUpdate.setName(request.getParameter("name"));
            userUpdate.setPhone(request.getParameter("phone"));
            userUpdate.setNickname(request.getParameter("nickname"));
            userUpdate.setAge(age);
            userUpdate.setGender(gender);

            SignupService signupService = new SignupServiceImpl();
            signupService.updateUserProfile(userUpdate);

            // Refresh session with updated user info
            loginUser.setName(userUpdate.getName());
            loginUser.setPhone(userUpdate.getPhone());
            loginUser.setNickname(userUpdate.getNickname());
            loginUser.setAge(age);
            loginUser.setGender(gender);

            // 2. Handle profile image upload
            Part profileImagePart = request.getPart("profileImage");
            String profileImageFileName = null;
            if (profileImagePart != null && profileImagePart.getSize() > 0) {
                String original = Paths.get(profileImagePart.getSubmittedFileName()).getFileName().toString();
                profileImageFileName = "profile_" + loginUser.getId() + "_" + original;
                profileImagePart.write(uploadDir + File.separator + profileImageFileName);
                loginUser.setProfileImg(profileImageFileName);
            }

            // 3. Update trainer type, gym, address, description
            String trainerType = request.getParameter("trainerType");
            if (trainerType != null && !trainerType.isEmpty()) {
                trainer.setTrainerType(trainerType);
            }

            trainer.setDescription(request.getParameter("description"));

            String gymCode = request.getParameter("gymCode");
            boolean isGymBased = "GYM_EMPLOYED".equals(trainerType) || "GYM_RENTAL".equals(trainerType);

            if (isGymBased && gymCode != null && !gymCode.trim().isEmpty()) {
                Integer newGymId = trainerService.findGymIdByGymCode(gymCode.trim());
                if (newGymId == null) {
                    request.setAttribute("error", "유효하지 않은 헬스장 코드입니다. 다시 확인해 주세요.");
                    request.setAttribute("trainer", trainer);
                    int tid = trainer.getTrainerId();
                    request.setAttribute("specializations", trainerService.getSpecializationsByTrainerId(tid));
                    request.setAttribute("traits",          trainerService.getTraitsByTrainerId(tid));
                    request.setAttribute("certifications",  trainerService.getCertificationsByTrainerId(tid));
                    if (trainer.getGymId() != null)
                        request.setAttribute("currentGym", trainerService.getGymInfoById(trainer.getGymId()));
                    request.getRequestDispatcher("/trainer/profileEdit.jsp").forward(request, response);
                    return;
                }
                trainer.setGymId(newGymId);
                // Copy gym address + coordinates onto trainer record
                dto.gym.Gym gym = trainerService.getGymInfoById(newGymId);
                if (gym != null) {
                    trainer.setAddress(gym.getAddress());
                    trainer.setAddressDetail(gym.getAddressDetail());
                    trainer.setPostcode(gym.getPostcode());
                    trainer.setLatitude(gym.getLatitude());
                    trainer.setLongitude(gym.getLongitude());
                }
            } else if (isGymBased) {
                // Gym-based but no new code entered — carry existing lat/lng from hidden inputs
                String lat = request.getParameter("latitude");
                String lng = request.getParameter("longitude");
                if (lat != null && !lat.isEmpty()) trainer.setLatitude(new java.math.BigDecimal(lat));
                if (lng != null && !lng.isEmpty()) trainer.setLongitude(new java.math.BigDecimal(lng));
            } else {
                // Freelance — use trainer's own address and clear gym
                trainer.setGymId(null);
                trainer.setLatitude(null);
                trainer.setLongitude(null);
                trainer.setAddress(request.getParameter("address"));
                trainer.setAddressDetail(request.getParameter("addressDetail"));
            }
            String[] specializations = request.getParameterValues("specializations");
            String[] traits = request.getParameterValues("traits");
            if (specializations == null) specializations = new String[0];
            if (traits == null) traits = new String[0];

            trainerService.updateProfileWithTagsAndImage(trainer, specializations, traits, profileImageFileName);

            // 4. Update certifications
            String[] certNames   = request.getParameterValues("certName");
            String[] issuingOrgs = request.getParameterValues("issuingOrg");
            String[] issueDates  = request.getParameterValues("issueDate");
            String[] expiryDates = request.getParameterValues("expiryDate");

            List<Part> fileParts = new ArrayList<>();
            Collection<Part> allParts = request.getParts();
            for (Part part : allParts) {
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
                        String saved = "cert_" + loginUser.getId() + "_" + i + "_" + original;
                        part.write(uploadDir + File.separator + saved);
                        fileNames[i] = saved;
                    }
                }
            }

            if (certNames != null && certNames.length > 0) {
                trainerService.insertCertifications(
                        trainer.getTrainerId(), certNames, issuingOrgs, issueDates, expiryDates, fileNames);
            } else {
                trainerService.insertCertifications(trainer.getTrainerId(), new String[0], null, null, null, null);
            }

            // 5. Save pricing
            String[] pricingLabels = request.getParameterValues("pricingLabel");
            String[] sessionCounts = request.getParameterValues("sessionCount");
            String[] pricePrices   = request.getParameterValues("price");
            String[] popularRows   = request.getParameterValues("popularRow");

            Set<String> popularSet = new HashSet<>();
            if (popularRows != null) {
                for (String r : popularRows) popularSet.add(r);
            }

            List<PricingDTO> pricingList = new ArrayList<>();
            if (pricingLabels != null) {
                for (int i = 0; i < pricingLabels.length; i++) {
                    if (pricingLabels[i] == null || pricingLabels[i].trim().isEmpty()) continue;
                    PricingDTO p = new PricingDTO();
                    p.setLabel(pricingLabels[i].trim());
                    p.setSessionCount(parseIntSafe(sessionCounts, i, 1));
                    p.setPrice(parseIntSafe(pricePrices, i, 0));
                    p.setPopular(popularSet.contains(String.valueOf(i)));
                    pricingList.add(p);
                }
            }

            // 6. Save availability
            String[] allDays = {"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"};
            List<AvailabilityDTO> availabilityList = new ArrayList<>();
            for (String day : allDays) {
                if (request.getParameter("availEnabled_" + day) != null) {
                    AvailabilityDTO a = new AvailabilityDTO();
                    a.setDayOfWeek(day);
                    String start = request.getParameter("startTime_" + day);
                    String end   = request.getParameter("endTime_" + day);
                    a.setStartTime(start != null && !start.isEmpty() ? start : "09:00");
                    a.setEndTime(end   != null && !end.isEmpty()   ? end   : "18:00");
                    availabilityList.add(a);
                }
            }

            trainerService.savePricingAndAvailability(trainer.getTrainerId(), pricingList, availabilityList);

            response.sendRedirect(request.getContextPath() + "/trainer/profileEdit?saved=1");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "저장에 실패했습니다. 다시 시도해 주세요.");
            UserDTO loginUser2 = (UserDTO) session.getAttribute("loginUser");
            TrainerService ts2 = new TrainerServiceImpl();
            TrainerDTO trainer2 = ts2.getTrainerByUserId(loginUser2.getId());
            if (trainer2 != null) {
                int tid = trainer2.getTrainerId();
                request.setAttribute("trainer", trainer2);
                request.setAttribute("specializations",  ts2.getSpecializationsByTrainerId(tid));
                request.setAttribute("traits",           ts2.getTraitsByTrainerId(tid));
                request.setAttribute("certifications",   ts2.getCertificationsByTrainerId(tid));
                request.setAttribute("pricingList",      ts2.getPricingByTrainerId(tid));
                request.setAttribute("availabilityList", ts2.getAvailabilityByTrainerId(tid));
            }
            request.getRequestDispatcher("/trainer/profileEdit.jsp").forward(request, response);
        }
    }

    private int parseIntSafe(String[] arr, int i, int defaultVal) {
        if (arr == null || i >= arr.length || arr[i] == null || arr[i].isEmpty()) return defaultVal;
        try { return Integer.parseInt(arr[i]); } catch (NumberFormatException e) { return defaultVal; }
    }
}
