package dao.trainer;

import dto.trainer.ClientDTO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import util.MybatisSqlSessionFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClientDAOImpl implements ClientDAO {

    // list of clients
    @Override
    public List<ClientDTO> selectClients(SqlSession session, int offset, int limit, String filter, String search, int trainerId) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        params.put("filter", filter);
        params.put("search", search);
        params.put("trainerId", trainerId);

        return session.selectList("mapper.trainer.client.selectClients", params);
    }

    // total client count
    @Override
    public int selectClientCount(SqlSession session, String filter, String search, int trainerId) {
        Map<String, Object> params = new HashMap<>();
        params.put("filter", filter);
        params.put("search", search);
        params.put("trainerId", trainerId);

        return session.selectOne("mapper.trainer.client.countClients", params);
    }

    // client by Id
    public ClientDTO selectClientById(SqlSession session, int clientId) {
            return session.selectOne("mapper.trainer.client.selectClientById", clientId);
    }
}

//DAO     → select / insert / update (SQL language)
//Service → get / create / update   (business language)