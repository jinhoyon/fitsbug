package service.member;

import java.util.*;

public interface CompleteService {

    List<String> getWeekLog(String userId); // 월~일 체크용
    int getStreak(String userId); // 연속일수
    int getBestStreak(String userId);
}