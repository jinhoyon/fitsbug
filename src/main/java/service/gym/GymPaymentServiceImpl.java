package service.gym;

import java.util.List;

import dao.gym.GymPaymentDao;
import dao.gym.GymPaymentDaoImpl;
import dto.gym.Membership;
import dto.gym.MembershipRegistration;
import dto.common.Payment;

public class GymPaymentServiceImpl implements GymPaymentService{
	private GymPaymentDao dao = new GymPaymentDaoImpl();

	@Override
	public int registerMembershipAndPayment(MembershipRegistration membershipRegistration, Payment payment) throws Exception{
		return dao.registerMembershipAndPayment(membershipRegistration, payment);
	}

	@Override
	public MembershipRegistration getMembershipRegistration(int mrNum) throws Exception{
		return dao.selectMembershipRegistration(mrNum);
	}

	@Override
	public Payment getPayment(int paymentNum) throws Exception{
		return dao.selectPayment(paymentNum);
	}

	@Override
	public Membership getMembership(int membershipNum) throws Exception{
		return dao.selectMembership(membershipNum);
	}

	@Override
	public List<Payment> selectRefundRequestList(int gymId) throws Exception {
		return dao.selectRefundRequestList(gymId);
	}

	@Override
	public int countRefundRequest(int gymId) throws Exception {
		return dao.countRefundRequest(gymId);
	}

	@Override
	public void approveRefund(int paymentNum, int gymId) throws Exception {
		dao.approveRefund(paymentNum, gymId);
	    dao.cancelPtSessionByPayment(paymentNum);
	}

	

	@Override
	public boolean cancelPayment(String orderId, String reason) throws Exception {
		 Payment payment =
		            dao.selectPaymentByOrderId(orderId);

		    if (payment == null) {
		        throw new RuntimeException("결제 내역이 없습니다.");
		    }

		    if (!"결제완료".equals(payment.getStatus())) {
		        throw new RuntimeException("취소 가능한 상태가 아닙니다.");
		    }

		    GymTossCancelService cancelService =
		            new GymTossCancelServiceImpl();

		    boolean cancelResult =
		            cancelService.cancelPayment(orderId, reason);

		    if (!cancelResult) {
		        throw new RuntimeException("포트원 결제 취소 실패");
		    }

		    int result =
		            dao.cancelPaymentByOrderId(orderId, reason);
		    dao.expireMembershipPtByOrderId(orderId);

		    
		    dao.cancelPtSessionByPayment(payment.getPaymentNum());

		    return result > 0;
	}

}
