package service.trainer;

import dao.trainer.TrainerDAO;
import dao.trainer.TrainerDAOImpl;
import dto.trainer.AvailabilityDTO;
import dto.trainer.CertificationDTO;
import dto.trainer.PayoutAccountDTO;
import dto.trainer.PricingDTO;
import dto.common.TrainerDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.List;

public class TrainerServiceImpl implements TrainerService {

    private TrainerDAO trainerDAO = new TrainerDAOImpl();

    @Override
    public TrainerDTO getTrainerByUserId(int userId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findByUserId(session, userId);
        } finally {
            session.close();
        }
    }

    @Override
    public int insertTrainer(TrainerDTO trainer) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            int result = trainerDAO.insertTrainer(session, trainer);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Insert trainer failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public int updateTrainer(TrainerDTO trainer) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            int result = trainerDAO.updateTrainer(session, trainer);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Update trainer failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public void updateProfileWithTagsAndImage(TrainerDTO trainer,
                                              String[] specializations,
                                              String[] strengths,
                                              String fileName) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            TrainerDTO existing = trainerDAO.findByUserId(session, trainer.getUserId());

            if (existing == null) {
                trainerDAO.insertTrainer(session, trainer);
            } else {
                trainer.setTrainerId(existing.getTrainerId());
                trainerDAO.updateTrainer(session, trainer);
            }

            TrainerDTO saved = trainerDAO.findByUserId(session, trainer.getUserId());
            int trainerId = saved.getTrainerId();

            trainerDAO.deleteSpecializations(session, trainerId);
            if (specializations != null) {
                for (String spec : specializations) {
                    trainerDAO.insertSpecialization(session, trainerId, spec);
                }
            }

            trainerDAO.deleteTraits(session, trainerId);
            if (strengths != null) {
                for (String strength : strengths) {
                    trainerDAO.insertTrait(session, trainerId, strength);
                }
            }

            if (fileName != null) {
                trainerDAO.updateProfileImage(session, trainerId, fileName);
            }

            session.commit();

        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Trainer profile step2 failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public Integer findGymIdByGymCode(String gymCode) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findGymIdByGymCode(session, gymCode);
        } finally {
            session.close();
        }
    }

    @Override
    public dto.gym.Gym getGymInfoById(int gymId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findGymInfoById(session, gymId);
        } finally {
            session.close();
        }
    }

    @Override
    public int insertPayoutAccount(PayoutAccountDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            int result = trainerDAO.insertPayoutAccount(session, dto);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Payout account insert failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public void replacePayoutAccount(PayoutAccountDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            trainerDAO.deletePayoutAccount(session, dto.getTrainerId());
            trainerDAO.insertPayoutAccount(session, dto);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Payout account replace failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public PayoutAccountDTO getPayoutAccountByTrainerId(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.getPayoutAccountByTrainerId(session, trainerId);
        } finally {
            session.close();
        }
    }

    @Override
    public List<String> getSpecializationsByTrainerId(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findSpecializationsByTrainerId(session, trainerId);
        } finally {
            session.close();
        }
    }

    @Override
    public List<String> getTraitsByTrainerId(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findTraitsByTrainerId(session, trainerId);
        } finally {
            session.close();
        }
    }

    // ── Certifications ───────────────────────────────────────────────────────

    @Override
    public void insertCertifications(int trainerId, String[] certNames,
                                     String[] issuingOrgs, String[] issueDates, String[] expiryDates,
                                     String[] fileNames) {
        if (certNames == null || certNames.length == 0) return;

        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            trainerDAO.deleteCertifications(session, trainerId);
            for (int i = 0; i < certNames.length; i++) {
                if (certNames[i] == null || certNames[i].trim().isEmpty()) continue;
                CertificationDTO dto = new CertificationDTO();
                dto.setTrainerId(trainerId);
                dto.setCertName(certNames[i].trim());
                dto.setIssuingOrg(get(issuingOrgs, i));
                dto.setIssueDate(getDate(issueDates, i));
                dto.setExpiryDate(getDate(expiryDates, i));
                dto.setCertFile(get(fileNames, i));
                trainerDAO.insertCertification(session, dto);
            }
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Insert certifications failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public List<CertificationDTO> getCertificationsByTrainerId(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findCertificationsByTrainerId(session, trainerId);
        } finally {
            session.close();
        }
    }

    // ── Pricing & Availability ────────────────────────────────────────────────

    @Override
    public void savePricingAndAvailability(int trainerId,
                                           List<PricingDTO> pricing,
                                           List<AvailabilityDTO> availability) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            trainerDAO.deletePricing(session, trainerId);
            if (pricing != null) {
                for (PricingDTO p : pricing) {
                    p.setTrainerId(trainerId);
                    trainerDAO.insertPricing(session, p);
                }
            }
            trainerDAO.deleteAvailability(session, trainerId);
            if (availability != null) {
                for (AvailabilityDTO a : availability) {
                    a.setTrainerId(trainerId);
                    trainerDAO.insertAvailability(session, a);
                }
            }
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Save pricing/availability failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public List<PricingDTO> getPricingByTrainerId(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findPricingByTrainerId(session, trainerId);
        } finally {
            session.close();
        }
    }

    @Override
    public List<AvailabilityDTO> getAvailabilityByTrainerId(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return trainerDAO.findAvailabilityByTrainerId(session, trainerId);
        } finally {
            session.close();
        }
    }

    @Override
    public void resetApprovalStatusToPending(int trainerId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            trainerDAO.resetApprovalStatusToPending(session, trainerId);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Reset approval status failed", e);
        } finally {
            session.close();
        }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private String get(String[] arr, int i) {
        return (arr != null && i < arr.length && arr[i] != null && !arr[i].isEmpty()) ? arr[i] : null;
    }

    private String getDate(String[] arr, int i) {
        String v = get(arr, i);
        return (v != null && !v.isEmpty()) ? v : null;
    }
}
