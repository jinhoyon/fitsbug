package service.gym;

import java.util.List;
import java.util.Map;

import dao.gym.GymNoticeDao;
import dao.gym.GymNoticeDaoImpl;
import dto.gym.GymNotice;
import dto.gym.NoticeImages;

public class GymNoticeServiceImpl implements GymNoticeService {
	private GymNoticeDao gymNoticeDao = new GymNoticeDaoImpl();
	
	@Override
	public int getNoticeCount(int gymId) throws Exception {
		return gymNoticeDao.selectNoticeCount(gymId);
	}

	@Override
	public List<GymNotice> getNoticeList(Map<String, Object> param) throws Exception {
		return gymNoticeDao.selectNoticeList(param);
	}

	@Override
	public GymNotice getNoticeDetail(int id) throws Exception {
		return gymNoticeDao.selectNoticeDetail(id);
	}

	@Override
	public void increaseViewCount(int id) throws Exception {
		gymNoticeDao.updateViewCount(id);
	}

	@Override
	public void writeNotice(GymNotice notice) throws Exception {
		gymNoticeDao.insertNotice(notice);
	}
	
	@Override
	public void updateNotice(GymNotice notice) throws Exception {
		gymNoticeDao.updateNotice(notice);
	}
	
	
	@Override
	public void addImage(NoticeImages image) throws Exception {
		gymNoticeDao.insertImages(image);
	}
	
	@Override
	public void removeImages(List<Integer> imageId) throws Exception {
		gymNoticeDao.deleteImages(imageId);
	}

	@Override
	public List<NoticeImages> getImagesByNoticeId(int noticeId) throws Exception {
		return gymNoticeDao.selectImagesByNoticeId(noticeId);
	}

	@Override
	public void deleteNotice(int noticeId) throws Exception {
		gymNoticeDao.deleteImagesByNoticeId(noticeId);
	    gymNoticeDao.deleteNotice(noticeId);
	}

	@Override
	public void deleteImagesByNoticeId(int noticeId) throws Exception {
		gymNoticeDao.deleteImagesByNoticeId(noticeId);
	}

	@Override
	public List<GymNotice> selectNoticeList(Integer gymId) throws Exception {
		return gymNoticeDao.selectNoticeList(gymId);
	}

}
