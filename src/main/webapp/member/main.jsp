<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.common.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
if(loginUser == null){
    response.sendRedirect(request.getContextPath() + "/member/login");
    return;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>핏츠버그 - 대시보드</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body style="background:#F7F9FC;display:flex;min-height:100vh;font-family:'Noto Sans KR','Nunito',sans-serif;">

<!-- 사이드바 -->
<jsp:include page="sidebar.jsp" />

<!-- 메인 컨텐츠 -->
<div style="flex:1;margin-left:260px;padding:32px 36px;max-width:calc(100vw - 260px);">

  <!-- 페이지 헤더 -->
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:28px;">
    <div>
      <h1 style="font-size:26px;font-weight:900;color:#1A1F36;letter-spacing:-0.5px;">
        안녕하세요, <span style="color:#FF6B35;"><%= loginUser.getNickname() %></span>님! 💪
      </h1>
      <p style="font-size:14px;color:#9DA8C0;margin-top:4px;">오늘도 핏불과 함께 건강한 하루 만들어봐요!</p>
    </div>

    <!-- 알림 + 채팅 아이콘 -->
    <div style="display:flex;align-items:center;gap:12px;">
      <button onclick="openNotification()" style="
        position:relative;width:44px;height:44px;border-radius:50%;
        border:none;background:white;cursor:pointer;
        box-shadow:0 2px 8px rgba(0,0,0,0.08);
        display:flex;align-items:center;justify-content:center;
        transition:all 0.2s;
      " onmouseover="this.style.background='#FFF3EE'" onmouseout="this.style.background='white'">
        <span class="material-symbols-outlined" style="font-size:22px;color:#5A6480;">notifications</span>
        <span id="notiCount" style="
          position:absolute;top:-2px;right:-2px;
          width:18px;height:18px;background:#FF6B35;color:white;
          border-radius:50%;font-size:10px;font-weight:700;
          display:none;align-items:center;justify-content:center;border:2px solid white;
        "></span>
      </button>

      <button onclick="openChatModal()" style="
        position:relative;width:44px;height:44px;border-radius:50%;
        border:none;background:white;cursor:pointer;
        box-shadow:0 2px 8px rgba(0,0,0,0.08);
        display:flex;align-items:center;justify-content:center;
        transition:all 0.2s;
      " onmouseover="this.style.background='#E8F8F6'" onmouseout="this.style.background='white'">
        <span class="material-symbols-outlined" style="font-size:22px;color:#5A6480;">chat</span>
        <span id="chatCount" style="
          position:absolute;top:-2px;right:-2px;
          width:18px;height:18px;background:#00BFA5;color:white;
          border-radius:50%;font-size:10px;font-weight:700;
          display:none;align-items:center;justify-content:center;border:2px solid white;
        "></span>
      </button>
    </div>
  </div>

  <!-- 통계 카드 행 -->
  <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:28px;">

    <div style="background:white;border-radius:16px;padding:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);display:flex;align-items:center;gap:14px;">
      <div style="width:48px;height:48px;border-radius:12px;background:#FFF3EE;display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0;">🔥</div>
      <div>
        <div style="font-size:22px;font-weight:900;color:#1A1F36;"><span id="streakBadge">-</span></div>
        <div style="font-size:12px;color:#9DA8C0;font-weight:600;">오운완 스트릭</div>
      </div>
    </div>

    <div style="background:white;border-radius:16px;padding:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);display:flex;align-items:center;gap:14px;">
      <div style="width:48px;height:48px;border-radius:12px;background:#E8F8F6;display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0;">💪</div>
      <div>
        <div style="font-size:22px;font-weight:900;color:#1A1F36;" id="statBestWorkout">-</div>
        <div style="font-size:12px;color:#9DA8C0;font-weight:600;">오늘 최고 운동</div>
      </div>
    </div>

    <div style="background:white;border-radius:16px;padding:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);display:flex;align-items:center;gap:14px;">
      <div style="width:48px;height:48px;border-radius:12px;background:#FFF9E6;display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0;">🥗</div>
      <div>
        <div style="font-size:22px;font-weight:900;color:#1A1F36;" id="statTodayCalorie">-</div>
        <div style="font-size:12px;color:#9DA8C0;font-weight:600;">오늘 칼로리(kcal)</div>
      </div>
    </div>

    <div style="background:linear-gradient(135deg,#FF6B35,#FF8C5A);border-radius:16px;padding:20px;border:none;box-shadow:0 4px 20px rgba(255,107,53,0.25);display:flex;align-items:center;gap:14px;">
      <div style="width:48px;height:48px;border-radius:12px;background:rgba(255,255,255,0.2);display:flex;align-items:center;justify-content:center;font-size:22px;flex-shrink:0;">🏅</div>
      <div>
        <div style="font-size:22px;font-weight:900;color:white;"><span id="ptBadge">-</span></div>
        <div style="font-size:12px;color:rgba(255,255,255,0.8);font-weight:600;"><span id="ptRemainBadge">-</span></div>
      </div>
    </div>

  </div>

  <!-- 2열 그리드: 차트 + 기록 -->
  <div style="display:grid;grid-template-columns:1fr 360px;gap:24px;margin-bottom:24px;">

    <!-- 왼쪽: 차트 -->
    <div style="background:white;border-radius:20px;padding:24px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
        <div>
          <h2 style="font-size:16px;font-weight:800;color:#1A1F36;">나의 운동 변화</h2>
          <p style="font-size:12px;color:#9DA8C0;margin-top:2px;">볼륨 = 중량 × 횟수 × 세트수</p>
        </div>
        <div style="display:flex;gap:6px;">
          <button onclick="loadChart('workout')" id="btn-workout" style="
            padding:7px 16px;border-radius:99px;border:none;cursor:pointer;font-size:13px;font-weight:700;
            background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;
            box-shadow:0 3px 12px rgba(255,107,53,0.3);font-family:'Noto Sans KR',sans-serif;
            transition:all 0.2s;
          ">운동</button>
          <button onclick="loadChart('food')" id="btn-food" style="
            padding:7px 16px;border-radius:99px;border:2px solid #E8EDF5;cursor:pointer;font-size:13px;font-weight:700;
            background:white;color:#5A6480;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
          ">식단</button>
          <button onclick="loadChart('inbody')" id="btn-inbody" style="
            padding:7px 16px;border-radius:99px;border:2px solid #E8EDF5;cursor:pointer;font-size:13px;font-weight:700;
            background:white;color:#5A6480;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
          ">인바디</button>
        </div>
      </div>
      <canvas id="chart" height="110"></canvas>
      <div id="calendar" style="display:none;margin-top:12px;"></div>
      <div style="margin-top:16px;text-align:right;">
        <button onclick="loadFeedback()" style="
          padding:8px 18px;border-radius:99px;border:1.5px solid #E8EDF5;
          background:white;color:#5A6480;font-size:13px;font-weight:600;cursor:pointer;
          font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
        " onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'"
           onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#5A6480'">
          트레이너 피드백 보기
        </button>
      </div>
    </div>

    <!-- 오른쪽: PT 일정 + 멤버십 -->
    <div style="display:flex;flex-direction:column;gap:16px;">

      <!-- PT 일정 -->
      <div style="background:white;border-radius:20px;padding:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
          <h3 style="font-size:15px;font-weight:800;color:#1A1F36;">📅 나의 PT 일정</h3>
          <a href="${pageContext.request.contextPath}/member/trainerDetail?trainerId=${memberInfo.trainerId}" style="font-size:12px;color:#FF6B35;text-decoration:none;font-weight:700;">상세보기 →</a>
        </div>
        <div style="display:flex;justify-content:space-between;align-items:center;">
          <div>
            <div style="font-weight:700;font-size:14px;color:#1A1F36;"><span id="ptTrainerName">-</span></div>
            <div style="font-size:12px;color:#9DA8C0;margin-top:3px;"><span id="ptNextSession">-</span></div>
          </div>
          <button onclick="openReviewModal()" style="
            padding:7px 14px;border-radius:99px;border:none;cursor:pointer;
            background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;
            font-size:12px;font-weight:700;font-family:'Noto Sans KR',sans-serif;
            box-shadow:0 3px 12px rgba(0,191,165,0.3);
          ">리뷰 작성</button>
        </div>
      </div>

      <!-- 멤버십 -->
      <div style="background:linear-gradient(135deg,#00BFA5,#26D4BB);border-radius:20px;padding:20px;box-shadow:0 4px 20px rgba(0,191,165,0.28);">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;">
          <h3 style="font-size:15px;font-weight:800;color:white;">🏆 멤버십</h3>
          <a href="mypage?tab=membership" style="font-size:12px;color:rgba(255,255,255,0.8);text-decoration:underline;font-weight:600;">상세보기</a>
        </div>
        <div style="font-size:14px;color:white;font-weight:600;" id="membershipLabel">-</div>
        <div style="font-size:13px;color:rgba(255,255,255,0.85);margin-top:4px;">남은 횟수: <strong id="membershipRemain">-</strong></div>
        <div style="margin-top:12px;background:rgba(255,255,255,0.25);border-radius:99px;height:8px;overflow:hidden;">
          <div id="membershipBar" style="width:0%;height:100%;background:white;border-radius:99px;transition:width 0.6s;"></div>
        </div>
      </div>

    </div>
  </div>

  <!-- 기록 카드 3열 -->
  <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:24px;">

    <!-- 운동 기록 -->
    <div style="background:white;border-radius:20px;padding:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
        <h3 style="font-size:15px;font-weight:800;color:#1A1F36;">💪 운동 기록</h3>
        <span style="font-size:11px;color:#9DA8C0;background:#F7F9FC;padding:3px 10px;border-radius:99px;font-weight:600;">오늘</span>
      </div>
      <!-- DB에서 AJAX로 로드 -->
      <div id="workoutList" style="display:flex;flex-direction:column;gap:8px;margin-bottom:14px;">
        <p style="font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;">불러오는 중...</p>
      </div>
      <button onclick="openWorkoutModal()" style="
        width:100%;padding:10px;border-radius:10px;
        border:2px dashed #E8EDF5;background:white;cursor:pointer;
        font-size:13px;color:#9DA8C0;font-weight:600;
        font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
      " onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'"
         onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#9DA8C0'">
        + 기록 추가
      </button>
    </div>

    <!-- 식단 기록 -->
    <div style="background:white;border-radius:20px;padding:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
        <h3 style="font-size:15px;font-weight:800;color:#1A1F36;">🥗 식단 기록</h3>
        <span style="font-size:11px;color:#9DA8C0;background:#F7F9FC;padding:3px 10px;border-radius:99px;font-weight:600;">오늘</span>
      </div>
      <!-- DB에서 AJAX로 로드 -->
      <div id="mealList" style="margin-bottom:8px;">
        <p style="font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;">불러오는 중...</p>
      </div>
      <div id="mealSummary" style="font-size:12px;color:#9DA8C0;margin-bottom:14px;"></div>
      <button onclick="openFoodModal()" style="
        width:100%;padding:10px;border-radius:10px;
        border:2px dashed #E8EDF5;background:white;cursor:pointer;
        font-size:13px;color:#9DA8C0;font-weight:600;
        font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
      " onmouseover="this.style.borderColor='#00BFA5';this.style.color='#00BFA5'"
         onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#9DA8C0'">
        + 기록 추가
      </button>
    </div>

    <!-- 인바디 기록 -->
    <div style="background:white;border-radius:20px;padding:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
        <h3 style="font-size:15px;font-weight:800;color:#1A1F36;">📊 인바디 기록</h3>
        <span id="inbodyDateLabel" style="font-size:11px;color:#9DA8C0;background:#F7F9FC;padding:3px 10px;border-radius:99px;font-weight:600;">최근</span>
      </div>
      <!-- DB에서 AJAX로 로드 -->
      <div id="inbodyList" style="display:flex;flex-direction:column;gap:10px;margin-bottom:14px;">
        <p style="font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;">불러오는 중...</p>
      </div>
      <button onclick="openInbodyModal()" style="
        width:100%;padding:10px;border-radius:10px;
        border:2px dashed #E8EDF5;background:white;cursor:pointer;
        font-size:13px;color:#9DA8C0;font-weight:600;
        font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
      " onmouseover="this.style.borderColor='#9333EA';this.style.color='#9333EA'"
         onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#9DA8C0'">
        + 기록 추가
      </button>
    </div>

  </div>

  <!-- 하단 2열: 트레이너 일정 + 헬스장 핫타임 -->
  <div style="display:grid;grid-template-columns:1fr 1fr;gap:24px;">

    <!-- 트레이너 수업 가능 일정 -->
    <div style="background:white;border-radius:20px;padding:24px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);">

      <c:choose>
      <c:when test="${memberInfo != null && memberInfo.trainer_id != null }">

        <!-- Header -->
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;flex-wrap:wrap;gap:8px;">
          <h2 style="font-size:16px;font-weight:800;color:#1A1F36;">
            🗓 <c:out value="${not empty scheduleTrainerName ? scheduleTrainerName : '트레이너'}"/> 트레이너 수업 가능 일정
          </h2>
          <div style="display:flex;align-items:center;gap:6px;">
            <button onclick="prevWeek()" style="padding:5px 12px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;cursor:pointer;font-size:13px;font-weight:700;color:#5A6480;">← 이전</button>
            <span id="weekLabel" style="font-size:13px;font-weight:700;color:#5A6480;min-width:140px;text-align:center;"></span>
            <button onclick="nextWeek()" style="padding:5px 12px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;cursor:pointer;font-size:13px;font-weight:700;color:#5A6480;">다음 →</button>
          </div>
        </div>

        <!-- Legend -->
        <div style="display:flex;gap:14px;margin-bottom:12px;flex-wrap:wrap;">
          <span style="font-size:11px;color:#5A6480;display:flex;align-items:center;gap:4px;">
            <span style="width:12px;height:12px;border-radius:3px;background:linear-gradient(135deg,rgba(0,191,165,0.2),rgba(38,212,187,0.12));border:1.5px solid rgba(0,191,165,0.4);display:inline-block;"></span>가능
          </span>
          <span style="font-size:11px;color:#5A6480;display:flex;align-items:center;gap:4px;">
            <span style="width:12px;height:12px;border-radius:3px;background:#00BFA5;display:inline-block;"></span>선택됨
          </span>
          <span style="font-size:11px;color:#5A6480;display:flex;align-items:center;gap:4px;">
            <span style="width:12px;height:12px;border-radius:3px;background:rgba(255,107,53,0.2);border:1.5px solid rgba(255,107,53,0.4);display:inline-block;"></span>예약됨
          </span>
          <span style="font-size:11px;color:#5A6480;display:flex;align-items:center;gap:4px;">
            <span style="width:12px;height:12px;border-radius:3px;background:#F0F2F8;display:inline-block;"></span>불가
          </span>
        </div>

        <!-- Grid -->
        <div id="scheduleGrid" style="overflow-x:auto;">
        	<table border="1">
        	<tr><td>멤버ID</td><td>요일</td><td>시작시간</td><td>끝시간</td></tr>
        	<c:forEach items="${availList}" var="avail">
        	<tr>
        		<td>${avail.id }</td>
        		<td>${avail.dayOfWeek }</td>
        		<td>${avail.startTime }</td>
        		<td>${avail.endTime }</td>
        	</tr>
        	</c:forEach>
        	</table>
        </div>

        <!-- Reserve area -->
        <div id="reserveArea" style="display:none;margin-top:16px;padding:14px 16px;background:#E8F8F6;border-radius:12px;border:1.5px solid rgba(0,191,165,0.3);">
          <div id="selectedSlotInfo" style="font-size:13px;font-weight:700;color:#007A6A;margin-bottom:12px;"></div>
          <form method="post" action="${pageContext.request.contextPath}/member/reserveLesson" id="reserveForm">
            <input type="hidden" name="lessonDate" id="hdnDate">
            <input type="hidden" name="startTime"  id="hdnStart">
            <input type="hidden" name="endTime"    id="hdnEnd">
            <div style="display:flex;gap:8px;">
              <button type="submit" style="flex:1;padding:11px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 14px rgba(0,191,165,0.3);">
                예약하기
              </button>
              <button type="button" onclick="cancelSelect()" style="padding:11px 18px;border-radius:99px;border:1.5px solid #B2DFDB;cursor:pointer;background:white;color:#5A6480;font-size:13px;font-weight:700;font-family:'Noto Sans KR',sans-serif;">
                취소
              </button>
            </div>
          </form>
        </div>

        <script>
        (function(){
          const AVAIL        = ${not empty availabilityJson ? availabilityJson : '[]'};
          const TRAINER_ID   = ${sessionScope.memberInfo.trainerId};
          const LESSON_COUNT = ${sessionScope.memberInfo.lessonCount};
          const CTX          = '${pageContext.request.contextPath}';
          const DAY_NAMES_EN = ['SUN','MON','TUE','WED','THU','FRI','SAT'];
          const DAY_NAMES_KO = ['일','월','화','수','목','금','토'];

          let currentMonday = getMonday(new Date());
          let bookedSlots   = [];
          let selectedSlot  = null;

          function getMonday(d) {
            const day = d.getDay();
            const diff = (day === 0) ? -6 : 1 - day;
            const m = new Date(d);
            m.setDate(d.getDate() + diff);
            m.setHours(0,0,0,0);
            return m;
          }

          function fmt(d) {
            return d.getFullYear() + '-' +
              String(d.getMonth()+1).padStart(2,'0') + '-' +
              String(d.getDate()).padStart(2,'0');
          }

          function toMin(t) { // "HH:mm" or "HH:mm:ss"
            const p = t.split(':');
            return parseInt(p[0]) * 60 + parseInt(p[1]);
          }

          function getAvailForDay(dayIndex) {
            const dow = DAY_NAMES_EN[dayIndex];
            return AVAIL.find(a => a.dayOfWeek === dow) || null;
          }

          function isBooked(dateStr, hour) {
            const sStart = hour * 60, sEnd = (hour+1) * 60;
            return bookedSlots.some(b =>
              b.lessonDate === dateStr &&
              toMin(b.startTime) < sEnd &&
              toMin(b.endTime)   > sStart
            );
          }

          function getHourRange() {
            if (!AVAIL.length) return {min:9, max:19};
            let min = 23, max = 0;
            AVAIL.forEach(a => {
              const s = parseInt(a.startTime.split(':')[0]);
              const e = parseInt(a.endTime.split(':')[0]);
              if (s < min) min = s;
              if (e > max) max = e;
            });
            return {min, max};
          }

          function renderGrid() {
            const {min: HMIN, max: HMAX} = getHourRange();
            const hours = [];
            for (let h = HMIN; h < HMAX; h++) hours.push(h);

            const dates = [];
            for (let i = 0; i < 7; i++) {
              const d = new Date(currentMonday);
              d.setDate(currentMonday.getDate() + i);
              dates.push(d);
            }

            const start = dates[0], end = dates[6];
            document.getElementById('weekLabel').textContent =
              (start.getMonth()+1)+'월 '+start.getDate()+'일 ~ '+(end.getMonth()+1)+'월 '+end.getDate()+'일';

            let html = '<div style="display:grid;grid-template-columns:38px repeat(7,1fr);gap:3px;min-width:340px;">';

            // Header
            html += '<div></div>';
            dates.forEach(d => {
              const isToday = fmt(d) === fmt(new Date());
              const color = isToday ? '#FF6B35' : '#5A6480';
              html += '<div style="font-size:11px;font-weight:800;padding:4px 2px;text-align:center;color:'+color+';">'
                + DAY_NAMES_KO[d.getDay()]+'<br>'
                + '<span style="font-size:14px;">'+d.getDate()+'</span></div>';
            });

            // Rows
            hours.forEach(h => {
              html += '<div style="font-size:10px;color:#9DA8C0;font-weight:600;text-align:right;padding-right:4px;line-height:28px;">'+h+':00</div>';
              dates.forEach(d => {
                const dateStr = fmt(d);
                const avail   = getAvailForDay(d.getDay());
                let style, click = '';

                if (!avail) {
                  style = 'background:#F0F2F8;cursor:default;';
                } else {
                  const aStart = toMin(avail.startTime), aEnd = toMin(avail.endTime);
                  const sStart = h*60, sEnd = (h+1)*60;
                  if (sStart >= aEnd || sEnd <= aStart) {
                    style = 'background:#F0F2F8;cursor:default;';
                  } else if (isBooked(dateStr, h)) {
                    style = 'background:linear-gradient(135deg,rgba(255,107,53,0.18),rgba(255,140,90,0.10));border:1.5px solid rgba(255,107,53,0.35);cursor:not-allowed;';
                  } else {
                    const sel = selectedSlot && selectedSlot.date===dateStr && selectedSlot.hour===h;
                    if (sel) {
                      style = 'background:linear-gradient(135deg,#00BFA5,#26D4BB);border:2px solid #00897B;cursor:pointer;';
                    } else {
                      style = 'background:linear-gradient(135deg,rgba(0,191,165,0.15),rgba(38,212,187,0.08));border:1.5px solid rgba(0,191,165,0.3);cursor:pointer;';
                      click = 'onclick="selectSlot(\''+dateStr+'\','+h+')" onmouseover="this.style.background=\'linear-gradient(135deg,rgba(0,191,165,0.3),rgba(38,212,187,0.2))\'" onmouseout="this.style.background=\'linear-gradient(135deg,rgba(0,191,165,0.15),rgba(38,212,187,0.08))\'"';
                    }
                  }
                }
                html += '<div style="height:28px;border-radius:6px;'+style+'transition:all 0.15s;" '+click+'></div>';
              });
            });

            html += '</div>';
            document.getElementById('scheduleGrid').innerHTML = html;
          }

          async function fetchLessons() {
            const sunday = new Date(currentMonday);
            sunday.setDate(currentMonday.getDate() + 6);
            const url = CTX+'/member/trainerSchedule?trainerId='+TRAINER_ID
              +'&startDate='+fmt(currentMonday)+'&endDate='+fmt(sunday);
            try {
              const resp = await fetch(url);
              bookedSlots = await resp.json();
            } catch(e) {
              bookedSlots = [];
            }
            renderGrid();
          }

          window.selectSlot = function(dateStr, hour) {
            if (LESSON_COUNT <= 0) {
              document.getElementById('noLessonsModal').style.display = 'flex';
              return;
            }
            if (selectedSlot && selectedSlot.date===dateStr && selectedSlot.hour===hour) {
              selectedSlot = null;
              document.getElementById('reserveArea').style.display = 'none';
            } else {
              selectedSlot = {date: dateStr, hour: hour};
              const d = new Date(dateStr+'T00:00:00');
              const label = (d.getMonth()+1)+'월 '+d.getDate()+'일 ('+DAY_NAMES_KO[d.getDay()]+') '
                +String(hour).padStart(2,'0')+':00 – '+String(hour+1).padStart(2,'0')+':00';
              document.getElementById('selectedSlotInfo').textContent = '📌 ' + label;
              document.getElementById('hdnDate').value  = dateStr;
              document.getElementById('hdnStart').value = String(hour).padStart(2,'0')+':00:00';
              document.getElementById('hdnEnd').value   = String(hour+1).padStart(2,'0')+':00:00';
              document.getElementById('reserveArea').style.display = 'block';
            }
            renderGrid();
          };

          window.cancelSelect = function() {
            selectedSlot = null;
            document.getElementById('reserveArea').style.display = 'none';
            renderGrid();
          };

          window.prevWeek = function() {
            currentMonday.setDate(currentMonday.getDate() - 7);
            selectedSlot = null;
            document.getElementById('reserveArea').style.display = 'none';
            fetchLessons();
          };

          window.nextWeek = function() {
            currentMonday.setDate(currentMonday.getDate() + 7);
            selectedSlot = null;
            document.getElementById('reserveArea').style.display = 'none';
            fetchLessons();
          };

          fetchLessons();
        })();
        </script>

      </c:when>
      <c:otherwise>
        <h2 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:16px;">🗓 트레이너 수업 가능 일정</h2>
        <div style="text-align:center;padding:32px 0;">
          <div style="font-size:40px;margin-bottom:12px;">🏋️</div>
          <p style="font-size:14px;color:#9DA8C0;font-weight:600;margin-bottom:16px;">아직 담당 트레이너가 없습니다.</p>
          <a href="${pageContext.request.contextPath}/member/trainerList"
             style="display:inline-block;padding:10px 24px;border-radius:99px;background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-size:13px;font-weight:800;text-decoration:none;box-shadow:0 4px 14px rgba(0,191,165,0.3);">
            트레이너 찾아보기 →
          </a>
        </div>
      </c:otherwise>
      </c:choose>

    </div>

    <!-- 헬스장 핫타임 -->
    <div style="background:white;border-radius:20px;padding:24px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);">
      <h2 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:16px;">🔥 헬스장 핫타임</h2>
      <div id="hotMessage" style="
        background:linear-gradient(135deg,#FF6B35,#FF8C5A);
        color:white;font-size:13px;padding:12px 16px;
        border-radius:12px;margin-bottom:18px;font-weight:600;
      ">데이터 분석 중...</div>
      <h3 style="font-size:13px;font-weight:700;color:#5A6480;margin-bottom:10px;">요일별 이용자 수</h3>
      <canvas id="dayChart" height="80"></canvas>
      <h3 style="font-size:13px;font-weight:700;color:#5A6480;margin-top:18px;margin-bottom:10px;">시간별 이용자 수</h3>
      <canvas id="timeChart" height="80"></canvas>
    </div>

  </div>

</div><!-- end content -->

<!-- ================================================
     모달들
     ================================================ -->

<!-- 운동 기록 모달 -->
<div id="workoutModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:32px;width:100%;max-width:420px;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
      <h3 style="font-size:18px;font-weight:800;color:#1A1F36;">💪 운동 기록 추가</h3>
      <button onclick="closeWorkoutModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div style="display:flex;flex-direction:column;gap:12px;">
      <input id="name" placeholder="운동명 (예: 벤치프레스)" class="fb-modal-input">
      <input id="weight" placeholder="무게 (kg)" class="fb-modal-input" type="number">
      <input id="reps" placeholder="횟수" class="fb-modal-input" type="number">
    </div>
    <button onclick="saveWorkout()" style="
      width:100%;margin-top:20px;padding:13px;border-radius:99px;border:none;cursor:pointer;
      background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-weight:700;font-size:15px;
      font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(255,107,53,0.3);
    ">저장하기</button>
    <button onclick="closeWorkoutModal()" style="
      width:100%;margin-top:8px;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;
      background:white;color:#5A6480;font-weight:600;font-size:14px;cursor:pointer;
      font-family:'Noto Sans KR',sans-serif;
    ">닫기</button>
  </div>
</div>

<!-- 식단 모달 -->
<div id="foodModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:32px;width:100%;max-width:420px;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
      <h3 style="font-size:18px;font-weight:800;color:#1A1F36;">🥗 식단 기록 추가</h3>
      <button onclick="closeFoodModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div style="display:flex;flex-direction:column;gap:12px;">
      <input id="foodName" placeholder="음식명" class="fb-modal-input">
      <input id="gram" placeholder="섭취량 (g)" class="fb-modal-input" type="number">
      <div id="result" style="font-size:14px;color:#00BFA5;font-weight:700;min-height:22px;"></div>
    </div>
    <button onclick="calcCalorie()" style="
      width:100%;margin-top:16px;padding:13px;border-radius:99px;border:none;cursor:pointer;
      background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-weight:700;font-size:15px;
      font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(0,191,165,0.3);
    ">칼로리 계산</button>
    <button onclick="saveMeal()" style="
      width:100%;margin-top:8px;padding:13px;border-radius:99px;border:none;cursor:pointer;
      background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-weight:700;font-size:15px;
      font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(255,107,53,0.3);
    ">저장하기</button>
    <button onclick="closeFoodModal()" style="
      width:100%;margin-top:8px;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;
      background:white;color:#5A6480;font-weight:600;font-size:14px;cursor:pointer;
      font-family:'Noto Sans KR',sans-serif;
    ">닫기</button>
  </div>
</div>

<!-- 인바디 모달 -->
<div id="inbodyModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:32px;width:100%;max-width:420px;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
      <h3 style="font-size:18px;font-weight:800;color:#1A1F36;">📊 인바디 기록 추가</h3>
      <button onclick="closeInbodyModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div style="display:flex;flex-direction:column;gap:12px;">
      <input id="inbodyWeight" placeholder="체중 (kg)" class="fb-modal-input" type="number" step="0.1">
      <input id="inbodyMuscle" placeholder="골격근량 (kg)" class="fb-modal-input" type="number" step="0.1">
      <input id="inbodyFat"    placeholder="체지방량 (kg)" class="fb-modal-input" type="number" step="0.1">
    </div>
    <button onclick="saveInbody()" style="
      width:100%;margin-top:20px;padding:13px;border-radius:99px;border:none;cursor:pointer;
      background:linear-gradient(135deg,#9333EA,#A855F7);color:white;font-weight:700;font-size:15px;
      font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(147,51,234,0.3);
    ">저장하기</button>
    <button onclick="closeInbodyModal()" style="
      width:100%;margin-top:8px;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;
      background:white;color:#5A6480;font-weight:600;font-size:14px;cursor:pointer;
      font-family:'Noto Sans KR',sans-serif;
    ">닫기</button>
  </div>
</div>

<!-- 피드백 리스트 모달 -->
<div id="feedbackListModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:28px;width:100%;max-width:500px;max-height:90vh;overflow-y:auto;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
      <h3 style="font-size:18px;font-weight:800;color:#1A1F36;">💬 트레이너 피드백</h3>
      <button onclick="closeFeedbackListModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div id="feedbackListContainer"></div>
  </div>
</div>

<!-- 알림 모달 -->
<div id="notificationModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:28px;width:360px;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
      <h3 style="font-size:18px;font-weight:800;color:#1A1F36;">🔔 알림</h3>
      <button onclick="closeNotification()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div id="notificationList" style="max-height:340px;overflow-y:auto;"></div>
    <button onclick="readAllNotification()" style="
      font-size:13px;color:#FF6B35;background:none;border:none;cursor:pointer;
      font-family:'Noto Sans KR',sans-serif;font-weight:700;margin-top:12px;
    ">전체 읽음 표시</button>
  </div>
</div>

<!-- 채팅 목록 모달 -->
<div id="chatModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:28px;width:360px;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
      <h3 style="font-size:18px;font-weight:800;color:#1A1F36;">💬 채팅 목록</h3>
      <button onclick="closeChatModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div id="chatList" style="max-height:340px;overflow-y:auto;"></div>
  </div>
</div>

<!-- 수업권 없음 모달 -->
<div id="noLessonsModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:36px 32px;width:100%;max-width:400px;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;text-align:center;">
    <div style="font-size:52px;margin-bottom:12px;">🎟️</div>
    <h3 style="font-size:18px;font-weight:800;color:#1A1F36;margin-bottom:8px;">남은 수업권이 없어요</h3>
    <p style="font-size:14px;color:#9DA8C0;line-height:1.6;margin-bottom:24px;">
      예약하려면 수업권이 필요해요.<br>트레이너 페이지에서 PT를 구매해보세요.
    </p>
    <a href="${pageContext.request.contextPath}/member/trainerList"
       style="display:block;width:100%;padding:13px;border-radius:99px;border:none;cursor:pointer;
              background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:15px;font-weight:800;
              text-decoration:none;box-shadow:0 4px 16px rgba(255,107,53,0.3);margin-bottom:10px;box-sizing:border-box;">
      수업권 구매하러 가기 →
    </a>
    <button onclick="document.getElementById('noLessonsModal').style.display='none'"
            style="width:100%;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;
                   background:white;color:#5A6480;font-weight:600;font-size:14px;cursor:pointer;
                   font-family:'Noto Sans KR',sans-serif;">
      닫기
    </button>
  </div>
</div>

<!-- 리뷰 모달 -->
<div id="reviewModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(4px);">
  <div style="background:white;border-radius:24px;padding:32px;width:440px;box-shadow:0 8px 32px rgba(0,0,0,0.15);animation:fb_modal_in 0.3s ease;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
      <h3 style="font-size:18px;font-weight:800;color:#1A1F36;">⭐ 트레이너 리뷰 작성</h3>
      <button onclick="closeReviewModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div style="display:flex;flex-direction:column;gap:14px;">
      <div>
        <label style="font-size:13px;font-weight:600;color:#5A6480;display:block;margin-bottom:6px;">별점</label>
        <select id="rating" class="fb-modal-input">
          <option value="5">★★★★★ 최고예요!</option>
          <option value="4">★★★★☆ 좋아요</option>
          <option value="3">★★★☆☆ 보통이에요</option>
          <option value="2">★★☆☆☆ 별로예요</option>
          <option value="1">★☆☆☆☆ 최악이에요</option>
        </select>
      </div>
      <div>
        <label style="font-size:13px;font-weight:600;color:#5A6480;display:block;margin-bottom:6px;">사진 첨부</label>
        <input type="file" id="reviewImage" accept="image/*" class="fb-modal-input">
      </div>
      <div>
        <label style="font-size:13px;font-weight:600;color:#5A6480;display:block;margin-bottom:6px;">리뷰 내용 (최소 20자)</label>
        <textarea id="reviewContent" placeholder="리뷰를 작성해주세요..." class="fb-modal-input" style="height:120px;resize:none;"></textarea>
      </div>
    </div>
    <button onclick="submitReview()" style="
      width:100%;margin-top:20px;padding:13px;border-radius:99px;border:none;cursor:pointer;
      background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-weight:700;font-size:15px;
      font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(255,107,53,0.3);
    ">저장하기</button>
    <button onclick="closeReviewModal()" style="
      width:100%;margin-top:8px;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;
      background:white;color:#5A6480;font-weight:600;font-size:14px;cursor:pointer;
      font-family:'Noto Sans KR',sans-serif;
    ">닫기</button>
  </div>
</div>

<style>
.fb-modal-input {
  width:100%;padding:12px 16px;border-radius:12px;
  border:2px solid #E8EDF5;background:#F7F9FC;
  color:#1A1F36;font-family:'Noto Sans KR',sans-serif;font-size:14px;
  outline:none;transition:border-color 0.2s,box-shadow 0.2s;box-sizing:border-box;
}
.fb-modal-input:focus {
  border-color:#FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.12);background:white;
}
.fb-modal-input::placeholder { color:#9DA8C0; }

@keyframes fb_modal_in {
  from { opacity:0;transform:scale(0.9) translateY(20px); }
  to   { opacity:1;transform:scale(1) translateY(0); }
}

/* 모달 flex display */
[id$="Modal"] { display:none; }
[id$="Modal"].open { display:flex !important; }
</style>

<script>
/* Chart.js 기본 색상 오버라이드 */
Chart.defaults.color = '#9DA8C0';
Chart.defaults.borderColor = '#E8EDF5';

let chart, dayChart, timeChart;
let currentData = [];

function loadChart(type){
  document.getElementById('chart').style.display = 'none';
  document.getElementById('calendar').style.display = 'none';

  // 버튼 상태 초기화
  ['workout','food','inbody'].forEach(t => {
    const btn = document.getElementById('btn-'+t);
    if(btn){
      btn.style.background = 'white';
      btn.style.color = '#5A6480';
      btn.style.boxShadow = 'none';
      btn.style.border = '2px solid #E8EDF5';
    }
  });
  const activeBtn = document.getElementById('btn-'+type);
  if(activeBtn){
    activeBtn.style.background = 'linear-gradient(135deg,#FF6B35,#FF8C5A)';
    activeBtn.style.color = 'white';
    activeBtn.style.boxShadow = '0 3px 12px rgba(255,107,53,0.3)';
    activeBtn.style.border = 'none';
  }

  fetch("chart?type="+type)
  .then(res=>res.json())
  .then(data=>{
    currentData = data;
    if(chart) chart.destroy();
    if(type==='workout') drawWorkoutChart(data);
    else if(type==='food') drawFoodCalendar(data);
    else if(type==='inbody') drawInbodyChart(data);
  }).catch(err=>console.error("차트 로딩 실패:", err));
}

/* ── 운동 차트: 날짜별 볼륨(막대) + 막대 클릭 시 피드백 ── */
function drawWorkoutChart(data){
  document.getElementById('chart').style.display='block';
  document.getElementById('calendar').style.display='none';

  if (!data || data.length === 0) {
    document.getElementById('chart').style.display='none';
    document.getElementById('calendar').style.display='block';
    document.getElementById('calendar').innerHTML =
      "<p style='color:#9DA8C0;font-size:14px;text-align:center;padding:32px 0;'>운동 기록이 없습니다</p>";
    return;
  }

  chart = new Chart(document.getElementById('chart'), {
    type: 'bar',
    data: {
      labels: data.map(function(d){ return d.date; }),
      datasets: [{
        label: '운동 볼륨 (kg)',
        data: data.map(function(d){ return d.value || 0; }),
        backgroundColor: 'rgba(255,107,53,0.18)',
        borderColor: '#FF6B35',
        borderWidth: 2,
        borderRadius: 8,
        hoverBackgroundColor: 'rgba(255,107,53,0.35)'
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            label: function(ctx) {
              return '볼륨: ' + ctx.parsed.y.toLocaleString() + ' kg';
            },
            title: function(items) {
              return items[0].label + ' 운동 기록';
            }
          }
        }
      },
      scales: {
        x: { grid: { display: false }, ticks: { color: '#9DA8C0' } },
        y: {
          grid: { color: '#F0F0F0' },
          ticks: {
            color: '#9DA8C0',
            callback: function(v){ return v.toLocaleString() + ' kg'; }
          }
        }
      },
      onClick: function(e, elements) {
        if (elements.length > 0) openFeedbackByDate(data[elements[0].index].date);
      }
    }
  });
}

/* ── 식단 차트: 날짜별 칼로리(막대) + 하단에 항목 카드 ── */
function drawFoodCalendar(data){
  document.getElementById('chart').style.display='block';
  document.getElementById('calendar').style.display='block';

  const cal = document.getElementById('calendar');
  cal.innerHTML = '';

  if (!data || data.length === 0) {
    document.getElementById('chart').style.display='none';
    cal.innerHTML = "<p style='color:#9DA8C0;font-size:14px;text-align:center;padding:32px 0;'>식단 기록이 없습니다</p>";
    return;
  }

  // ① 위에 칼로리 막대그래프
  chart = new Chart(document.getElementById('chart'), {
    type: 'bar',
    data: {
      labels: data.map(function(d){ return d.date; }),
      datasets: [{
        label: '칼로리 (kcal)',
        data: data.map(function(d){ return d.calorie || 0; }),
        backgroundColor: 'rgba(0,191,165,0.18)',
        borderColor: '#00BFA5',
        borderWidth: 2,
        borderRadius: 8,
        hoverBackgroundColor: 'rgba(0,191,165,0.35)'
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            label: function(ctx){ return '총 ' + ctx.parsed.y.toLocaleString() + ' kcal'; }
          }
        }
      },
      scales: {
        x: { grid: { display: false }, ticks: { color: '#9DA8C0' } },
        y: {
          grid: { color: '#F0F0F0' },
          ticks: {
            color: '#9DA8C0',
            callback: function(v){ return v.toLocaleString() + ' kcal'; }
          }
        }
      }
    }
  });

  // ② 아래에 날짜별 식단 항목 카드
  cal.innerHTML = '<div style="font-size:12px;font-weight:700;color:#5A6480;margin-bottom:8px;">📋 날짜별 식단 항목</div>';
  data.slice(-7).reverse().forEach(function(d) {  // 최근 7일
    var items = d.food ? d.food.split(', ').filter(function(s){ return s.trim(); }) : [];
    var tagsHtml = items.map(function(item) {
      return '<span style="display:inline-block;padding:3px 10px;border-radius:99px;background:#E8F8F6;color:#00897B;font-size:11px;font-weight:600;margin:2px;">' + item + '</span>';
    }).join('');

    cal.innerHTML +=
      '<div style="border:1.5px solid #E8EDF5;border-radius:12px;padding:12px 14px;margin-bottom:8px;background:white;">' +
        '<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:6px;">' +
          '<span style="font-size:12px;font-weight:700;color:#5A6480;">' + d.date + '</span>' +
          '<span style="font-size:13px;font-weight:900;color:#00BFA5;">' + (d.calorie || 0).toLocaleString() + ' kcal</span>' +
        '</div>' +
        '<div>' + (tagsHtml || '<span style="font-size:11px;color:#C4CEDE;">항목 없음</span>') + '</div>' +
      '</div>';
  });
}

/* ── 인바디 차트: 날짜별 체중/골격근량/체지방량(라인) + 커스텀 툴팁 ── */
function drawInbodyChart(data){
  document.getElementById('chart').style.display='block';
  document.getElementById('calendar').style.display='none';

  if (!data || data.length === 0) {
    document.getElementById('chart').style.display='none';
    document.getElementById('calendar').style.display='block';
    document.getElementById('calendar').innerHTML =
      "<p style='color:#9DA8C0;font-size:14px;text-align:center;padding:32px 0;'>인바디 기록이 없습니다</p>";
    return;
  }

  chart = new Chart(document.getElementById('chart'), {
    type: 'line',
    data: {
      labels: data.map(function(d){ return d.date; }),
      datasets: [
        {
          label: '체중(kg)',
          data: data.map(function(d){ return d.weight || 0; }),
          borderColor: '#FF6B35',
          backgroundColor: 'rgba(255,107,53,0.08)',
          tension: 0.4, fill: true, pointRadius: 5, pointHoverRadius: 7,
          borderWidth: 2
        },
        {
          label: '골격근량(kg)',
          data: data.map(function(d){ return d.muscle || 0; }),
          borderColor: '#00BFA5',
          backgroundColor: 'rgba(0,191,165,0.08)',
          tension: 0.4, fill: true, pointRadius: 5, pointHoverRadius: 7,
          borderWidth: 2
        },
        {
          label: '체지방량(kg)',
          data: data.map(function(d){ return d.fat || 0; }),
          borderColor: '#9333EA',
          backgroundColor: 'rgba(147,51,234,0.08)',
          tension: 0.4, fill: true, pointRadius: 5, pointHoverRadius: 7,
          borderWidth: 2
        }
      ]
    },
    options: {
      responsive: true,
      interaction: { mode: 'index', intersect: false },
      plugins: {
        legend: {
          display: true,
          position: 'top',
          labels: {
            color: '#5A6480',
            font: { family: "'Noto Sans KR', sans-serif", weight: '700' },
            boxWidth: 12, padding: 16
          }
        },
        tooltip: {
          callbacks: {
            label: function(ctx) {
              return ctx.dataset.label + ': ' + ctx.parsed.y + ' kg';
            }
          }
        }
      },
      scales: {
        x: { grid: { display: false }, ticks: { color: '#9DA8C0' } },
        y: {
          grid: { color: '#F0F0F0' },
          ticks: {
            color: '#9DA8C0',
            callback: function(v){ return v + ' kg'; }
          }
        }
      }
    }
  });
}

function loadFeedback(){
  fetch("feedback").then(res=>res.json()).then(list=>{
    const container=document.getElementById("feedbackListContainer");
    container.innerHTML="";
    list.sort((a,b)=>new Date(b.date)-new Date(a.date));
    list.forEach(function(f){
      var img=f.trainerImg||"https://api.dicebear.com/7.x/avataaars/svg?seed=trainer";
      var summary=f.summary?(f.summary):(f.content?f.content.substring(0,40)+"...":"내용 없음");
      container.innerHTML+=
        '<div onclick="openFeedbackModal(\''+f.date+'\',\''+f.trainer+'\',\''+f.content+'\')" '+
        'style="display:flex;align-items:center;gap:12px;padding:14px;border-bottom:1.5px solid #F0F0F0;cursor:pointer;border-radius:12px;transition:background 0.2s;" '+
        'onmouseover="this.style.background=\'#FFF3EE\'" onmouseout="this.style.background=\'white\'">' +
          '<img src="'+img+'" style="width:44px;height:44px;border-radius:50%;object-fit:cover;border:2px solid #E8EDF5;">' +
          '<div style="flex:1;">' +
            '<div style="display:flex;justify-content:space-between;align-items:center;">' +
              '<span style="font-weight:700;font-size:14px;color:#1A1F36;">'+f.trainer+'</span>' +
              '<span style="font-size:11px;color:#9DA8C0;">'+f.date+'</span>' +
            '</div>' +
            '<div style="font-size:13px;color:#5A6480;margin-top:3px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:320px;">'+summary+'</div>' +
          '</div>' +
        '</div>';
    });
    document.getElementById("feedbackListModal").style.display='flex';
  }).catch(err=>console.error("피드백 불러오기 실패", err));
}

function openFeedbackByDate(date){
  fetch("feedback").then(res=>res.json()).then(list=>{
    const target=list.find(f=>f.date===date);
    if(target) openFeedbackModal(target.date,target.trainer,target.content);
    else alert("해당 날짜 피드백 없음");
  });
}

function loadHotTime(){
  fetch("hotTime").then(res=>res.json()).then(data=>{
    drawDayChart(data.dayData);
    drawTimeChart(data.timeData);
    let maxDay=data.dayData.reduce((a,b)=>a.count>b.count?a:b);
    document.getElementById("hotMessage").innerText="🔥 현재 가장 붐비는 요일은 "+maxDay.day+" 입니다. 혼잡 시간을 피하세요!";
  });
}

function drawDayChart(data){
  if(dayChart) dayChart.destroy();
  dayChart=new Chart(document.getElementById("dayChart"),{
    type:'bar',
    data:{
      labels:data.map(d=>d.day),
      datasets:[{label:'이용자 수',data:data.map(d=>d.count),backgroundColor:'rgba(255,107,53,0.15)',borderColor:'#FF6B35',borderWidth:2,borderRadius:6}]
    },
    options:{plugins:{legend:{display:false}},scales:{x:{grid:{display:false}},y:{grid:{color:'#F0F0F0'}}}}
  });
}

function drawTimeChart(data){
  if(timeChart) timeChart.destroy();
  timeChart=new Chart(document.getElementById("timeChart"),{
    type:'line',
    data:{
      labels:data.map(d=>d.time),
      datasets:[{label:'이용자 수',data:data.map(d=>d.count),borderColor:'#00BFA5',backgroundColor:'rgba(0,191,165,0.1)',fill:true,tension:0.4,pointRadius:3}]
    },
    options:{plugins:{legend:{display:false}},scales:{x:{grid:{display:false}},y:{grid:{color:'#F0F0F0'}}}}
  });
}

function loadNotification(){
  fetch("notification").then(res=>res.json()).then(data=>{
    const countEl=document.getElementById("notiCount");
    if(data.count>0){countEl.style.display="flex";countEl.innerText=data.count;}
    else countEl.style.display="none";
    const box=document.getElementById("notificationList");
    box.innerHTML="";
    data.list.forEach(function(n){
      box.innerHTML+=
        '<div onclick="readNotification('+n.id+',\''+n.url+'\')" '+
        'style="padding:12px;border-bottom:1.5px solid #F0F0F0;cursor:pointer;border-radius:10px;'+
        (n.isRead?'':'background:#FFF3EE;')+
        'transition:background 0.2s;" onmouseover="this.style.background=\'#F7F9FC\'" onmouseout="this.style.background=\''+
        (n.isRead?'white':'#FFF3EE')+'\'">'+
          '<div style="font-size:13px;color:#1A1F36;">'+n.message+'</div>'+
          '<div style="font-size:11px;color:#9DA8C0;margin-top:3px;">'+n.createdAt+'</div>'+
        '</div>';
    });
  });
}

function readNotification(id,url){
  fetch("notification",{method:"POST",headers:{"Content-Type":"application/x-www-form-urlencoded"},body:"action=readOne&id="+id})
  .then(()=>{
    const c=document.getElementById("notiCount");
    const cnt=parseInt(c.innerText);
    if(cnt>1)c.innerText=cnt-1;else c.style.display="none";
    location.href=url;
  });
}

function readAllNotification(){
  fetch("notification",{method:"POST",headers:{"Content-Type":"application/x-www-form-urlencoded"},body:"action=readAll"})
  .then(()=>{document.getElementById("notiCount").style.display="none";loadNotification();});
}

function loadChatList(){
  fetch("messageList").then(res=>res.json()).then(list=>{
    const box=document.getElementById("chatList");
    box.innerHTML="";
    list.forEach(function(c){
      box.innerHTML+=
        '<div onclick="enterChat(\''+c.email+'\')" '+
        'style="display:flex;align-items:center;gap:12px;padding:12px;border-bottom:1.5px solid #F0F0F0;cursor:pointer;border-radius:10px;transition:background 0.2s;" '+
        'onmouseover="this.style.background=\'#F7F9FC\'" onmouseout="this.style.background=\'white\'">'+
          '<div style="width:42px;height:42px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#00BFA5);display:flex;align-items:center;justify-content:center;color:white;font-weight:700;font-size:16px;flex-shrink:0;">'+
            c.nickname.charAt(0)+'</div>'+
          '<div style="flex:1;min-width:0;">'+
            '<div style="font-weight:700;font-size:14px;color:#1A1F36;">'+c.nickname+'</div>'+
            '<div style="font-size:12px;color:#9DA8C0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">'+c.lastMessage+'</div>'+
          '</div>'+
          (c.unreadCount>0?'<div style="width:20px;height:20px;background:#FF6B35;border-radius:50%;color:white;font-size:11px;font-weight:700;display:flex;align-items:center;justify-content:center;">'+c.unreadCount+'</div>':'')+
        '</div>';
    });
  });
}

function enterChat(email){
  fetch("message",{method:"POST",headers:{"Content-Type":"application/x-www-form-urlencoded"},body:"action=readAll&receiver="+email})
  .then(()=>{location.href="chat.jsp?receiver="+email;});
}

function loadChatCount(){
  fetch("chatCount").then(res=>res.text()).then(count=>{
    const el=document.getElementById("chatCount");
    if(parseInt(count)>0){el.style.display="flex";el.innerText=count;}
    else el.style.display="none";
  });
}

window.onload = function() {
  loadChart('workout');
  loadHotTime();
  loadChatCount();
  loadTodayWorkout();
  loadTodayMeal();
  loadLatestInbody();
  loadMembershipInfo();
  loadOwunStreak();

  var params = new URLSearchParams(location.search);
  if (params.get('reserved') === '1') showToast('✅ 예약이 완료되었습니다!', '#00BFA5');
  if (params.get('reserveError') === '1') showToast('❌ 예약 중 오류가 발생했습니다.', '#FF4D4D');
  if (params.get('reserveError') === 'noLessons') {
    var m = document.getElementById('noLessonsModal');
    if (m) m.style.display = 'flex';
  }
};

/* ── 오운완 스트릭 ── */
function loadOwunStreak() {
  var ctx = '<%=request.getContextPath()%>';
  fetch(ctx + '/member/mypageData?type=owun')
    .then(function(r){ return r.json(); })
    .then(function(data){
      var el = document.getElementById('streakBadge');
      if (el) el.innerText = (data.streak || 0) + '일';
    }).catch(function(){
      var el = document.getElementById('streakBadge');
      if (el) el.innerText = '0일';
    });
}

/* ── 멤버십 + PT 일정 카드 + 통계 배지 DB 연동 ── */
function loadMembershipInfo() {
  var ctx = '<%=request.getContextPath()%>';
  fetch(ctx + '/member/mypageData?type=membership')
    .then(function(r){ return r.json(); })
    .then(function(mp){
      if (!mp) return;

      // 통계카드 PT 배지
      var ptBadge = document.getElementById('ptBadge');
      var ptRemainBadge = document.getElementById('ptRemainBadge');
      if (ptBadge) ptBadge.innerText = mp.membershipType === 'pt' ? 'PT' : (mp.membershipType === 'month' ? '월정액' : '-');
      if (ptRemainBadge) ptRemainBadge.innerText = '남은 횟수: ' + (mp.lessonCount || 0) + '회';

      // PT 일정 카드 트레이너 이름 + 다음 수업
      var nameEl = document.getElementById('ptTrainerName');
      var sessionEl = document.getElementById('ptNextSession');
      if (nameEl) nameEl.innerText = (mp.trainerNickname || '-') + ' 트레이너';
      if (sessionEl) sessionEl.innerText = mp.nextSession || '예약 없음';

      // 멤버십 카드
      var total = mp.typeRep || 1;
      var remain = mp.lessonCount || 0;
      var pct = Math.min(Math.round(remain / total * 100), 100);
      var typeLabel = mp.membershipType === 'pt'
        ? 'PT ' + total + '회권'
        : (mp.membershipType === 'month' ? total + '개월 이용권' : '이용권');

      var labelEl  = document.getElementById('membershipLabel');
      var remainEl = document.getElementById('membershipRemain');
      var barEl    = document.getElementById('membershipBar');
      if (labelEl)  labelEl.innerText   = typeLabel;
      if (remainEl) remainEl.innerText  = remain + '회';
      if (barEl)    barEl.style.width   = pct + '%';
    }).catch(function(){});
}
/* ── 오늘 운동 기록 카드 로드 (workout_log + workout_detail) ── */
function loadTodayWorkout() {
  fetch("workout")
    .then(function(r) { return r.json(); })
    .then(function(data) {
      var box = document.getElementById("workoutList");
      if (!data || data.length === 0) {
        box.innerHTML = "<p style='font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;'>오늘 운동 기록이 없습니다</p>";
        document.getElementById("statBestWorkout").innerText = "-";
        return;
      }
      box.innerHTML = "";
      var maxVol = 0, bestTitle = "";
      data.forEach(function(d, i) {
        var vol = (d.weight || 0) * (d.rep || 0) * (d.set || 1);
        if (vol > maxVol) { maxVol = vol; bestTitle = d.title; }
        box.innerHTML +=
          '<div style="display:flex;justify-content:space-between;align-items:center;padding:10px 12px;background:#FFF3EE;border-radius:10px;">' +
            '<span style="font-size:13px;font-weight:600;color:#1A1F36;">#' + (i + 1) + ' ' + d.title + '</span>' +
            '<span style="font-size:13px;color:#FF6B35;font-weight:700;">' + d.weight + 'kg × ' + d.rep + '회</span>' +
          '</div>';
      });
      if (bestTitle) document.getElementById("statBestWorkout").innerText = bestTitle;
    })
    .catch(function() {
      var box = document.getElementById("workoutList");
      if (box) box.innerHTML = "<p style='font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;'>불러오기 실패</p>";
    });
}

/* ── 오늘 식단 기록 카드 로드 (meal_log) ── */
function loadTodayMeal() {
  fetch("food")
    .then(function(r) { return r.json(); })
    .then(function(data) {
      var box     = document.getElementById("mealList");
      var summary = document.getElementById("mealSummary");
      var calStat = document.getElementById("statTodayCalorie");

      // 오늘 날짜(YYYY-MM-DD) 필터
      var today = new Date();
      var todayStr = today.getFullYear() + '-'
        + String(today.getMonth() + 1).padStart(2, '0') + '-'
        + String(today.getDate()).padStart(2, '0');

      var todayList = (data || []).filter(function(f) {
        return f.date && f.date.substring(0, 10) === todayStr;
      });

      if (todayList.length === 0) {
        box.innerHTML = "<p style='font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;'>오늘 식단 기록이 없습니다</p>";
        summary.innerText = "";
        if (calStat) calStat.innerText = "-";
        return;
      }

      box.innerHTML = "";
      var totalCal = 0;
      todayList.forEach(function(f) {
        totalCal += (f.calorie || 0);
        box.innerHTML +=
          '<div style="padding:10px 12px;background:#E8F8F6;border-radius:10px;margin-bottom:6px;">' +
            '<div style="font-size:13px;font-weight:600;color:#1A1F36;">' + f.food + '</div>' +
            '<div style="font-size:12px;color:#00897B;margin-top:3px;font-weight:600;">' + f.calorie + ' kcal</div>' +
          '</div>';
      });

      summary.innerText = "총 " + todayList.length + "끼 · 약 " + totalCal.toLocaleString() + " kcal";
      if (calStat) calStat.innerText = totalCal.toLocaleString();
    })
    .catch(function() {
      var box = document.getElementById("mealList");
      if (box) box.innerHTML = "<p style='font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;'>불러오기 실패</p>";
    });
}

/* ── 최근 인바디 기록 카드 로드 (inbody_log) ── */
function loadLatestInbody() {
  fetch("inbody")
    .then(function(r) { return r.json(); })
    .then(function(data) {
      var box       = document.getElementById("inbodyList");
      var dateLabel = document.getElementById("inbodyDateLabel");

      if (!data || data.length === 0) {
        box.innerHTML = "<p style='font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;'>인바디 기록이 없습니다</p>";
        return;
      }

      // 가장 최근 기록 1건
      var d = data[0];
      if (dateLabel && d.date) dateLabel.innerText = d.date.substring(0, 10);

      // 프로그레스바 너비 계산 (체중 max 120kg, 골격근량 max 60kg, 체지방량 max 40kg 기준)
      var weightPct  = Math.min(Math.round((d.weight  || 0) / 120 * 100), 100);
      var musclePct  = Math.min(Math.round((d.muscle  || 0) / 60  * 100), 100);
      var fatPct     = Math.min(Math.round((d.fat     || 0) / 40  * 100), 100);

      box.innerHTML =
        makeInbodyRow("체중",    d.weight  || 0, "kg", weightPct, "linear-gradient(90deg,#FF6B35,#FFD166)") +
        makeInbodyRow("골격근량", d.muscle  || 0, "kg", musclePct, "linear-gradient(90deg,#00BFA5,#26D4BB)") +
        makeInbodyRow("체지방량", d.fat     || 0, "kg", fatPct,    "linear-gradient(90deg,#FF4D4D,#FF8C5A)");
    })
    .catch(function() {
      var box = document.getElementById("inbodyList");
      if (box) box.innerHTML = "<p style='font-size:13px;color:#9DA8C0;text-align:center;padding:12px 0;'>불러오기 실패</p>";
    });
}

function makeInbodyRow(label, value, unit, pct, gradient) {
  return '<div>' +
    '<div style="display:flex;justify-content:space-between;font-size:12px;margin-bottom:4px;">' +
      '<span style="font-weight:600;color:#5A6480;">' + label + '</span>' +
      '<span style="font-weight:700;color:#1A1F36;">' + value + unit + '</span>' +
    '</div>' +
    '<div style="height:7px;background:#F0F0F0;border-radius:99px;overflow:hidden;">' +
      '<div style="width:' + pct + '%;height:100%;background:' + gradient + ';border-radius:99px;transition:width 0.6s ease;"></div>' +
    '</div>' +
  '</div>';
}

function showToast(msg, color) {
  const t = document.createElement('div');
  t.textContent = msg;
  t.style.cssText = 'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);'
    +'background:'+color+';color:white;padding:12px 24px;border-radius:99px;'
    +'font-size:14px;font-weight:700;z-index:9999;box-shadow:0 4px 20px rgba(0,0,0,0.2);'
    +'animation:fb_modal_in 0.3s ease;';
  document.body.appendChild(t);
  setTimeout(() => t.remove(), 3000);

}

/* 모달 열기/닫기 */
function openWorkoutModal(){ document.getElementById("workoutModal").style.display="flex"; }
function closeWorkoutModal(){ document.getElementById("workoutModal").style.display="none"; }
function openFoodModal(){ document.getElementById("foodModal").style.display="flex"; }
function closeFoodModal(){ document.getElementById("foodModal").style.display="none"; }
function openInbodyModal(){ document.getElementById("inbodyModal").style.display="flex"; }
function closeInbodyModal(){ document.getElementById("inbodyModal").style.display="none"; }
function closeFeedbackListModal(){ document.getElementById("feedbackListModal").style.display="none"; }
function openNotification(){ document.getElementById("notificationModal").style.display="flex"; loadNotification(); }
function closeNotification(){ document.getElementById("notificationModal").style.display="none"; }
function openChatModal(){ document.getElementById("chatModal").style.display="flex"; loadChatList(); }
function closeChatModal(){ document.getElementById("chatModal").style.display="none"; }
function openReviewModal(){ document.getElementById("reviewModal").style.display="flex"; }
function closeReviewModal(){ document.getElementById("reviewModal").style.display="none"; }

function openFeedbackModal(date,trainer,content){
  alert("피드백 - "+trainer+" ("+date+"): "+content);
}

/* 저장 */
function saveWorkout(){
  var name   = document.getElementById("name").value.trim();
  var weight = document.getElementById("weight").value;
  var reps   = document.getElementById("reps").value;

  if(!name){ alert("운동명을 입력해주세요."); return; }
  if(!weight || weight <= 0){ alert("무게를 입력해주세요."); return; }
  if(!reps || reps <= 0){ alert("횟수를 입력해주세요."); return; }

  fetch("workout", {
    method: "POST",
    headers: {"Content-Type":"application/x-www-form-urlencoded"},
    body: "name=" + encodeURIComponent(name)
        + "&weight=" + encodeURIComponent(weight)
        + "&reps="   + encodeURIComponent(reps)
  })
  .then(function(r){ return r.json(); })
  .then(function(res){
    if(res.success){
      closeWorkoutModal();
      // 입력창 초기화
      document.getElementById("name").value   = "";
      document.getElementById("weight").value = "";
      document.getElementById("reps").value   = "";
      loadTodayWorkout();  // 운동 기록 카드 즉시 갱신
    } else {
      alert("저장에 실패했습니다. 다시 시도해주세요.");
    }
  })
  .catch(function(){ alert("서버 연결 오류가 발생했습니다."); });
}

// 칼로리 계산 (간이 계산, 저장 없음)
function calcCalorie() {
  var name = document.getElementById("foodName").value.trim();
  var gram = parseFloat(document.getElementById("gram").value) || 0;
  if (!name) { alert("음식명을 입력해주세요."); return; }

  // 간이 칼로리 계산 (100g 기준 대략값)
  var calorieMap = {
    "닭가슴살":165,"삶은달걀":155,"현미밥":130,"고구마":86,"브로콜리":34,
    "오트밀":389,"아보카도":160,"연어":208,"두부":76,"고등어":205
  };
  var baseCalorie = calorieMap[name] || 100; // 없으면 100kcal/100g
  var calorie = Math.round(baseCalorie * gram / 100);

  document.getElementById("result").innerText = "🔥 칼로리: " + calorie + " kcal";
  // 계산 결과를 숨김 필드에 저장
  document.getElementById("result").setAttribute("data-calorie", calorie);
}

// 식단 저장 (DB 연동)
function saveMeal() {
  var foodName = document.getElementById("foodName").value.trim();
  var gram     = document.getElementById("gram").value;
  var resultEl = document.getElementById("result");
  var calorie  = resultEl.getAttribute("data-calorie") || "0";

  if (!foodName) { alert("음식명을 입력해주세요."); return; }

  fetch("food", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: "foodName=" + encodeURIComponent(foodName)
        + "&gram="     + encodeURIComponent(gram)
        + "&calorie="  + encodeURIComponent(calorie)
  })
  .then(function(r) { return r.json(); })
  .then(function(res) {
    if (res.success) {
      closeFoodModal();
      document.getElementById("foodName").value = "";
      document.getElementById("gram").value = "";
      resultEl.innerText = "";
      resultEl.removeAttribute("data-calorie");
      loadTodayMeal();   // 식단 기록 카드 즉시 갱신
      showToast("✅ 식단이 기록되었습니다!", "#00BFA5");
    } else {
      alert("저장에 실패했습니다.");
    }
  })
  .catch(function() { alert("서버 연결 오류가 발생했습니다."); });
}

// 인바디 저장 (DB 연동)
function saveInbody() {
  var weight = document.getElementById("inbodyWeight").value;
  var muscle = document.getElementById("inbodyMuscle").value;
  var fat    = document.getElementById("inbodyFat").value;

  if (!weight || parseFloat(weight) <= 0) {
    alert("체중을 입력해주세요."); return;
  }

  fetch("inbody", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: "weight=" + encodeURIComponent(weight)
        + "&muscle=" + encodeURIComponent(muscle || "0")
        + "&fat="    + encodeURIComponent(fat    || "0")
  })
  .then(function(r) { return r.json(); })
  .then(function(res) {
    if (res.success) {
      closeInbodyModal();
      document.getElementById("inbodyWeight").value = "";
      document.getElementById("inbodyMuscle").value = "";
      document.getElementById("inbodyFat").value    = "";
      loadLatestInbody();  // 인바디 기록 카드 즉시 갱신
      showToast("✅ 인바디가 기록되었습니다!", "#9333EA");
    } else {
      alert("저장에 실패했습니다. " + (res.msg || ""));
    }
  })
  .catch(function() { alert("서버 연결 오류가 발생했습니다."); });
}

function submitReview(){
  const content=document.getElementById("reviewContent").value;
  if(content.length<20){alert("리뷰는 20자 이상 작성해주세요");return;}
  const formData=new FormData();
  formData.append("rating",document.getElementById("rating").value);
  formData.append("content",content);
  formData.append("trainerId", TRAINER_ID || 1);
  const file=document.getElementById("reviewImage").files[0];
  if(file) formData.append("image",file);
  fetch("review",{method:"POST",body:formData}).then(res=>res.text()).then(msg=>{alert(msg);closeReviewModal();});
}
</script>

</body>
</html>
