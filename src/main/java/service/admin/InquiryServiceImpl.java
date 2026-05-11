package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.InquiryDAO;
import dao.admin.InquiryDAOImpl;
import dao.admin.ReportDAO;
import dao.admin.ReportDAOImpl;
import dto.admin.InquiryDTO;

public class InquiryServiceImpl implements InquiryService {

	private InquiryDAO inquiryDAO;
	private ReportDAO reportDAO;
	public InquiryServiceImpl() {
		inquiryDAO = new InquiryDAOImpl();
		reportDAO = new ReportDAOImpl();
	}
	
	@Override
	public List<InquiryDTO> getInquiryList(String status, String keyword) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("status", status);
        paramMap.put("keyword", keyword);
        return inquiryDAO.selectInquiryList(paramMap);
	}

	@Override
	public InquiryDTO getInquiryDetail(int inquiryId) throws Exception {
		return inquiryDAO.selectInquiryDetail(inquiryId);
	}

	@Override
	public boolean answerInquiry(InquiryDTO inquiry) throws Exception {
		// 1. DAO를 통해 업데이트 실행 (성공 시 1, 실패 시 0 반환됨)
        int result = inquiryDAO.updateInquiryReply(inquiry);
        
        // 2. 결과값이 0보다 크면(성공) true, 아니면 false 반환
        // 만약 여기서 알림 발송 로직이 추가된다면 result > 0 일 때 실행하면 됩니다.
        return result > 0;
	}

	@Override
	public Integer totalCnt() throws Exception {
		return inquiryDAO.selectInquiryCnt() + reportDAO.selectReportCnt();
	}

	@Override
	public Integer inquiryCnt() throws Exception {
		return inquiryDAO.selectInquiryCnt();
	}

}
