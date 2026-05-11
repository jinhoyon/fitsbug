package service.member;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


import dao.member.WorkoutLogDAO;
import dao.member.WorkoutLogDAOImpl;
import dto.member.WorkoutLogDTO;

public class HotTimeServiceImpl implements HotTimeService {

    
    private WorkoutLogDAO dao = new WorkoutLogDAOImpl();

    @Override
    public String getHotTimeData(String email) {

        
        List<WorkoutLogDTO> list = dao.findByEmail(email);
        if (list == null) list = new ArrayList<>();

        // 요일 카운트 맵
        Map<String, Integer> dayMap = new LinkedHashMap<>();
        String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
        for (String d : days) dayMap.put(d, 0);

        // 시간대 카운트 맵 (0~23)
        Map<Integer, Integer> timeMap = new LinkedHashMap<>();
        for (int i = 0; i < 24; i++) timeMap.put(i, 0);

        for (WorkoutLogDTO w : list) {

            // null 체크
            if (w.getDate() == null || w.getStartTime() == null) continue;

            // LocalDate + LocalTime → LocalDateTime
            LocalDateTime dt = LocalDateTime.of(w.getDate(), w.getStartTime());

            // 요일 (Mon, Tue ...)
            // getDayOfWeek() 반환값: "MONDAY", "TUESDAY" → 앞 3자리 추출 후 첫자 대문자
            String rawDay = dt.getDayOfWeek().toString(); // e.g. "MONDAY"
            String day = rawDay.charAt(0)
                       + rawDay.substring(1, 3).toLowerCase(); // "Mon"

            // 시간 (0~23)
            int hour = dt.getHour();

            if (dayMap.containsKey(day)) {
                dayMap.put(day, dayMap.get(day) + 1);
            }
            timeMap.put(hour, timeMap.get(hour) + 1);
        }

        // JSON 생성
        StringBuilder json = new StringBuilder();
        json.append("{");

        json.append("\"dayData\":[");
        String[] dayKeys = dayMap.keySet().toArray(new String[0]);
        for (int i = 0; i < dayKeys.length; i++) {
            json.append("{\"day\":\"").append(dayKeys[i])
                .append("\",\"count\":").append(dayMap.get(dayKeys[i]))
                .append("}");
            if (i < dayKeys.length - 1) json.append(",");
        }
        json.append("],");

        json.append("\"timeData\":[");
        Integer[] timeKeys = timeMap.keySet().toArray(new Integer[0]);
        for (int i = 0; i < timeKeys.length; i++) {
            json.append("{\"time\":\"").append(timeKeys[i])
                .append("\",\"count\":").append(timeMap.get(timeKeys[i]))
                .append("}");
            if (i < timeKeys.length - 1) json.append(",");
        }
        json.append("]");

        json.append("}");

        return json.toString();
    }
}