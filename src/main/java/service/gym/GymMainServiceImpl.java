package service.gym;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.gym.GymProfileDAO;
import dao.gym.GymProfileDAOImpl;
import dao.gym.MembershipCatalogDAO;
import dao.gym.MembershipCatalogDAOImpl;
import dao.gym.NoticeDAO;
import dao.gym.NoticeDAOImpl;
import dao.gym.ReviewDAO;
import dao.gym.ReviewDAOImpl;
import dao.gym.ScheduleDAO;
import dao.gym.ScheduleDAOImpl;
import dao.gym.TrainerViewDAO;
import dao.gym.TrainerViewDAOImpl;
import dto.common.Gym;
import dto.gym.GymNotice;
import dto.gym.GymTrainerView;
import dto.gym.HotTime;
import dto.gym.Membership;
import dto.gym.Review;
import dto.gym.Schedule;
import dto.common.UserDTO;

public class GymMainServiceImpl implements GymMainService {

	private GymProfileDAO gymProfileDAO = new GymProfileDAOImpl();
    private NoticeDAO noticeDAO = new NoticeDAOImpl();
    private ReviewDAO reviewDAO = new ReviewDAOImpl();
    private MembershipCatalogDAO membershipCatalogDAO = new MembershipCatalogDAOImpl();
    private ScheduleDAO scheduleDAO = new ScheduleDAOImpl();
    private TrainerViewDAO trainerViewDAO = new TrainerViewDAOImpl();
    
    @Override
    public Map<String,Object> getGymMainInfo(int gymId) throws Exception {
        return gymProfileDAO.selectGymMainInfo(gymId);
    }

    @Override
    public List<GymNotice> getNoticeList(int gymId) throws Exception {
        return noticeDAO.selectNoticeList(gymId);
    }

    @Override
    public List<Review> getReviewList(int gymId) throws Exception {
        return reviewDAO.selectRecentReviewByGym(gymId);
    }

    @Override
    public List<Membership> getMembershipList(int gymId) throws Exception {
        return membershipCatalogDAO.selectMembershipByGym(gymId);
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

	    return gymProfileDAO.selectTodayHotTime(param);
	}

	@Override
	public void joinGym(UserDTO user, Gym gym) throws Exception {
		gymProfileDAO.insertUserByGym(user);
		gym.setUserId(user.getId());
		gymProfileDAO.insertGym(gym);
		
	}

}
