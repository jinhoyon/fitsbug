package dto.gym;

public class TrainerList {
	private int trainerId;
    private int userId;
    private String name;
    private String phoneNum;
    private String profileImg;
    private String trainerType;
    private String approvalStatus;
    private Integer memberCount;
	
    public TrainerList() {
		super();
	}

	public TrainerList(int trainerId, int userId, String name, String phoneNum, String profileImg, String trainerType,
			String approvalStatus, Integer memberCount) {
		super();
		this.trainerId = trainerId;
		this.userId = userId;
		this.name = name;
		this.phoneNum = phoneNum;
		this.profileImg = profileImg;
		this.trainerType = trainerType;
		this.approvalStatus = approvalStatus;
		this.memberCount = memberCount;
	}

	public int getTrainerId() {
		return trainerId;
	}

	public void setTrainerId(int trainerId) {
		this.trainerId = trainerId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getTrainerType() {
		return trainerType;
	}

	public void setTrainerType(String trainerType) {
		this.trainerType = trainerType;
	}

	public String getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public Integer getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(Integer memberCount) {
		this.memberCount = memberCount;
	}

	@Override
	public String toString() {
		return "TrainerList [trainerId=" + trainerId + ", userId=" + userId + ", name=" + name + ", phoneNum="
				+ phoneNum + ", profileImg=" + profileImg + ", trainerType=" + trainerType + ", approvalStatus="
				+ approvalStatus + ", memberCount=" + memberCount + "]";
	}

	
    
    
}
