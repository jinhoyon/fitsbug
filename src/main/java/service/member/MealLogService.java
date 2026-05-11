package service.member;

import dto.member.MealLogDTO;
import java.util.List;

/** FoodRecordService → MealLogService 로 변경 */
public interface MealLogService {
    int save(MealLogDTO dto);
    List<MealLogDTO> getListByMemberId(int memberId);
    List<MealLogDTO> getListByEmail(String email);
}
