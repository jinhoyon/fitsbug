package dao.member;

import dto.member.MealLogDTO;
import java.util.List;

/**
 * FoodRecordDAO → MealLogDAO 로 변경
 * MEAL_LOG 테이블 기준 (member_id FK)
 */
public interface MealLogDAO {
    int insert(MealLogDTO dto);
    List<MealLogDTO> findByMemberId(int memberId);
    List<MealLogDTO> findByEmail(String email);
}
