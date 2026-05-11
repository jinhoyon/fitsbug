package service.member;

import dao.member.InbodyLogDAO;
import dao.member.InbodyLogDAOImpl;
import dto.member.InbodyLogDTO;
import java.util.List;

public class InbodyLogServiceImpl implements InbodyLogService {

    private InbodyLogDAO dao = new InbodyLogDAOImpl();

    @Override
    public int save(InbodyLogDTO dto) { return dao.insert(dto); }

    @Override
    public List<InbodyLogDTO> getListByMemberId(int memberId) { return dao.findByMemberId(memberId); }

    @Override
    public List<InbodyLogDTO> getListByEmail(String email) { return dao.findByEmail(email); }
}
