package dto.admin;

import java.sql.Timestamp;

public class InquiryDTO {
	private Integer inquiryId;
    private Integer userId;
    private String userName;
    private String category; // ENUM 매칭
    private String title;
    private String content;
    private String file;
    private String result;
    private String status;   // ENUM 매칭
    private Timestamp regDate;
    private Timestamp processDate;
    
	public InquiryDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public InquiryDTO(Integer inquiryId, Integer userId, String userName, String category, String title, String content, String file,
			String result, String status, Timestamp regDate, Timestamp processDate) {
		super();
		this.inquiryId = inquiryId;
		this.userId = userId;
		this.userName = userName;
		this.category = category;
		this.title = title;
		this.content = content;
		this.file = file;
		this.result = result;
		this.status = status;
		this.regDate = regDate;
		this.processDate = processDate;
	}

	public Integer getInquiryId() {
		return inquiryId;
	}

	public void setInquiryId(Integer inquiryId) {
		this.inquiryId = inquiryId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
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

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public Timestamp getProcessDate() {
		return processDate;
	}

	public void setProcessDate(Timestamp processDate) {
		this.processDate = processDate;
	}
}