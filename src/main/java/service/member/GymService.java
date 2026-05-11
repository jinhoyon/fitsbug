package service.member;

import dto.member.GymDTO;
import java.util.List;

public interface GymService {
    List<GymDTO> getGymList(String keyword, String category, String sort, Double lat, Double lng);
    int insertGym(GymDTO dto);
}
