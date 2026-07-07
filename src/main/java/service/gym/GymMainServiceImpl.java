package service.gym;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.gym.GymMainDao;
import dao.gym.GymMainDaoImpl;
import dao.gym.GymMainMembershipDao;
import dao.gym.GymMainMembershipDaoImpl;
import dao.gym.GymMainNoticeDao;
import dao.gym.GymMainNoticeDaoImpl;
import dao.gym.GymMainReviewDao;
import dao.gym.GymMainReviewDaoImpl;
import dao.gym.GymMainScheduleDao;
import dao.gym.GymMainScheduleDaoImpl;
import dao.gym.GymMainTrainerViewDao;
import dao.gym.GymMainTrainerViewDaoImpl;
import dto.gym.Gym;
import dto.gym.GymNotice;
import dto.gym.GymTrainerView;
import dto.gym.HotTime;
import dto.gym.Membership;
import dto.gym.Review;
import dto.gym.Schedule;
import dto.common.UserDTO;

public class GymMainServiceImpl implements GymMainService {

	private GymMainDao gymMainDao = new GymMainDaoImpl();
    private GymMainNoticeDao noticeDao = new GymMainNoticeDaoImpl();
    private GymMainReviewDao reviewDao = new GymMainReviewDaoImpl();
    private GymMainMembershipDao membershipDao = new GymMainMembershipDaoImpl();
    private GymMainScheduleDao scheduleDao = new GymMainScheduleDaoImpl();
    private GymMainTrainerViewDao trainerViewDao = new GymMainTrainerViewDaoImpl();
    
    @Override
    public Map<String,Object> getGymMainInfo(int gymId) throws Exception {
        return gymMainDao.selectGymMainInfo(gymId);
    }

    @Override
    public List<GymNotice> getNoticeList(int gymId) throws Exception {
        return noticeDao.selectRecentNoticeByGym(gymId);
    }

    @Override
    public List<Review> getReviewList(int gymId) throws Exception {
        return reviewDao.selectRecentReviewByGym(gymId);
    }

    @Override
    public List<Membership> getMembershipList(int gymId) throws Exception {
        return membershipDao.selectMembershipByGym(gymId);
    }

    @Override
    public Schedule getSchedule(int gymId) throws Exception {
        return scheduleDao.selectScheduleByGym(gymId);
    }

    @Override
    public List<GymTrainerView> getGymTrainerViewList(int gymId) throws Exception {
        return trainerViewDao.selectGymTrainerViewByGym(gymId);
    }

	@Override
	public HotTime getTodayHotTime(int gymId) throws Exception {
		Map<String, Object> param = new HashMap<>();
	    param.put("gymId", gymId);

	    return gymMainDao.selectTodayHotTime(param);
	}

	@Override
	public void joinGym(UserDTO user, Gym gym) throws Exception {
		gymMainDao.insertUserByGym(user);
		gym.setUserId(user.getId());
		gymMainDao.insertGym(gym);
		
	}

}
