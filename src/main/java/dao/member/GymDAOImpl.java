package dao.member;

import dto.common.Gym;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GymDAOImpl implements GymDAO {

    @Override
    public List<Gym> selectGymList(SqlSession session, String keyword, String category) {
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("category", category);
        return session.selectList("mapper.member.gym.selectGymListForSearch", params);
    }

    @Override
    public int insertGym(SqlSession session, Gym dto) {
        return session.insert("mapper.member.gym.insertGymJoin", dto);
    }
}
