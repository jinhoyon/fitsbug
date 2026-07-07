package service.gym;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.gym.TrainerManageDAO;
import dao.gym.TrainerManageDAOImpl;
import dto.gym.TrainerAssign;
import dto.gym.TrainerList;
import dto.gym.TrainerMemberView;

public class GymTrainerManageServiceImpl implements GymTrainerManageService {

	private TrainerManageDAO dao = new TrainerManageDAOImpl();

    @Override
    public List<TrainerMemberView> getCurrentMembers(int trainerId, int gymId) throws Exception{
        return dao.selectCurrentMembers(trainerId,gymId);
    }

    @Override
    public List<TrainerMemberView> getPastMembers(int trainerId, int gymId) throws Exception{
        return dao.selectPastMembers(trainerId, gymId);
    }

    @Override
    public List<TrainerMemberView> getMembers(int trainerId, int gymId, String type) throws Exception{
    	if ("past".equals(type)) {
            return dao.selectPastMembers(trainerId, gymId);
        }

        return dao.selectCurrentMembers(trainerId, gymId);
    }

	@Override
	public List<TrainerList> getTrainerList(int gymId, String keyword) throws Exception{
		Map<String, Object> param = new HashMap<>();
        param.put("gymId", gymId);
        param.put("keyword", keyword);

        return dao.selectTrainerList(param);
	}

	@Override
	public List<TrainerAssign> getTrainerAssignList(int gymId) throws Exception{
		return dao.selectTrainerAssignList(gymId);
	}

}
