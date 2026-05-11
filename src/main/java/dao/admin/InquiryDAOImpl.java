package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.admin.InquiryDTO;
import util.MybatisSqlSessionFactory;

public class InquiryDAOImpl implements InquiryDAO {

	@Override
	public List<InquiryDTO> selectInquiryList(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<InquiryDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.inquiry.selectInquiryList", paramMap);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return list;
	}

	@Override
	public InquiryDTO selectInquiryDetail(int inquiryId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		InquiryDTO detail = null;
		try {
			detail = sqlSession.selectOne("mapper.admin.inquiry.selectInquiryDetail", inquiryId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return detail;
	}

	@Override
	public Integer updateInquiryReply(InquiryDTO inquiry) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Integer reply = 0;
		try {
			reply = sqlSession.update("mapper.admin.inquiry.updateInquiryReply", inquiry);
			sqlSession.commit();
		} catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return reply;
	}

	@Override
	public Integer selectInquiryCnt() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Integer InquiryCnt = 0;
		try {
			InquiryCnt = sqlSession.selectOne("mapper.admin.inquiry.selectInquiryCnt");
		} catch(Exception e){
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return InquiryCnt;
	}

}
