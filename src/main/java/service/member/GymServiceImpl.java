package service.member;

import dao.member.GymDAO;
import dao.member.GymDAOImpl;
import dto.member.GymDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.ArrayList;
import java.util.List;

public class GymServiceImpl implements GymService {

    private final GymDAO dao = new GymDAOImpl();

    @Override
    public List<GymDTO> getGymList(String keyword, String category,
                                   String sort, Double lat, Double lng) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            List<GymDTO> list = dao.selectGymList(session, keyword, category);
            return enrichAndSort(list, sort, lat, lng);
        } finally {
            session.close();
        }
    }

    @Override
    public int insertGym(GymDTO dto) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(false);
        try {
            int result = dao.insertGym(session, dto);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            return 0;
        } finally {
            session.close();
        }
    }

    private List<GymDTO> enrichAndSort(List<GymDTO> list, String sort, Double lat, Double lng) {
        if (list == null) {
            return new ArrayList<>();
        }

        for (GymDTO gym : list) {
            if (lat != null && lng != null
                    && gym.getLatitude() != 0 && gym.getLongitude() != 0) {
                gym.setDistance(haversine(lat, lng, gym.getLatitude(), gym.getLongitude()));
            } else {
                gym.setDistance(0.0);
            }

            double score = gym.getRating() * 2.0 - (gym.getDistance() * 0.5);
            gym.setScore(Math.max(score, 0));
        }

        switch (sort == null ? "recommend" : sort) {
            case "distance":
                list.sort((a, b) -> Double.compare(a.getDistance(), b.getDistance()));
                break;
            case "rating":
                list.sort((a, b) -> Double.compare(b.getRating(), a.getRating()));
                break;
            default:
                list.sort((a, b) -> Double.compare(b.getScore(), a.getScore()));
                break;
        }

        return list;
    }

    private double haversine(double lat1, double lon1, double lat2, double lon2) {
        final double R = 6371.0;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1))
                * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    }
}
