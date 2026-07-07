package dao.gym;

import java.util.List;
import java.util.Map;

import dto.gym.Sales;
import dto.gym.SalesChart;
import dto.gym.SalesSummary;
import dto.gym.SalesTopTrainer;
import dto.gym.TrainerChoose;

public interface GymSalesDao {
	List<Sales> selectSalesList(Map<String, Object> param) throws Exception;
    int selectSalesCount(Map<String, Object> param) throws Exception;
    SalesSummary selectSalesSummary(Map<String, Object> param) throws Exception;
    List<SalesChart> selectSalesChartList(Map<String, Object> param) throws Exception;
    List<SalesTopTrainer> selectTopTrainerList(Map<String, Object> param) throws Exception;
    List<TrainerChoose> selectTrainerList(int gymNum) throws Exception;
    
}
