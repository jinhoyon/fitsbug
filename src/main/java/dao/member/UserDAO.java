package dao.member;

import dto.common.UserDTO;
import java.util.List;

public interface UserDAO {

    int insert(UserDTO dto);
    int insertSocial(UserDTO dto);                      // 카카오/네이버 소셜 가입
    UserDTO findByEmailAndPassword(String email, String password);
    UserDTO findByEmail(String email);
    boolean isEmailExists(String email);
    List<UserDTO> findAll();
    int update(UserDTO dto);
    int updatePassword(String email, String password);
    int delete(int id);
}
