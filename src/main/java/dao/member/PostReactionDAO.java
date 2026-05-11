package dao.member;

import java.util.List;
import java.util.Map;

public interface PostReactionDAO {
    int addReaction(int postId, String userId, String type);

    int getReactionCount(int postId, String type);

    List<Map<String, Object>> getAllCounts(int postId);

    int hasReacted(int postId, String userId, String type);
}
