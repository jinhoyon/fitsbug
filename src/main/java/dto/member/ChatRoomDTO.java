package dto.member;

/**
 * ↔ CHAT_ROOM 테이블 (신규)
 * id, user_one(FK→USER.id), user_two(FK→USER.id), create_date
 */
public class ChatRoomDTO {

    private int    id;
    private int    userOne;       // user_one (FK → USER.id)
    private int    userTwo;       // user_two (FK → USER.id)
    private String createDate;   // create_date

    // 화면 표시용
    private String userOneNickname;
    private String userTwoNickname;
    private String lastMessage;
    private int    unreadCount;

    public ChatRoomDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserOne() { return userOne; }
    public void setUserOne(int userOne) { this.userOne = userOne; }

    public int getUserTwo() { return userTwo; }
    public void setUserTwo(int userTwo) { this.userTwo = userTwo; }

    public String getCreateDate() { return createDate; }
    public void setCreateDate(String createDate) { this.createDate = createDate; }

    public String getUserOneNickname() { return userOneNickname; }
    public void setUserOneNickname(String userOneNickname) { this.userOneNickname = userOneNickname; }

    public String getUserTwoNickname() { return userTwoNickname; }
    public void setUserTwoNickname(String userTwoNickname) { this.userTwoNickname = userTwoNickname; }

    public String getLastMessage() { return lastMessage; }
    public void setLastMessage(String lastMessage) { this.lastMessage = lastMessage; }

    public int getUnreadCount() { return unreadCount; }
    public void setUnreadCount(int unreadCount) { this.unreadCount = unreadCount; }
}
