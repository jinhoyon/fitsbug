package dto.member;

public class PostReactionDTO {

    private int id;

    // 게시글 ID
    private int postId;

    // 반응한 사용자 ID
    private String userId;

    // like / good / muscle 등
    private String type;


    public PostReactionDTO() {
        super();
    }


    public PostReactionDTO(int id,
                           int postId,
                           String userId,
                           String type) {

        super();

        this.id = id;
        this.postId = postId;
        this.userId = userId;
        this.type = type;
    }


    public int getId() {
        return id;
    }


    public void setId(int id) {
        this.id = id;
    }


    public int getPostId() {
        return postId;
    }


    public void setPostId(int postId) {
        this.postId = postId;
    }


    public String getUserId() {
        return userId;
    }


    public void setUserId(String userId) {
        this.userId = userId;
    }


    public String getType() {
        return type;
    }


    public void setType(String type) {
        this.type = type;
    }


    @Override
    public String toString() {

        return "PostReactionDTO [id=" + id
                + ", postId=" + postId
                + ", userId=" + userId
                + ", type=" + type
                + "]";
    }
}