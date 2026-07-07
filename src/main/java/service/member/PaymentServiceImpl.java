package service.member;

import dto.common.NotificationDTO;
import dto.common.Payment;

public class PaymentServiceImpl implements PaymentService {

    private final service.common.PaymentService paymentService = new service.common.PaymentServiceImpl();
    private final NotificationService notificationService = new NotificationServiceImpl();

    @Override
    public Payment createPayment(Payment dto) {
        dto.setStatus("READY");
        return paymentService.insert(dto);
    }

    @Override
    public void success(String orderId, String email) {
        NotificationDTO n = new NotificationDTO();
        n.setEmail(email);
        n.setType("payment");
        n.setMessage("회원권 결제가 완료되었습니다");
        n.setUrl("mypage.jsp");
        notificationService.create(n);
    }

    @Override
    public Payment getActivePayment(String email) {
        try (org.apache.ibatis.session.SqlSession session =
                     util.MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            dto.common.UserDTO user = session.selectOne("mapper.member.user.findByEmail", email);
            if (user == null) {
                return null;
            }
            java.util.List<Payment> list = paymentService.findByUserId(user.getId());
            return list.isEmpty() ? null : list.get(0);
        }
    }

    @Override
    public void requestCancel(String orderId) {
        // Domain controllers resolve orderId → payment id before cancel.
    }

    @Override
    public void requestRefund(String orderId) {
        // Domain controllers resolve orderId → payment id before refund.
    }
}
