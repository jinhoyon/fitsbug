package dao.trainer;

import dto.trainer.UserDTO;
import org.apache.ibatis.session.SqlSession;

public class UserDAOImpl implements UserDAO {
    public UserDTO getUserTrainer (SqlSession session, String email) throws Exception {
            return session.selectOne("mapper.TrainerUser.selectUserTrainer", email);
    }

    public UserDTO getUserById(SqlSession session, int id) throws Exception {
        return session.selectOne("mapper.TrainerUser.selectUserById", id);
    }

    public int insertUserTrainer(SqlSession session, UserDTO dto) throws Exception {
        return session.insert("mapper.TrainerUser.insertUserTrainer", dto);
    }

    public int updateUser(SqlSession session, UserDTO dto) throws Exception {
        return session.update("mapper.TrainerUser.updateUser", dto);
    }

    public int updateUserProfile(SqlSession session, UserDTO dto) throws Exception {
        return session.update("mapper.TrainerUser.updateUserProfile", dto);
    }
}
