package service.trainer;

import dao.trainer.LessonDAO;
import dao.trainer.LessonDAOImpl;
import dao.trainer.NotificationDAO;
import dao.trainer.NotificationDAOImpl;
import dto.trainer.LessonDTO;
import dto.trainer.NotificationDTO;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.Comparator;
import java.util.List;

/**
 * DashboardService의 구현체.
 * 대시보드 페이지에 필요한 모든 데이터(오늘의 수업, 선택된 수업, 알림)를
 * 조합해서 반환하는 비즈니스 로직을 담당한다.
 */
public class DashboardServiceImpl implements DashboardService {

    // 수업 데이터를 DB에서 가져오는 DAO
    private final LessonService lessonService = new LessonServiceImpl();

    // 알림 데이터를 DB에서 가져오는 DAO
    private final NotificationDAO notificationDAO = new NotificationDAOImpl();

    /**
     * 대시보드에 필요한 모든 데이터를 조합해서 반환한다.
     */
    @Override
    public DashboardData getDashboardData(Integer lessonId, int trainerId) {
        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();

        // ── 1. 오늘 날짜의 수업 목록을 DB에서 가져온다 ──────────────────
        List<LessonDTO> lessons = lessonService.getLessonsByDate(today, trainerId);

        // ── 2. 수업 목록을 시작 시간 기준으로 오름차순 정렬 ──────────────
        lessons.sort(Comparator.comparing(this::safeStartTime));

        // 현재 진행 중인 수업의 인덱스 (-1이면 없음)
        int nowIndex = -1;

        // 각 수업에 기본 상태 "Booked"를 부여하고,
        // 현재 시간이 수업 시간 범위 안에 있으면 nowIndex를 기록한다
        for (int i = 0; i < lessons.size(); i++) {
            LessonDTO lesson = lessons.get(i);
            lesson.setStatus("Booked");

            if (isInLessonRange(now, lesson.getStartTime(), lesson.getEndTime())) {
                nowIndex = i;
            }
        }

        // ── 3. 수업 상태 업데이트 (Now / Up Next / Booked) ───────────────
        int upNextIndex = -1;

        if (nowIndex != -1) {
            // 현재 진행 중인 수업이 있으면 → "Now"
            lessons.get(nowIndex).setStatus("Now");

            // 그 다음 수업이 있으면 → "Up Next"
            if (nowIndex + 1 < lessons.size()) {
                upNextIndex = nowIndex + 1;
                lessons.get(upNextIndex).setStatus("Up Next");
            }
        } else {
            // 진행 중인 수업이 없으면 → 가장 가까운 미래 수업을 "Up Next"로
            upNextIndex = findFirstUpcomingIndex(lessons, now);

            if (upNextIndex != -1) {
                lessons.get(upNextIndex).setStatus("Up Next");
            }
        }

        // ── 4. 선택된 수업 결정 ──────────────────────────────────────────
        // URL에 lessonId가 있으면 해당 수업을 선택,
        // 없으면 Now → Up Next → 첫 번째 수업 순으로 자동 선택
        LessonDTO selectedLesson = findById(lessons, lessonId);

        if (selectedLesson == null) {
            if (nowIndex != -1) {
                selectedLesson = lessons.get(nowIndex);        // 현재 수업
            } else if (upNextIndex != -1) {
                selectedLesson = lessons.get(upNextIndex);     // 다음 수업
            } else if (!lessons.isEmpty()) {
                selectedLesson = lessons.get(0);               // 첫 번째 수업
            }
        }

        // ── 5. 알림 목록 조회 ────────────────────────────────────────────
        // 오늘 수업이 있는 회원들의 이름 목록 추출
        List<String> todayMemberNames = lessons.stream()
                .map(LessonDTO::getMemberName)
                .distinct()
                .collect(java.util.stream.Collectors.toList());

        List<NotificationDTO> notifications;
        if (todayMemberNames.isEmpty()) {
            notifications = new java.util.ArrayList<>();
        } else {
            // 선택된 수업의 회원 이름을 기준으로 최근 알림 20개를 가져온다
            // 단, 오늘 수업이 있는 회원의 알림만 조회한다
            String selectedMemberName =
                    selectedLesson != null ? selectedLesson.getMemberName() : null;

            String clientUserId = selectedLesson != null
                    ? String.valueOf(selectedLesson.getClientId())  // LessonDTO에 clientId 있어야 함
                    : null;

            notifications = notificationDAO.findRecentByUserAndMember(
                    clientUserId,
                    selectedMemberName,
                    20,
                    today
            );
        }

        // ── 6. 모든 데이터를 DashboardData에 담아서 반환 ─────────────────
        return new DashboardData(
                today.toString(),
                lessons,
                selectedLesson,
                notifications
        );
    }

    // =========================================================
    // 내부 헬퍼 메서드
    // =========================================================

    /**
     * 현재 시간이 수업 시간 범위(startTime ~ endTime) 안에 있는지 확인한다.
     * 파싱 실패 시 false를 반환한다.
     */
    private boolean isInLessonRange(LocalTime now, String startTime, String endTime) {
        try {
            LocalTime start = LocalTime.parse(startTime);
            LocalTime end = LocalTime.parse(endTime);
            return !now.isBefore(start) && now.isBefore(end);
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    /**
     * 시간 문자열("HH:mm")을 LocalTime으로 변환한다.
     * 파싱 실패 시 null을 반환한다.
     */
    private LocalTime parseTime(String value) {
        try {
            return LocalTime.parse(value);
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    /**
     * 수업의 시작 시간을 반환한다.
     * 파싱 실패 시 LocalTime.MAX를 반환해서 정렬 시 맨 뒤로 밀린다.
     */
    private LocalTime safeStartTime(LessonDTO lesson) {
        LocalTime start = parseTime(lesson.getStartTime());
        return start != null ? start : LocalTime.MAX;
    }

    /**
     * 수업 목록에서 현재 시간 이후에 시작하는 첫 번째 수업의 인덱스를 반환한다.
     * 없으면 -1을 반환한다.
     */
    private int findFirstUpcomingIndex(List<LessonDTO> lessons, LocalTime now) {
        for (int i = 0; i < lessons.size(); i++) {
            LocalTime start = parseTime(lessons.get(i).getStartTime());
            if (start != null && start.isAfter(now)) {
                return i;
            }
        }
        return -1;
    }

    /**
     * 수업 목록에서 lessonId가 일치하는 수업을 찾아 반환한다.
     * lessonId가 null이거나 일치하는 수업이 없으면 null을 반환한다.
     */
    private LessonDTO findById(List<LessonDTO> lessons, Integer lessonId) {
        if (lessonId == null) return null;

        for (LessonDTO lesson : lessons) {
            if (lesson.getLessonId() == lessonId) {
                return lesson;
            }
        }
        return null;
    }
}