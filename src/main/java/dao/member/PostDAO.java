package dao.member;

import java.util.List;

import dto.member.PostDTO;

public interface PostDAO {
    int insert(PostDTO dto);
    List<PostDTO> getList();
	String getWriterEmail(int postId);
}