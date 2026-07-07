package dao.member;

import dto.common.Gym;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public interface GymDAO {
    List<Gym> selectGymList(SqlSession session, String keyword, String category);

    int insertGym(SqlSession session, Gym dto);
}
