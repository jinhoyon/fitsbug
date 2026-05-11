package service.member;

import java.util.List;
import java.util.Map;

import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dto.member.MemberDTO;

public class MemberServiceImpl implements MemberService {

    private MemberDAO memberDAO = new MemberDAOImpl();

    @Override
    public int insertMember(MemberDTO dto) { return memberDAO.insertMember(dto); }

    @Override
    public Map<String,Object> findByEmail(String email) { return memberDAO.findByEmail(email); }

    @Override
    public MemberDTO findById(int id) { return memberDAO.findById(id); }

    @Override
    public MemberDTO findByUserId(int userId) { return memberDAO.findByUserId(userId); }

//    @Override
//    public int findMemberIdByEmail(String email) { return memberDAO.findMemberIdByEmail(email); }

    @Override
    public int update(MemberDTO dto) { return memberDAO.update(dto); }

    @Override
    public List<MemberDTO> findByTrainerId(int trainerId) { return memberDAO.findByTrainerId(trainerId); }

    @Override
    public List<MemberDTO> findByGymId(int gymId) { return memberDAO.findByGymId(gymId); }
}
