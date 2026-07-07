package service.member;

import java.util.List;
import java.util.Map;

import dto.common.TrainerDTO;
import dto.common.AvailabilityDTO;

public interface TrainerService {
    List<TrainerDTO> getTrainerList(String keyword, String category, String sort);
    
    TrainerDTO getTrainerDetail(int trainerId);
    List<AvailabilityDTO> getTrainerAvailabilityList(Integer trainerId);
    Map<String,Object> getTrainerInfoByTrainerId(Integer trainerId);
}