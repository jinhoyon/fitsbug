package dao.member;

import dto.common.NotificationDTO;
import java.util.List;

public interface NotificationDAO {
    List<NotificationDTO> findByRecvId(String recvId);
    int countUnread(String recvId);
    int insert(NotificationDTO dto);
    int updateReadAll(String recvId);
    int updateReadOne(int id);
}
