package dao.member;

import java.util.List;
import dto.member.InquiryDTO;

public interface SupportDAO {
    void insertInquiry(InquiryDTO dto);
    List<InquiryDTO> findByEmail(String email);
}
