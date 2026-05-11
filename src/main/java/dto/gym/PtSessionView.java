package dto.gym;

public class PtSessionView {
	private int id;
    private int trainerId;
    private String trainerName;
    private int clientId;
    private String clientName;
    private String startTime;
    private String endTime;
    private String status;
    private int startHour;
    private int dayOfWeek;
    private String specialization;
    
	public PtSessionView() {
		super();
	}

	public PtSessionView(int id, int trainerId, String trainerName, int clientId, String clientName, String startTime,
			String endTime, String status, int startHour, int dayOfWeek, String specialization) {
		super();
		this.id = id;
		this.trainerId = trainerId;
		this.trainerName = trainerName;
		this.clientId = clientId;
		this.clientName = clientName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.status = status;
		this.startHour = startHour;
		this.dayOfWeek = dayOfWeek;
		this.specialization = specialization;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getStartHour() {
		return startHour;
	}

	public void setStartHour(int startHour) {
		this.startHour = startHour;
	}

	public int getDayOfWeek() {
		return dayOfWeek;
	}

	public void setDayOfWeek(int dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}

	public String getSpecialization() {
		return specialization;
	}

	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}

	@Override
	public String toString() {
		return "PtSessionView [id=" + id + ", trainerId=" + trainerId + ", trainerName=" + trainerName + ", clientId="
				+ clientId + ", clientName=" + clientName + ", startTime=" + startTime + ", endTime=" + endTime
				+ ", status=" + status + ", startHour=" + startHour + ", dayOfWeek=" + dayOfWeek + ", specialization="
				+ specialization + "]";
	}
	
	
	
    
    
}
