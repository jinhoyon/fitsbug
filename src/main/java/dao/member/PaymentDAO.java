package dao.member;

import dto.member.PaymentDTO;
import java.util.List;
import java.util.Map;

public interface PaymentDAO {
    int insert(PaymentDTO dto);
    void updateStatus(String orderId, String status);
    PaymentDTO findActiveByEmail(String email);
    List<PaymentDTO> findByUserId(int userId);
    PaymentDTO findById(int id);
    int cancel(Map<String, Object> params);
    int requestRefund(Map<String, Object> params);
}
