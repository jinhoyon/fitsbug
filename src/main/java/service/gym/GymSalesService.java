package service.gym;

import java.util.List;
import java.util.Map;

import dto.gym.Sales;
import dto.gym.SalesChart;
import dto.gym.SalesSummary;
import dto.gym.SalesTopTrainer;
import dto.gym.TrainerChoose;

public interface GymSalesService {
	List<Sales> getSalesList(Map<String, Object> param) throws Exception;
    int getSalesCount(Map<String, Object> param) throws Exception;
    SalesSummary getSalesSummary(Map<String, Object> param) throws Exception;
    List<SalesChart> getSalesChartList(Map<String, Object> param) throws Exception;
    List<SalesTopTrainer> getTopTrainerList(Map<String, Object> param) throws Exception;
    List<TrainerChoose> getTrainerList(int gymNum) throws Exception;
}
