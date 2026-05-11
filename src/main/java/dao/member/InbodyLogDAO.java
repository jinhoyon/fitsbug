package dao.member;

import dto.member.InbodyLogDTO;
import java.util.List;

/**
 * InbodyRecordDAO → InbodyLogDAO 로 변경
 * INBODY_LOG 테이블 기준 (member_id FK)
 */
public interface InbodyLogDAO {
    int insert(InbodyLogDTO dto);
    List<InbodyLogDTO> findByMemberId(int memberId);
    List<InbodyLogDTO> findByEmail(String email);
}
