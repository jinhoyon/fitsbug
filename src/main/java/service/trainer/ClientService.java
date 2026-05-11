package service.trainer;

import dto.trainer.ClientDTO;

import java.util.List;

public interface ClientService {
    List<ClientDTO> getClients(int offset, int limit, String filter, String search, int trainerId);

    int getClientCount(String filter, String search, int trainerId);

    ClientDTO getClientById(int clientId);

}

//DAO     → select / insert / update (SQL language)
//Service → get / create / update   (business language)