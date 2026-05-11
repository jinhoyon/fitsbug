package dto.gym;

import java.util.List;

public class GymTrainerView {
	private int id;
	private String name;
	private String profileImg;
	private Integer memberCount;
	private List<String> advList;
	private String mainSpecial;
	private Integer trainerId;

	public GymTrainerView() {
		super();
	}

	public GymTrainerView(int id, String name, String profileImg, Integer memberCount, List<String> advList,
			String mainSpecial, Integer trainerId) {
		super();
		this.id = id;
		this.name = name;
		this.profileImg = profileImg;
		this.memberCount = memberCount;
		this.advList = advList;
		this.mainSpecial = mainSpecial;
		this.trainerId = trainerId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public Integer getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(Integer memberCount) {
		this.memberCount = memberCount;
	}

	public List<String> getAdvList() {
		return advList;
	}

	public void setAdvList(List<String> advList) {
		this.advList = advList;
	}

	public String getMainSpecial() {
		return mainSpecial;
	}

	public void setMainSpecial(String mainSpecial) {
		this.mainSpecial = mainSpecial;
	}

	public Integer getTrainerId() {
		return trainerId;
	}

	public void setTrainerId(Integer trainerId) {
		this.trainerId = trainerId;
	}

	@Override
	public String toString() {
		return "GymTrainerView [id=" + id + ", name=" + name + ", profileImg=" + profileImg + ", memberCount="
				+ memberCount + ", advList=" + advList + ", mainSpecial=" + mainSpecial + ", trainerId=" + trainerId
				+ "]";
	}

}
