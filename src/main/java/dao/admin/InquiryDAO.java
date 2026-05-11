package dao.admin;

import java.util.List;
import java.util.Map;

import dto.admin.InquiryDTO;

public interface InquiryDAO {
	List<InquiryDTO> selectInquiryList(Map<String, Object> paramMap) throws Exception;
	
	InquiryDTO selectInquiryDetail(int inquiryId) throws Exception;
	
	Integer updateInquiryReply(InquiryDTO inquiry) throws Exception;
	
	Integer selectInquiryCnt() throws Exception;
}
