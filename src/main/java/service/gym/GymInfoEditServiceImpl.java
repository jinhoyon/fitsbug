package service.gym;

import java.util.List;
import java.util.Map;

import dao.gym.InfoEditDao;
import dao.gym.InfoEditDaoImpl;
import dto.gym.Gym;
import dto.gym.Membership;
import dto.gym.Schedule;
import dto.member.UserDTO;

public class GymInfoEditServiceImpl implements GymInfoEditService {
	private InfoEditDao dao = new InfoEditDaoImpl();
	
	@Override
	public Gym selectGymMypage(int gymId) {
		return dao.selectGymMypage(gymId);
	}

	@Override
	public int updateGym(Gym gym) {
		return dao.updateGym(gym);
	}

	@Override
	public void updateGymUser(UserDTO user) {
		dao.updateGymUser(user);
	}

	@Override
	public int updatePassword(Map<String, Object> param) {
		return dao.updatePassword(param);
	}

	@Override
	public int countEmail(String emailId) {
		return dao.countEmail(emailId);
	}

	@Override
	public Schedule selectSchedule(int gymId) {
		return dao.selectSchedule(gymId);
	}

	@Override
	public int updateSchedule(Schedule schedule) {
		return dao.updateSchedule(schedule);
	}

	@Override
	public List<Membership> selectMembershipList(int gymId) {
		return dao.selectMembershipList(gymId);
	}

	@Override
	public int updateMembership(Membership membership) {
		return dao.updateMembership(membership);
	}

	@Override
	public int insertMembership(Membership membership) {
		return dao.insertMembership(membership);
	}

	@Override
	public int deleteMembership(int membershipNum) {
		return dao.deleteMembership(membershipNum);
	}

	

	@Override
	public boolean isEmailAvailable(String emailId) {
		return dao.countEmail(emailId)==0;
	}

}
