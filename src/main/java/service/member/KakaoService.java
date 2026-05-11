package service.member;

import dto.member.UserDTO;

// ✅ LoginDTO 삭제됨 → UserDTO로 교체
public interface KakaoService {
    String getAccessToken(String code);
    UserDTO getUserInfo(String token);
}
