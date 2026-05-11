package service.trainer;

import dao.trainer.TrainerDAO;
import dao.trainer.TrainerDAOImpl;
import dao.trainer.UserDAO;
import dao.trainer.UserDAOImpl;
import dto.trainer.TrainerDTO;
import dto.trainer.UserDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

public class SignupServiceImpl implements SignupService {

    private UserDAO userDAO = new UserDAOImpl();
    private TrainerDAO trainerDAO = new TrainerDAOImpl();

    @Override
    public int signupTrainer(UserDTO dto) {

        SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession(false); // transaction control

        try {

            int result = userDAO.insertUserTrainer(session, dto);

            session.commit(); // ✅ success
            return result;

        } catch (Exception e) {
            session.rollback(); // ❌ fail
            throw new RuntimeException("Signup failed", e);

        } finally {
            session.close();
        }
    }

    @Override
    public UserDTO getUserById(int id) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return userDAO.getUserById(session, id);
        } catch (Exception e) {
            throw new RuntimeException("Get user by id failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public int updateUser(UserDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            int result = userDAO.updateUser(session, dto);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Update user failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public int updateUserProfile(UserDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            int result = userDAO.updateUserProfile(session, dto);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Update user profile failed", e);
        } finally {
            session.close();
        }
    }

    @Override
    public int signupTrainerProfile(TrainerDTO dto) {
        SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession(false);

        try {
            int result = trainerDAO.insertTrainer(session, dto);

            session.commit();
            return result;

        } catch (Exception e) {
            session.rollback();
            throw new RuntimeException("Trainer profile signup failed", e);

        } finally {
            session.close();
        }
    }
}
