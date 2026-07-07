package dao.gym;


import java.util.List;
import java.util.Map;

import dto.gym.GymNotice;
import dto.gym.NoticeImages;

public interface NoticeDAO {
	int selectNoticeCount(int gymId) throws Exception;
	List<GymNotice> selectNoticeList(Map<String, Object> param) throws Exception;
	GymNotice selectNoticeDetail(int id) throws Exception;
	void updateViewCount(int id) throws Exception;
	void insertNotice(GymNotice notice) throws Exception;
	void updateNotice(GymNotice notice) throws Exception;
	List<NoticeImages> selectImagesByNoticeId(int noticeId) throws Exception;
	void insertImages(NoticeImages image) throws Exception;
	void deleteImages(List<Integer> imageIds) throws Exception;
	void deleteNotice(int noticeId) throws Exception;
	void deleteImagesByNoticeId(int noticeId) throws Exception;
	List<GymNotice> selectNoticeList(Integer gymId) throws Exception;
}
