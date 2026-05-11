package dto.member;

/**
 * ↔ REPORT 테이블
 * id, reporter_id, target_id, post_id,
 * category(홍보/부적합/혐오/개인정보/기타), title, content, file,
 * result, status(WAIT/REJECT/HIDE), reg_date, process_date
 */
public class ReportDTO {

    private int    id;
    private Integer reporterId;  // reporter_id (FK → USER.id, 신고자)
    private Integer targetId;   // target_id (FK → USER.id, 피신고자)
    private Integer postId;     // post_id (FK → POST.id, nullable)
    private String category;    // ENUM('홍보','부적합','혐오','개인정보','기타')
    private String title;
    private String content;
    private String file;
    private String result;
    private String status;      // ENUM('WAIT','REJECT','HIDE') DEFAULT 'WAIT'
    private String regDate;     // reg_date
    private String processDate; // process_date

    // ── 이전 코드 호환용 ────────────────────────────────────────
    private String reason;     // category 별칭 (이전 코드 호환)
    private String detail;     // content 별칭 (이전 코드 호환)
    private String userId;     // reporterId의 email 표현 (이전 코드 호환)

    public ReportDTO() {}

    public ReportDTO(Integer reporterId, Integer targetId, Integer postId,
                     String category, String title, String content, String status) {
        this.reporterId = reporterId;
        this.targetId   = targetId;
        this.postId     = postId;
        this.category   = category;
        this.title      = title;
        this.content    = content;
        this.status     = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getReporterId() { return reporterId; }
    public void setReporterId(Integer reporterId) { this.reporterId = reporterId; }

    public Integer getTargetId() { return targetId; }
    public void setTargetId(Integer targetId) { this.targetId = targetId; }

    public Integer getPostId() { return postId; }
    public void setPostId(Integer postId) { this.postId = postId; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; this.reason = category; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; this.detail = content; }

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

    // 호환용
    public String getReason() { return category; }
    public void setReason(String reason) { this.reason = reason; this.category = reason; }

    public String getDetail() { return content; }
    public void setDetail(String detail) { this.detail = detail; this.content = detail; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

	@Override
	public String toString() {
		return "ReportDTO [id=" + id + ", reporterId=" + reporterId + ", targetId=" + targetId + ", postId=" + postId
				+ ", category=" + category + ", title=" + title + ", content=" + content + ", file=" + file
				+ ", result=" + result + ", status=" + status + ", regDate=" + regDate + ", processDate=" + processDate
				+ ", reason=" + reason + ", detail=" + detail + ", userId=" + userId + "]";
	}
    
}
