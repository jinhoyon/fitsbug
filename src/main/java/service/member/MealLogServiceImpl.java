package service.member;

import dao.member.MealLogDAO;
import dao.member.MealLogDAOImpl;
import dto.member.MealLogDTO;
import java.util.List;

public class MealLogServiceImpl implements MealLogService {

    private MealLogDAO dao = new MealLogDAOImpl();

    @Override
    public int save(MealLogDTO dto) { return dao.insert(dto); }

    @Override
    public List<MealLogDTO> getListByMemberId(int memberId) { return dao.findByMemberId(memberId); }

    @Override
    public List<MealLogDTO> getListByEmail(String email) { return dao.findByEmail(email); }
}
