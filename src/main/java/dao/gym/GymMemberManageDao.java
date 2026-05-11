package dao.gym;

import java.util.List;
import java.util.Map;

import dto.gym.MemberManage;

public interface GymMemberManageDao {
	List<MemberManage> selectMemberList(Map<String, Object> param) throws Exception;
    int countMember(int gymId) throws Exception;
    int countNewMember(int gymId) throws Exception;
    int countMemberList(Map<String, Object> param) throws Exception;
}
