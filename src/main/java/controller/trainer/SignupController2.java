package controller.trainer;

import dto.trainer.TrainerDTO;
import service.trainer.TrainerService;
import service.trainer.TrainerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/trainer/signup/step2")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class SignupController2 extends HttpServlet {

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
        if (session == null || session.getAttribute("pendingTrainerUserId") == null) {
            response.sendRedirect(request.getContextPath() + "/trainer/signup");
            return;
        }

        int userId = (int) session.getAttribute("pendingTrainerUserId");
        TrainerService trainerService = new TrainerServiceImpl();
        TrainerDTO trainer = trainerService.getTrainerByUserId(userId);
        if (trainer != null) {
            request.setAttribute("prefillTrainer", trainer);
            request.setAttribute("prefillSpecs", trainerService.getSpecializationsByTrainerId(trainer.getTrainerId()));
            request.setAttribute("prefillTraits", trainerService.getTraitsByTrainerId(trainer.getTrainerId()));
        }

        request.getRequestDispatcher("/trainer/signup2.jsp").forward(request, response);
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

        String description = request.getParameter("description");
        String[] specializations = request.getParameterValues("specializations");
        String[] traits = request.getParameterValues("traits");

        if (specializations == null) specializations = new String[0];
        if (traits == null) traits = new String[0];

        Part filePart = request.getPart("profileImage");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            filePart.write(uploadDir + File.separator + fileName);
        }

        TrainerDTO trainer = new TrainerDTO();
        trainer.setUserId(userId);
        trainer.setDescription(description);

        TrainerService trainerService = new TrainerServiceImpl();

        try {
            trainerService.updateProfileWithTagsAndImage(trainer, specializations, traits, fileName);
            response.sendRedirect(request.getContextPath() + "/trainer/signup/step3");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "프로필 저장에 실패했습니다.");
            request.getRequestDispatcher("/trainer/signup2.jsp").forward(request, response);
        }
    }
}
