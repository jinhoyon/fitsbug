package dao.gym;

import java.util.List;
import java.util.Map;

import dto.gym.Membership;
import dto.gym.MembershipRegistration;
import dto.common.Payment;

public interface GymPaymentDAO {
	int insertMembershipRegistration(MembershipRegistration membershipRegistration)throws Exception;
    int insertPayment(Payment payment)throws Exception;
    MembershipRegistration selectMembershipRegistration(int mrNum)throws Exception;
    Payment selectPayment(int paymentNum)throws Exception;
    Membership selectMembership(int membershipNum)throws Exception;
    List<Payment> selectRefundRequestList(int gymId) throws Exception;
    int countRefundRequest(int gymId) throws Exception;
    void approveRefund(int paymentNum, int gymId) throws Exception;
    List<Payment> selectCancelRequestList(Map<String, Object> param) throws Exception;
    int countCancelRequest(int gymId) throws Exception;
    void updateCancelApprove(int paymentNum, int gymId) throws Exception;
    void cancelPtSessionByPayment(int paymentNum)throws Exception;
    int registerMembershipAndPayment(MembershipRegistration membershipRegistration, Payment payment) throws Exception;
    Payment selectPaymentByOrderId(String orderId);
    int cancelPaymentByOrderId(String orderId, String reason);
    void expireMembershipPtByOrderId(String orderId) throws Exception;
}
