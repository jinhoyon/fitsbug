package service.member;

import java.util.List;

import dto.member.CommentDTO;

public interface CommentService {
    void write(CommentDTO dto);

    List<CommentDTO> getComments(int postNum);
}