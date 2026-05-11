package service.member;

import dto.member.InbodyLogDTO;
import java.util.List;

public interface InbodyLogService {
    int save(InbodyLogDTO dto);
    List<InbodyLogDTO> getListByMemberId(int memberId);
    List<InbodyLogDTO> getListByEmail(String email);
}
