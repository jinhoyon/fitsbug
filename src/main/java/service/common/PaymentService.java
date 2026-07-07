package service.common;

import dto.common.Payment;

import java.util.List;

public interface PaymentService {

    Payment insert(Payment payment);

    Payment findById(int id);

    List<Payment> findByUserId(int userId);

    int cancel(int paymentId, String reason);

    int requestRefund(int paymentId, String reason);
}
