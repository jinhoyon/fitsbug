package dao.member;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.member.ExerciseGuideDTO;
import util.MybatisSqlSessionFactory;

public class ExerciseDAOImpl implements ExerciseDAO {

    private static final String NS = "mapper.member.exercise_guide.";

    // ── 전체 조회 ─────────────────────────────────────────────
    @Override
    public List<ExerciseGuideDTO> getAllExercises() {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<ExerciseGuideDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "getAllExercises");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    // ── 키워드 검색 ───────────────────────────────────────────
    @Override
    public List<ExerciseGuideDTO> searchExercises(String keyword) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<ExerciseGuideDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "searchExercises", keyword);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    // ── id로 단건 조회 ────────────────────────────────────────
    public ExerciseGuideDTO findById(int id) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        ExerciseGuideDTO result = null;
        try {
            result = session.selectOne(NS + "findById", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }

    // ── targetMuscle로 필터 조회 ──────────────────────────────
    public List<ExerciseGuideDTO> findByMuscle(String targetMuscle) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        List<ExerciseGuideDTO> list = new ArrayList<>();
        try {
            list = session.selectList(NS + "findByMuscle", targetMuscle);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }
}
