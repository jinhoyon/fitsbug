package dao.trainer;

import dto.trainer.NotificationDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.time.LocalDate;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NotificationDAOImpl implements NotificationDAO {

    @Override
    public List<NotificationDTO> findRecentByUser(String userId, int limit) {
        return findRecentByUserAndMember(userId, null, limit, LocalDate.now());
    }

    @Override
    public List<NotificationDTO> findRecentByUserAndMember(String userId, String memberName, int limit, LocalDate today) {
        if (userId == null || userId.trim().isEmpty()) {
            return Collections.emptyList();
        }

        int safeLimit = limit > 0 ? limit : 20;

        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("memberName", memberName);
        params.put("limit", safeLimit);
        params.put("today", today.toString()); // "2026-04-23"

        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return sqlSession.selectList("mapper.notification.findRecentByUserAndMember", params);
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    @Override
    public int markAsRead(int notificationId, String userId) {
        if (notificationId <= 0 || userId == null || userId.trim().isEmpty()) {
            return 0;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("notificationId", notificationId);
        params.put("userId", userId);

        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            int updated = sqlSession.update("mapper.notification.markAsRead", params);
            sqlSession.commit();
            return updated;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int markAllAsRead(String userId, String memberName) {
        if (userId == null || userId.trim().isEmpty()) {
            return 0;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("memberName", memberName);

        try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            int updated = sqlSession.update("mapper.notification.markAllAsRead", params);
            sqlSession.commit();
            return updated;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
