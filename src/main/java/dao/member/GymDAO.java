package dao.member;

import dto.member.GymDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public interface GymDAO {
    List<GymDTO> selectGymList(SqlSession session, String keyword, String category);

    int insertGym(SqlSession session, GymDTO dto);
}
