package dao.gym;


import dto.gym.NoticeImages;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.GymNotice;
import util.MybatisSqlSessionFactory;

public class GymNoticeDaoImpl implements GymNoticeDao {
	
	@Override
	public int selectNoticeCount(int gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gymNotice.selectNoticeCount", gymId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<GymNotice> selectNoticeList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gymNotice.selectNoticeList", param);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public GymNotice selectNoticeDetail(int id) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectOne("mapper.gymNotice.selectNoticeDetail", id);
		}finally{
			sqlSession.close();
		}
		
	}

	@Override
	public void updateViewCount(int id) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.gymNotice.updateViewCount", id);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}finally{
			sqlSession.close();
		}
		
	}

	@Override
	public void insertNotice(GymNotice notice) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.gymNotice.insertNotice", notice);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}finally{
			sqlSession.close();
		}
		
	}

	@Override
	public void updateNotice(GymNotice notice) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.gymNotice.updateNotice", notice);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}finally{
			sqlSession.close();
		}
		
	}

	@Override
	public List<NoticeImages> selectImagesByNoticeId(int noticeId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gymNotice.selectImagesByNoticeId", noticeId);
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public void insertImages(NoticeImages image) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.gymNotice.insertImages", image);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}finally{
			sqlSession.close();
		}
		
	}

	@Override
	public void deleteImages(List<Integer> imageIds) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.delete("mapper.gymNotice.deleteImages", imageIds);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}finally{
			sqlSession.close();
		}
		
	}

	@Override
	public void deleteNotice(int noticeId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.delete("mapper.gymNotice.deleteNotice", noticeId);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}finally{
			sqlSession.close();
		}
		
	}

	@Override
	public void deleteImagesByNoticeId(int noticeId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.delete("mapper.gymNotice.deleteImagesByNoticeId", noticeId);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}finally{
			sqlSession.close();
		}
	}

	@Override
	public List<GymNotice> selectNoticeList(Integer gymId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.gymNotice.selectRecentNoticeByGym", gymId);
		}finally{
			sqlSession.close();
		}
	}

}
