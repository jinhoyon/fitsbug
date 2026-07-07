package service.admin;

import java.util.List;
import java.util.Map;

import dto.admin.MemberDTO;

public interface MemberService {
	List<MemberDTO> gymList(Map<String, Object> paramMap) throws Exception;
	List<MemberDTO> trainerList(Map<String, Object> paramMap) throws Exception;
	List<MemberDTO> clientList(Map<String, Object> paramMap) throws Exception;
	Integer totalCnt() throws Exception;
	Integer gymCnt() throws Exception;
	Integer trainerCnt() throws Exception;
	Integer clientCnt() throws Exception;
	List<Map<String, Object>> getPendingAuthList() throws Exception;
	Map<String, Object> getAuthDetail(String userId, String authType) throws Exception;
	public boolean approveMember(String userId, String authType) throws Exception;
}