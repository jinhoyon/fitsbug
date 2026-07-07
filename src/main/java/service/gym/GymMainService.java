package service.gym;

import java.util.List;
import java.util.Map;

import dto.common.Gym;
import dto.gym.GymNotice;
import dto.gym.GymTrainerView;
import dto.gym.HotTime;
import dto.gym.Membership;
import dto.gym.Review;
import dto.gym.Schedule;
import dto.common.UserDTO;

public interface GymMainService {
	Map<String,Object> getGymMainInfo(int gymId) throws Exception;
    List<GymNotice> getNoticeList(int gymId) throws Exception;
    List<Review> getReviewList(int gymId) throws Exception;
    List<Membership> getMembershipList(int gymId) throws Exception;
    Schedule getSchedule(int gymId) throws Exception;
    List<GymTrainerView> getGymTrainerViewList(int gymId) throws Exception;
    HotTime getTodayHotTime(int gymId) throws Exception;
    void joinGym(UserDTO user,Gym gym) throws Exception;
}
