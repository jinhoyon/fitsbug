package service.gym;

import java.util.List;
import java.util.Map;

import dto.gym.GymNotice;
import dto.gym.NoticeImages;

public interface GymNoticeService {
	int getNoticeCount(int gymId) throws Exception;
	List<GymNotice> getNoticeList(Map<String, Object> param) throws Exception;
	GymNotice getNoticeDetail(int id) throws Exception;
	void increaseViewCount(int id) throws Exception;
	void writeNotice(GymNotice notice) throws Exception;
	void updateNotice(GymNotice notice) throws Exception;
	void addImage(NoticeImages image) throws Exception;
	void removeImages(List<Integer> imageId) throws Exception;
	List<NoticeImages> getImagesByNoticeId(int noticeId) throws Exception;
	void deleteNotice(int noticeId) throws Exception;
	void deleteImagesByNoticeId(int noticeId) throws Exception;
	List<GymNotice> selectNoticeList(Integer gymId) throws Exception;

}
