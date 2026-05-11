package dao.member;

import org.apache.ibatis.session.SqlSession;

import dto.member.ReportDTO;
import util.MybatisSqlSessionFactory;

public class ReportDAOImpl implements ReportDAO {

    @Override
    public void insert(ReportDTO dto) {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            sqlSession.insert("mapper.ReportMapper.insert", dto);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
    }
}
