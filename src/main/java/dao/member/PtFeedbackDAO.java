package dao.member;

import java.util.List;

import dto.member.PtFeedbackDTO;

public interface PtFeedbackDAO {
    List<PtFeedbackDTO> getFeedbackList(String email);
    
    PtFeedbackDTO getFeedbackDetail(int id);
    
    void insertFeedback(PtFeedbackDTO dto);
}