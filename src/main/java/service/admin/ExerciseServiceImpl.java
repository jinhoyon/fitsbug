package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.ExerciseDAO;
import dao.admin.ExerciseDAOImpl;
import dto.admin.ExerciseDTO;

public class ExerciseServiceImpl implements ExerciseService {
	
	private ExerciseDAO exerciseDAO;
	public ExerciseServiceImpl() {
		exerciseDAO = new ExerciseDAOImpl();
	}

	@Override
	public void registerExerciseGuide(ExerciseDTO dto) throws Exception {
		try {
            // 1. EXERCISE 테이블에 기본 정보 등록
            // Mapper의 useGeneratedKeys="true" 덕분에 실행 후 dto의 exerciseNum에 값이 채워집니다.
            exerciseDAO.insertGuide(dto);
            
            // 2. 위에서 채워진 exerciseNum이 있는지 확인 (디버깅용)
            System.out.println("생성된 운동 번호: " + dto.getEgNum());
        } catch (Exception e) {
            System.out.println("서비스 단에서 작전 실패: " + e.getMessage());
            throw e; // 컨트롤러로 에러를 던져 후속 조치(에러 페이지 등)를 하게 함
        }
    }

	@Override
	public Map<String, Object> getExerciseGuideList(int page, String targetMuscle, String searchKeyword) throws Exception {
		Map<String, Object> params = new HashMap<>();
	    params.put("targetMuscle", targetMuscle);
	    params.put("searchKeyword", searchKeyword);

	    // 1. 전체 데이터 개수 조회
	    int totalCount = ((ExerciseDAOImpl)exerciseDAO).selectGuideCount(params);

	    // 2. 페이징 계산 (PageInfo 객체 활용)
	    int pageSize = 8;
	    int allPage = (int) Math.ceil((double) totalCount / pageSize);
	    if (allPage == 0) allPage = 1;

	    // 페이지 블록 계산 (예: 1~5, 6~10)
	    int startPage = ((page - 1) / 5) * 5 + 1;
	    int endPage = startPage + 4;
	    if (endPage > allPage) endPage = allPage;

	    util.PageInfo pageInfo = new util.PageInfo(page, allPage, startPage, endPage);

	    // 3. 목록 조회를 위한 시작 위치 계산 및 조회
	    params.put("startRow", (page - 1) * pageSize);
	    List<ExerciseDTO> list = exerciseDAO.selectAllGuide(params);

	    // 4. 컨트롤러로 보낼 결과 맵 구성
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("guideList", list);
	    resultMap.put("pageInfo", pageInfo);
	    resultMap.put("totalCount", totalCount);

	    return resultMap;
	}

	@Override
	public ExerciseDTO getExerciseDetail(int egNum) throws Exception {
		return exerciseDAO.selectGuideById(egNum);
	}
	
	@Override
	public void modifyExerciseGuide(ExerciseDTO dto) throws Exception {
		int result = exerciseDAO.updateExerciseGuide(dto);
	    if(result == 0) {
	        throw new Exception("수정 실패: 해당 번호의 가이드가 존재하지 않습니다.");
	    }
	}

	@Override
	public void removeExerciseGuide(int egNum) throws Exception {
		// [작전 1] DB에서 해당 데이터 삭제 전, 파일명을 알아내기 위해 정보 조회
	    // (선택 사항: 서버 용량 관리를 위해 실제 파일도 지우고 싶을 때)
	    ExerciseDTO guide = exerciseDAO.selectGuideById(egNum);
	    
	    if (guide != null) {
	        // [작전 2] DB에서 데이터 삭제 명령
	        int result = exerciseDAO.deleteGuide(egNum);
	        
	        // [작전 3] DB 삭제 성공 시, 실제 파일 시스템에서도 이미지/비디오 삭제 로직 추가 가능
	        if (result > 0) {
	            // 파일 삭제 로직은 별도의 Utility 클래스로 분리하거나 
	            // 이곳에서 File 객체를 이용해 삭제를 수행할 수 있습니다.
	            System.out.println(egNum + "번 가이드 삭제 완료");
	        }
	    }
	}

	
}