package dao.trainer;

import dto.trainer.ClientDTO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public interface ClientDAO {

    // clients (회원상세)
    List<ClientDTO> selectClients(SqlSession session, int offset, int limit, String filter, String search, int trainerId);

    int selectClientCount(SqlSession session, String filter, String search, int trainerId);

    ClientDTO selectClientById(SqlSession session, int clientId);
}
//DAO     → select / insert / update (SQL language)
//Service → get / create / update   (business language)