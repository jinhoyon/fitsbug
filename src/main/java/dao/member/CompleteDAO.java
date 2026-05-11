package dao.member;

import java.util.List;

public interface CompleteDAO {

    void insertLog(String userId);

    List<String> getWeekLog(String userId);

    int getStreak(String userId);

    int getBestStreak(String userId);
}