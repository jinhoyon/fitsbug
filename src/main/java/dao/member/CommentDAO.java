package dao.member;

import java.util.List;

import dto.member.CommentDTO;

public interface CommentDAO {
    void insert(CommentDTO dto);

    List<CommentDTO> findByPostNum(int postNum);
}