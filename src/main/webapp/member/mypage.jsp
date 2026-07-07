<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.common.UserDTO, dto.member.MemberDTO, java.util.Map"%>
<%
UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
if (loginUser == null) {
    response.sendRedirect(request.getContextPath() + "/member/login");
    return;
}

// MyPageController는 Map<String,Object>를 "member"로 넘김
// mypage.jsp에서 MemberDTO로 캐스팅하면 ClassCastException 발생 → Map으로 수정
@SuppressWarnings("unchecked")
Map<String, Object> memberMap = (Map<String, Object>) request.getAttribute("member");

// null이면 세션 캐시(memberInfo)에서 보완
if (memberMap == null) {
    Object cached = session.getAttribute("memberInfo");
    if (cached instanceof Map) {
        memberMap = (Map<String, Object>) cached;
    }
}

// Map에서 각 필드 추출하는 헬퍼
// goals, experience, height, weight, diet 를 사용하는 JSP 표현식에 맞게 변수화
String  m_goals      = memberMap != null && memberMap.get("goals")      != null ? String.valueOf(memberMap.get("goals"))      : "";
String  m_experience = memberMap != null && memberMap.get("experience")  != null ? String.valueOf(memberMap.get("experience"))  : "";
String  m_diet       = memberMap != null && memberMap.get("diet")        != null ? String.valueOf(memberMap.get("diet"))        : "";
int     m_height     = 0;
int     m_weight     = 0;
try { if (memberMap != null && memberMap.get("height") != null) m_height = Integer.parseInt(String.valueOf(memberMap.get("height"))); } catch (Exception ignored) {}
try { if (memberMap != null && memberMap.get("weight") != null) m_weight = Integer.parseInt(String.valueOf(memberMap.get("weight"))); } catch (Exception ignored) {}

// 편의 변수 (user.getNickname() 등 기존 코드 그대로 호환)
UserDTO user = loginUser;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 마이페이지</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;display:flex;min-height:100vh;}
.tab{display:none;} .tab.active{display:block;}
.quick-item{padding:18px 10px;border-radius:16px;cursor:pointer;text-align:center;border:1.5px solid #E8EDF5;background:white;transition:all 0.2s;}
.quick-item:hover{border-color:#FF6B35;background:#FFF3EE;transform:translateY(-2px);}
.quick-item.active{background:linear-gradient(135deg,#FF6B35,#FF8C5A);border-color:transparent;box-shadow:0 4px 16px rgba(255,107,53,0.3);}
.quick-item.active p{color:white!important;}
.view-btn{padding:8px 18px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:13px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;}
.view-btn.active{background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;border-color:transparent;box-shadow:0 3px 12px rgba(255,107,53,0.3);}
.info-label{font-size:12px;color:#9DA8C0;font-weight:600;margin-bottom:4px;}
.info-value{font-size:14px;font-weight:700;color:#1A1F36;}
.fb-inp{width:100%;padding:12px 16px;border-radius:12px;border:2px solid #E8EDF5;background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;transition:border-color 0.2s,box-shadow 0.2s;}
.fb-inp:focus{border-color:#FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.12);background:white;}
.fb-inp::placeholder{color:#C4CEDE;}
.fb-modal-wrap{display:none;position:fixed;inset:0;background:rgba(26,31,54,0.52);z-index:1000;align-items:center;justify-content:center;backdrop-filter:blur(5px);}
.fb-modal-box{background:white;border-radius:24px;padding:32px;width:100%;max-width:420px;box-shadow:0 12px 40px rgba(0,0,0,0.15);animation:fb_in 0.3s ease;}
@keyframes fb_in{from{opacity:0;transform:scale(0.9) translateY(20px);}to{opacity:1;transform:scale(1) translateY(0);}}
.cal-cell{border:1.5px solid #E8EDF5;border-radius:10px;padding:8px;min-height:80px;cursor:pointer;transition:all 0.2s;background:white;}
.cal-cell:hover{background:#FFF3EE;border-color:#FF6B35;}
.cal-cell.has-data{background:linear-gradient(135deg,#E8F8F6,white);border-color:rgba(0,191,165,0.3);}
.history-item{display:flex;justify-content:space-between;align-items:center;padding:12px 16px;background:#F7F9FC;border-radius:12px;border:1.5px solid #E8EDF5;}
.history-item.best{background:linear-gradient(135deg,#FFF3EE,white);border-color:rgba(255,107,53,0.25);}
.feedback-card{border:1.5px solid #E8EDF5;border-radius:14px;padding:16px;cursor:pointer;transition:all 0.2s;}
.feedback-card:hover{background:#FFF3EE;border-color:#FF6B35;transform:translateY(-1px);}
.post-mini{border:1.5px solid #E8EDF5;border-radius:14px;overflow:hidden;cursor:pointer;transition:all 0.2s;background:white;}
.post-mini:hover{box-shadow:0 6px 20px rgba(0,0,0,0.1);transform:translateY(-2px);}
.pay-table th{background:#F7F9FC;padding:12px 16px;font-size:13px;font-weight:700;color:#5A6480;text-align:left;border-bottom:1.5px solid #E8EDF5;}
.pay-table td{padding:12px 16px;font-size:14px;color:#1A1F36;border-bottom:1.5px solid #F0F0F0;}
.pay-table tr:last-child td{border-bottom:none;}
</style>
</head>
<body>
<jsp:include page="sidebar.jsp" />

<div style="flex:1;margin-left:260px;padding:32px 36px;max-width:calc(100vw - 260px);">

<!-- 배너 -->
<div style="background:linear-gradient(135deg,#FF6B35 0%,#FF8C5A 45%,#00BFA5 100%);border-radius:24px;padding:36px 40px;margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;box-shadow:0 8px 28px rgba(255,107,53,0.25);position:relative;overflow:hidden;">
  <div style="position:absolute;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,0.07);top:-80px;right:60px;"></div>
  <div style="position:relative;z-index:1;">
    <div style="font-size:13px;color:rgba(255,255,255,0.8);font-weight:600;margin-bottom:6px;">🐾 나의 피트니스 여정</div>
    <h1 style="font-size:30px;font-weight:900;color:white;letter-spacing:-0.5px;"><%= user.getNickname() %>님의 마이페이지</h1>
    <p style="font-size:14px;color:rgba(255,255,255,0.85);margin-top:6px;">오늘도 핏불과 함께 목표를 향해 달려봐요! 💪</p>
  </div>
  <div style="position:relative;z-index:1;display:flex;gap:20px;">
    <div style="text-align:center;background:rgba(255,255,255,0.18);border-radius:16px;padding:16px 22px;backdrop-filter:blur(8px);">
      <div style="font-size:24px;font-weight:900;color:white;" id="streakCount">-</div>
      <div style="font-size:11px;color:rgba(255,255,255,0.85);font-weight:600;">연속 오운완</div>
    </div>
  </div>
</div>

<!-- 퀵 메뉴 -->
<div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:20px 24px;margin-bottom:24px;">
  <div style="display:grid;grid-template-columns:repeat(5,1fr);gap:12px;">
    <div onclick="showTab('profileTab',this)" class="quick-item tab-btn active">
      <div style="font-size:28px;margin-bottom:8px;">👤</div>
      <p style="font-size:13px;font-weight:700;color:#1A1F36;">개인정보</p>
      <p style="font-size:11px;color:#9DA8C0;margin-top:2px;">프로필 관리</p>
    </div>
    <div onclick="showTab('recordTab',this)" class="quick-item tab-btn">
      <div style="font-size:28px;margin-bottom:8px;">📋</div>
      <p style="font-size:13px;font-weight:700;color:#1A1F36;">나의 기록</p>
      <p style="font-size:11px;color:#9DA8C0;margin-top:2px;">데이터 추적</p>
    </div>
    <div onclick="showTab('paymentTab',this)" class="quick-item tab-btn">
      <div style="font-size:28px;margin-bottom:8px;">💳</div>
      <p style="font-size:13px;font-weight:700;color:#1A1F36;">결제 내역</p>
      <p style="font-size:11px;color:#9DA8C0;margin-top:2px;">구독 히스토리</p>
    </div>
    <div onclick="showTab('feedbackTab',this)" class="quick-item tab-btn">
      <div style="font-size:28px;margin-bottom:8px;">🏋️</div>
      <p style="font-size:13px;font-weight:700;color:#1A1F36;">담당 트레이너</p>
      <p style="font-size:11px;color:#9DA8C0;margin-top:2px;">피드백 확인</p>
    </div>
    <div onclick="showTab('communityTab',this)" class="quick-item tab-btn">
      <div style="font-size:28px;margin-bottom:8px;">💬</div>
      <p style="font-size:13px;font-weight:700;color:#1A1F36;">커뮤니티</p>
      <p style="font-size:11px;color:#9DA8C0;margin-top:2px;">내 활동 내역</p>
    </div>
  </div>
</div>

<!-- ═══ TAB 1 : 개인정보 ═══ -->
<div id="profileTab" class="tab active">
<div style="display:grid;grid-template-columns:1fr 1fr;gap:24px;">

  <!-- 개인정보 카드 -->
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
      <h2 style="font-size:16px;font-weight:800;color:#1A1F36;">개인정보 관리</h2>
      <button onclick="openProfileModal()" style="padding:7px 16px;border-radius:99px;border:1.5px solid #FF6B35;background:white;color:#FF6B35;font-size:13px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='#FFF3EE'" onmouseout="this.style.background='white'">✏️ 수정</button>
    </div>
    <div style="display:flex;gap:20px;align-items:flex-start;">
      <div style="text-align:center;">
        <img id="profileImg"
          src="upload/<%= user.getProfileImage() == null ? "default.png" : user.getProfileImage() %>"
          onerror="this.src='https://api.dicebear.com/7.x/adventurer/svg?seed=<%= user.getNickname() %>'"
          style="width:90px;height:90px;border-radius:50%;border:3px solid #FF6B35;object-fit:cover;" alt="프로필">
        <form id="uploadForm">
          <label style="margin-top:10px;display:inline-block;padding:5px 12px;border-radius:99px;border:1.5px solid #E8EDF5;font-size:11px;font-weight:700;color:#5A6480;cursor:pointer;transition:all 0.2s;" onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'" onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#5A6480'">
            📷 변경
            <input type="file" name="profile_image" onchange="uploadImg()" style="display:none;">
          </label>
        </form>
      </div>
      <div style="flex:1;display:flex;flex-direction:column;gap:14px;">
        <div><div class="info-label">아이디 (이메일)</div><div class="info-value"><%= user.getEmail() %></div></div>
        <div><div class="info-label">닉네임</div><div class="info-value"><%= user.getNickname() %></div></div>
        <div>
          <div class="info-label">이메일 인증</div>
          <div style="display:inline-flex;align-items:center;gap:5px;padding:4px 12px;border-radius:99px;font-size:12px;font-weight:700;background:<%= user.isEmailVerified() ? "#E8F8F6" : "#FFF0EE" %>;color:<%= user.isEmailVerified() ? "#00897B" : "#FF4D1F" %>;">
            <%= user.isEmailVerified() ? "✔ 인증 완료" : "✕ 미인증" %>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 운동 계획 카드 -->
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
      <h2 style="font-size:16px;font-weight:800;color:#1A1F36;">맞춤형 운동 계획</h2>
      <button onclick="openPlanModal()" style="padding:7px 16px;border-radius:99px;border:1.5px solid #00BFA5;background:white;color:#00BFA5;font-size:13px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='#E8F8F6'" onmouseout="this.style.background='white'">✏️ 수정</button>
    </div>
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
      <!-- ✅ 에러 수정 3: 잘못된 삼항연산자 정리 + getGoals() 사용 -->
      <div style="background:#FFF3EE;border-radius:12px;padding:14px;">
        <div class="info-label">운동 목표</div>
        <div class="info-value"><%= m_goals.isEmpty() ? "미설정" : m_goals %></div>
      </div>
      <!-- ✅ 에러 수정 2: getLevel() 없음 → getExperience() 사용 -->
      <div style="background:#E8F8F6;border-radius:12px;padding:14px;">
        <div class="info-label">경험 수준</div>
        <div class="info-value"><%= m_experience.isEmpty() ? "미설정" : m_experience %></div>
      </div>
      <div style="background:#F7F9FC;border-radius:12px;padding:14px;">
        <div class="info-label">키 / 몸무게</div>
        <div class="info-value">
          <%= m_height > 0 ? m_height + "cm" : "-" %> /
          <%= m_weight > 0 ? m_weight + "kg" : "-" %>
        </div>
      </div>
      <div style="background:#FFF9E6;border-radius:12px;padding:14px;">
        <div class="info-label">식단 유형</div>
        <div class="info-value"><%= m_diet.isEmpty() ? "-" : m_diet %></div>
      </div>
    </div>
  </div>

</div>
</div>

<!-- ═══ TAB 2 : 기록 ═══ -->
<div id="recordTab" class="tab">
<div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
    <div>
      <h2 style="font-size:16px;font-weight:800;color:#1A1F36;">나의 기록 대시보드</h2>
      <p style="font-size:12px;color:#9DA8C0;margin-top:3px;">운동 · 식단 · 인바디 전체 기록</p>
    </div>
    <div style="display:flex;gap:8px;">
      <button onclick="changeView('workout',this)" class="view-btn active">💪 운동</button>
      <button onclick="changeView('food',this)" class="view-btn">🥗 식단</button>
      <button onclick="changeView('inbody',this)" class="view-btn">📊 인바디</button>
    </div>
  </div>
  <div style="font-size:12px;color:#9DA8C0;text-align:right;margin-bottom:12px;">
    단위: kg · 추정 1RM = 무게 × (1 + 0.033 × 횟수)
  </div>
  <canvas id="chart" style="display:none;max-height:280px;"></canvas>
  <div id="workoutHistory" style="display:none;margin-top:22px;">
    <h3 style="font-size:14px;font-weight:800;color:#1A1F36;margin-bottom:12px;">📅 운동 히스토리</h3>
    <div id="historyList" style="display:flex;flex-direction:column;gap:8px;"></div>
  </div>
  <div id="foodList" style="display:none;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
      <button onclick="prevMonth()" style="width:36px;height:36px;border-radius:50%;border:1.5px solid #E8EDF5;background:white;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">◀</button>
      <h3 id="calendarTitle" style="font-size:15px;font-weight:800;color:#1A1F36;"></h3>
      <button onclick="nextMonth()" style="width:36px;height:36px;border-radius:50%;border:1.5px solid #E8EDF5;background:white;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">▶</button>
    </div>
    <div id="calendarGrid" style="display:grid;grid-template-columns:repeat(7,1fr);gap:6px;"></div>
  </div>
</div>
</div>

<!-- ═══ TAB 3 : 결제 내역 ═══ -->
<div id="paymentTab" class="tab">
  <div id="activeMembership" style="margin-bottom:24px;"></div>
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;overflow:hidden;">
    <div style="margin-bottom:18px;">
      <h2 style="font-size:16px;font-weight:800;color:#1A1F36;">결제 내역 관리</h2>
      <p style="font-size:13px;color:#9DA8C0;margin-top:4px;">이용권 결제 내역을 확인하세요</p>
    </div>
    <div style="overflow-x:auto;">
      <table class="pay-table" style="width:100%;border-collapse:collapse;">
        <thead><tr><th>결제 일시</th><th>이용권</th><th>트레이너</th><th>결제 금액</th></tr></thead>
        <tbody id="paymentTable"></tbody>
      </table>
    </div>
  </div>
</div>

<!-- ═══ TAB 4 : 담당 트레이너 & 피드백 ═══ -->
<div id="feedbackTab" class="tab">
<div style="display:grid;grid-template-columns:320px 1fr;gap:24px;">
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
    <div style="text-align:center;margin-bottom:20px;">
      <img id="feedbackTrainerImg" src="https://api.dicebear.com/7.x/avataaars/svg?seed=trainer"
           style="width:88px;height:88px;border-radius:50%;border:3px solid #00BFA5;object-fit:cover;margin-bottom:12px;" alt="트레이너">
      <div id="feedbackTrainerName" style="font-size:18px;font-weight:900;color:#1A1F36;">트레이너 정보 로딩 중...</div>
      <div style="font-size:13px;color:#9DA8C0;margin-top:4px;">PT 담당 트레이너</div>
    </div>
    <div style="border-top:1.5px solid #E8EDF5;padding-top:16px;display:flex;flex-direction:column;gap:10px;">
      <div style="display:flex;justify-content:space-between;">
        <span style="font-size:13px;color:#9DA8C0;font-weight:600;">PT 진행</span>
        <span id="ptProgressText" style="font-size:13px;font-weight:700;color:#1A1F36;">-</span>
      </div>
      <div style="height:8px;background:#F0F0F0;border-radius:99px;overflow:hidden;">
        <div id="ptProgressBar" style="width:0%;height:100%;background:linear-gradient(90deg,#00BFA5,#26D4BB);border-radius:99px;transition:width 0.6s;"></div>
      </div>
      <div style="display:flex;justify-content:space-between;margin-top:4px;">
        <span style="font-size:13px;color:#9DA8C0;font-weight:600;">다음 수업</span>
        <span id="nextSessionText" style="font-size:13px;font-weight:700;color:#FF6B35;">-</span>
      </div>
    </div>
    <button onclick="goChat()" style="width:100%;margin-top:18px;padding:12px;border-radius:14px;border:none;cursor:pointer;background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 14px rgba(0,191,165,0.3);transition:all 0.2s;display:flex;align-items:center;justify-content:center;gap:8px;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
      <span class="material-symbols-outlined" style="font-size:18px;">chat</span>채팅하기
    </button>
    <!-- ✅ 에러 수정 4: ptFeedback.jsp → 컨트롤러 경로 -->
    <button onclick="location.href='<%=request.getContextPath()%>/member/ptFeedback'" style="width:100%;margin-top:8px;padding:12px;border-radius:14px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='#F7F9FC'" onmouseout="this.style.background='white'">
      전체 피드백 보기 →
    </button>
  </div>
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
      <h3 style="font-size:16px;font-weight:800;color:#1A1F36;">📋 최근 PT 피드백</h3>
    </div>
    <div id="recentFeedbackBox" style="display:flex;flex-direction:column;gap:12px;"></div>
  </div>
</div>
</div>

<!-- ═══ TAB 5 : 커뮤니티 ═══ -->
<div id="communityTab" class="tab">
<div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
    <div>
      <h2 style="font-size:16px;font-weight:800;color:#1A1F36;">나의 커뮤니티 활동</h2>
      <p style="font-size:12px;color:#9DA8C0;margin-top:3px;">내가 작성한 게시글과 반응</p>
    </div>
    <!-- ✅ community.jsp → 컨트롤러 경로 -->
    <a href="<%=request.getContextPath()%>/member/community" style="padding:8px 18px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:13px;font-weight:700;text-decoration:none;transition:all 0.2s;" onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'" onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#5A6480'">커뮤니티 →</a>
  </div>
  <div id="myPostBox" style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;"></div>
</div>
</div>

</div><!-- end content -->

<!-- 모달: 개인정보 수정 -->
<div id="profileModal" class="fb-modal-wrap">
  <div class="fb-modal-box">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
      <h2 style="font-size:18px;font-weight:900;color:#1A1F36;">개인정보 수정</h2>
      <button onclick="closeProfileModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div style="display:flex;flex-direction:column;gap:14px;">
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">닉네임</label>
        <input id="editNickname" class="fb-inp" placeholder="닉네임" value="<%= user.getNickname() %>">
      </div>
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">새 비밀번호</label>
        <input id="editPassword" type="password" class="fb-inp" placeholder="새 비밀번호">
      </div>
    </div>
    <button onclick="updateProfile()" style="width:100%;margin-top:22px;padding:13px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:15px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(255,107,53,0.3);">저장하기</button>
    <button onclick="closeProfileModal()" style="width:100%;margin-top:8px;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:600;cursor:pointer;font-family:'Noto Sans KR',sans-serif;">닫기</button>
  </div>
</div>

<!-- 모달: 운동계획 수정 -->
<div id="planModal" class="fb-modal-wrap">
  <div class="fb-modal-box" style="max-width:460px;max-height:90vh;overflow-y:auto;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
      <h2 style="font-size:18px;font-weight:900;color:#1A1F36;">운동 계획 수정</h2>
      <button onclick="closePlanModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div style="display:flex;flex-direction:column;gap:14px;">

      <!-- 운동 목적 (purpose) — ENUM: diet/balance/bulk-up → 드롭다운 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">🎯 운동 목적</label>
        <select id="purpose" class="fb-inp">
          <option value="diet"    <%= "diet".equals(memberMap != null ? String.valueOf(memberMap.getOrDefault("purpose","")) : "") ? "selected" : "" %>>🥗 다이어트 · 체중 감량</option>
          <option value="balance" <%= "balance".equals(memberMap != null ? String.valueOf(memberMap.getOrDefault("purpose","")) : "") ? "selected" : "" %>>⚖️ 밸런스 · 체형 교정</option>
          <option value="bulk-up" <%= "bulk-up".equals(memberMap != null ? String.valueOf(memberMap.getOrDefault("purpose","")) : "") ? "selected" : "" %>>💪 벌크업 · 근육 증가</option>
        </select>
      </div>

      <!-- 나만의 목표 (goals) — 자유 텍스트 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">✍️ 나만의 목표</label>
        <input id="goal" class="fb-inp" placeholder="예: 올해 안에 벤치 100kg 달성" value="<%= m_goals %>">
      </div>

      <!-- 운동 경력 (experience) — ENUM: first(0)/beginner(<1)/intermediate(1~3)/high(>3) → 드롭다운 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">🏋️ 운동 경력</label>
        <select id="level" class="fb-inp">
          <option value="first(0)"          <%= "first(0)".equals(m_experience)          ? "selected" : "" %>>🌱 처음이에요 · 완전 초보</option>
          <option value="beginner(<1)"       <%= "beginner(<1)".equals(m_experience)       ? "selected" : "" %>>🐣 1년 미만 · 초급</option>
          <option value="intermediate(1~3)" <%= "intermediate(1~3)".equals(m_experience) ? "selected" : "" %>>🏃 1~3년 · 중급</option>
          <option value="high(>3)"          <%= "high(>3)".equals(m_experience)          ? "selected" : "" %>>🏆 3년 이상 · 고급</option>
        </select>
      </div>

      <!-- 키 / 몸무게 — 텍스트(숫자) 입력 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">📏 키 / 몸무게</label>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;">
          <input id="height" class="fb-inp" placeholder="키 (cm)"     type="number" min="100" max="250" value="<%= m_height > 0 ? m_height : "" %>">
          <input id="weight" class="fb-inp" placeholder="몸무게 (kg)" type="number" min="30"  max="300" value="<%= m_weight > 0 ? m_weight : "" %>">
        </div>
      </div>

      <!-- 식단 유형 (diet) — ENUM: YES/Intermediate/NO → 드롭다운 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">🥗 식단 관리</label>
        <select id="diet" class="fb-inp">
          <option value="YES"          <%= "YES".equals(m_diet)          ? "selected" : "" %>>✅ 철저하게 관리해요</option>
          <option value="Intermediate" <%= "Intermediate".equals(m_diet) ? "selected" : "" %>>🔆 어느 정도 신경써요</option>
          <option value="NO"           <%= "NO".equals(m_diet)           ? "selected" : "" %>>❌ 거의 안 해요</option>
        </select>
      </div>

      <!-- 주간 운동 횟수 (exerciseCountGoal) — ENUM: <=2/3~4/>5 → 드롭다운 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">📅 주간 운동 목표</label>
        <select id="exerciseCountGoal" class="fb-inp">
          <option value="<=2" <%= "<=2".equals(memberMap != null ? String.valueOf(memberMap.getOrDefault("exerciseCount_goal","")) : "") ? "selected" : "" %>>🚶 주 1~2회 · 가볍게 꾸준히</option>
          <option value="3~4" <%= "3~4".equals(memberMap != null ? String.valueOf(memberMap.getOrDefault("exerciseCount_goal","")) : "") ? "selected" : "" %>>🏃 주 3~4회 · 일반적인 목표</option>
          <option value=">5"  <%= ">5".equals(memberMap != null ? String.valueOf(memberMap.getOrDefault("exerciseCount_goal","")) : "") ? "selected" : "" %>>💪 주 5회+ · 본격적인 몸 만들기</option>
        </select>
      </div>

    </div>
    <button onclick="updatePlan()" style="width:100%;margin-top:22px;padding:13px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-size:15px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(0,191,165,0.3);">저장하기</button>
    <button onclick="closePlanModal()" style="width:100%;margin-top:8px;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:600;cursor:pointer;font-family:'Noto Sans KR',sans-serif;">닫기</button>
  </div>
</div>

<!-- 모달: 식단 상세 -->
<div id="foodModal" class="fb-modal-wrap">
  <div class="fb-modal-box" style="max-width:360px;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
      <h2 id="modalDate" style="font-size:16px;font-weight:900;color:#1A1F36;"></h2>
      <button onclick="closeFoodModal()" style="width:32px;height:32px;border-radius:50%;border:none;background:#F7F9FC;color:#5A6480;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;">✕</button>
    </div>
    <div id="modalContent"></div>
    <button onclick="closeFoodModal()" style="width:100%;margin-top:18px;padding:11px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:600;cursor:pointer;font-family:'Noto Sans KR',sans-serif;">닫기</button>
  </div>
</div>

<script>
let chartInstance = null;
let currentView   = "workout";
let currentDate   = new Date();
let currentFoodData = [];
const CTX = '<%=request.getContextPath()%>';

window.onload = function() {
  loadData("workout");
  loadOwunStreak();
  loadCommunityData();
  const tab = "<%= request.getAttribute("tab") %>";
  if (tab && tab !== "null") openTab(tab);
};

function loadOwunStreak() {
  fetch(CTX + '/member/mypageData?type=owun')
    .then(function(res){ return res.json(); })
    .then(function(data){
      var el = document.getElementById('streakCount');
      if (el) el.innerText = (data.streak || 0) + '일';
    }).catch(function(){
      var el = document.getElementById('streakCount');
      if (el) el.innerText = '0일';
    });
}

function showTab(tabId, el) {
  document.querySelectorAll(".tab").forEach(function(t){ t.classList.remove("active"); });
  document.querySelectorAll(".tab-btn").forEach(function(b){
    b.classList.remove("active");
    b.querySelectorAll("p").forEach(function(p){ p.style.color = ""; });
  });
  document.getElementById(tabId).classList.add("active");
  if (el) el.classList.add("active");
  
  if (tabId === "recordTab")    loadData(currentView);
  if (tabId === "paymentTab")   loadPaymentData();
  if (tabId === "communityTab") loadCommunityData();
  if (tabId === "feedbackTab")  loadRecentFeedback();
}

function openTab(name) {
  const map = {profile:"profileTab", record:"recordTab", payment:"paymentTab", feedback:"feedbackTab", community:"communityTab"};
  const id = map[name];
  if (!id) return;
  document.querySelectorAll(".tab-btn").forEach(function(b){
    if (b.getAttribute("onclick") && b.getAttribute("onclick").includes(id)) showTab(id, b);
  });
}

function changeView(type, el) {
  currentView = type;
  document.querySelectorAll(".view-btn").forEach(function(b){ b.classList.remove("active"); });
  if (el) el.classList.add("active");
  loadData(type);
}

function loadData(type) {
  const chartEl   = document.getElementById("chart");
  const foodEl    = document.getElementById("foodList");
  const historyEl = document.getElementById("workoutHistory");
  chartEl.style.display = foodEl.style.display = historyEl.style.display = "none";
  
  fetch(type)
    .then(function(res){ if (!res.ok) throw new Error(); return res.json(); })
    .then(function(data){ render(type, data); })
    .catch(function(){
      console.error("데이터를 불러오는데 실패했습니다. (type: " + type + ")");
    });
}

function render(type, data) {
  const chartEl   = document.getElementById("chart");
  const foodEl    = document.getElementById("foodList");
  const historyEl = document.getElementById("workoutHistory");
  chartEl.style.display = foodEl.style.display = historyEl.style.display = "none";
  
  if (type === "workout") { 
    chartEl.style.display = historyEl.style.display = "block"; 
    drawWorkoutChart(data); 
    drawWorkoutHistory(data); 
  }
  else if (type === "food") { 
    foodEl.style.display = "block"; 
    currentFoodData = data; 
    drawCalendar(); 
  }
  else if (type === "inbody") { 
    chartEl.style.display = "block"; 
    drawInbodyChart(data); 
  }
}

function drawWorkoutChart(data) {
  if (chartInstance) chartInstance.destroy();
  const labels  = [...new Set(data.map(function(d){ return d.date; }))];
  const grouped = {};
  data.forEach(function(d){ 
    if (!grouped[d.name]) grouped[d.name] = []; 
    grouped[d.name].push({date: d.date, value: (d.weight * (1 + 0.033 * d.reps)).toFixed(1)}); 
  });
  
  const colors = ["#FF6B35","#00BFA5","#9333EA","#FFD166","#FF4D4D"];
  const datasets = Object.keys(grouped).map(function(name, i){
    return {
      label: name, 
      data: labels.map(function(date){
        const f = grouped[name].find(function(d){ return d.date === date; });
        return f ? f.value : null;
      }),
      borderColor: colors[i % colors.length], 
      backgroundColor: colors[i % colors.length] + "20",
      tension: 0.4, fill: true, pointRadius: 5, pointHoverRadius: 7
    };
  });
  
  chartInstance = new Chart(document.getElementById("chart"), {
    type: "line", 
    data: {labels: labels, datasets: datasets},
    options: {
      plugins: {legend: {labels: {color: "#5A6480", font: {family: "'Noto Sans KR'", weight: "700"}}}},
      scales: {
        x: {grid: {display: false}, ticks: {color: "#9DA8C0"}},
        y: {grid: {color: "#F0F0F0"}, ticks: {color: "#9DA8C0"}}
      }
    }
  });
}

function drawWorkoutHistory(data) {
  const box = document.getElementById("historyList");
  box.innerHTML = "";
  if (!data || data.length === 0) return;

  const maxW = Math.max.apply(null, data.map(function(d){ return d.weight; }));
  
  data.forEach(function(d, i){
    const isBest = d.weight === maxW;
    box.innerHTML += 
      '<div class="history-item' + (isBest ? ' best' : '') + '">' +
        '<div>' +
          '<div style="font-size:12px;color:#9DA8C0;font-weight:600;">#' + (i + 1) + ' · ' + d.date + '</div>' +
          '<div style="font-weight:800;font-size:14px;color:#1A1F36;margin-top:2px;">' + d.name + '</div>' +
        '</div>' +
        '<div style="text-align:right;">' +
          '<div style="font-size:14px;font-weight:700;color:' + (isBest ? '#FF6B35' : '#1A1F36') + ';">' + d.weight + 'kg × ' + d.reps + '회</div>' +
          (isBest ? '<div style="font-size:18px;margin-top:2px;">👑 최고기록</div>' : '') +
        '</div>' +
      '</div>';
  });
}

function drawInbodyChart(data) {
  if (chartInstance) chartInstance.destroy();
  chartInstance = new Chart(document.getElementById("chart"), {
    type: "line",
    data: {
      labels: data.map(function(d){ return d.date; }),
      datasets: [
        {label: "체중(kg)", data: data.map(function(d){ return d.weight; }), borderColor: "#FF6B35", backgroundColor: "rgba(255,107,53,0.08)", tension: 0.4, fill: true, pointRadius: 5},
        {label: "골격근량(kg)", data: data.map(function(d){ return d.muscle; }), borderColor: "#00BFA5", backgroundColor: "rgba(0,191,165,0.08)", tension: 0.4, fill: true, pointRadius: 5},
        {label: "체지방량(kg)", data: data.map(function(d){ return d.fat; }), borderColor: "#9333EA", backgroundColor: "rgba(147,51,234,0.08)", tension: 0.4, fill: true, pointRadius: 5}
      ]
    },
    options: {
      plugins: {legend: {labels: {color: "#5A6480", font: {family: "'Noto Sans KR'", weight: "700"}}}},
      scales: {
        x: {grid: {display: false}, ticks: {color: "#9DA8C0"}},
        y: {grid: {color: "#F0F0F0"}, ticks: {color: "#9DA8C0"}}
      }
    }
  });
}

function drawCalendar() {
  const grid = document.getElementById("calendarGrid");
  if (!grid) return;
  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();
  document.getElementById("calendarTitle").innerText = year + "년 " + (month + 1) + "월";
  const lastDate = new Date(year, month + 1, 0).getDate();
  
  const map = {};
  currentFoodData.forEach(function(d){ map[d.date] = d; });
  
  const days = ["일","월","화","수","목","금","토"];
  let html = days.map(function(d){ return '<div style="text-align:center;font-size:12px;font-weight:700;color:#9DA8C0;padding:6px 0;">' + d + '</div>'; }).join("");
  
  for(let i = 1; i <= lastDate; i++){
    const full = year + "-" + String(month + 1).padStart(2,"0") + "-" + String(i).padStart(2,"0");
    const d = map[full];
    html += 
      '<div onclick="openFoodModal(\'' + full + '\')" class="cal-cell' + (d ? ' has-data' : '') + '">' +
        '<div style="font-size:12px;font-weight:800;color:#1A1F36;margin-bottom:4px;">' + i + '</div>' +
        (d ? '<div style="font-size:11px;color:#00897B;font-weight:600;">' + d.food + '</div><div style="font-size:11px;color:#9DA8C0;">' + d.calorie + 'kcal</div>' : '') +
      '</div>';
  }
  grid.innerHTML = html;
}

function prevMonth() { currentDate.setMonth(currentDate.getMonth() - 1); drawCalendar(); }
function nextMonth() { currentDate.setMonth(currentDate.getMonth() + 1); drawCalendar(); }

function loadPaymentData() {
  fetch(CTX + '/member/mypageData?type=membership')
    .then(function(res){ return res.json(); })
    .then(drawMembership)
    .catch(function(){ document.getElementById('activeMembership').innerHTML = ''; });
    
  fetch(CTX + '/member/mypageData?type=payment')
    .then(function(res){ return res.json(); })
    .then(drawPaymentTable)
    .catch(function(){
      document.getElementById('paymentTable').innerHTML = '<tr><td colspan="5" style="text-align:center;color:#9DA8C0;padding:24px;">결제 내역이 없습니다.</td></tr>';
    });
}

function drawMembership(data) {
  const box = document.getElementById('activeMembership');
  if (!data || data === null) { box.innerHTML = ''; return; }
  
  const typeLabel = data.membershipType === 'pt' 
    ? 'PT ' + (data.typeRep || 0) + '회권' 
    : (data.membershipType === 'month' ? (data.typeRep || '') + '개월 이용권' : '이용권');
    
  const remain = data.lessonCount || 0;
  const total  = data.typeRep || 1;
  const pct    = Math.min(Math.round(remain / total * 100), 100);
  const mpId   = data.id || 0;
  
  box.innerHTML = 
    '<div style="position:relative;background:linear-gradient(135deg,#FF6B35,#FF8C5A);border-radius:20px;padding:28px;margin-bottom:8px;box-shadow:0 4px 20px rgba(255,107,53,0.25);">' +
      '<div style="color:rgba(255,255,255,0.8);font-size:13px;font-weight:600;">이용 중인 회원권</div>' +
      '<div style="font-size:22px;font-weight:900;color:white;margin-top:4px;">🎫 ' + (data.trainerNickname || '') + ' · ' + typeLabel + '</div>' +
      '<div style="margin-top:16px;">' +
        '<div style="color:white;font-size:13px;">남은 횟수 ' + remain + ' / ' + total + '회</div>' +
        '<div style="height:10px;background:rgba(255,255,255,0.3);border-radius:99px;margin-top:8px;overflow:hidden;">' +
          '<div style="width:' + pct + '%;height:100%;background:white;border-radius:99px;"></div>' +
        '</div>' +
        '<div style="margin-top:14px;">' +
          '<button onclick="requestRefund(' + mpId + ')" style="padding:10px 20px;border-radius:99px;border:2px solid white;background:transparent;color:white;font-size:13px;font-weight:700;cursor:pointer;font-family:\'Noto Sans KR\',sans-serif;" onmouseover="this.style.background=\'rgba(255,255,255,0.2)\'" onmouseout="this.style.background=\'transparent\'">💸 환불 요청</button>' +
        '</div>' +
      '</div>' +
    '</div>';
}

function drawPaymentTable(list) {
  const tbody = document.getElementById('paymentTable');
  if (!list || list.length === 0) {
    tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;color:#9DA8C0;padding:24px;">결제 내역이 없습니다.</td></tr>';
    return;
  }
  
  tbody.innerHTML = list.map(function(p){
    const date  = p.paymentDate ? String(p.paymentDate).substring(0,10) : '-';
    const price = p.paymentPrice ? Number(p.paymentPrice).toLocaleString() : '0';
    const statusColor = p.status === '결제완료' ? '#00897B' : '#FF4D4D';
    return '<tr>' +
      '<td>' + date + '</td>' +
      '<td><span style="background:#FFF3EE;color:#FF6B35;padding:4px 10px;border-radius:99px;">' + (p.paymentType === 'PT' ? 'PT 이용권' : '헬스장 이용권') + '</span></td>' +
      '<td>' + (p.trainerNickname || '-') + '</td>' +
      '<td>' + price + '원</td>' +
      '<td><span style="padding:4px 12px;border-radius:99px;font-size:12px;font-weight:700;background:#F7F9FC;color:' + statusColor + ';">' + (p.status || '-') + '</span></td>' +
    '</tr>';
  }).join('');
}

function requestRefund(mpId) {
  if (!confirm('환불을 요청하시겠습니까?\n처리까지 1~3 영업일이 소요됩니다.')) return;
  fetch(CTX + '/member/mypageData', {
    method: 'POST', 
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'type=refund&mpId=' + mpId + '&reason=회원+환불+요청'
  }).then(function(res){ return res.json(); })
  .then(function(r){
    if (r.result === 'ok') { 
      alert('✅ 환불 요청이 접수되었습니다.'); 
      loadPaymentData(); 
    } else {
      alert('처리 중 오류가 발생했습니다.');
    }
  });
}

function loadRecentFeedback() {
  fetch(CTX + '/member/mypageData?type=feedback')
    .then(function(res){ return res.json(); })
    .then(function(data){
      drawRecentFeedback(data);
      if (data && data.length > 0 && data[0].trainerNickname) {
        const el = document.getElementById('feedbackTrainerName');
        if (el) el.innerText = data[0].trainerNickname + ' 트레이너';
      }
    }).catch(function(){ drawRecentFeedback([]); });
    
  fetch(CTX + '/member/mypageData?type=membership')
    .then(function(res){ return res.json(); })
    .then(function(mp){
      if (!mp) return;
      const remain = mp.lessonCount || 0;
      const total  = mp.typeRep || 1;
      const pct    = Math.min(Math.round(remain / total * 100), 100);
      
      const pt = document.getElementById('ptProgressText');
      const pb = document.getElementById('ptProgressBar');
      const ns = document.getElementById('nextSessionText');
      
      if (pt) pt.innerText = remain + ' / ' + total + '회';
      if (pb) pb.style.width = pct + '%';
      if (ns) ns.innerText  = mp.nextSession || '예약 없음';
    }).catch(function(){});
}

function drawRecentFeedback(list) {
  const box = document.getElementById('recentFeedbackBox');
  if (!list || list.length === 0) {
    box.innerHTML = 
      '<div style="text-align:center;padding:32px 0;color:#9DA8C0;">' +
        '<div style="font-size:36px;margin-bottom:10px;">📭</div>' +
        '<p style="font-size:14px;font-weight:600;">아직 피드백이 없습니다</p>' +
      '</div>';
    return;
  }
  
  box.innerHTML = list.map(function(f){
    return '<div class="feedback-card">' +
      '<div style="display:flex;justify-content:space-between;margin-bottom:10px;">' +
        '<span style="font-size:13px;font-weight:800;color:#1A1F36;">📅 ' + (f.feedbackDate || '') + '</span>' +
        '<span style="font-size:12px;color:#9DA8C0;">' + (f.trainerNickname || '트레이너') + '</span>' +
      '</div>' +
      (f.summary ? '<div style="font-size:13px;color:#5A6480;margin-bottom:6px;">📝 ' + f.summary + '</div>' : '') +
      (f.comment ? '<div style="font-size:13px;color:#5A6480;margin-bottom:6px;">💬 ' + f.comment + '</div>' : '') +
      (f.nextComment ? '<div style="font-size:13px;color:#FF6B35;font-weight:600;">🎯 다음 목표: ' + f.nextComment + '</div>' : '') +
    '</div>';
  }).join('');
}

function loadCommunityData() {
  fetch(CTX + '/member/community?ajax=myPosts')
    .then(function(res){ if(!res.ok) throw new Error(); return res.json(); })
    .then(drawMyPosts)
    .catch(function(){ drawMyPosts([]); });
}

function drawMyPosts(posts) {
  const box = document.getElementById('myPostBox');
  if (!posts || posts.length === 0) {
    box.innerHTML = 
      '<div style="grid-column:1/-1;text-align:center;padding:48px 20px;color:#9DA8C0;">' +
        '<div style="font-size:40px;margin-bottom:12px;">📭</div>' +
        '<p style="font-size:14px;font-weight:600;">아직 작성한 게시글이 없어요</p>' +
        '<p style="font-size:13px;margin-top:6px;">오운완 게시글을 올리면 출석이 인증됩니다!</p>' +
      '</div>';
    return;
  }
  
  box.innerHTML = posts.map(function(post){
    const isOwun = post.postType === 'exerciseComplete';
    return '<div onclick="goDetail(' + post.id + ')" class="post-mini">' +
      '<div style="padding:12px 14px;border-bottom:1px solid #F0F0F0;">' +
        '<span style="padding:3px 10px;border-radius:99px;font-size:11px;font-weight:800;background:' + (isOwun ? 'linear-gradient(135deg,#FF6B35,#FFD166)' : '#E8F8F6') + ';color:' + (isOwun ? 'white' : '#00897B') + ';">' +
          (isOwun ? '🏆 오운완' : '💬 자유') + 
        '</span>' +
      '</div>' +
      '<div style="padding:14px;">' +
        '<div style="font-weight:700;font-size:13px;color:#1A1F36;margin-bottom:6px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">' + (post.title || '') + '</div>' +
        '<div style="font-size:12px;color:#9DA8C0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">' + (post.body || '') + '</div>' +
        '<div style="font-size:12px;color:#C4CEDE;margin-top:8px;">❤️ ' + (post.recommended || 0) + '</div>' +
      '</div>' +
    '</div>';
  }).join('');
}

function uploadImg() {
  const data = new FormData(document.getElementById("uploadForm"));
  fetch("uploadProfile", {method:"POST", body:data})
    .then(function(res){ return res.text(); })
    .then(function(file){ document.getElementById("profileImg").src = "upload/" + file; });
}

function openProfileModal()  { document.getElementById("profileModal").style.display = "flex"; }
function closeProfileModal() { document.getElementById("profileModal").style.display = "none"; }

function updateProfile() {
  const formData = new FormData();
  formData.append("nickname", document.getElementById("editNickname").value);
  formData.append("password", document.getElementById("editPassword").value);
  const fileInput = document.querySelector('input[name="profile_image"]');
  if(fileInput && fileInput.files.length > 0) {
    formData.append("profile_image", fileInput.files[0]);
  }
  
  fetch("updateProfile", {method:"POST", body:formData})
    .then(function(res){ return res.text(); })
    .then(function(r){
      if(r === "ok") {
        alert("✅ 개인정보가 저장되었습니다.");
        closeProfileModal();
        location.reload();
      } else {
        alert("저장에 실패했습니다. 다시 시도해주세요.");
      }
    })
    .catch(function(){ alert("서버 연결 오류가 발생했습니다."); });
}

function openPlanModal()  { document.getElementById("planModal").style.display = "flex"; }
function closePlanModal() { document.getElementById("planModal").style.display = "none"; }

function updatePlan() {
  const params = "goal=" + encodeURIComponent(document.getElementById("goal").value)
               + "&level=" + encodeURIComponent(document.getElementById("level").value)
               + "&height=" + encodeURIComponent(document.getElementById("height").value)
               + "&weight=" + encodeURIComponent(document.getElementById("weight").value)
               + "&diet=" + encodeURIComponent(document.getElementById("diet").value)
               + "&purpose=" + encodeURIComponent(document.getElementById("purpose").value)
               + "&exerciseCountGoal=" + encodeURIComponent(document.getElementById("exerciseCountGoal").value);

  fetch("updatePlan", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: params
  })
  .then(function(res){ return res.text(); })
  .then(function(r){
    if(r === "ok") {
      alert("✅ 운동 계획이 저장되었습니다.");
      closePlanModal();
      location.reload();
    } else {
      alert("저장에 실패했습니다. 다시 시도해주세요.");
    }
  })
  .catch(function(){ alert("서버 연결 오류가 발생했습니다."); });
}

function openFoodModal(date) {
  document.getElementById("modalDate").innerText = "📅 " + date;
  const found = currentFoodData.find(function(d){ return d.date === date; });
  document.getElementById("modalContent").innerHTML = found
    ? '<div><div style="font-weight:700;color:#1A1F36;margin-bottom:8px;">' + found.food + '</div><div style="font-size:14px;color:#FF6B35;font-weight:800;">🔥 ' + found.calorie + ' kcal</div></div>'
    : '<p style="color:#9DA8C0;font-size:13px;">기록된 식단이 없습니다.</p>';
  document.getElementById("foodModal").style.display = "flex";
}

function closeFoodModal() { document.getElementById("foodModal").style.display = "none"; }

function goDetail(id) { location.href = "<%=request.getContextPath()%>/member/communityDetail?id=" + id; }
function goChat()     { location.href = "<%=request.getContextPath()%>/member/chat"; }
</script>
</body>
</html>
