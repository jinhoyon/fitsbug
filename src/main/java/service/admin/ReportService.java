package service.admin;

import java.util.List;

import dto.admin.ReportDTO;

public interface ReportService {
	List<ReportDTO> getReportList(String status, String keyword) throws Exception;
	
	ReportDTO getReportDetail(int reportId) throws Exception;
	
	boolean processReport(ReportDTO report) throws Exception;
	
	Integer totalCnt() throws Exception;
	Integer reportCnt() throws Exception;
}
