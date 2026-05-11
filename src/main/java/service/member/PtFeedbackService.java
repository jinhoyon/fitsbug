package service.member;

import java.util.List;

import dto.member.PtFeedbackDTO;

public interface PtFeedbackService {
    List<PtFeedbackDTO> getList(String email);
    
    PtFeedbackDTO getDetail(int id);
    
    void addFeedback(PtFeedbackDTO dto);
}