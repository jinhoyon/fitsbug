package service.trainer;

import dto.common.AvailabilityDTO;
import dto.common.CertificationDTO;
import dto.common.PayoutAccountDTO;
import dto.common.PricingDTO;
import dto.common.TrainerDTO;

import java.util.List;

public interface TrainerService {

    TrainerDTO getTrainerByUserId(int userId);

    int insertTrainer(TrainerDTO trainer);

    int updateTrainer(TrainerDTO trainer);

    void updateProfileWithTagsAndImage(TrainerDTO trainer,
                                       String[] specializations,
                                       String[] strengths,
                                       String fileName);

    Integer findGymIdByGymCode(String gymCode);

    dto.common.Gym getGymInfoById(int gymId);

    int insertPayoutAccount(PayoutAccountDTO dto);

    void replacePayoutAccount(PayoutAccountDTO dto);

    PayoutAccountDTO getPayoutAccountByTrainerId(int trainerId);

    List<String> getSpecializationsByTrainerId(int trainerId);

    List<String> getTraitsByTrainerId(int trainerId);

    // Certifications
    void insertCertifications(int trainerId, String[] certNames,
                               String[] issuingOrgs, String[] issueDates, String[] expiryDates,
                               String[] fileNames);

    List<CertificationDTO> getCertificationsByTrainerId(int trainerId);

    // Pricing & Availability
    void savePricingAndAvailability(int trainerId,
                                    List<PricingDTO> pricing,
                                    List<AvailabilityDTO> availability);

    List<PricingDTO> getPricingByTrainerId(int trainerId);

    List<AvailabilityDTO> getAvailabilityByTrainerId(int trainerId);

    void resetApprovalStatusToPending(int trainerId);
}
