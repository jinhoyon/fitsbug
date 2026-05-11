package service.member;

import dto.member.MemberDTO;
import dto.member.MyPageDTO;
import dto.member.UserDTO;

/**
 * ✅ WorkoutPlanDTO 완전 제거
 *    → 운동 계획 수정도 MemberDTO 로 처리
 */
public interface MyPageService {

    // 마이페이지 통합 조회 (USER + MEMBER)
    MyPageDTO getMyPage(String email);

    // 마이페이지 수정: USER 기본정보 + MEMBER 운동계획 동시 수정
    void updateMyPage(UserDTO user, MemberDTO member);

    // 프로필 이미지 수정
    void updateProfile_image(UserDTO user);
}
