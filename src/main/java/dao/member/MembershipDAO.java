package dao.member;

import dto.member.MembershipDTO;
import dto.member.MembershipRegistrationDTO;
import java.util.List;
import java.util.Map;

public interface MembershipDAO {
    /** @deprecated 대신 decrementLessonCount(int mpId) 사용 */
    void decreaseCount(String email);

    MembershipDTO findById(int id);
    List<MembershipDTO> findByGymId(int gymId);
    List<MembershipDTO> findByTrainerId(int trainerId);

    int insertRegistration(MembershipRegistrationDTO dto);
    List<MembershipRegistrationDTO> findRegistrationByMemberId(int memberId);
    MembershipRegistrationDTO findActiveByMemberId(int memberId);
    int updateRegistrationStatus(Map<String, Object> params);
    int decrementLessonCount(int mpId);
    int addLessonCount(Map<String, Object> params);
    List<MembershipRegistrationDTO> findRegistrationByTrainerId(int trainerId);
}
