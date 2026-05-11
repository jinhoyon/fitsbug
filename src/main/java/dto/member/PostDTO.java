package dto.member;

public class PostDTO {

    private int id;

    // USER 테이블 FK
    private Integer userId;   // USER.nickname (닉네임으로 매핑)

    // free / exerciseComplete
    private String postType;

    private String title;

    private String body;

    private String image;

    private String hashtags;
    
    private String nickName;

    // recommended 컬럼
    private long recommended;

    // created_at
    private String createdAt;

    // hidden / normal
    private String status;
    
    private String profileImage;
    
    public PostDTO() {
        super();
    }

	public PostDTO(int id, Integer userId, String postType, String title, String body, String image, String hashtags,
			String nickName, long recommended, String createdAt, String status, String profileImage) {
		super();
		this.id = id;
		this.userId = userId;
		this.postType = postType;
		this.title = title;
		this.body = body;
		this.image = image;
		this.hashtags = hashtags;
		this.nickName = nickName;
		this.recommended = recommended;
		this.createdAt = createdAt;
		this.status = status;
		this.profileImage = profileImage;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getPostType() {
		return postType;
	}

	public void setPostType(String postType) {
		this.postType = postType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getHashtags() {
		return hashtags;
	}

	public void setHashtags(String hashtags) {
		this.hashtags = hashtags;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public long getRecommended() {
		return recommended;
	}

	public void setRecommended(long recommended) {
		this.recommended = recommended;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	@Override
	public String toString() {
		return "PostDTO [id=" + id + ", userId=" + userId + ", postType=" + postType + ", title=" + title + ", body="
				+ body + ", image=" + image + ", hashtags=" + hashtags + ", nickName=" + nickName + ", recommended="
				+ recommended + ", createdAt=" + createdAt + ", status=" + status + ", profileImage=" + profileImage
				+ "]";
	}

	
}

	