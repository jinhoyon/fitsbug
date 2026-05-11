package service.trainer;

import dao.trainer.ClientDAO;
import dao.trainer.ClientDAOImpl;
import dto.trainer.ClientDTO;
import org.apache.ibatis.session.SqlSession;
import util.MybatisSqlSessionFactory;

import java.util.List;

public class ClientServiceImpl implements ClientService {

    private ClientDAO clientDAO = new ClientDAOImpl();

    @Override
    public List<ClientDTO> getClients(int offset, int limit, String filter, String search, int trainerId) {

        SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession();

        try {
            return clientDAO.selectClients(session, offset, limit, filter, search, trainerId);

        } finally {
            session.close();
        }
    }

    @Override
    public int getClientCount(String filter, String search, int trainerId) {

        SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession();

        try {
            return clientDAO.selectClientCount(session, filter, search, trainerId);
        } finally {
            session.close();
        }
    }

    @Override
    public ClientDTO getClientById(int clientId) {
        SqlSession session = MybatisSqlSessionFactory
                .getSqlSessionFactory()
                .openSession();
        try {
            return clientDAO.selectClientById(session, clientId);
        } finally {
            session.close();
        }
    }
}
//DAO     → select / insert / update (SQL language)
//Service → get / create / update   (business language)