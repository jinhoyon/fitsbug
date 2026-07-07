package dao.trainer;

import dto.common.UserDTO;
import org.apache.ibatis.session.SqlSession;

public class UserDAOImpl implements UserDAO {
    public UserDTO getUserTrainer (SqlSession session, String email) throws Exception {
            return session.selectOne("mapper.trainer.user.selectUserTrainer", email);
    }

    public UserDTO getUserById(SqlSession session, int id) throws Exception {
        return session.selectOne("mapper.trainer.user.selectUserById", id);
    }

    public int insertUserTrainer(SqlSession session, UserDTO dto) throws Exception {
        return session.insert("mapper.trainer.user.insertUserTrainer", dto);
    }

    public int updateUser(SqlSession session, UserDTO dto) throws Exception {
        return session.update("mapper.trainer.user.updateUser", dto);
    }

    public int updateUserProfile(SqlSession session, UserDTO dto) throws Exception {
        return session.update("mapper.trainer.user.updateUserProfile", dto);
    }
}
