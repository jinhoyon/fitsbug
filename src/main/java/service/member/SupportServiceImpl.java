package service.member;

import java.util.List;

import dao.member.SupportDAO;
import dao.member.SupportDAOImpl;
import dto.member.InquiryDTO;

public class SupportServiceImpl implements SupportService {

    private SupportDAO dao = new SupportDAOImpl();

    @Override
    public void write(InquiryDTO dto) {
        dao.insertInquiry(dto);
    }

    @Override
    public List<InquiryDTO> getList(String email) {
        return dao.findByEmail(email);
    }
}
