package service.member;

import java.util.List;
import java.util.Map;

import dao.member.PostDAO;
import dao.member.PostDAOImpl;
import dao.member.PostReactionDAO;
import dao.member.PostReactionDAOImpl;
import dto.member.NotificationDTO;

public class PostReactionServiceImpl implements PostReactionService {

    private PostReactionDAO dao    = new PostReactionDAOImpl();
    private PostDAO         postDAO = new PostDAOImpl();
    private NotificationService notificationService = new NotificationServiceImpl();

    @Override
    public int addReaction(int postId, String userEmail, String type) {
        int result = dao.addReaction(postId, userEmail, type);

        if (result > 0 && "like".equals(type)) {
            String writerEmail = postDAO.getWriterEmail(postId);
            if (writerEmail != null && !writerEmail.equals(userEmail)) {
                NotificationDTO n = new NotificationDTO();
                n.setEmail(writerEmail);
                n.setType("like");
                n.setMessage("회원님의 게시글에 좋아요가 눌렸습니다");
                n.setUrl("/member/post");
                notificationService.create(n);
            }
        }

        return result;
    }

    @Override
    public int getReactionCount(int postId, String type) {
        return dao.getReactionCount(postId, type);
    }

    @Override
    public List<Map<String, Object>> getAllCounts(int postId) {
        return dao.getAllCounts(postId);
    }

    @Override
    public int hasReacted(int postId, String userId, String type) {
        return dao.hasReacted(postId, userId, type);
    }
}
