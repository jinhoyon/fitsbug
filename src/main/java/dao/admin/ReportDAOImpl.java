package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.admin.ReportDTO;
import util.MybatisSqlSessionFactory;

public class ReportDAOImpl implements ReportDAO {

	@Override
	public List<ReportDTO> selectReportList(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<ReportDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.report.selectReportList", paramMap);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return list;
	}

	@Override
	public ReportDTO selectReportDetail(int reportId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		ReportDTO detail = null;
		try {
			detail = sqlSession.selectOne("mapper.admin.report.selectReportDetail", reportId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return detail;
	}

	@Override
	public Integer updateReportStatus(ReportDTO report) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Integer status = 0;
		try {
			status = sqlSession.update("mapper.admin.report.updateReportStatus", report);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		return status;
	}

	@Override
	public Integer selectReportCnt() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Integer ReportCnt = 0;
		try {
			ReportCnt = sqlSession.selectOne("mapper.admin.report.selectReportCnt");
		} catch(Exception e){
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return ReportCnt;
	}
}
