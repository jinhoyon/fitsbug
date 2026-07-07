package service.trainer;

import dto.trainer.TrainerDTO;
import dto.common.UserDTO;

public interface SignupService {
    int signupTrainer(UserDTO dto);
    int signupTrainerProfile(TrainerDTO dto);
    UserDTO getUserById(int id);
    int updateUser(UserDTO dto);
    int updateUserProfile(UserDTO dto);
}
