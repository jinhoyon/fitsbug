/*
 * package service.member;
 * 
 * import dto.common.UserDTO; import java.util.List;
 * 
 * public interface UserService { int register(UserDTO dto); int
 * registerSocial(UserDTO dto); UserDTO login(String email, String password)
 * throws Exception; boolean isEmailExists(String email); UserDTO
 * findByEmail(String email); List<UserDTO> findAll(); int update(UserDTO dto);
 * int updatePassword(String email, String password); int delete(int id); }
 */
package service.member;

import dto.common.UserDTO;
import java.util.List;

public interface UserService {
    int register(UserDTO dto);
    int registerSocial(UserDTO dto);

    // 로그인
    UserDTO login(String email, String password) throws Exception;

    boolean isEmailExists(String email);
    UserDTO findByEmail(String email);
    List<UserDTO> findAll();
    int update(UserDTO dto);
    int updatePassword(String email, String password);
    int delete(int id);
}