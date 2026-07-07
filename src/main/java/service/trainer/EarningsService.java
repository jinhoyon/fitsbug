package service.trainer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface EarningsService {

    EarningsOverview getOverview(int trainerId, String currentMonth);

    SettlementPage getSettlementPage(int trainerId, int page, String sortBy, String sortDir);

    TransactionsPage getTransactionsPage(int trainerId, int page, String sortBy, String sortDir,
            String dateFrom, String dateTo);

    class EarningsOverview {
        public final Map<String, Object> currentSettlement;
        public final List<Map<String, Object>> settlementHistory;
        public final List<Map<String, Object>> transactions;
        public final String currentMonth;

        public EarningsOverview(Map<String, Object> currentSettlement,
                                List<Map<String, Object>> settlementHistory,
                                List<Map<String, Object>> transactions,
                                String currentMonth) {
            this.currentSettlement = currentSettlement;
            this.settlementHistory = settlementHistory;
            this.transactions = transactions;
            this.currentMonth = currentMonth;
        }
    }

    class SettlementPage {
        public final List<Map<String, Object>> settlementHistory;
        public final int totalCount;
        public final int page;
        public final int totalPages;
        public final String sortBy;
        public final String sortDir;

        public SettlementPage(List<Map<String, Object>> settlementHistory, int totalCount,
                              int page, int totalPages, String sortBy, String sortDir) {
            this.settlementHistory = settlementHistory;
            this.totalCount = totalCount;
            this.page = page;
            this.totalPages = totalPages;
            this.sortBy = sortBy;
            this.sortDir = sortDir;
        }
    }

    class TransactionsPage {
        public final List<Map<String, Object>> transactions;
        public final int totalCount;
        public final int page;
        public final int totalPages;
        public final String sortBy;
        public final String sortDir;
        public final String dateFrom;
        public final String dateTo;

        public TransactionsPage(List<Map<String, Object>> transactions, int totalCount,
                                int page, int totalPages, String sortBy, String sortDir,
                                String dateFrom, String dateTo) {
            this.transactions = transactions;
            this.totalCount = totalCount;
            this.page = page;
            this.totalPages = totalPages;
            this.sortBy = sortBy;
            this.sortDir = sortDir;
            this.dateFrom = dateFrom;
            this.dateTo = dateTo;
        }
    }
}
