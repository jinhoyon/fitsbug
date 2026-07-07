package service.gym;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.gym.ScheduleDAO;
import dao.gym.ScheduleDAOImpl;
import dto.gym.PtSessionView;
import dto.gym.ScheduleDay;
import dto.gym.TrainerChoose;

public class GymScheduleServiceImpl implements GymScheduleService {
	private ScheduleDAO dao = new ScheduleDAOImpl();
	@Override
	public Map<String, Object> getSchedulePageData(int gymId, int weekOffset) throws Exception {

		LocalDate today = LocalDate.now();

		LocalDate weekStart = today.with(DayOfWeek.MONDAY).plusWeeks(weekOffset);
		LocalDate weekEnd = weekStart.plusDays(7);

		String weekRangeText = weekStart.getYear() + "년 " + weekStart.getMonthValue() + "월 " + weekStart.getDayOfMonth()
				+ "일 - " + weekEnd.minusDays(1).getYear() + "년 " + weekEnd.minusDays(1).getMonthValue() + "월 "
				+ weekEnd.minusDays(1).getDayOfMonth() + "일";

		List<ScheduleDay> dayList = makeDayList(weekStart);

		List<Integer> hourList = makeHourList(9, 22);

		List<TrainerChoose> trainerList = dao.selectTrainerListByGym(gymId);

		Map<String, Object> param = new HashMap<>();
		param.put("gymId", gymId);
		param.put("weekStart", weekStart.toString());
		param.put("weekEnd", weekEnd.toString());

		List<PtSessionView> ptSessionList = dao.selectPtSessionListByGymAndWeek(param);

		Map<Integer, Map<Integer, List<PtSessionView>>> scheduleMap = makeScheduleMap(hourList, dayList, ptSessionList);

		Map<String, Object> result = new HashMap<>();
		result.put("trainerList", trainerList);
		result.put("dayList", dayList);
		result.put("hourList", hourList);
		result.put("scheduleMap", scheduleMap);
		result.put("weekRangeText", weekRangeText);

		return result;
	}

	private List<ScheduleDay> makeDayList(LocalDate weekStart) {
		List<ScheduleDay> dayList = new ArrayList<>();

		String[] dayNames = { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" };

		for (int i = 0; i < 7; i++) {
			LocalDate date = weekStart.plusDays(i);

			int value = date.getDayOfWeek().getValue();
			String name = dayNames[i];
			String dateText = date.getMonthValue() + "/" + date.getDayOfMonth();

			dayList.add(new ScheduleDay(value, name, dateText));
		}

		return dayList;
	}

	private List<Integer> makeHourList(int startHour, int endHour) {
		List<Integer> hourList = new ArrayList<>();

		for (int hour = startHour; hour <= endHour; hour++) {
			hourList.add(hour);
		}

		return hourList;
	}

	private Map<Integer, Map<Integer, List<PtSessionView>>> makeScheduleMap(List<Integer> hourList,
			List<ScheduleDay> dayList, List<PtSessionView> ptSessionList) {

		Map<Integer, Map<Integer, List<PtSessionView>>> scheduleMap = new HashMap<>();

		for (Integer hour : hourList) {
			Map<Integer, List<PtSessionView>> dayMap = new HashMap<>();

			for (ScheduleDay day : dayList) {
				dayMap.put(day.getValue(), new ArrayList<>());
			}

			scheduleMap.put(hour, dayMap);
		}

		for (PtSessionView session : ptSessionList) {
			int hour = session.getStartHour();
			int day = session.getDayOfWeek();

			if (scheduleMap.containsKey(hour) && scheduleMap.get(hour).containsKey(day)) {
				scheduleMap.get(hour).get(day).add(session);
			}
		}

		return scheduleMap;
	}

}
