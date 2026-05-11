package dto.member;

public class MyPostDTO {
    private String title;
    private String content;
    private String image;
    private int likeCount;
    private int commentCount;
    
	public MyPostDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MyPostDTO(String title, String content, String image, int likeCount, int commentCount) {
		super();
		this.title = title;
		this.content = content;
		this.image = image;
		this.likeCount = likeCount;
		this.commentCount = commentCount;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

}