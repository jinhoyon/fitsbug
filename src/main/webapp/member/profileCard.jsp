<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.member.UserDTO, dto.member.MemberDTO"%>
<%
UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
MemberDTO memberInfo = (MemberDTO) session.getAttribute("memberInfo");
if (loginUser == null) return;

String imgSrc = (loginUser.getProfileImage() != null && !loginUser.getProfileImage().isEmpty())
    ? request.getContextPath() + "/upload/" + loginUser.getProfileImage()
    : "https://api.dicebear.com/7.x/adventurer/svg?seed=" + loginUser.getNickname();
%>

<!-- 핏불 프로필 카드 (고정 사이드) -->
<div style="
  position:fixed; top:88px; left:20px; z-index:999;
  width:240px; background:white;
  border-radius:20px; border:1.5px solid #E8EDF5;
  box-shadow:0 4px 20px rgba(0,0,0,0.10);
  font-family:'Noto Sans KR','Nunito',sans-serif;
  overflow:hidden;
">
  <!-- 상단 그라디언트 배너 -->
  <div style="height:54px;background:linear-gradient(135deg,#FF6B35,#FF8C5A,#00BFA5);position:relative;"></div>

  <!-- 프로필 이미지 (배너 위 오버랩) -->
  <div style="display:flex;flex-direction:column;align-items:center;margin-top:-32px;padding:0 16px 16px;">
    <div style="position:relative;">
      <img src="<%= imgSrc %>"
           onerror="this.src='https://api.dicebear.com/7.x/adventurer/svg?seed=fallback'"
           style="width:64px;height:64px;border-radius:50%;border:3px solid white;object-fit:cover;box-shadow:0 4px 12px rgba(0,0,0,0.12);"
           alt="프로필">
      <div style="position:absolute;bottom:1px;right:1px;width:13px;height:13px;background:#00BFA5;border-radius:50%;border:2px solid white;"></div>
    </div>

    <!-- 닉네임 / 이메일 -->
    <div style="margin-top:10px;text-align:center;">
      <div style="font-size:15px;font-weight:800;color:#1A1F36;"><%= loginUser.getNickname() %></div>
      <div style="font-size:11px;color:#9DA8C0;margin-top:2px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;max-width:200px;">
        <%= loginUser.getEmail() %>
      </div>
    </div>

    <!-- 운동 목표 뱃지 -->
    <div style="margin-top:10px;padding:5px 14px;border-radius:99px;background:linear-gradient(135deg,#FFF3EE,#FFEEE5);border:1.5px solid rgba(255,107,53,0.2);font-size:12px;font-weight:700;color:#FF6B35;text-align:center;">
      <%
      /*
       * ✅ 에러 수정 2:
       *    기존: plan.getGoal()  → WorkoutPlanDTO 메서드
       *    수정: memberInfo.getGoals() → MemberDTO 메서드 (getGoals 복수형)
       */
      String goalsDisplay = (memberInfo != null && memberInfo.getGoals() != null)
          ? memberInfo.getGoals() : "목표 미설정";
      %>
      🎯 <%= goalsDisplay %>
    </div>

    <div style="width:100%;height:1.5px;background:#E8EDF5;margin:14px 0;"></div>

    <!-- 간단 스탯 -->
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;width:100%;">
      <div style="text-align:center;padding:10px 6px;background:#F7F9FC;border-radius:12px;border:1.5px solid #E8EDF5;">
        <div style="font-size:16px;font-weight:900;color:#FF6B35;">5일</div>
        <div style="font-size:10px;color:#9DA8C0;font-weight:600;margin-top:1px;">스트릭 🔥</div>
      </div>
      <div style="text-align:center;padding:10px 6px;background:#F7F9FC;border-radius:12px;border:1.5px solid #E8EDF5;">
        <div style="font-size:16px;font-weight:900;color:#00BFA5;">
          <%
          /*
           * ✅ 에러 수정 3:
           *    기존: memberInfo.getLevel() → MemberDTO에 getLevel() 메서드 없음
           *    수정: memberInfo.getExperience() 사용
           *          (MEMBER 테이블 experience 컬럼 = 운동 수준)
           */
          String levelDisplay = (memberInfo != null && memberInfo.getExperience() != null)
              ? memberInfo.getExperience() : "-";
          %>
          <%= levelDisplay %>
        </div>
        <div style="font-size:10px;color:#9DA8C0;font-weight:600;margin-top:1px;">운동 레벨</div>
      </div>
    </div>

    <!-- 마이페이지 버튼 -->
    <a href="<%= request.getContextPath() %>/member/mypage" style="
      display:block;width:100%;margin-top:12px;padding:10px;border-radius:12px;text-align:center;
      background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;text-decoration:none;
      font-size:13px;font-weight:800;box-shadow:0 4px 12px rgba(255,107,53,0.28);
      transition:all 0.2s;
    " onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">
      마이페이지 →
    </a>

  </div>
</div>
