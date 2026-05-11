package dto.member;

/**
 * ↔ INQUIRY 테이블 (신규)
 * id, user_id, category(계정/결제/오류/제휴/기타), title, content, file,
 * result, status(WAIT/COMPLETE), reg_date, process_date
 */
public class InquiryDTO {

    private int    id;
    private int    userId;        // user_id (FK → USER.id)
    private String category;      // ENUM('계정','결제','오류','제휴','기타')
    private String title;
    private String content;
    private String file;
    private String result;
    private String status;        // ENUM('WAIT','COMPLETE') DEFAULT 'WAIT'
    private String regDate;       // reg_date
    private String processDate;   // process_date

    // 화면용
    private String userEmail;
    private String userName;

    public InquiryDTO() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getFile() { return file; }
    public void setFile(String file) { this.file = file; }

    public String getResult() { return result; }
    public void setResult(String result) { this.result = result; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }

    public String getProcessDate() { return processDate; }
    public void setProcessDate(String processDate) { this.processDate = processDate; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}
