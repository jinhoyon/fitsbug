package dto.admin;

import java.sql.Timestamp;

public class ReportDTO {
	private Integer reportId;
    private Integer reporterId;
    private String reporterName;
    private Integer targetId;
    private String targetName;
    private Integer postNum;
    private String category; // ENUM 매칭
    private String title;
    private String content;
    private String file;
    private String result;
    private String status;   // ENUM 매칭
    private Timestamp regDate;
    private Timestamp processDate;
    
	public ReportDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ReportDTO(Integer reportId, Integer reporterId, String reporterName, Integer targetId, String targetName,
			Integer postNum, String category, String title, String content, String file, String result, String status,
			Timestamp regDate, Timestamp processDate) {
		super();
		this.reportId = reportId;
		this.reporterId = reporterId;
		this.reporterName = reporterName;
		this.targetId = targetId;
		this.targetName = targetName;
		this.postNum = postNum;
		this.category = category;
		this.title = title;
		this.content = content;
		this.file = file;
		this.result = result;
		this.status = status;
		this.regDate = regDate;
		this.processDate = processDate;
	}

	public Integer getReportId() {
		return reportId;
	}

	public void setReportId(Integer reportId) {
		this.reportId = reportId;
	}

	public Integer getReporterId() {
		return reporterId;
	}

	public void setReporterId(Integer reporterId) {
		this.reporterId = reporterId;
	}

	public String getReporterName() {
		return reporterName;
	}

	public void setReporterName(String reporterName) {
		this.reporterName = reporterName;
	}

	public Integer getTargetId() {
		return targetId;
	}

	public void setTargetId(Integer targetId) {
		this.targetId = targetId;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}

	public Integer getPostNum() {
		return postNum;
	}

	public void setPostNum(Integer postNum) {
		this.postNum = postNum;
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