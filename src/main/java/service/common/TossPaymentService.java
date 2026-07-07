package service.common;

import dto.common.TossDTO;
import org.json.JSONObject;

public interface TossPaymentService {

    JSONObject confirmPayment(String paymentKey, String orderId, long amount) throws Exception;

    JSONObject cancelPayment(String paymentKey, String cancelReason) throws Exception;

    void saveToss(TossDTO dto);

    TossDTO findByOrderId(String orderId);

    void updateStatus(String orderId, String status);

    String getPaymentKeyByOrderId(String orderId);
}
