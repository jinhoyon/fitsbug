package dao.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.member.GymDTO;
import util.DBUtil;

public class GymDAOImpl implements GymDAO {

    // ── 헬스장 목록 조회 ─────────────────────────────────────
    @Override
    public List<GymDTO> getGymList(String keyword, String category,
                                   String sort, Double lat, Double lng) {

        List<GymDTO> list = new ArrayList<>();

        /*
         * GYM 테이블 실제 컬럼:
         *   id, user_id, name, background_img, phone_num,
         *   address, address_detail, postcode,
         *   latitude, longitude,          ← lat/lng 아님
         *   description, facility, approval_status,
         *   gym_code, bank_name, account_number
         *
         * 수정: gym_id → id, lat/lng → latitude/longitude
         */
        StringBuilder sb = new StringBuilder(
            "SELECT id, name, address, address_detail, postcode, background_img," +
            "       latitude, longitude, facility, approval_status " +
            "FROM GYM "
        );
        
        System.out.println(keyword);
        
        if (!"전체".equals(keyword)) {
            sb.append("WHERE name LIKE ? ");
        }

        System.out.println(sb.toString());
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sb.toString())) {

            
            if (!"전체".equals(keyword)) {
            	ps.setString(1, "%" + keyword + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                GymDTO g = new GymDTO();

                // ✅ DB 컬럼명 기준
                g.setId(rs.getInt("id"));
                g.setName(rs.getString("name"));
                g.setAddress(rs.getString("address"));
                g.setAddressDetail(rs.getString("address_detail"));
                g.setPostcode(rs.getString("postcode"));
                g.setLatitude(rs.getDouble("latitude"));    // latitude (이전 lat 아님)
                g.setLongitude(rs.getDouble("longitude"));  // longitude (이전 lng 아님)
                g.setFacility(rs.getString("facility"));
                g.setApprovalStatus(rs.getString("approval_status"));
                g.setBackgroundImg(rs.getString("background_img"));

                // 거리 계산 (Haversine)
                if (lat != null && lng != null
                        && g.getLatitude() != 0 && g.getLongitude() != 0) {
                    double dist = haversine(lat, lng, g.getLatitude(), g.getLongitude());
                    g.setDistance(dist);
                } else {
                    g.setDistance(0.0);
                }

                // 추천 점수 (rating 없으면 0 기반)
                double score = g.getRating() * 2.0 - (g.getDistance() * 0.5);
                g.setScore(Math.max(score, 0));

                list.add(g);
            }

            // 정렬
            switch (sort == null ? "recommend" : sort) {
                case "distance":
                    list.sort((a, b) -> Double.compare(a.getDistance(), b.getDistance()));
                    break;
                case "rating":
                    list.sort((a, b) -> Double.compare(b.getRating(), a.getRating()));
                    break;
                default: // recommend
                    list.sort((a, b) -> Double.compare(b.getScore(), a.getScore()));
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ── 헬스장 등록 (gymJoin) ─────────────────────────────────
    @Override
    public int insertGym(GymDTO dto) {
        /*
         * gymJoin.jsp 에서 전송하는 파라미터:
         *   address, address_detail, postcode, lat, lng
         */
        String sql =
            "INSERT INTO GYM " +
            "(user_id, name, phone_num, address, address_detail, postcode, " +
            " latitude, longitude, approval_status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'PENDING')";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setObject(1, dto.getUserId());              // user_id (null 허용)
            ps.setString(2, dto.getName());
            ps.setString(3, dto.getPhoneNum());
            ps.setString(4, dto.getAddress());
            ps.setString(5, dto.getAddressDetail());       // address_detail ← 신규
            ps.setString(6, dto.getPostcode());            // postcode       ← 신규
            ps.setDouble(7, dto.getLatitude());            // latitude       ← 신규
            ps.setDouble(8, dto.getLongitude());           // longitude      ← 신규

            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── Haversine 공식 (km 단위) ─────────────────────────────
    private double haversine(double lat1, double lon1, double lat2, double lon2) {
        final double R = 6371.0;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1))
                * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    }
}
