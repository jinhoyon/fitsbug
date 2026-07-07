package service.trainer;

import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EarningsServiceImpl implements EarningsService {

    private static final int SETTLEMENT_PAGE_SIZE = 12;
    private static final int TRANSACTION_PAGE_SIZE = 20;

    @Override
    public EarningsOverview getOverview(int trainerId, String currentMonth) {
        Map<String, Object> currentSettlement = null;
        List<Map<String, Object>> settlementHistory = new ArrayList<>();
        List<Map<String, Object>> transactions = new ArrayList<>();

        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            try {
                Map<String, Object> param = new HashMap<>();
                param.put("trainerId", trainerId);
                param.put("month", currentMonth);
                currentSettlement = session.selectOne("mapper.trainer.settlement.findCurrentMonth", param);
            } catch (Exception e) {
                e.printStackTrace();
            }

            try {
                settlementHistory = session.selectList("mapper.trainer.settlement.findAllByTrainer", trainerId);
            } catch (Exception e) {
                e.printStackTrace();
            }

            try {
                transactions = session.selectList("mapper.member.payment.findAllByTrainerId", trainerId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } finally {
            session.close();
        }

        return new EarningsOverview(currentSettlement, settlementHistory, transactions, currentMonth);
    }

    @Override
    public SettlementPage getSettlementPage(int trainerId, int page, String sortBy, String sortDir) {
        if (page < 1) {
            page = 1;
        }

        int totalCount = 0;
        List<Map<String, Object>> settlementHistory = new ArrayList<>();

        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            try {
                totalCount = session.selectOne("mapper.trainer.settlement.countAllByTrainer", trainerId);
            } catch (Exception e) {
                e.printStackTrace();
            }

            try {
                Map<String, Object> param = new HashMap<>();
                param.put("trainerId", trainerId);
                param.put("limit", SETTLEMENT_PAGE_SIZE);
                param.put("offset", (page - 1) * SETTLEMENT_PAGE_SIZE);
                param.put("sortBy", sortBy);
                param.put("sortDir", sortDir);
                settlementHistory = session.selectList("mapper.trainer.settlement.findAllByTrainerPaged", param);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } finally {
            session.close();
        }

        int totalPages = (int) Math.ceil((double) totalCount / SETTLEMENT_PAGE_SIZE);
        return new SettlementPage(settlementHistory, totalCount, page, totalPages, sortBy, sortDir);
    }

    @Override
    public TransactionsPage getTransactionsPage(int trainerId, int page, String sortBy, String sortDir,
            String dateFrom, String dateTo) {
        if (page < 1) {
            page = 1;
        }

        int totalCount = 0;
        List<Map<String, Object>> transactions = new ArrayList<>();

        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            try {
                Map<String, Object> countParam = new HashMap<>();
                countParam.put("trainerId", trainerId);
                countParam.put("dateFrom", dateFrom);
                countParam.put("dateTo", dateTo);
                totalCount = session.selectOne("mapper.member.payment.countByTrainerId", countParam);
            } catch (Exception e) {
                e.printStackTrace();
            }

            try {
                Map<String, Object> param = new HashMap<>();
                param.put("trainerId", trainerId);
                param.put("limit", TRANSACTION_PAGE_SIZE);
                param.put("offset", (page - 1) * TRANSACTION_PAGE_SIZE);
                param.put("sortBy", sortBy);
                param.put("sortDir", sortDir);
                param.put("dateFrom", dateFrom);
                param.put("dateTo", dateTo);
                transactions = session.selectList("mapper.member.payment.findByTrainerIdPaged", param);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } finally {
            session.close();
        }

        int totalPages = (int) Math.ceil((double) totalCount / TRANSACTION_PAGE_SIZE);
        return new TransactionsPage(transactions, totalCount, page, totalPages, sortBy, sortDir, dateFrom, dateTo);
    }
}
