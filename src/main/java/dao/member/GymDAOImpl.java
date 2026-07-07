package dao.member;

import dto.member.GymDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GymDAOImpl implements GymDAO {

    @Override
    public List<GymDTO> selectGymList(SqlSession session, String keyword, String category) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("category", category);
        return session.selectList("mapper.GymMapper.selectGymListForSearch", params);
    }

    @Override
    public int insertGym(SqlSession session, GymDTO dto) {
        return session.insert("mapper.GymMapper.insertGymJoin", dto);
    }
}
