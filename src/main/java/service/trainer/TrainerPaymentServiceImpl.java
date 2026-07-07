package service.trainer;

import dao.trainer.PaymentDAO;
import dao.trainer.PaymentDAOImpl;
import dto.trainer.PaymentDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

public class TrainerPaymentServiceImpl implements TrainerPaymentService {

    private final PaymentDAO paymentDAO = new PaymentDAOImpl();

    @Override
    public PaymentDTO getPaymentByOrderId(String orderId) {
        SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return paymentDAO.getPaymentByOrderId(session, orderId);
        } finally {
            session.close();
        }
    }
}
