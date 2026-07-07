package dao.gym;

import java.util.List;

import dto.gym.Membership;

public interface MembershipCatalogDAO {
	List<Membership> selectMembershipByGym(int gymNum) throws Exception;
	
}
