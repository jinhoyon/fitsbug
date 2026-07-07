package dao.trainer;

import dto.trainer.NotificationDTO;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDate;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NotificationDAOImpl implements NotificationDAO {

    @Override
    public List<NotificationDTO> findRecentByUser(SqlSession session, String userId, int limit) {
        return findRecentByUserAndMember(session, userId, null, limit, LocalDate.now());
    }

    @Override
    public List<NotificationDTO> findRecentByUserAndMember(SqlSession session, String userId,
            String memberName, int limit, LocalDate today) {
        if (userId == null || userId.trim().isEmpty()) {
            return Collections.emptyList();
        }

        int safeLimit = limit > 0 ? limit : 20;
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("memberName", memberName);
        params.put("limit", safeLimit);
        params.put("today", today.toString());

        return session.selectList("mapper.notification.findRecentByUserAndMember", params);
    }

    @Override
    public int markAsRead(SqlSession session, int notificationId, String userId) {
        if (notificationId <= 0 || userId == null || userId.trim().isEmpty()) {
            return 0;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("notificationId", notificationId);
        params.put("userId", userId);
        return session.update("mapper.notification.markAsRead", params);
    }

    @Override
    public int markAllAsRead(SqlSession session, String userId, String memberName) {
        if (userId == null || userId.trim().isEmpty()) {
            return 0;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("memberName", memberName);
        return session.update("mapper.notification.markAllAsRead", params);
    }
}
