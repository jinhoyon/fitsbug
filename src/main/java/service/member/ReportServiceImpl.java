package service.member;

import dao.member.ReportDAO;
import dao.member.ReportDAOImpl;
import dto.member.ReportDTO;

public class ReportServiceImpl implements ReportService {

    private ReportDAO dao = new ReportDAOImpl();

    public void insertReport(ReportDTO dto) {
        dao.insert(dto);
    }
}