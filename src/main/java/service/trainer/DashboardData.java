package service.trainer;

import dto.common.LessonDTO;
import dto.common.NotificationDTO;

import java.util.List;

public class DashboardData {

    private String todayDate;
    private List<LessonDTO> lessons;
    private LessonDTO selectedLesson;
    private List<NotificationDTO> notifications;

    public DashboardData(String todayDate,
                         List<LessonDTO> lessons,
                         LessonDTO selectedLesson,
                         List<NotificationDTO> notifications) {
        this.todayDate = todayDate;
        this.lessons = lessons;
        this.selectedLesson = selectedLesson;
        this.notifications = notifications;
    }

    public String getTodayDate() {
        return todayDate;
    }

    public List<LessonDTO> getLessons() {
        return lessons;
    }

    public LessonDTO getSelectedLesson() {
        return selectedLesson;
    }

    public List<NotificationDTO> getNotifications() {
        return notifications;
    }
}