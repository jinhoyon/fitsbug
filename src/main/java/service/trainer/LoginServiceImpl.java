package service.trainer;

import at.favre.lib.crypto.bcrypt.BCrypt;
import dao.trainer.TrainerDAO;
import dao.trainer.TrainerDAOImpl;
import dao.trainer.UserDAO;
import dao.trainer.UserDAOImpl;
import dto.trainer.TrainerDTO;
import dto.common.UserDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

public class LoginServiceImpl implements LoginService {
    private UserDAO userDAO = new UserDAOImpl();
    private TrainerDAO trainerDAO = new TrainerDAOImpl();

    @Override
    public LoginResult loginTrainer(String email, String password) {

        SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession();

        try {
            UserDTO trainer = userDAO.getUserTrainer(session, email);

            // check user exists
            if (trainer == null) {
                return new LoginResult(LoginResult.Status.ACCOUNT_NOT_FOUND, null);
            }

            // check user is a trainer
            if (!trainer.hasRole("TRAINER")) {
                return new LoginResult(LoginResult.Status.NOT_TRAINER, null);
            }

            // check password
            BCrypt.Result result = BCrypt.verifyer().verify(
                    password.toCharArray(),
                    trainer.getPassword()
            );

            if (!result.verified) {
                return new LoginResult(LoginResult.Status.WRONG_PASSWORD, null);
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
