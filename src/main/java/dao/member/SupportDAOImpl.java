package dao.member;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.member.InquiryDTO;
import util.MybatisSqlSessionFactory;

public class SupportDAOImpl implements SupportDAO {

    private static final String NS = "mapper.member.InquiryMapper.";

    @Override
    public void insertInquiry(InquiryDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            session.insert(NS + "insertInquiry", dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    @Override
    public List<InquiryDTO> findByEmail(String email) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<InquiryDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "findByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }
}
