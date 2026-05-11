package service.member;

import java.util.List;

import dao.member.CompleteDAO;
import dao.member.CompleteDAOImpl;
import dao.member.PostDAO;
import dao.member.PostDAOImpl;
import dto.member.PostDTO;

public class PostServiceImpl implements PostService {

    private PostDAO     dao         = new PostDAOImpl();
    private CompleteDAO completeDAO = new CompleteDAOImpl();

    @Override
    public int writePost(PostDTO dto, String userEmail) {
        int result = dao.insert(dto);

        // postType = "exerciseComplete" 이면 오운완 기록 저장
        if (result > 0 && "exerciseComplete".equals(dto.getPostType())) {
            completeDAO.insertLog(userEmail);
        }

        return result;
    }

    @Override
    public List<PostDTO> getPosts() {
        return dao.getList();
    }
}
