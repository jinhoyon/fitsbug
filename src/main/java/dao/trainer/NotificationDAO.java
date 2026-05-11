package dao.trainer;

import dto.trainer.NotificationDTO;

import java.time.LocalDate;
import java.util.List;

public interface NotificationDAO {
    List<NotificationDTO> findRecentByUser(String userId, int limit);
    List<NotificationDTO> findRecentByUserAndMember(String userId, String memberName, int limit, LocalDate today);
    int markAsRead(int notificationId, String userId);
    int markAllAsRead(String userId, String memberName);
}
