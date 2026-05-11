package dto.gym;

public class TrainerChoose {
	private int trainerId;
    private String trainerName;
	public TrainerChoose() {
		super();
	}
	public TrainerChoose(int trainerId, String trainerName) {
		super();
		this.trainerId = trainerId;
		this.trainerName = trainerName;
	}
	public int getTrainerId() {
		return trainerId;
	}
	public void setTrainerId(int trainerId) {
		this.trainerId = trainerId;
	}
	public String getTrainerName() {
		return trainerName;
	}
	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}
	@Override
	public String toString() {
		return "TrainerChoose [trainerId=" + trainerId + ", trainerName=" + trainerName + "]";
	}
    

}
