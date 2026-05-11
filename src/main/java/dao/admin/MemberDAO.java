package dao.admin;

import java.util.List;
import java.util.Map;

import dto.admin.MemberDTO;

public interface MemberDAO {
	
	List<MemberDTO> selectAllGym() throws Exception;
	List<MemberDTO> selectAllTrainer() throws Exception;
	List<MemberDTO> selectAllClient() throws Exception;
	
	List<MemberDTO> selectGymList(Map<String, Object> paramMap) throws Exception;
	List<MemberDTO> selectTrainerList(Map<String, Object> paramMap) throws Exception;
	List<MemberDTO> selectClientList(Map<String, Object> pagramMap) throws Exception;
 	
	Integer selectGymCnt() throws Exception;
	Integer selectTrainerCnt() throws Exception;
	Integer selectClientCnt() throws Exception;
	
	List<Map<String, Object>> selectAuthList() throws Exception;
	Map<String, Object> selectGymAuthDetail(String userId) throws Exception;
	Map<String, Object> selectTrainerAuthDetail(String userId) throws Exception;
	
	public int updateGymStatus(String userId, String status) throws Exception;
	public int updateTrainerStatus(String userId, String status) throws Exception;
}
