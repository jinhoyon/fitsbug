package dao.gym;

import java.util.List;

import dto.gym.Membership;

public interface GymMainMembershipDao {
	List<Membership> selectMembershipByGym(int gymNum) throws Exception;
	
}
