package dao.member;

import dto.member.GymDTO;
import java.util.List;

public interface GymDAO {
    // 헬스장 목록 조회 (검색, 카테고리, 정렬, 위치 기반)
    List<GymDTO> getGymList(String keyword, String category, String sort, Double lat, Double lng);

    // 헬스장 등록 (gymJoin)
    int insertGym(GymDTO dto);
}
