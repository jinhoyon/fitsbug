package dao.member;

import java.util.Map;

import dto.member.MemberDTO;
import dto.common.UserDTO;

/**
 * 마이페이지 DAO
 * ✅ WorkoutPlanDTO 완전 제거 → MemberDTO 로 통합
 */
public interface MyPageDAO {

    // USER 테이블 조회 (로그인 정보)
    UserDTO selectUser(String email);

    // MEMBER 테이블 조회 (회원 정보 + 운동 계획 통합)
    Map<String, Object> selectMember(String email);

    // USER 기본 정보 수정 (nickname, phone)
    void updateUser(UserDTO user);

    // MEMBER 운동 계획 수정 (height, weight, diet, goals, experience)
    void updateMemberPlan(MemberDTO member);

    // 프로필 이미지 수정
    void updateProfileImg(UserDTO user);
}
