package dao.gym;

import java.util.List;
import java.util.Map;

import dto.gym.TrainerAssign;
import dto.gym.TrainerList;
import dto.gym.TrainerMemberView;

public interface TrainerManageDAO {
	List<TrainerList> selectTrainerList(Map<String, Object> param)throws Exception;
    List<TrainerAssign> selectTrainerAssignList(int gymId)throws Exception;
	List<TrainerMemberView> selectCurrentMembers(int trainerId, int gymId)throws Exception;
	List<TrainerMemberView> selectPastMembers(int trainerId, int gymId)throws Exception;
}
