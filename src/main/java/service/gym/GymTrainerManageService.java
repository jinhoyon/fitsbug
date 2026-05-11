package service.gym;

import java.util.List;

import dto.gym.TrainerAssign;
import dto.gym.TrainerList;
import dto.gym.TrainerMemberView;

public interface GymTrainerManageService {

    List<TrainerList> getTrainerList(int gymId, String keyword) throws Exception;

    List<TrainerAssign> getTrainerAssignList(int gymId) throws Exception;

    List<TrainerMemberView> getCurrentMembers(int trainerId, int gymId) throws Exception;

    List<TrainerMemberView> getPastMembers(int trainerId, int gymId) throws Exception;

    List<TrainerMemberView> getMembers(int trainerId, int gymId, String type) throws Exception;
}