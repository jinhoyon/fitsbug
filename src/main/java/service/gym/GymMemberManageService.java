package service.gym;

import java.util.List;
import java.util.Map;

import dto.gym.MemberManage;

public interface GymMemberManageService {
	List<MemberManage> getMemberList(Map<String, Object> param) throws Exception;
    int getTotalMemberCount(int gymId) throws Exception;
    int getNewMemberCount(int gymId) throws Exception;
    int getMemberListCount(Map<String, Object> param) throws Exception;
}
