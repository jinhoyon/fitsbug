package service.member;

import java.util.List;

import dao.member.NotificationDAO;
import dao.member.NotificationDAOImpl;
import dto.common.NotificationDTO;

public class NotificationServiceImpl implements NotificationService {

    private NotificationDAO dao = new NotificationDAOImpl();
    
    @Override
    public List<NotificationDTO> getList(String email) {
        return dao.findByRecvId(email);
    }

    @Override
    public int getUnreadCount(String email) {
        return dao.countUnread(email);
    }

    @Override
    public void create(NotificationDTO dto) {
        dao.insert(dto);
    }

    @Override
    public void readAll(String email) {
        dao.updateReadAll(email);
    }

    @Override
    public void readOne(int id) {
        dao.updateReadOne(id);
    }
}