package service.member;

import java.util.List;

import dao.member.CommentDAO;
import dao.member.CommentDAOImpl;
import dto.member.CommentDTO;

public class CommentServiceImpl implements CommentService {
    private CommentDAO dao = new CommentDAOImpl();

    @Override
    public void write(CommentDTO dto) {
        dao.insert(dto);
    }

    @Override
    public List<CommentDTO> getComments(int postNum) {
        return dao.findByPostNum(postNum);
    }
}