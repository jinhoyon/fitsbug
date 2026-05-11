package service.gym;

import java.util.List;

import dto.gym.Membership;
import dto.gym.MembershipRegistration;
import dto.gym.Payment;

public interface GymPaymentService {
	int registerMembershipAndPayment(MembershipRegistration membershipRegistration, Payment payment)throws Exception;
    MembershipRegistration getMembershipRegistration(int mrNum)throws Exception;
    Payment getPayment(int paymentNum)throws Exception;
    Membership getMembership(int membershipNum)throws Exception;
    List<Payment> selectRefundRequestList(int gymId) throws Exception;
    int countRefundRequest(int gymId) throws Exception;
    void approveRefund(int paymentNum, int gymId) throws Exception;
    boolean cancelPayment(String orderId, String reason) throws Exception;
}
