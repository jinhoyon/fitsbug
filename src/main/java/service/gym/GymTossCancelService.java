package service.gym;

public interface GymTossCancelService {
	boolean cancelPayment(String orderId, String reason) throws Exception;
}
