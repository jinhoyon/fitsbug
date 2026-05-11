package service.member;

import java.util.List;

import dto.member.ChartDTO;

public interface ChartService {
	List<ChartDTO> getWorkoutChart(String email);
    List<ChartDTO> getFoodChart(String email);
    List<ChartDTO> getInbodyChart(String email);
    
}