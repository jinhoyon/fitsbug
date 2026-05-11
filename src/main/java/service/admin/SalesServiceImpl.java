package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.SalesDAO;
import dao.admin.SalesDAOImpl;
import util.PageInfo;

public class SalesServiceImpl implements SalesService {
	
	private SalesDAO salesDAO;
	public SalesServiceImpl() {
		salesDAO = new SalesDAOImpl();
	}
	
	private PageInfo calculatePage(int curPage, int totalCount, int pageSize) {
        // 전체 페이지 수 계산
        int allPage = (int) Math.ceil((double) totalCount / pageSize);
        if (allPage == 0) allPage = 1;

        // 현재 페이지가 전체 페이지보다 크지 않도록 보정
        if (curPage > allPage) curPage = allPage;

        // 페이지 블록 계산 (예: 5개씩 보여줌)
        int blockCount = 5;
        int startPage = ((curPage - 1) / blockCount) * blockCount + 1;
        int endPage = startPage + blockCount - 1;
        
        if (endPage > allPage) endPage = allPage;

        return new PageInfo(curPage, allPage, startPage, endPage);
    }

	@Override
	public Map<String, Object> getDashboardData(Map<String, Object> paramMap) throws Exception {
		Map<String, Object> data = new HashMap<>();

	    // --- [에러 해결 포인트] 안전하게 숫자 꺼내기 ---
	    // paramMap.get() 결과가 null이거나 타입이 다를 수 있으므로 Object로 받아서 처리
	    int salesCurPage = parseMapInt(paramMap, "salesPage", 1);
	    int paymentCurPage = parseMapInt(paramMap, "paymentPage", 1);
	    int pageSize = parseMapInt(paramMap, "pageSize", 10);

	    // --- 매출 내역(Sales) 처리 ---
	    int totalSalesCount = salesDAO.selectSalesCount(paramMap); 
	    PageInfo salesPager = calculatePage(salesCurPage, totalSalesCount, pageSize);
	    
	    // 계산된 현재 페이지로 오프셋 재설정
	    paramMap.put("salesOffset", (salesPager.getCurPage() - 1) * pageSize);
	    data.put("details", salesDAO.selectSalesList(paramMap));
	    data.put("salesPager", salesPager);

	    // --- 결제 내역(Payment) 처리 ---
	    int totalPaymentCount = salesDAO.selectPaymentCount(paramMap);
	    PageInfo paymentPager = calculatePage(paymentCurPage, totalPaymentCount, pageSize);
	    
	    paramMap.put("paymentOffset", (paymentPager.getCurPage() - 1) * pageSize);
	    data.put("payments", salesDAO.selectPaymentHistory(paramMap));
	    data.put("paymentPager", paymentPager);
	    
	    // 요약 정보
	    data.put("summary", salesDAO.getSalesSummary(paramMap));

	    return data;
	}
	
	private int parseMapInt(Map<String, Object> map, String key, int defaultValue) {
	    Object value = map.get(key);
	    if (value == null) return defaultValue;
	    if (value instanceof Integer) return (Integer) value;
	    try {
	        return Integer.parseInt(value.toString());
	    } catch (NumberFormatException e) {
	        return defaultValue;
	    }
	}
	
	@Override
	public boolean processSettlement(Integer id) throws Exception {
		// 매퍼의 updateSettlementStatus 호출 (status='정산완료', completed_at=NOW() 반영)
        return salesDAO.updateSettlementStatus(id) > 0;
	}

	@Override
	public List<Map<String, Object>> getSettlementDetail(Integer settlementId) throws Exception {
		return salesDAO.selectSettlementDetail(settlementId);
	}
}