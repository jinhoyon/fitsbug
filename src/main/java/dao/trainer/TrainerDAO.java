package dao.trainer;

import dto.trainer.AvailabilityDTO;
import dto.trainer.CertificationDTO;
import dto.trainer.PayoutAccountDTO;
import dto.trainer.PricingDTO;
import dto.common.TrainerDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public interface TrainerDAO {
    int insertTrainer(SqlSession session, TrainerDTO dto) throws Exception;

    TrainerDTO findByUserId(SqlSession session, int userId);

    int updateTrainer(SqlSession session, TrainerDTO dto);

    void deleteSpecializations(SqlSession session, int trainerId);

    void insertSpecialization(SqlSession session, int trainerId, String type);

    void deleteTraits(SqlSession session, int trainerId);

    void insertTrait(SqlSession session, int trainerId, String type);

    void updateProfileImage(SqlSession session, int trainerId, String fileName);

    Integer findGymIdByGymCode(SqlSession session, String gymCode);

    dto.gym.Gym findGymInfoById(SqlSession session, int gymId);

    int insertPayoutAccount(SqlSession session, PayoutAccountDTO dto);

    void deletePayoutAccount(SqlSession session, int trainerId);

    PayoutAccountDTO getPayoutAccountByTrainerId(SqlSession session, int trainerId);

    List<String> findSpecializationsByTrainerId(SqlSession session, int trainerId);

    List<String> findTraitsByTrainerId(SqlSession session, int trainerId);

    // Certifications
    void deleteCertifications(SqlSession session, int trainerId);

    void insertCertification(SqlSession session, CertificationDTO dto);

    List<CertificationDTO> findCertificationsByTrainerId(SqlSession session, int trainerId);

    // Pricing
    void deletePricing(SqlSession session, int trainerId);

    void insertPricing(SqlSession session, PricingDTO dto);

    List<PricingDTO> findPricingByTrainerId(SqlSession session, int trainerId);

    // Availability
    void deleteAvailability(SqlSession session, int trainerId);

    void insertAvailability(SqlSession session, AvailabilityDTO dto);

    List<AvailabilityDTO> findAvailabilityByTrainerId(SqlSession session, int trainerId);

    void resetApprovalStatusToPending(SqlSession session, int trainerId);
}
