package service.member;

import java.util.HashMap;
import java.util.Map;

import dao.member.MyPageDAO;
import dao.member.MyPageDAOImpl;
import dto.member.MemberDTO;
import dto.member.MyPageDTO;
import dto.common.UserDTO;

public class MyPageServiceImpl implements MyPageService {

    private MyPageDAO dao = new MyPageDAOImpl();

    @Override
    public MyPageDTO getMyPage(String email) {

        // selectMember → Map<String,Object> 반환 (MyPageDAO 정의대로)
        Map<String, Object> memberMap = dao.selectMember(email);

        // null 방어: USER 정보로 최소값 채움
        if (memberMap == null) {
            memberMap = new HashMap<>();
        }

        // email이 없으면 USER 테이블에서 보완
        if (memberMap.get("email") == null) {
            UserDTO userDto = dao.selectUser(email);
            if (userDto != null) {
                memberMap.put("email",         userDto.getEmail());
                memberMap.put("nickname",      userDto.getNickname());
                memberMap.put("profile_image", userDto.getProfileImage());
                memberMap.put("role",          userDto.getRole());
            }
        }

        // MyPageDTO는 Map<String,Object> 기반
        MyPageDTO dto = new MyPageDTO();
        dto.setMember(memberMap);
        return dto;
    }

    @Override
    public void updateMyPage(UserDTO user, MemberDTO member) {
        if (user   != null) dao.updateUser(user);
        if (member != null) dao.updateMemberPlan(member);
    }

    @Override
    public void updateProfile_image(UserDTO user) {
        dao.updateProfileImg(user);
    }
}
