package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.MemberDAO;
import dao.admin.MemberDAOImpl;
import dto.admin.MemberDTO;
import util.PageInfo;

public class MemberServiceImpl implements MemberService {
	
	private MemberDAO memberDAO; //dao 가져오기.
	public MemberServiceImpl() {
		memberDAO = new MemberDAOImpl();
	}

	@Override
	public List<MemberDTO> gymList(Map<String, Object> paramMap) throws Exception {
		int pageRow = 4; // 한 페이지에 보여줄 데이터 수
		int btnCnt = 4; // 화면 하단에 보여줄 페이지 번호 버튼 갯수
		
		PageInfo pageInfo = (PageInfo)paramMap.get("pageInfo");
		String gymName = (String)paramMap.get("gymName");
		String sortColumn = (String)paramMap.get("sortColumn");
		String sortOrder = (String)paramMap.get("sortOrder");
		
		Integer gymCnt = memberDAO.selectGymCnt(); // db에 등록된 전체 헬스장 수
		Integer allPage = (int)Math.ceil((double)gymCnt/pageRow); // 전체 페이지 수 계산 ceil:올림
		Integer startPage = (pageInfo.getCurPage()-1)/btnCnt*btnCnt+1;
		Integer endPage = Math.min(startPage + btnCnt -1, allPage);
		if(endPage>allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*pageRow;
		
		//새로운 Map에 넣어, DAO로 이동!
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("row", row);
		pagingMap.put("pageRow", pageRow);
		pagingMap.put("gymName", gymName);
		
		//정렬값 없으면 기본값(이름순, 오름차순) 설정
		pagingMap.put("sortColumn", (sortColumn == null || sortColumn.isEmpty()) ? "gymName" : sortColumn);
	    pagingMap.put("sortOrder", (sortOrder == null || sortOrder.isEmpty()) ? "ASC" : sortOrder);
		
		return memberDAO.selectGymList(pagingMap);
	}

	@Override
	public List<MemberDTO> trainerList(Map<String, Object> paramMap) throws Exception {
		int pageRow = 4; // 한 페이지에 보여줄 데이터 수
		int btnCnt = 4; // 화면 하단에 보여줄 페이지 번호 버튼 갯수
		
		PageInfo pageInfo = (PageInfo)paramMap.get("pageInfo");
	    String trainerName = (String)paramMap.get("trainerName");
	    String sortColumn = (String)paramMap.get("sortColumn");
	    String sortOrder = (String)paramMap.get("sortOrder");
	    
		Integer trainerCnt = memberDAO.selectTrainerCnt(); // db에 등록된 전체 헬스장 수
		Integer allPage = (int)Math.ceil((double)trainerCnt/pageRow); // 전체 페이지 수 계산 ceil:올림
		Integer startPage = (pageInfo.getCurPage()-1)/btnCnt*btnCnt+1;
		Integer endPage = Math.min(startPage + btnCnt - 1, allPage);
		if(endPage>allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*pageRow;
		
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("row", row);
		pagingMap.put("pageRow", pageRow);
		pagingMap.put("trainerName", trainerName);
		pagingMap.put("sortColumn", (sortColumn == null || sortColumn.isEmpty()) ? "trainerName" : sortColumn);
	    pagingMap.put("sortOrder", (sortOrder == null || sortOrder.isEmpty()) ? "ASC" : sortOrder);
	    
		return memberDAO.selectTrainerList(pagingMap);
	}

	@Override
	public List<MemberDTO> clientList(Map<String, Object> paramMap) throws Exception {
		int pageRow = 4; // 한 페이지에 보여줄 데이터 수
		int btnCnt = 4; // 화면 하단에 보여줄 페이지 번호 버튼 갯수
		
		PageInfo pageInfo = (PageInfo)paramMap.get("pageInfo");
	    String clientName = (String)paramMap.get("clientName");
	    String sortColumn = (String)paramMap.get("sortColumn");
	    String sortOrder = (String)paramMap.get("sortOrder");
	    
		Integer clientCnt = memberDAO.selectClientCnt(); // db에 등록된 전체 헬스장 수
		Integer allPage = (int)Math.ceil((double)clientCnt/pageRow); // 전체 페이지 수 계산 ceil:올림
		Integer startPage = (pageInfo.getCurPage()-1)/btnCnt*btnCnt+1;
		Integer endPage = Math.min(startPage + btnCnt - 1, allPage);
		if(endPage>allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*pageRow;
		
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("row", row);
		pagingMap.put("pageRow", pageRow);
		pagingMap.put("clientName", clientName);
		pagingMap.put("sortColumn", (sortColumn == null || sortColumn.isEmpty()) ? "clientName" : sortColumn);
	    pagingMap.put("sortOrder", (sortOrder == null || sortOrder.isEmpty()) ? "ASC" : sortOrder);
	    
		return memberDAO.selectClientList(pagingMap);
	}

	@Override
	public Integer totalCnt() throws Exception {
		return memberDAO.selectGymCnt()+memberDAO.selectTrainerCnt()+memberDAO.selectClientCnt();
	}

	@Override
	public Integer gymCnt() throws Exception {
		return memberDAO.selectGymCnt();
	} 

	@Override
	public Integer trainerCnt() throws Exception {
		return memberDAO.selectTrainerCnt();
	}

	@Override
	public Integer clientCnt() throws Exception {
		return memberDAO.selectClientCnt();
	}

	@Override
	public List<Map<String, Object>> getPendingAuthList() throws Exception {
		return memberDAO.selectAuthList();
	}

	@Override
	public Map<String, Object> getAuthDetail(String userId, String authType) throws Exception {
		if("GYM".equals(authType)) {
			return memberDAO.selectGymAuthDetail(userId);
		}else {
			return memberDAO.selectTrainerAuthDetail(userId);
		}
	}
	@Override
	public boolean approveMember(String userId, String authType) throws Exception {
	    int result = 0;
	    if("GYM".equals(authType)) {
	        result = memberDAO.updateGymStatus(userId, "APPROVED");
	    } else {
	        result = memberDAO.updateTrainerStatus(userId, "APPROVED");
	    }
	    return result > 0;
	}
}