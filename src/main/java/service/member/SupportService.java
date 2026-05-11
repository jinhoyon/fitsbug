package service.member;

import java.util.List;
import dto.member.InquiryDTO;

public interface SupportService {
    void write(InquiryDTO dto);
    List<InquiryDTO> getList(String email);
}
