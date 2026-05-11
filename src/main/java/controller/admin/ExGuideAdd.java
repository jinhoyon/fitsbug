package controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.admin.ExerciseDTO;
import service.admin.ExerciseService;
import service.admin.ExerciseServiceImpl;

/**
 * Servlet implementation class ExGuideAdd
 */
@WebServlet("/admin/exGuideAdd")
@MultipartConfig( // 스프링 없이 표준 서블릿에서 파일 업로드를 허용하는 설정
	    maxFileSize = 1024 * 1024 * 50,      // 파일 하나당 최대 50MB
	    maxRequestSize = 1024 * 1024 * 100   // 전체 요청 최대 100MB
	)
public class ExGuideAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ExerciseService exerciseService = new ExerciseServiceImpl();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExGuideAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		String egNumStr = request.getParameter("egNum");
        
        try {
            // egNum 파라미터가 있다면 '수정' 작전 개시
            if (egNumStr != null && !egNumStr.isEmpty()) {
                int egNum = Integer.parseInt(egNumStr);
                ExerciseDTO guide = exerciseService.getExerciseDetail(egNum);
                // 조회된 데이터를 'guide'라는 이름으로 JSP에 전달
                request.setAttribute("guide", guide);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/admin/exGuideAdd.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 인코딩 설정 (한글 깨짐 방지)
        request.setCharacterEncoding("UTF-8");

        String uploadPath = request.getServletContext().getRealPath("/uploads");
        //File uploadDir = new File(uploadPath);
        // if (!uploadDir.exists()) uploadDir.mkdirs(); // 폴더가 없으면 생성

        try {
        	String egNumStr = request.getParameter("egNum"); // hidden 필드에서 받음
            String title = request.getParameter("title");
            String type = request.getParameter("type");
            String difficulty = request.getParameter("difficulty");
            String targetMuscle = request.getParameter("targetMuscle");
            String description = request.getParameter("description");
            String keyPoint = request.getParameter("keyPoint");
            String videoUrl = request.getParameter("video");
            
            // 3. 파일 처리 (MultipartFile 대신 request.getPart() 사용)
            Part imagePart = request.getPart("imageFile"); // JSP의 name과 일치
            String image = saveFile(imagePart, uploadPath);

            // 4. DTO 생성 및 수동 매핑 (Spring이 아니므로 하나씩 직접 넣어야 함)
            ExerciseDTO dto = new ExerciseDTO();
            dto.setTitle(title);
            dto.setType(type);
            dto.setDifficulty(difficulty);
            dto.setTargetMuscle(targetMuscle);
            dto.setDescription(description);
            dto.setKeyPoint(keyPoint);
            dto.setVideo(videoUrl);
            
         // 4. 분기 작전 (등록 vs 수정)
            if (egNumStr == null || egNumStr.isEmpty()) {
                // [신규 등록]
                dto.setImage(image);
                exerciseService.registerExerciseGuide(dto);
            } else {
                // [기존 수정]
                int egNum = Integer.parseInt(egNumStr);
                dto.setEgNum(egNum);
                
                // 만약 새로운 파일을 올리지 않았다면 기존 파일명을 유지해야 함
                // (이 로직은 서비스나 DAO에서 처리하거나, 여기서 기존 정보를 다시 불러와 세팅)
                if(image != null) {
                    dto.setImage(image);
                } else {
                    // 이미지를 새로 선택 안 했다면 기존 이미지 유지 로직 필요
                    // 기존 데이터를 불러와서 세팅하거나, DAO에서 null 체크를 해야 합니다.
                    ExerciseDTO oldData = exerciseService.getExerciseDetail(egNum);
                    dto.setImage(oldData.getImage());
                }
                
                exerciseService.modifyExerciseGuide(dto); // 서비스에 modify 메서드 추가 필요
            }

            response.sendRedirect(request.getContextPath() + "/admin/exGuideList");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/common/error.jsp");
        }
    }

    // 파일 저장 로직 (중복 방지를 위한 UUID 적용) -> DB저장시 파일 앞에 난수 생성
    private String saveFile(Part part, String uploadPath) throws IOException {
        String originalName = getFileName(part);
        if (originalName == null || originalName.isEmpty()) return null;

        // UUID를 붙여 파일명 중복 원천 차단
        String savedName = UUID.randomUUID().toString() + "_" + originalName;
        System.out.println(uploadPath + File.separator + savedName);
        part.write(uploadPath + File.separator + savedName);
        return savedName;
    }

    // Part 객체에서 실제 파일명을 뽑아내는 메서드
    private String getFileName(Part part) {
    	// 1. 파트 자체가 null이면 즉시 퇴각 (JSP에서 데이터가 안 넘어온 경우)
        if (part == null) return null;

        String contentDisp = part.getHeader("content-disposition");
        
        // 2. 헤더가 없거나 일반 텍스트 데이터인 경우 처리
        if (contentDisp == null || !contentDisp.contains("filename")) return null;

        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
                return fileName.replace("\"", ""); // 따옴표 제거
            }
        }
        return null;
    }
}