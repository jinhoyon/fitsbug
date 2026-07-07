package dao.trainer;

import dto.common.TrainerDTO;
import dto.common.UserDTO;
import org.apache.ibatis.session.SqlSession;

public interface UserDAO {
    UserDTO getUserTrainer(SqlSession session, String email) throws Exception;
    UserDTO getUserById(SqlSession session, int id) throws Exception;
    int insertUserTrainer(SqlSession session, UserDTO dto) throws Exception;
    int updateUser(SqlSession session, UserDTO dto) throws Exception;
    int updateUserProfile(SqlSession session, UserDTO dto) throws Exception;
}
