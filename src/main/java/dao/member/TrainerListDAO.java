package dao.member;

import dto.common.AvailabilityDTO;
import dto.common.TrainerDTO;

import java.util.List;
import java.util.Map;

/** Member-facing trainer discovery (list, detail, availability). Not trainer profile CRUD. */
public interface TrainerListDAO {
    List<TrainerDTO> getTrainerList(String keyword, String category, String sort);

    TrainerDTO getTrainerDetail(int trainerId);

    List<AvailabilityDTO> findAvailabilityByTrainerId(Integer trainerId);

    Map<String, Object> findTrainerInfoById(Integer trainerId);
}
