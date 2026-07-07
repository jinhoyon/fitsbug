package service.member;

import java.util.List;
import dto.member.PostDTO;

public interface PostService {
    // postType = "exerciseComplete" 이면 오운완 기록 저장
    int writePost(PostDTO dto, String userEmail);

    List<PostDTO> getPosts();

    List<String> getWeekLog(String email);

    int getStreak(String email);

    int getBestStreak(String email);
}
