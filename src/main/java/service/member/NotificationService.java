package service.member;

import java.util.List;

import dto.member.NotificationDTO;

public interface NotificationService {
    List<NotificationDTO> getList(String email);

    int getUnreadCount(String email);

    void create(NotificationDTO dto);

    void readAll(String email);

	void readOne(int id);
}