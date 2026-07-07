package dao.member;

import dto.common.TrainerDTO;
import dto.common.AvailabilityDTO;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

public interface TrainerDAO {
    // 기존 기능 (회원가입/트레이너 등록)
    void insertTrainer(Connection conn, String id, String pw, String name) throws Exception;

    // 리스트 조회 (새 기능)
    List<TrainerDTO> getTrainerList(String keyword, String category, String sort);
    
    public TrainerDTO getTrainerDetail(int trainerId);
    List<AvailabilityDTO> findAvailabilityByTrainerId(Integer trainerId);
    Map<String,Object> findTrainerInfoById(Integer trainerId);
}