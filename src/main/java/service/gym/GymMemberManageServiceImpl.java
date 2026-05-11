package service.gym;

import java.util.List;
import java.util.Map;

import dao.gym.GymMemberManageDao;
import dao.gym.GymMemberManageDaoImpl;
import dto.gym.MemberManage;

public class GymMemberManageServiceImpl implements GymMemberManageService {
	private GymMemberManageDao dao = new GymMemberManageDaoImpl();
	
	@Override
	public List<MemberManage> getMemberList(Map<String, Object> param) throws Exception {
		return dao.selectMemberList(param);
	}

	@Override
	public int getTotalMemberCount(int gymId) throws Exception {
		return dao.countMember(gymId);
	}

	@Override
	public int getNewMemberCount(int gymId) throws Exception {
		return dao.countNewMember(gymId);
	}

	@Override
	public int getMemberListCount(Map<String, Object> param) throws Exception {
		return dao.countMemberList(param);
	}

}
