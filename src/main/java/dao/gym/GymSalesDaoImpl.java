package dao.gym;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.gym.Sales;
import dto.gym.SalesChart;
import dto.gym.SalesSummary;
import dto.gym.SalesTopTrainer;
import dto.gym.TrainerChoose;
import util.MybatisSqlSessionFactory;

public class GymSalesDaoImpl implements GymSalesDao {

	@Override
	public List<Sales> selectSalesList(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.sales.selectSalesList", param);
		}finally {
			session.close();
		}
	}

	@Override
	public int selectSalesCount(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.sales.selectSalesCount", param);
		}finally {
			session.close();
		}
	}

	@Override
	public SalesSummary selectSalesSummary(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectOne("mapper.sales.selectSalesSummary", param);
		}finally {
			session.close();
		}
	}

	@Override
	public List<SalesChart> selectSalesChartList(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.sales.selectSalesChartList", param);
		}finally {
			session.close();
		}
	}

	@Override
	public List<SalesTopTrainer> selectTopTrainerList(Map<String, Object> param) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.sales.selectTopTrainerList", param);
		}finally {
			session.close();
		}
	}

	@Override
	public List<TrainerChoose> selectTrainerList(int gymNum) throws Exception {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return session.selectList("mapper.sales.selectTrainerList", gymNum);
		}finally {
			session.close();
		}
	}

	

}
