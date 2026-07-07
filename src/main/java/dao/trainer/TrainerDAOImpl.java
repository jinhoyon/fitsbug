package dao.trainer;

import dto.trainer.AvailabilityDTO;
import dto.common.CertificationDTO;
import dto.common.PayoutAccountDTO;
import dto.common.PricingDTO;
import dto.common.TrainerDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;
import java.util.Map;

public class TrainerDAOImpl implements TrainerDAO {

    @Override
    public int insertTrainer(SqlSession session, TrainerDTO dto) {
        return session.insert("trainer.insertTrainer", dto);
    }

    @Override
    public TrainerDTO findByUserId(SqlSession session, int userId) {
        return session.selectOne("trainer.findByUserId", userId);
    }

    @Override
    public int updateTrainer(SqlSession session, TrainerDTO dto) {
        return session.update("trainer.updateTrainer", dto);
    }

    @Override
    public void deleteSpecializations(SqlSession session, int trainerId) {
        session.delete("trainer.deleteSpecializations", trainerId);
    }

    @Override
    public void insertSpecialization(SqlSession session, int trainerId, String type) {
        session.insert("trainer.insertSpecialization",
                Map.of("trainerId", trainerId, "type", type));
    }

    @Override
    public void deleteTraits(SqlSession session, int trainerId) {
        session.delete("trainer.deleteTraits", trainerId);
    }

    @Override
    public void insertTrait(SqlSession session, int trainerId, String type) {
        session.insert("trainer.insertTrait",
                Map.of("trainerId", trainerId, "type", type));
    }

    @Override
    public void updateProfileImage(SqlSession session, int trainerId, String fileName) {
        session.update("trainer.updateProfileImage",
                Map.of("trainerId", trainerId, "fileName", fileName));
    }

    @Override
    public Integer findGymIdByGymCode(SqlSession session, String gymCode) {
        return session.selectOne("trainer.findGymIdByGymCode", gymCode);
    }

    @Override
    public dto.common.Gym findGymInfoById(SqlSession session, int gymId) {
        return session.selectOne("trainer.findGymInfoById", gymId);
    }

    @Override
    public int insertPayoutAccount(SqlSession session, PayoutAccountDTO dto) {
        return session.insert("payoutAccount.insertPayoutAccount", dto);
    }

    @Override
    public void deletePayoutAccount(SqlSession session, int trainerId) {
        session.delete("payoutAccount.deleteByTrainerId", trainerId);
    }

    @Override
    public PayoutAccountDTO getPayoutAccountByTrainerId(SqlSession session, int trainerId) {
        return session.selectOne("payoutAccount.findByTrainerId", trainerId);
    }

    @Override
    public List<String> findSpecializationsByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("trainer.findSpecializationsByTrainerId", trainerId);
    }

    @Override
    public List<String> findTraitsByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("trainer.findTraitsByTrainerId", trainerId);
    }

    // ── Certifications ───────────────────────────────────────────────────────

    @Override
    public void deleteCertifications(SqlSession session, int trainerId) {
        session.delete("mapper.certification.deleteCertifications", trainerId);
    }

    @Override
    public void insertCertification(SqlSession session, CertificationDTO dto) {
        session.insert("mapper.certification.insertCertification", dto);
    }

    @Override
    public List<CertificationDTO> findCertificationsByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("mapper.certification.findByTrainerId", trainerId);
    }

    // ── Pricing ──────────────────────────────────────────────────────────────

    @Override
    public void deletePricing(SqlSession session, int trainerId) {
        session.delete("pricingAvailability.deletePricing", trainerId);
    }

    @Override
    public void insertPricing(SqlSession session, PricingDTO dto) {
        session.insert("pricingAvailability.insertPricing", dto);
    }

    @Override
    public List<PricingDTO> findPricingByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("pricingAvailability.findPricingByTrainerId", trainerId);
    }

    // ── Availability ─────────────────────────────────────────────────────────

    @Override
    public void deleteAvailability(SqlSession session, int trainerId) {
        session.delete("pricingAvailability.deleteAvailability", trainerId);
    }

    @Override
    public void insertAvailability(SqlSession session, AvailabilityDTO dto) {
        session.insert("pricingAvailability.insertAvailability", dto);
    }

    @Override
    public List<AvailabilityDTO> findAvailabilityByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("pricingAvailability.findAvailabilityByTrainerId", trainerId);
    }

    @Override
    public void resetApprovalStatusToPending(SqlSession session, int trainerId) {
        session.update("trainer.resetApprovalStatusToPending", trainerId);
    }
}
