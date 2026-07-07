package service.member;

import java.util.List;
import java.util.Map;

import dao.member.TrainerDAO;
import dao.member.TrainerDAOImpl;
import dto.common.TrainerDTO;
import dto.trainer.AvailabilityDTO;

public class TrainerServiceImpl implements TrainerService {
    private TrainerDAO dao = new TrainerDAOImpl();

    @Override
    public List<TrainerDTO> getTrainerList(String keyword, String category, String sort) {
        return dao.getTrainerList(keyword, category, sort);
    }

    @Override
    public TrainerDTO getTrainerDetail(int trainerId) {
        return dao.getTrainerDetail(trainerId);
    }

	@Override
	public List<AvailabilityDTO> getTrainerAvailabilityList(Integer trainerId) {
		// TODO Auto-generated method stub
		return dao.findAvailabilityByTrainerId(trainerId);
	}

	@Override
	public Map<String, Object> getTrainerInfoByTrainerId(Integer trainerId) {
		// TODO Auto-generated method stub
		return dao.findTrainerInfoById(trainerId);
	}
}