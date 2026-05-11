package service.trainer;

import dto.trainer.TrainerDTO;
import dto.trainer.UserDTO;

public interface LoginService {
    LoginResult loginTrainer(String email, String password);

    class LoginResult {
        public enum Status {
            SUCCESS,
            ACCOUNT_NOT_FOUND,
            NOT_TRAINER,
            TRAINER_PROFILE_NOT_FOUND,
            WRONG_PASSWORD
        }

        private final Status status;
        private final UserDTO user;
        private final TrainerDTO trainer;

        public LoginResult(Status status, UserDTO user) {
            this(status, user, null);
        }

        public LoginResult(Status status, UserDTO user, TrainerDTO trainer) {
            this.status = status;
            this.user = user;
            this.trainer = trainer;
        }

        public Status getStatus() {
            return status;
        }

        public UserDTO getUser() {
            return user;
        }

        public TrainerDTO getTrainer() {
            return trainer;
        }

        public boolean isSuccess() {
            return status == Status.SUCCESS;
        }
    }
}
