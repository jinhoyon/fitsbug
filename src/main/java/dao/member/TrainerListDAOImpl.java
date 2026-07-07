package dao.member;

import dto.common.AvailabilityDTO;
import dto.common.TrainerDTO;

import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TrainerListDAOImpl implements TrainerListDAO {

    @Override
    public List<TrainerDTO> getTrainerList(String keyword, String category, String sort) {
        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> params = new HashMap<>();
            params.put("keyword", keyword != null ? keyword : "");
            params.put("category", category != null ? category : "전체");
            params.put("sort", sort != null ? sort : "latest");
            return sql.selectList("mapper.member.trainer.findTrainerList", params);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public TrainerDTO getTrainerDetail(int trainerId) {
        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sql.selectOne("mapper.TrainerMapper.findById", trainerId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<AvailabilityDTO> findAvailabilityByTrainerId(Integer trainerId) {
        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sql.selectList("pricingAvailability.findAvailabilityByTrainerId", trainerId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Map<String, Object> findTrainerInfoById(Integer trainerId) {
        try (SqlSession sql = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sql.selectOne("mapper.TrainerMapper.findById", trainerId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
