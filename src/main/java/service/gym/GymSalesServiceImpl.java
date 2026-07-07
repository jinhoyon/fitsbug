package service.gym;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.gym.GymSalesDAO;
import dao.gym.GymSalesDAOImpl;
import dto.gym.Sales;
import dto.gym.SalesChart;
import dto.gym.SalesSummary;
import dto.gym.SalesTopTrainer;
import dto.gym.TrainerChoose;

public class GymSalesServiceImpl implements GymSalesService {
	private GymSalesDAO dao = new GymSalesDAOImpl();
	
	@Override
	public List<Sales> getSalesList(Map<String, Object> param) throws Exception {
		List<Sales> list = dao.selectSalesList(param);

		for (Sales s : list) {
		    s.setNetPrice(s.getPaymentPrice().subtract(s.getPaymentFee()));

		    boolean started = false;

		    if (s.getStartDate() != null) {
		        LocalDate startDate = s.getStartDate()
		                .toLocalDateTime()
		                .toLocalDate();

		        started = !startDate.isAfter(LocalDate.now());
		    }

		    s.setStarted(started);
		}

	    return list;
	}

	@Override
	public int getSalesCount(Map<String, Object> param) throws Exception {
		return dao.selectSalesCount(param);
	}

	@Override
	public SalesSummary getSalesSummary(Map<String, Object> param) throws Exception {
		SalesSummary current = dao.selectSalesSummary(param);

		if (current == null) {
			current = new SalesSummary();
		}

		String startDateStr = (String) param.get("startDate");
		String endDateStr = (String) param.get("endDate");

		if (startDateStr == null || startDateStr.isBlank()
				|| endDateStr == null || endDateStr.isBlank()) {
			current.setGrowthRate(0.0);
			return current;
		}

		LocalDate startDate = LocalDate.parse(startDateStr);
		LocalDate endDate = LocalDate.parse(endDateStr);

		Map<String, Object> prevParam = new HashMap<>(param);
		prevParam.put("startDate", startDate.minusMonths(1).toString());
		prevParam.put("endDate", endDate.minusMonths(1).toString());

		SalesSummary prev = dao.selectSalesSummary(prevParam);

		BigDecimal currentSales = current.getTotalSales() == null ? BigDecimal.ZERO : current.getTotalSales();
		BigDecimal prevSales = (prev == null || prev.getTotalSales() == null)
		        ? BigDecimal.ZERO
		        : prev.getTotalSales();

		double growthRate = 0.0;

		if (prevSales.compareTo(BigDecimal.ZERO) > 0) {
		    growthRate = currentSales
		            .subtract(prevSales)
		            .divide(prevSales, 4, RoundingMode.HALF_UP)
		            .multiply(BigDecimal.valueOf(100))
		            .doubleValue();

		    growthRate = Math.round(growthRate * 10) / 10.0;
		}

		current.setGrowthRate(growthRate);

		return current;
	}

	@Override
	public List<SalesChart> getSalesChartList(Map<String, Object> param) throws Exception {
		String startDateStr = (String) param.get("startDate");
	    String endDateStr = (String) param.get("endDate");

	    LocalDate startDate = LocalDate.parse(startDateStr);
	    LocalDate endDate = LocalDate.parse(endDateStr);

	    long days = java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate) + 1;

	    if (days <= 31) {
	        param.put("chartType", "day");
	    } else if (days <= 180) {
	        param.put("chartType", "week");
	    } else if (days <= 730) {
	        param.put("chartType", "month");
	    } else {
	        param.put("chartType", "year");
	    }

	    List<SalesChart> list = dao.selectSalesChartList(param);

	    BigDecimal maxSales = BigDecimal.ZERO;

	    for (SalesChart chart : list) {
	        BigDecimal sales = chart.getSales() == null ? BigDecimal.ZERO : chart.getSales();

	        if (sales.compareTo(maxSales) > 0) {
	            maxSales = sales;
	        }
	    }

	    for (SalesChart chart : list) {
	        BigDecimal sales = chart.getSales() == null ? BigDecimal.ZERO : chart.getSales();

	        int percent = 0;

	        if (maxSales.compareTo(BigDecimal.ZERO) > 0) {
	            percent = sales
	                    .multiply(BigDecimal.valueOf(100))
	                    .divide(maxSales, 0, RoundingMode.HALF_UP)
	                    .intValue();
	        }

	        chart.setPercent(percent);
	    }

	    return list;
	}

	@Override
	public List<SalesTopTrainer> getTopTrainerList(Map<String, Object> param) throws Exception {
		return dao.selectTopTrainerList(param);
	}

	@Override
	public List<TrainerChoose> getTrainerList(int gymNum) throws Exception {
		return dao.selectTrainerList(gymNum);
	}

}
