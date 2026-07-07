package service.trainer;

import dao.member.UserDAOImpl;
import dao.trainer.TrainerDAO;
import dao.trainer.TrainerDAOImpl;
import dto.common.TrainerDTO;
import dto.common.UserDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;
import util.PasswordUtil;

public class LoginServiceImpl implements LoginService {
    private dao.trainer.UserDAO trainerUserDAO = new dao.trainer.UserDAOImpl();
    private dao.member.UserDAO memberUserDAO = new UserDAOImpl();
    private TrainerDAO trainerDAO = new TrainerDAOImpl();

    @Override
    public LoginResult loginTrainer(String email, String password) {

        SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession();

        try {
            UserDTO trainer = trainerUserDAO.getUserTrainer(session, email);

            if (trainer == null) {
                return new LoginResult(LoginResult.Status.ACCOUNT_NOT_FOUND, null);
            }

            if (!trainer.hasRole("TRAINER")) {
                return new LoginResult(LoginResult.Status.NOT_TRAINER, null);
            }

            if (!PasswordUtil.verify(password, trainer.getPassword())) {
                return new LoginResult(LoginResult.Status.WRONG_PASSWORD, null);
            }

            if (!PasswordUtil.isBcryptHash(trainer.getPassword())) {
                memberUserDAO.updatePassword(email, PasswordUtil.hash(password));
            }

            TrainerDTO trainerProfile = trainerDAO.findByUserId(session, trainer.getId());
            if (trainerProfile == null) {
                return new LoginResult(LoginResult.Status.TRAINER_PROFILE_NOT_FOUND, trainer);
            }

            return new LoginResult(LoginResult.Status.SUCCESS, trainer, trainerProfile);

        } catch (Exception e) {
            throw new RuntimeException("Login failed", e);

        } finally {
            session.close();
        }
    }
}
