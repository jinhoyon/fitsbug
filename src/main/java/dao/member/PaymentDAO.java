package dao.member;

import dto.common.Payment;
import java.util.List;
import java.util.Map;

public interface PaymentDAO {
    int insert(Payment dto);
    void updateStatus(String orderId, String status);
    Payment findActiveByEmail(String email);
    List<Payment> findByUserId(int userId);
    Payment findById(int id);
    int cancel(Map<String, Object> params);
    int requestRefund(Map<String, Object> params);
}
