package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.InquiryDAO;
import dao.admin.InquiryDAOImpl;
import dao.admin.ReportDAO;
import dao.admin.ReportDAOImpl;
import dto.admin.ReportDTO;

public class ReportServiceImpl implements ReportService {

	private ReportDAO reportDAO;
	private InquiryDAO inquiryDAO;
	public ReportServiceImpl() {
		reportDAO = new ReportDAOImpl();
		inquiryDAO = new InquiryDAOImpl();
	}
	
	@Override
	public List<ReportDTO> getReportList(String status, String keyword) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("status", status);
        paramMap.put("keyword", keyword);
        return reportDAO.selectReportList(paramMap);
	}

	@Override
	public ReportDTO getReportDetail(int reportId) throws Exception {
		return reportDAO.selectReportDetail(reportId);
	}

	@Override
	public boolean processReport(ReportDTO report) throws Exception {
		// 1. DAO를 통해 업데이트 실행 (성공 시 1, 실패 시 0 반환됨)
        int result = reportDAO.updateReportStatus(report);
        
        // 2. 결과값이 0보다 크면(성공) true, 아니면 false 반환
        // 만약 여기서 알림 발송 로직이 추가된다면 result > 0 일 때 실행하면 됩니다.
        return result > 0;
	}

	@Override
	public Integer totalCnt() throws Exception {
		return reportDAO.selectReportCnt() + inquiryDAO.selectInquiryCnt();
	}

	@Override
	public Integer reportCnt() throws Exception {
		return reportDAO.selectReportCnt();
	}

}
