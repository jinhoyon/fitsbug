package dao.trainer;

import dto.trainer.NotificationDTO;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDate;
import java.util.List;

public interface NotificationDAO {
    List<NotificationDTO> findRecentByUser(SqlSession session, String userId, int limit);

    List<NotificationDTO> findRecentByUserAndMember(SqlSession session, String userId,
            String memberName, int limit, LocalDate today);

    int markAsRead(SqlSession session, int notificationId, String userId);

    int markAllAsRead(SqlSession session, String userId, String memberName);
}
