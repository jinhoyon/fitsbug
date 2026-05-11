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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet("/trainer/signup/step4")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize       = 1024 * 1024 * 10,  // 10 MB per file
        maxRequestSize    = 1024 * 1024 * 50    // 50 MB total
)
public class SignupController4 extends HttpServlet {

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
        request.getRequestDispatcher("/trainer/signup4.jsp").forward(request, response);
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

        String[] certNames   = request.getParameterValues("certName");
        String[] issuingOrgs = request.getParameterValues("issuingOrg");
        String[] issueDates  = request.getParameterValues("issueDate");
        String[] expiryDates = request.getParameterValues("expiryDate");

        // Collect file parts in submission order (one per cert row, may be empty)
        List<Part> fileParts = new ArrayList<>();
        Collection<Part> allParts = request.getParts();
        for (Part part : allParts) {
            if ("certFile".equals(part.getName())) {
                fileParts.add(part);
            }
        }

        // Save files and build fileNames array aligned with certNames[]

        String[] fileNames = new String[certNames == null ? 0 : certNames.length];
        for (int i = 0; i < fileNames.length; i++) {
            if (i < fileParts.size()) {
                Part part = fileParts.get(i);
                if (part.getSize() > 0) {
                    String original = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String saved    = "cert_" + userId + "_" + i + "_" + original;
                    part.write(uploadDir + File.separator + saved);
                    fileNames[i] = saved;
                }
            }
        }

        TrainerService trainerService = new TrainerServiceImpl();
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
}
