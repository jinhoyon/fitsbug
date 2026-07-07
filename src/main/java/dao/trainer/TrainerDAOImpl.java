package dao.trainer;

import dto.common.AvailabilityDTO;
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
        return session.insert("mapper.trainer.trainer.insertTrainer", dto);
    }

    @Override
    public TrainerDTO findByUserId(SqlSession session, int userId) {
        return session.selectOne("mapper.trainer.trainer.findByUserId", userId);
    }

    @Override
    public int updateTrainer(SqlSession session, TrainerDTO dto) {
        return session.update("mapper.trainer.trainer.updateTrainer", dto);
    }

    @Override
    public void deleteSpecializations(SqlSession session, int trainerId) {
        session.delete("mapper.trainer.trainer.deleteSpecializations", trainerId);
    }

    @Override
    public void insertSpecialization(SqlSession session, int trainerId, String type) {
        session.insert("mapper.trainer.trainer.insertSpecialization",
                Map.of("trainerId", trainerId, "type", type));
    }

    @Override
    public void deleteTraits(SqlSession session, int trainerId) {
        session.delete("mapper.trainer.trainer.deleteTraits", trainerId);
    }

    @Override
    public void insertTrait(SqlSession session, int trainerId, String type) {
        session.insert("mapper.trainer.trainer.insertTrait",
                Map.of("trainerId", trainerId, "type", type));
    }

    @Override
    public void updateProfileImage(SqlSession session, int trainerId, String fileName) {
        session.update("mapper.trainer.trainer.updateProfileImage",
                Map.of("trainerId", trainerId, "fileName", fileName));
    }

    @Override
    public Integer findGymIdByGymCode(SqlSession session, String gymCode) {
        return session.selectOne("mapper.trainer.trainer.findGymIdByGymCode", gymCode);
    }

    @Override
    public dto.common.Gym findGymInfoById(SqlSession session, int gymId) {
        return session.selectOne("mapper.trainer.trainer.findGymInfoById", gymId);
    }

    @Override
    public int insertPayoutAccount(SqlSession session, PayoutAccountDTO dto) {
        return session.insert("mapper.trainer.payout_account.insertPayoutAccount", dto);
    }

    @Override
    public void deletePayoutAccount(SqlSession session, int trainerId) {
        session.delete("mapper.trainer.payout_account.deleteByTrainerId", trainerId);
    }

    @Override
    public PayoutAccountDTO getPayoutAccountByTrainerId(SqlSession session, int trainerId) {
        return session.selectOne("mapper.trainer.payout_account.findByTrainerId", trainerId);
    }

    @Override
    public List<String> findSpecializationsByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("mapper.trainer.trainer.findSpecializationsByTrainerId", trainerId);
    }

    @Override
    public List<String> findTraitsByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("mapper.trainer.trainer.findTraitsByTrainerId", trainerId);
    }

    // ── Certifications ───────────────────────────────────────────────────────

    @Override
    public void deleteCertifications(SqlSession session, int trainerId) {
        session.delete("mapper.trainer.certification.deleteCertifications", trainerId);
    }

    @Override
    public void insertCertification(SqlSession session, CertificationDTO dto) {
        session.insert("mapper.trainer.certification.insertCertification", dto);
    }

    @Override
    public List<CertificationDTO> findCertificationsByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("mapper.trainer.certification.findByTrainerId", trainerId);
    }

    // ── Pricing ──────────────────────────────────────────────────────────────

    @Override
    public void deletePricing(SqlSession session, int trainerId) {
        session.delete("mapper.trainer.pricing_availability.deletePricing", trainerId);
    }

    @Override
    public void insertPricing(SqlSession session, PricingDTO dto) {
        session.insert("mapper.trainer.pricing_availability.insertPricing", dto);
    }

    @Override
    public List<PricingDTO> findPricingByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("mapper.trainer.pricing_availability.findPricingByTrainerId", trainerId);
    }

    // ── Availability ─────────────────────────────────────────────────────────

    @Override
    public void deleteAvailability(SqlSession session, int trainerId) {
        session.delete("mapper.trainer.pricing_availability.deleteAvailability", trainerId);
    }

    @Override
    public void insertAvailability(SqlSession session, AvailabilityDTO dto) {
        session.insert("mapper.trainer.pricing_availability.insertAvailability", dto);
    }

    @Override
    public List<AvailabilityDTO> findAvailabilityByTrainerId(SqlSession session, int trainerId) {
        return session.selectList("mapper.trainer.pricing_availability.findAvailabilityByTrainerId", trainerId);
    }

    @Override
    public void resetApprovalStatusToPending(SqlSession session, int trainerId) {
        session.update("mapper.trainer.trainer.resetApprovalStatusToPending", trainerId);
    }
}
