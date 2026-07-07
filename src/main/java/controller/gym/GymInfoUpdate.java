package controller.gym;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.gym.Gym;
import dto.gym.Membership;
import dto.gym.Schedule;
import dto.common.UserDTO;
import service.gym.GymInfoEditService;
import service.gym.GymInfoEditServiceImpl;

/**
 * Servlet implementation class GymInfoUpdate
 */
@WebServlet("/gym/infoUpdate")
@MultipartConfig
public class GymInfoUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GymInfoUpdate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginUser");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/member/login");
                return;
            }

            Integer gymId = user.getOtherId();

		    GymInfoEditService service = new GymInfoEditServiceImpl();
			

			Gym gym = service.selectGymMypage(gymId);
			if (gym == null) {
			    throw new ServletException("헬스장 정보 없음");
			}

			// 기본 정보
			gym.setId(gymId);
			gym.setUserId(user.getId());

			user.setEmail(request.getParameter("emailId"));
			user.setName(request.getParameter("userName"));
			user.setPhone(request.getParameter("tel"));


			gym.setName(request.getParameter("gymName"));
			gym.setPhoneNum(request.getParameter("phoneNum"));
			gym.setDescription(request.getParameter("description"));
			gym.setAddress(request.getParameter("address"));
			gym.setAddressDetail(request.getParameter("addressDetail"));
			gym.setPostcode(request.getParameter("postcode"));


			// 시설
			String[] facilities = request.getParameterValues("facility");
			gym.setFacility(facilities == null ? "" : String.join(",", facilities));

			// 갤러리 삭제
			String deleteGallery = request.getParameter("deleteGallery");

			List<String> currentFiles = new ArrayList<>();

			if (gym.getFile() != null && !gym.getFile().trim().isEmpty()) {
			    currentFiles.addAll(Arrays.asList(gym.getFile().split(",")));
			}

			if (deleteGallery != null && !deleteGallery.trim().isEmpty()) {
			    String[] deleteFiles = deleteGallery.split(",");
			    String uploadPath = request.getServletContext().getRealPath("/uploads");

			    for (String del : deleteFiles) {
			        currentFiles.remove(del);

			        File file = new File(uploadPath + File.separator + del);
			        if (file.exists()) {
			            file.delete();
			        }
			    }
			}

			// 갤러리 이미지 추가
			for (Part part : request.getParts()) {
			    if ("galleryImgs".equals(part.getName()) && part.getSize() > 0) {
			        String fileName = savePart(request, part, "/uploads");
			        if (fileName != null) {
			            currentFiles.add(fileName);
			        }
			    }
			}

			gym.setFile(String.join(",", currentFiles));
			
			// 프로필 이미지 업로드
			String profileFileName = uploadFile(request, "profileImg", "/uploads");
			if (profileFileName != null) {
			    user.setProfileImage(profileFileName);
			}

			// 배경 이미지 업로드
			String backgroundFileName = uploadFile(request, "backgroundImg", "/uploads");
			if (backgroundFileName != null) {
			    gym.setBackgroundImg(backgroundFileName);
			}

			// 사업자 등록증 업로드
			String brFileName = saveAnyFile(request, "brFile", "/uploads");
			if (brFileName != null) {
			    gym.setBrFile(brFileName);
			}

			

			service.updateGym(gym);
			service.updateGymUser(user);


			
			// 운영시간
			
			String weekdayStart = request.getParameter("weekdayStart");
			String weekdayEnd = request.getParameter("weekdayEnd");
			String weekendStart = request.getParameter("weekendStart");
			String weekendEnd = request.getParameter("weekendEnd");

			if (weekdayStart == null || weekdayEnd == null ||
			    weekendStart == null || weekendEnd == null) {

			    throw new ServletException("운영시간 값 누락");
			}
			
			Schedule schedule = new Schedule();
			schedule.setGymNum(gymId);
			schedule.setAvailableWeekdayStart(LocalTime.parse(request.getParameter("weekdayStart")));
			schedule.setAvailableWeekdayEnd(LocalTime.parse(request.getParameter("weekdayEnd")));
			schedule.setAvailableWeekendStart(LocalTime.parse(request.getParameter("weekendStart")));
			schedule.setAvailableWeekendEnd(LocalTime.parse(request.getParameter("weekendEnd")));
			
		

			service.updateSchedule(schedule);

			// 이용권 처리
			String[] membershipIds = request.getParameterValues("membershipId");
			String[] membershipTypes = request.getParameterValues("membershipType");
			String[] membershipTypeReps = request.getParameterValues("membershipTypeRep");
			String[] membershipPrices = request.getParameterValues("membershipPrice");

			if (membershipIds != null &&
				    membershipTypes != null &&
				    membershipTypeReps != null &&
				    membershipPrices != null) {

				    int size = membershipIds.length;

				    for (int i = 0; i < size; i++) {

				        if (membershipTypes.length <= i ||
				            membershipTypeReps.length <= i ||
				            membershipPrices.length <= i) {
				            continue;
				        }

				        Membership m = new Membership();
				        m.setGymNum(gymId);
				        m.setType(membershipTypes[i]);
				        m.setTypeRep(Integer.parseInt(membershipTypeReps[i]));
				        m.setPrice(new BigDecimal(membershipPrices[i]));

				        if ("new".equals(membershipIds[i])) {
				            service.insertMembership(m);
				        } else {
				            m.setMembershipNum(Integer.parseInt(membershipIds[i]));
				            service.updateMembership(m);
				        }
				    }
				}

			response.sendRedirect(request.getContextPath() + "/gym/infoEdit");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "헬스장 정보 수정 중 오류가 발생했습니다.");
			request.setAttribute("url", request.getContextPath() + "/gym/infoEdit");
			request.getRequestDispatcher("/common/alert.jsp").forward(request, response);
		}
	}

	private String uploadFile(HttpServletRequest request, String partName, String uploadDir)
	        throws IOException, ServletException {

	    Part part = request.getPart(partName);

	    if (part == null || part.getSize() == 0) {
	        return null;
	    }

	    return savePart(request, part, uploadDir);
	}

	private String savePart(HttpServletRequest request, Part part, String uploadDir)
	        throws IOException {

		String contentType = part.getContentType();

		if (contentType == null || !(contentType.startsWith("image/")|| contentType.equals("application/pdf"))) {
		    return null;
		}
		
	    String originalFileName = new File(part.getSubmittedFileName()).getName();

	    if (originalFileName == null || originalFileName.trim().isEmpty()) {
	        return null;
	    }

	    String ext = "";
	    int dotIndex = originalFileName.lastIndexOf(".");
	    if (dotIndex != -1) {
	        ext = originalFileName.substring(dotIndex);
	    }

	    String saveFileName =
	    	    System.currentTimeMillis() + "_" +
	    	    java.util.UUID.randomUUID().toString().replace("-", "") + ext;

	    String uploadPath = request.getServletContext().getRealPath(uploadDir);

	    File dir = new File(uploadPath);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    part.write(uploadPath + File.separator + saveFileName);

	    return saveFileName;
	}
	
	private String saveAnyFile(HttpServletRequest request, String partName, String uploadDir)
	        throws IOException, ServletException {

	    Part part = request.getPart(partName);

	    if (part == null || part.getSize() == 0) {
	        return null;
	    }

	    String originalFileName = new File(part.getSubmittedFileName()).getName();

	    if (originalFileName == null || originalFileName.trim().isEmpty()) {
	        return null;
	    }

	    String ext = "";
	    int dotIndex = originalFileName.lastIndexOf(".");
	    if (dotIndex != -1) {
	        ext = originalFileName.substring(dotIndex);
	    }

	    String saveFileName =
	            System.currentTimeMillis() + "_" +
	            java.util.UUID.randomUUID().toString().replace("-", "") + ext;

	    String uploadPath = request.getServletContext().getRealPath(uploadDir);

	    File dir = new File(uploadPath);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    part.write(uploadPath + File.separator + saveFileName);

	    return saveFileName;
	}
}
