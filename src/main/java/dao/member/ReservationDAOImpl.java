package dao.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.member.ReservationDTO;
import util.MybatisSqlSessionFactory;

public class ReservationDAOImpl implements ReservationDAO {

    @Override
    public void insert(ReservationDTO dto) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            sqlSession.insert("mapper.ReservationMapper.insert", dto);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
    }

    @Override
    public ReservationDTO getNextReservation(String memberEmail, String trainerEmail) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        ReservationDTO result = null;
        try {
            Map<String, String> param = new HashMap<>();
            param.put("memberEmail",  memberEmail);
            param.put("trainerEmail", trainerEmail);
            result = sqlSession.selectOne("mapper.ReservationMapper.getNextReservation", param);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
        return result;
    }
}
