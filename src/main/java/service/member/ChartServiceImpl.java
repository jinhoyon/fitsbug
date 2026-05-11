package service.member;

import java.util.*;

import dao.member.MealLogDAO;
import dao.member.MealLogDAOImpl;
import dao.member.InbodyLogDAO;
import dao.member.InbodyLogDAOImpl;
import dao.member.WorkoutLogDAO;
import dao.member.WorkoutLogDAOImpl;

import dto.member.ChartDTO;
import dto.member.MealLogDTO;
import dto.member.InbodyLogDTO;
import dto.member.WorkoutLogDTO;
import dto.member.WorkoutDetailDTO;

public class ChartServiceImpl implements ChartService {

    private WorkoutLogDAO workoutDao = new WorkoutLogDAOImpl();
    private MealLogDAO    foodDao    = new MealLogDAOImpl();
    private InbodyLogDAO  inbodyDao  = new InbodyLogDAOImpl();

    // ─── 운동 차트 (날짜별 볼륨 합계) ───────────────────────────
    @Override
    public List<ChartDTO> getWorkoutChart(String email) {

        List<WorkoutLogDTO> records = workoutDao.findByEmail(email);
        if (records == null) records = new ArrayList<>();

        Map<String, Double> map = new TreeMap<>();

        for (WorkoutLogDTO log : records) {

            if (log.getDate() == null) continue;

            String date = log.getDate().toString();

            double totalVolume = 0;

            if (log.getDetails() != null) {
                for (WorkoutDetailDTO d : log.getDetails()) {
                    totalVolume += d.getWeight() * d.getRep() * d.getSet();
                }
            }

            map.put(date, map.getOrDefault(date, 0.0) + totalVolume);
        }

        return convertMapToChart(map);
    }

    // ─── 식단 차트 (날짜별 칼로리 합) ───────────────────────────
    @Override
    public List<ChartDTO> getFoodChart(String email) {

        List<MealLogDTO> records = foodDao.findByEmail(email);
        if (records == null) records = new ArrayList<>();

        Map<String, Double> map = new TreeMap<>();

        for (MealLogDTO r : records) {
            String date = r.getMealDate();
            if (date == null) continue;

            map.put(date, map.getOrDefault(date, 0.0) + r.getTotCalorie());
        }

        return convertMapToChart(map);
    }

    // ─── 인바디 차트 (날짜별 체중) ──────────────────────────────
    @Override
    public List<ChartDTO> getInbodyChart(String email) {

        // ✅ getRecords() 없음 → findByEmail() 사용
        List<InbodyLogDTO> records = inbodyDao.findByEmail(email);
        if (records == null) records = new ArrayList<>();

        Map<String, Double> map = new TreeMap<>();

        for (InbodyLogDTO r : records) {
            String date = r.getRecordDate();
            if (date == null) continue;
            // 같은 날짜면 마지막 값으로 덮어씀
            map.put(date, r.getWeight());
        }

        return convertMapToChart(map);
    }

    // ─── 공통 변환 메서드 ────────────────────────────────────────
    private List<ChartDTO> convertMapToChart(Map<String, Double> map) {
        List<ChartDTO> list = new ArrayList<>();
        for (String date : map.keySet()) {
            ChartDTO dto = new ChartDTO();
            dto.setDate(date);
            dto.setValue(map.get(date));
            list.add(dto);
        }
        return list;
    }
}