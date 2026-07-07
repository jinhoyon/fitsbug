package service.gym;

import java.util.List;
import java.util.Map;

import dao.gym.NoticeDAO;
import dao.gym.NoticeDAOImpl;
import dto.gym.GymNotice;
import dto.gym.NoticeImages;

public class GymNoticeServiceImpl implements GymNoticeService {
	private NoticeDAO gymNoticeDAO = new NoticeDAOImpl();
	
	@Override
	public int getNoticeCount(int gymId) throws Exception {
		return gymNoticeDAO.selectNoticeCount(gymId);
	}

	@Override
	public List<GymNotice> getNoticeList(Map<String, Object> param) throws Exception {
		return gymNoticeDAO.selectNoticeList(param);
	}

	@Override
	public GymNotice getNoticeDetail(int id) throws Exception {
		return gymNoticeDAO.selectNoticeDetail(id);
	}

	@Override
	public void increaseViewCount(int id) throws Exception {
		gymNoticeDAO.updateViewCount(id);
	}

	@Override
	public void writeNotice(GymNotice notice) throws Exception {
		gymNoticeDAO.insertNotice(notice);
	}
	
	@Override
	public void updateNotice(GymNotice notice) throws Exception {
		gymNoticeDAO.updateNotice(notice);
	}
	
	
	@Override
	public void addImage(NoticeImages image) throws Exception {
		gymNoticeDAO.insertImages(image);
	}
	
	@Override
	public void removeImages(List<Integer> imageId) throws Exception {
		gymNoticeDAO.deleteImages(imageId);
	}

	@Override
	public List<NoticeImages> getImagesByNoticeId(int noticeId) throws Exception {
		return gymNoticeDAO.selectImagesByNoticeId(noticeId);
	}

	@Override
	public void deleteNotice(int noticeId) throws Exception {
		gymNoticeDAO.deleteImagesByNoticeId(noticeId);
	    gymNoticeDAO.deleteNotice(noticeId);
	}

	@Override
	public void deleteImagesByNoticeId(int noticeId) throws Exception {
		gymNoticeDAO.deleteImagesByNoticeId(noticeId);
	}

	@Override
	public List<GymNotice> selectNoticeList(Integer gymId) throws Exception {
		return gymNoticeDAO.selectNoticeList(gymId);
	}

}
