package service.member;

import java.util.List;

import dao.member.PtFeedbackDAO;
import dao.member.PtFeedbackDAOImpl;
import dto.common.NotificationDTO;
import dto.member.PtFeedbackDTO;

public class PtFeedbackServiceImpl implements PtFeedbackService {
    private PtFeedbackDAO dao = new PtFeedbackDAOImpl();
    private NotificationService notificationService = new NotificationServiceImpl();
    
    @Override
    public List<PtFeedbackDTO> getList(String email) {
        return dao.getFeedbackList(email);
    }

    @Override
    public PtFeedbackDTO getDetail(int id) {
        return dao.getFeedbackDetail(id);
    }
    
    @Override
    public void addFeedback(PtFeedbackDTO dto) {

        // 1. 피드백 저장
        dao.insertFeedback(dto);

        // 2. 🔥 알림 생성
        NotificationDTO n = new NotificationDTO();
        n.setEmail(dto.getUserEmail());  
        n.setType("feedback");
        n.setMessage("트레이너가 피드백을 남겼습니다");
        n.setUrl("ptFeedback.jsp");

        notificationService.create(n);
}
}