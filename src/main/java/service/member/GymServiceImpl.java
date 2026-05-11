package service.member;

import dao.member.GymDAO;
import dao.member.GymDAOImpl;
import dto.member.GymDTO;
import java.util.List;

public class GymServiceImpl implements GymService {

    private GymDAO dao = new GymDAOImpl();

    @Override
    public List<GymDTO> getGymList(String keyword, String category,
                                   String sort, Double lat, Double lng) {
        return dao.getGymList(keyword, category, sort, lat, lng);
    }

    @Override
    public int insertGym(GymDTO dto) {
        return dao.insertGym(dto);
    }
}
