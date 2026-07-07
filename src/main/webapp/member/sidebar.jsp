<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.common.UserDTO"%>
<%
    String contextPath = request.getContextPath();
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
%>

<!-- 핏불 사이드바 -->
<aside id="fitbullSidebar" style="
  position:fixed; left:0; top:0; width:260px; height:100vh;
  background:#FFFFFF; border-right:2px solid #E8EDF5;
  display:flex; flex-direction:column; padding:22px 16px;
  z-index:100; overflow-y:auto;
  box-shadow:4px 0 24px rgba(0,0,0,0.06);
  font-family:'Noto Sans KR','Nunito',sans-serif;
">

  <!-- 로고 -->
  <a href="<%=contextPath%>/member/main" style="
    display:flex;align-items:center;gap:10px;
    margin-bottom:22px;padding:0 6px;text-decoration:none;
  ">
    <img src="<%=contextPath%>/resources/images/fitbull_icon.png"
         style="width:44px;height:44px;border-radius:50%;object-fit:cover;border:2px solid #FF6B35;"
         onerror="this.style.display='none';this.nextElementSibling.style.display='block'" alt="핏불">
    <div style="display:none;width:44px;height:44px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#00BFA5);flex-shrink:0;"></div>
    <span style="
      font-family:'Nunito',sans-serif;font-size:22px;font-weight:900;
      background:linear-gradient(135deg,#FF6B35,#00BFA5);
      -webkit-background-clip:text;-webkit-text-fill-color:transparent;
      background-clip:text;letter-spacing:-0.5px;
    ">핏츠버그</span>
  </a>

  <!-- 프로필 카드 -->
  <% if(loginUser != null){ %>
  <div style="
    background:linear-gradient(135deg,#FFF3EE,#ffffff);
    border:1.5px solid rgba(255,107,53,0.18);
    border-radius:14px;padding:14px;margin-bottom:18px;
    display:flex;align-items:center;gap:12px;
  ">
    <img src="<%= loginUser.getProfileImage() == null ? "https://api.dicebear.com/7.x/adventurer/svg?seed=" + loginUser.getNickname() : loginUser.getProfileImage() %>"
         style="width:46px;height:46px;border-radius:50%;border:2.5px solid #FF6B35;object-fit:cover;flex-shrink:0;" alt="프로필">
    <div style="min-width:0;">
      <div style="font-weight:700;font-size:14px;color:#1A1F36;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
        <%= loginUser.getNickname() %>
      </div>
      <div style="font-size:11px;color:#9DA8C0;margin-top:2px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
        <%= loginUser.getEmail() %>
      </div>
      <div style="font-size:11px;color:#00897B;background:#E8F8F6;padding:2px 8px;border-radius:99px;margin-top:5px;display:inline-block;font-weight:700;">
        맞춤 플랜 진행 중 💪
      </div>
    </div>
  </div>
  <% } %>

  <!-- 네비게이션 -->
  <nav style="display:flex;flex-direction:column;gap:3px;flex:1;">

    <a href="<%=contextPath%>/member/main" class="sb-link">
      <span class="material-symbols-outlined" style="font-size:20px;">home</span><span>홈</span>
    </a>
    <a href="<%=contextPath%>/member/guide" class="sb-link">
      <span class="material-symbols-outlined" style="font-size:20px;">fitness_center</span><span>운동 가이드</span>
    </a>
    <a href="<%=contextPath%>/member/trainerList" class="sb-link">
      <span class="material-symbols-outlined" style="font-size:20px;">badge</span><span>트레이너</span>
    </a>
   <a href="<%=contextPath%>/member/gymList" class="sb-link">
      <span class="material-symbols-outlined" style="font-size:20px;">store</span><span>헬스장</span>
    </a>
    <a href="<%=contextPath%>/member/community" class="sb-link">
      <span class="material-symbols-outlined" style="font-size:20px;">groups</span><span>커뮤니티</span>
    </a>
    <a href="<%=contextPath%>/member/mypage" class="sb-link">
      <span class="material-symbols-outlined" style="font-size:20px;">person</span><span>마이페이지</span>
    </a>

  </nav>

  <!-- 하단 -->
  <div style="border-top:1.5px solid #E8EDF5;padding-top:14px;margin-top:8px;display:flex;flex-direction:column;gap:4px;">
    <a href="<%=contextPath%>/member/support" class="sb-link">
      <span class="material-symbols-outlined" style="font-size:20px;">support_agent</span><span>고객센터</span>
    </a>
    <% if(loginUser != null){ %>
    <form action="<%=contextPath%>/member/logout" method="post">
      <button type="submit" class="sb-btn-main">
        <span class="material-symbols-outlined" style="font-size:18px;">logout</span>
        로그아웃
      </button>
    </form>
    <% } else { %>
    <button onclick="location.href='<%=contextPath%>/member/login'" class="sb-btn-main">
      <span class="material-symbols-outlined" style="font-size:18px;">login</span>로그인
    </button>
    <% } %>
  </div>

  <!-- 핏불 마스코트 -->
  <div style="margin-top:14px;text-align:center;opacity:0.4;padding:8px;">
    <svg width="56" height="56" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <circle cx="50" cy="48" r="28" fill="#FF6B35"/>
      <circle cx="37" cy="34" r="9" fill="#FF6B35"/><circle cx="63" cy="34" r="9" fill="#FF6B35"/>
      <circle cx="37" cy="34" r="5" fill="#F4A0A0"/><circle cx="63" cy="34" r="5" fill="#F4A0A0"/>
      <ellipse cx="50" cy="54" rx="18" ry="12" fill="#E8E8F0"/>
      <circle cx="43" cy="44" r="4" fill="#1A1F36"/><circle cx="57" cy="44" r="4" fill="#1A1F36"/>
      <circle cx="44.5" cy="42.5" r="1.5" fill="white"/><circle cx="58.5" cy="42.5" r="1.5" fill="white"/>
      <ellipse cx="50" cy="54" rx="5" ry="3.5" fill="#1A1F36"/>
      <path d="M43 61 Q50 68 57 61" stroke="#FF6B35" stroke-width="2.5" fill="none" stroke-linecap="round"/>
    </svg>
    <div style="font-size:10px;color:#9DA8C0;font-weight:600;margin-top:2px;">Fitbull 🐾</div>
  </div>

</aside>

<!-- =====================================================
     핏불 오운완 따봉 애니메이션 오버레이
     ===================================================== -->
<div id="fitbullCheerOverlay" style="
  position:fixed;inset:0;z-index:9999;pointer-events:none;
  display:flex;align-items:flex-end;justify-content:flex-end;padding:36px;
">
  <div id="fitbullCheerChar" style="
    transform:translateY(200px) scale(0.5);opacity:0;position:relative;
    transition:transform 0.6s cubic-bezier(0.175,0.885,0.32,1.275),opacity 0.4s ease;
  ">
    <!-- 말풍선 -->
    <div id="fitbullCheerBubble" style="
      position:absolute;top:-72px;right:-8px;
      background:linear-gradient(135deg,#FF6B35,#FFD166);
      color:white;font-family:'Noto Sans KR',sans-serif;
      font-weight:900;font-size:15px;
      padding:10px 18px;border-radius:18px;white-space:nowrap;
      box-shadow:0 4px 20px rgba(255,107,53,0.35);
      opacity:0;transform:scale(0.5) translateY(-10px);
      transition:all 0.4s ease 0.4s;
    ">
      🎉 오운완! 핏불이 응원해!
      <div style="position:absolute;bottom:-9px;right:24px;width:0;height:0;
        border-left:9px solid transparent;border-right:9px solid transparent;
        border-top:10px solid #FFD166;"></div>
    </div>

    <!-- 핏불 캐릭터 -->
    <svg width="160" height="160" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg"
         style="filter:drop-shadow(0 8px 24px rgba(255,107,53,0.35));">
      <!-- 몸통 / 오렌지 티셔츠 -->
      <ellipse cx="100" cy="148" rx="52" ry="38" fill="#FF6B35"/>
      <ellipse cx="100" cy="155" rx="44" ry="32" fill="#FF8C5A"/>
      <!-- 머리 -->
      <circle cx="100" cy="85" r="44" fill="#7A7EA8"/>
      <!-- 귀 -->
      <circle cx="76" cy="60" r="15" fill="#7A7EA8"/>
      <circle cx="124" cy="60" r="15" fill="#7A7EA8"/>
      <circle cx="76" cy="60" r="9" fill="#F4A0A0"/>
      <circle cx="124" cy="60" r="9" fill="#F4A0A0"/>
      <!-- 얼굴 밝은부분 -->
      <ellipse cx="100" cy="92" rx="28" ry="22" fill="#E8E8F0"/>
      <!-- 헤어밴드 -->
      <path d="M58 70 Q100 55 142 70" stroke="#FFD166" stroke-width="7" fill="none" stroke-linecap="round"/>
      <!-- 눈 -->
      <circle cx="87" cy="80" r="6" fill="#1A1F36"/>
      <circle cx="113" cy="80" r="6" fill="#1A1F36"/>
      <circle cx="88.5" cy="78.5" r="2" fill="white"/>
      <circle cx="114.5" cy="78.5" r="2" fill="white"/>
      <!-- 윙크 왼쪽 -->
      <path d="M81 80 Q87 76 93 80" stroke="#1A1F36" stroke-width="3" fill="none" stroke-linecap="round"/>
      <!-- 코 -->
      <ellipse cx="100" cy="93" rx="7" ry="5" fill="#1A1F36"/>
      <!-- 입 -->
      <path d="M87 103 Q100 115 113 103" stroke="#FF6B35" stroke-width="3.5" fill="none" stroke-linecap="round"/>
      <!-- 볼 -->
      <ellipse cx="79" cy="96" rx="8" ry="5" fill="#FFB4A2" opacity="0.7"/>
      <ellipse cx="121" cy="96" rx="8" ry="5" fill="#FFB4A2" opacity="0.7"/>
      <!-- 오른팔 따봉 -->
      <ellipse cx="155" cy="120" rx="24" ry="14" fill="#7A7EA8" transform="rotate(-25 155 120)"/>
      <rect x="144" y="90" width="28" height="22" rx="11" fill="#7A7EA8"/>
      <ellipse cx="143" cy="85" rx="10" ry="13" fill="#7A7EA8" transform="rotate(15 143 85)"/>
      <!-- 왼팔 덤벨 -->
      <rect x="24" y="114" width="36" height="9" rx="4.5" fill="#1A1F36"/>
      <rect x="18" y="107" width="10" height="23" rx="5" fill="#5A6480"/>
      <rect x="56" y="107" width="10" height="23" rx="5" fill="#5A6480"/>
      <!-- 반짝이 -->
      <line x1="165" y1="85" x2="172" y2="76" stroke="#FFD166" stroke-width="3" stroke-linecap="round"/>
      <line x1="174" y1="96" x2="183" y2="90" stroke="#FFD166" stroke-width="3" stroke-linecap="round"/>
      <line x1="168" y1="110" x2="178" y2="108" stroke="#FFD166" stroke-width="3" stroke-linecap="round"/>
    </svg>

    <!-- 파티클 컨테이너 -->
    <div id="fitbullSparkles" style="position:absolute;inset:0;pointer-events:none;overflow:visible;"></div>
  </div>
</div>

<!-- =====================================================
     공통 스타일 / 폰트
     ===================================================== -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<style>
/* 사이드바 링크 공통 */
.sb-link {
  display:flex;align-items:center;gap:12px;
  padding:11px 14px;border-radius:12px;
  font-size:14px;font-weight:600;text-decoration:none;
  color:#5A6480;transition:all 0.2s;
  font-family:'Noto Sans KR',sans-serif;
}
.sb-link:hover {
  background:#FFF3EE;color:#FF6B35;transform:translateX(3px);
}
.sb-btn-main {
  width:100%;padding:12px 14px;border:none;cursor:pointer;
  border-radius:12px;font-family:'Noto Sans KR',sans-serif;
  font-size:14px;font-weight:700;
  background:linear-gradient(135deg,#FF6B35,#FF8C5A);
  color:white;box-shadow:0 4px 16px rgba(255,107,53,0.25);
  display:flex;align-items:center;justify-content:center;gap:10px;
  transition:all 0.2s;
}
.sb-btn-main:hover { transform:translateY(-2px);box-shadow:0 6px 22px rgba(255,107,53,0.38); }

/* 파티클 애니메이션 */
@keyframes fb_sparkle {
  0%   { opacity:1; transform:scale(1) translate(0,0); }
  100% { opacity:0; transform:scale(0) translate(var(--tx),var(--ty)); }
}

/* CSS 변수 */
:root {
  --fb-orange:#FF6B35; --fb-teal:#00BFA5;
  --fb-orange-light:#FF8C5A; --fb-teal-light:#26D4BB;
  --fb-bg:#F7F9FC; --fb-border:#E8EDF5;
  --fb-text:#1A1F36; --fb-muted:#9DA8C0;
  --sidebar-w:260px;
  --radius-md:14px; --radius-lg:20px; --radius-xl:28px; --radius-full:9999px;
  --shadow-sm:0 2px 8px rgba(0,0,0,0.06);
  --shadow-md:0 4px 20px rgba(0,0,0,0.10);
  --shadow-lg:0 8px 32px rgba(0,0,0,0.12);
  --shadow-orange:0 4px 20px rgba(255,107,53,0.25);
  --shadow-teal:0 4px 20px rgba(0,191,165,0.25);
}

/* 전체 공통 body */
body {
  font-family:'Noto Sans KR','Nunito',sans-serif;
  background:#F7F9FC;color:#1A1F36;
}

::-webkit-scrollbar{width:5px;height:5px;}
::-webkit-scrollbar-track{background:#F7F9FC;}
::-webkit-scrollbar-thumb{background:#00BFA5;border-radius:99px;}
</style>

<script>
/* =====================================================
   핏불 오운완 따봉 애니메이션 JS
   ===================================================== */
function showFitbullCheer(msg) {
  const char = document.getElementById('fitbullCheerChar');
  const bubble = document.getElementById('fitbullCheerBubble');
  if (!char) return;

  if (msg) bubble.innerHTML = msg + '<div style="position:absolute;bottom:-9px;right:24px;width:0;height:0;border-left:9px solid transparent;border-right:9px solid transparent;border-top:10px solid #FFD166;"></div>';

  char.style.transform = 'translateY(0) scale(1)';
  char.style.opacity = '1';

  setTimeout(() => {
    bubble.style.opacity = '1';
    bubble.style.transform = 'scale(1) translateY(0)';
    spawnFitbullSparkles();
  }, 350);

  setTimeout(() => {
    char.style.transform = 'translateY(200px) scale(0.5)';
    char.style.opacity = '0';
    bubble.style.opacity = '0';
    bubble.style.transform = 'scale(0.5) translateY(-10px)';
  }, 4500);
}

function spawnFitbullSparkles() {
  const cont = document.getElementById('fitbullSparkles');
  if (!cont) return;
  cont.innerHTML = '';
  const colors = ['#FF6B35','#FFD166','#00BFA5','#FF8C5A','#26D4BB','#FFB4A2'];
  for (let i = 0; i < 18; i++) {
    const s = document.createElement('div');
    const tx = (Math.random() - 0.5) * 240;
    const ty = (Math.random() - 0.5) * 240;
    const size = 6 + Math.random() * 10;
    const delay = Math.random() * 0.4;
    s.style.cssText =
    	  'position:absolute;' +
    	  'width:' + size + 'px;height:' + size + 'px;' +
    	  'border-radius:50%;' +
    	  'background:' + colors[Math.floor(Math.random() * colors.length)] + ';' +
    	  'top:50%;left:50%;margin:-' + (size / 2) + 'px;' +
    	  '--tx:' + tx + 'px;--ty:' + ty + 'px;' +
    	  'animation:fb_sparkle 1.3s ease ' + delay + 's forwards;';
    cont.appendChild(s);
    setTimeout(() => s.remove(), 1800);
  }
}
</script>
