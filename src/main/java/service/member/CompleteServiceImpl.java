package service.member;

import java.sql.*;
import java.util.*;
import util.DBUtil;

public class CompleteServiceImpl implements CompleteService {

    // 이번주 기록
    public List<String> getWeekLog(String email){

        List<String> list = new ArrayList<>();

        String sql = 
        "SELECT DATE_FORMAT(log_date, '%a') AS day" +
        "FROM workout_log" +
        "WHERE email=?" +
        "AND YEARWEEK(log_date, 1)=YEARWEEK(CURDATE(),1)";

        try(Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(rs.getString("day"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    // 연속 일수
    public int getStreak(String email){

        int count = 0;

        String sql =
        "SELECT log_date FROM workout_log" +
        "WHERE email=?" +
        "ORDER BY log_date DESC";

        try(Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            java.sql.Date prev = null;

            while(rs.next()){
                java.sql.Date cur = rs.getDate("log_date");

                if(prev == null){
                    count++;
                }else{
                    long diff = (prev.getTime() - cur.getTime()) / (1000*60*60*24);

                    if(diff == 1){
                        count++;
                    }else{
                        break;
                    }
                }

                prev = cur;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return count;
    }

    // 최고 기록
    public int getBestStreak(String email){
        return getStreak(email);
    }
}