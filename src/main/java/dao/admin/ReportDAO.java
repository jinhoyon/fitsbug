package dao.admin;

import java.util.List;
import java.util.Map;

import dto.admin.ReportDTO;

public interface ReportDAO {
	List<ReportDTO> selectReportList(Map<String, Object> paramMap) throws Exception;
	
	ReportDTO selectReportDetail(int reportId) throws Exception;
	
	Integer updateReportStatus(ReportDTO report) throws Exception;
	
	Integer selectReportCnt() throws Exception;
}
