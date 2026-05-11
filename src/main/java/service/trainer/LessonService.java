package service.trainer;

import dto.trainer.LessonDTO;
import dto.trainer.LessonInfoResponse;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface LessonService {
    List<LessonDTO> getLessonsByDate(LocalDate date, int trainerId);
    List<LessonDTO> getLessonsByDateRange(LocalDate startDate, LocalDate endDate, int trainerId);
    Map<String, Integer> getLessonCountsByMonth(int year, int month, int trainerId);
    LessonInfoResponse getLessonInfo(int trainerId, int lessonId);
}

//DAO     → select / insert / update (SQL language)
//Service → get / create / update   (business language)
