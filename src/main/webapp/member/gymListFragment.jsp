<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dto.common.Gym" %>
<%
List<Gym> list = (List<Gym>) request.getAttribute("gymList");
if (list == null || list.isEmpty()) {
    // 빈 상태는 gymList.jsp의 emptyState div에서 처리
    return;
}
String contextPath = request.getContextPath();

for (Gym g : list) {

    // 거리 표시 문자열
    String distStr;
    if (g.getDistance() <= 0) {
        distStr = "-";
    } else if (g.getDistance() < 1.0) {
        distStr = (int)(g.getDistance() * 1000) + "m";
    } else {
        distStr = String.format("%.1f", g.getDistance()) + "km";
    }

    // 평점 별 (0.5 단위)
    double rating = g.getRating();
    StringBuilder stars = new StringBuilder();
    for (int si = 1; si <= 5; si++) {
        if (rating >= si)      stars.append("<span style='color:#FFD166;'>★</span>");
        else if (rating >= si - 0.5) stars.append("<span style='color:#FFD166;'>☆</span>");
        else                   stars.append("<span style='color:#E8EDF5;'>★</span>");
    }

    // 주소 표시 (address_detail 있으면 합쳐서)
    String fullAddr = g.getAddress() != null ? g.getAddress() : "";
    if (g.getAddressDetail() != null && !g.getAddressDetail().isEmpty()) {
        fullAddr += " " + g.getAddressDetail();
    }
%>
<div class="gym-card"
     onclick="location.href='<%=contextPath%>/member/gymDetail?gymId=<%=g.getId()%>'">

  <!-- 이미지 영역 -->
  <div style="position:relative;overflow:hidden;height:200px;">
    <img src="<%=contextPath%>/trainer/profile-img/<%=g.getBackgroundImg() != null ? g.getBackgroundImg() : ""%>"
         style="width:100%;height:100%;object-fit:cover;transition:transform 0.3s;"
         onmouseover="this.style.transform='scale(1.05)'"
         onmouseout="this.style.transform='scale(1)'"
         
         alt="<%=g.getName()%>">

    <!-- 전문분야 뱃지 -->
    <% if (g.getSpecialty() != null && !g.getSpecialty().isEmpty()) { %>
    <div style="position:absolute;top:10px;left:10px;">
      <span style="padding:5px 12px;border-radius:99px;background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-size:11px;font-weight:800;">
        <%=g.getSpecialty()%>
      </span>
    </div>
    <% } %>

    <!-- 거리 배지 (위치 기반) -->
    <div style="position:absolute;top:10px;right:10px;">
      <span style="padding:5px 12px;border-radius:99px;
                   background:<%= g.getDistance() > 0 && g.getDistance() <= 1.0 ? "#00BFA5" : "rgba(255,255,255,0.92)" %>;
                   color:<%= g.getDistance() > 0 && g.getDistance() <= 1.0 ? "white" : "#1A1F36" %>;
                   font-size:12px;font-weight:700;
                   backdrop-filter:blur(6px);
                   box-shadow:0 2px 8px rgba(0,0,0,0.12);">
        📍 <%=distStr%>
      </span>
    </div>

    <!-- 평점 배지 -->
    <% if (g.getRating() > 0) { %>
    <div style="position:absolute;bottom:10px;left:10px;background:rgba(255,255,255,0.95);backdrop-filter:blur(6px);padding:5px 12px;border-radius:99px;display:flex;align-items:center;gap:4px;box-shadow:0 2px 8px rgba(0,0,0,0.12);">
      <span style="color:#FFD166;font-size:13px;">★</span>
      <span style="font-size:13px;font-weight:800;color:#1A1F36;"><%=String.format("%.1f",g.getRating())%></span>
    </div>
    <% } %>
  </div>

  <!-- 카드 내용 -->
  <div style="padding:16px 18px 18px;">

    <!-- 헬스장 이름 -->
    <h3 style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:4px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
      <%=g.getName()%>
    </h3>

    <!-- 주소 -->
    <% if (!fullAddr.isEmpty()) { %>
    <p style="font-size:12px;color:#9DA8C0;margin-bottom:10px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
      📍 <%=fullAddr%>
    </p>
    <% } %>

    <!-- 거리 정보 (1km 이하 강조) -->
    <% if (g.getDistance() > 0) { %>
    <div style="display:inline-flex;align-items:center;gap:6px;
                padding:5px 12px;border-radius:99px;margin-bottom:10px;
                background:<%= g.getDistance() <= 0.5 ? "#E8F8F4" : g.getDistance() <= 1.0 ? "#F0FBF9" : "#F7F9FC" %>;
                border:1px solid <%= g.getDistance() <= 1.0 ? "rgba(0,191,165,0.25)" : "#E8EDF5" %>;">
      <span style="font-size:12px;font-weight:700;
                   color:<%= g.getDistance() <= 1.0 ? "#00897B" : "#5A6480" %>;">
        <%= g.getDistance() <= 0.5 ? "🔥 " + distStr + " 이내 초근거리!"
            : g.getDistance() <= 1.0 ? "👣 " + distStr + " 근처"
            : "🚶 " + distStr + " 거리" %>
      </span>
    </div>
    <% } %>

    <!-- 추천 점수 게이지 -->
    <% if (g.getScore() > 0) { %>
    <div style="margin-bottom:10px;">
      <div style="display:flex;justify-content:space-between;font-size:11px;margin-bottom:4px;">
        <span style="font-weight:600;color:#9DA8C0;">추천 점수</span>
        <span style="font-weight:800;color:#00BFA5;"><%=String.format("%.1f",g.getScore())%></span>
      </div>
      <div style="height:5px;background:#F0F0F0;border-radius:99px;overflow:hidden;">
        <div style="width:<%=Math.min(100,(int)(g.getScore()*10))%>%;height:100%;background:linear-gradient(90deg,#00BFA5,#26D4BB);border-radius:99px;"></div>
      </div>
    </div>
    <% } %>

    <!-- 이용권 가격 -->
    <% if (g.getPrice() > 0) { %>
    <div style="display:flex;justify-content:space-between;align-items:center;padding:10px 12px;background:#F7F9FC;border-radius:10px;margin-bottom:12px;">
      <span style="font-size:12px;color:#9DA8C0;font-weight:600;">월 이용권</span>
      <span style="font-size:15px;font-weight:900;color:#1A1F36;"><%=String.format("%,d",(int)g.getPrice())%>원</span>
    </div>
    <% } %>

    <!-- 시설 태그 -->
    <% if (g.getFacility() != null && !g.getFacility().isEmpty()) { %>
    <div style="display:flex;gap:4px;flex-wrap:wrap;margin-bottom:12px;">
      <% for (String f : g.getFacility().split("[,、]")) {
             f = f.trim();
             if (!f.isEmpty()) { %>
      <span style="padding:3px 10px;border-radius:99px;background:#F0F3F7;color:#5A6480;font-size:11px;font-weight:600;"><%=f%></span>
      <% } } %>
    </div>
    <% } %>

    <!-- 상세보기 버튼 -->
    <button onclick="event.stopPropagation();location.href='<%=contextPath%>/member/gymDetail?gymId=<%=g.getId()%>'"
            style="display:flex;align-items:center;justify-content:center;gap:6px;
                   width:100%;padding:10px;border-radius:12px;border:none;cursor:pointer;
                   background:linear-gradient(135deg,#00BFA5,#26D4BB);
                   color:white;font-size:13px;font-weight:700;
                   box-shadow:0 4px 12px rgba(0,191,165,0.3);transition:all 0.2s;"
            onmouseover="this.style.transform='translateY(-1px)'"
            onmouseout="this.style.transform='none'">
      <span style="font-size:16px;">🏋️</span> 상세보기
    </button>

  </div>
</div>
<% } %>
