package service.member;

import java.util.List;
import java.util.Map;

import dao.member.TrainerListDAO;
import dao.member.TrainerListDAOImpl;
import dto.common.AvailabilityDTO;
import dto.common.TrainerDTO;

public class TrainerServiceImpl implements TrainerService {
    private TrainerListDAO dao = new TrainerListDAOImpl();

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
        return dao.findAvailabilityByTrainerId(trainerId);
    }

    @Override
    public Map<String, Object> getTrainerInfoByTrainerId(Integer trainerId) {
        return dao.findTrainerInfoById(trainerId);
    }
}
