package service.member;

import dto.common.Gym;
import java.util.List;

public interface GymService {
    List<Gym> getGymList(String keyword, String category, String sort, Double lat, Double lng);
    int insertGym(Gym dto);
}
