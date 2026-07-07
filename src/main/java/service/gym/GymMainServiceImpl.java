package service.gym;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.gym.GymMainDAO;
import dao.gym.GymMainDAOImpl;
import dao.gym.GymMainMembershipDAO;
import dao.gym.GymMainMembershipDAOImpl;
import dao.gym.GymMainNoticeDAO;
import dao.gym.GymMainNoticeDAOImpl;
import dao.gym.GymMainReviewDAO;
import dao.gym.GymMainReviewDAOImpl;
import dao.gym.GymMainScheduleDAO;
import dao.gym.GymMainScheduleDAOImpl;
import dao.gym.GymMainTrainerViewDAO;
import dao.gym.GymMainTrainerViewDAOImpl;
import dto.common.Gym;
import dto.gym.GymNotice;
import dto.gym.GymTrainerView;
import dto.gym.HotTime;
import dto.gym.Membership;
import dto.gym.Review;
import dto.gym.Schedule;
import dto.common.UserDTO;

public class GymMainServiceImpl implements GymMainService {

	private GymMainDAO gymMainDAO = new GymMainDAOImpl();
    private GymMainNoticeDAO noticeDAO = new GymMainNoticeDAOImpl();
    private GymMainReviewDAO reviewDAO = new GymMainReviewDAOImpl();
    private GymMainMembershipDAO membershipDAO = new GymMainMembershipDAOImpl();
    private GymMainScheduleDAO scheduleDAO = new GymMainScheduleDAOImpl();
    private GymMainTrainerViewDAO trainerViewDAO = new GymMainTrainerViewDAOImpl();
    
    @Override
    public Map<String,Object> getGymMainInfo(int gymId) throws Exception {
        return gymMainDAO.selectGymMainInfo(gymId);
    }

    @Override
    public List<GymNotice> getNoticeList(int gymId) throws Exception {
        return noticeDAO.selectRecentNoticeByGym(gymId);
    }

    @Override
    public List<Review> getReviewList(int gymId) throws Exception {
        return reviewDAO.selectRecentReviewByGym(gymId);
    }

    @Override
    public List<Membership> getMembershipList(int gymId) throws Exception {
        return membershipDAO.selectMembershipByGym(gymId);
    }

    @Override
    public Schedule getSchedule(int gymId) throws Exception {
        return scheduleDAO.selectScheduleByGym(gymId);
    }

    @Override
    public List<GymTrainerView> getGymTrainerViewList(int gymId) throws Exception {
        return trainerViewDAO.selectGymTrainerViewByGym(gymId);
    }

	@Override
	public HotTime getTodayHotTime(int gymId) throws Exception {
		Map<String, Object> param = new HashMap<>();
	    param.put("gymId", gymId);

	    return gymMainDAO.selectTodayHotTime(param);
	}

	@Override
	public void joinGym(UserDTO user, Gym gym) throws Exception {
		gymMainDAO.insertUserByGym(user);
		gym.setUserId(user.getId());
		gymMainDAO.insertGym(gym);
		
	}

}
