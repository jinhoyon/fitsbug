package dao.gym;

import java.util.List;
import java.util.Map;

import dto.gym.Gym;
import dto.gym.Membership;
import dto.gym.Schedule;
import dto.member.UserDTO;

public interface InfoEditDao {
	Gym selectGymMypage(int gymId);
    int updateGym(Gym gym);
    void updateGymUser(UserDTO user);
    int updatePassword(Map<String, Object> param);
    int countEmail(String emailId);
    Schedule selectSchedule(int gymId);
    int updateSchedule(Schedule schedule);
    List<Membership> selectMembershipList(int gymId);
    int updateMembership(Membership membership);
    int insertMembership(Membership membership);
    int deleteMembership(int membershipNum);
    
}
