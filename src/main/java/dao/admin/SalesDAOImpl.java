package dao.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.admin.SalesDTO;
import util.MybatisSqlSessionFactory;

public class SalesDAOImpl implements SalesDAO {

	@Override
	public Map<String, Object> getSalesSummary(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Map<String, Object> map = null;
		try {
			map = sqlSession.selectOne("mapper.admin.sales.getSalesSummary", paramMap);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return map;
	}

	@Override
	public List<SalesDTO> selectSettlementList(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<SalesDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.sales.selectSettlementList", paramMap);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return list;
	}
	
	@Override
	public List<SalesDTO> selectSalesList(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<SalesDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.sales.selectSalesList", paramMap);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return list;
	}

	@Override
	public List<SalesDTO> selectPaymentHistory(Map<String, Object> paramMap) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<SalesDTO> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.sales.selectPaymentHistory", paramMap);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return list;
	}
	
	@Override
	public int updateSettlementStatus(Integer id) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		int status = 0;
		try {
			status = sqlSession.update("mapper.admin.sales.updateSettlementStatus", id);
			sqlSession.commit();
		} catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return status;
	}

	@Override
	public List<Map<String, Object>> selectSettlementDetail(Integer settlementId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		List<Map<String, Object>> list = null;
		try {
			list = sqlSession.selectList("mapper.admin.sales.selectSettlementDetail", settlementId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
		return list;
	}
	
	// [신규] 4. 매출 내역 총 개수 조회 (페이징 계산용)
    @Override
    public int selectSalesCount(Map<String, Object> paramMap) throws Exception {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int count = 0;
        try {
            count = sqlSession.selectOne("mapper.admin.sales.selectSalesCount", paramMap);
        } catch(Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            sqlSession.close();
        }
        return count;
    }

    // [신규] 5. 결제 내역 총 개수 조회 (페이징 계산용)
    @Override
    public int selectPaymentCount(Map<String, Object> paramMap) throws Exception {
        SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        int count = 0;
        try {
            count = sqlSession.selectOne("mapper.admin.sales.selectPaymentCount", paramMap);
        } catch(Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            sqlSession.close();
        }
        return count;
    }
}