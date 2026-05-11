package service.admin;

import java.util.List;

import dto.admin.InquiryDTO;

public interface InquiryService {
	List<InquiryDTO> getInquiryList(String status, String keyword) throws Exception;
	
	InquiryDTO getInquiryDetail(int inquiryId) throws Exception;
	
	boolean answerInquiry(InquiryDTO inquiry) throws Exception;
	
	Integer totalCnt() throws Exception;
	Integer inquiryCnt() throws Exception;
}
