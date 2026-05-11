package service.member;

import java.util.List;
import dto.member.PostDTO;

public interface PostService {
    // isOwun     = 오운완 여부 ("exerciseComplete" 이면 true)
    int writePost(PostDTO dto, String userEmail);

    List<PostDTO> getPosts();
}
