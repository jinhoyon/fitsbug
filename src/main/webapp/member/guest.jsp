<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 당신만의 피트니스를 발견하세요</title>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;color:#1A1F36;overflow-x:hidden;}
::-webkit-scrollbar{width:6px;} ::-webkit-scrollbar-thumb{background:#00BFA5;border-radius:99px;}

/* 사이드바 */
.guest-sidebar{position:fixed;left:0;top:0;width:240px;height:100vh;background:white;border-right:1.5px solid #E8EDF5;display:flex;flex-direction:column;padding:22px 16px;z-index:100;box-shadow:4px 0 20px rgba(0,0,0,0.05);}
.sb-link{display:flex;align-items:center;gap:12px;padding:11px 14px;border-radius:12px;font-size:14px;font-weight:600;text-decoration:none;color:#5A6480;transition:all 0.2s;font-family:'Noto Sans KR',sans-serif;}
.sb-link:hover{background:#FFF3EE;color:#FF6B35;transform:translateX(3px);}

/* 히어로 */
.hero{background:linear-gradient(135deg,#FF6B35 0%,#FF8C5A 40%,#00BFA5 100%);padding:80px 60px;position:relative;overflow:hidden;}
.hero::before{content:'';position:absolute;width:500px;height:500px;border-radius:50%;background:rgba(255,255,255,0.06);top:-120px;right:-80px;}
.hero::after{content:'';position:absolute;width:360px;height:360px;border-radius:50%;background:rgba(255,255,255,0.04);bottom:-80px;left:200px;}

/* 카드 슬라이더 */
.card-slider{display:grid;grid-auto-flow:column;grid-auto-columns:calc((100% - 48px)/3);gap:16px;overflow-x:auto;padding-bottom:8px;scroll-behavior:smooth;}
.card-slider::-webkit-scrollbar{display:none;}

/* 카드 hover */
.slide-card{background:white;border-radius:18px;overflow:hidden;border:1.5px solid #E8EDF5;transition:all 0.25s;cursor:pointer;}
.slide-card:hover{box-shadow:0 8px 28px rgba(0,0,0,0.12);transform:translateY(-3px);}

/* 섹션 공통 */
.section{padding:48px 60px;}
.section-title{font-size:20px;font-weight:900;color:#1A1F36;margin-bottom:22px;display:flex;align-items:center;gap:10px;}
.section-title::before{content:'';width:4px;height:22px;background:linear-gradient(180deg,#FF6B35,#FF8C5A);border-radius:99px;}

/* 하단 CTA 바 */
.cta-bar{position:fixed;bottom:0;left:240px;right:0;background:rgba(255,255,255,0.95);backdrop-filter:blur(12px);border-top:1.5px solid #E8EDF5;padding:20px 60px;display:flex;align-items:center;justify-content:space-between;z-index:100;box-shadow:0 -4px 20px rgba(0,0,0,0.06);}
</style>
</head>
<body>

<!-- ── 사이드바 ── -->
<div class="guest-sidebar">
  <div style="display:flex;align-items:center;gap:10px;margin-bottom:24px;padding:0 6px;">
    <div style="width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#00BFA5);display:flex;align-items:center;justify-content:center;font-size:18px;">🐾</div>
    <span style="font-family:'Nunito',sans-serif;font-size:20px;font-weight:900;background:linear-gradient(135deg,#FF6B35,#00BFA5);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">핏츠버그</span>
  </div>

  <nav style="display:flex;flex-direction:column;gap:3px;flex:1;">
    <a href="<%=contextPath%>/member/guide" class="sb-link"><span class="material-symbols-outlined" style="font-size:20px;">fitness_center</span>운동 가이드</a>
    <a href="<%=contextPath%>/member/trainerList" class="sb-link"><span class="material-symbols-outlined" style="font-size:20px;">badge</span>트레이너</a>
    <a href="<%=contextPath%>/member/gymList" class="sb-link"><span class="material-symbols-outlined" style="font-size:20px;">store</span>헬스장</a>
    <a href="<%=contextPath%>/member/community" class="sb-link"><span class="material-symbols-outlined" style="font-size:20px;">groups</span>커뮤니티</a>
  </nav>

  <div style="border-top:1.5px solid #E8EDF5;padding-top:14px;display:flex;flex-direction:column;gap:8px;">
    <button onclick="location.href='<%=contextPath%>/member/login'" style="width:100%;padding:12px;border-radius:12px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-weight:800;font-size:14px;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">
      🔥 로그인
    </button>
    <button onclick="location.href='<%=contextPath%>/member/join'" style="width:100%;padding:11px;border-radius:12px;border:2px solid #E8EDF5;cursor:pointer;background:white;color:#5A6480;font-weight:700;font-size:14px;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'" onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#5A6480'">
      회원가입
    </button>
  </div>
</div>

<!-- ── 메인 ── -->
<div style="margin-left:240px;padding-bottom:100px;">

  <!-- 히어로 -->
  <div class="hero">
    <div style="position:relative;z-index:1;display:flex;align-items:center;justify-content:space-between;">
      <div>
        <div style="display:inline-flex;align-items:center;gap:8px;background:rgba(255,255,255,0.2);backdrop-filter:blur(8px);border:1.5px solid rgba(255,255,255,0.3);border-radius:99px;padding:7px 16px;margin-bottom:20px;">
          <span style="font-size:14px;">🐾</span>
          <span style="font-size:13px;font-weight:700;color:white;">핏불이 함께하는 피트니스</span>
        </div>
        <h1 style="font-size:44px;font-weight:900;color:white;line-height:1.2;letter-spacing:-1px;margin-bottom:16px;">
          당신만의 최적의<br>운동을 발견하세요
        </h1>
        <p style="font-size:16px;color:rgba(255,255,255,0.88);line-height:1.6;margin-bottom:32px;">
          맞춤형 운동 플랜 · 전문 트레이너 매칭 · 오운완 커뮤니티<br>
          핏츠버그와 함께 건강한 라이프스타일을 만들어보세요
        </p>
        <div style="display:flex;gap:12px;">
          <button onclick="location.href='<%=contextPath%>/member/join'" style="padding:14px 32px;border-radius:99px;border:none;cursor:pointer;background:white;color:#FF6B35;font-size:16px;font-weight:900;font-family:'Noto Sans KR',sans-serif;box-shadow:0 6px 20px rgba(0,0,0,0.15);transition:all 0.2s;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
            🚀 무료 시작하기
          </button>
          <button onclick="location.href='<%=contextPath%>/member/login'" style="padding:14px 32px;border-radius:99px;border:2px solid rgba(255,255,255,0.6);cursor:pointer;background:transparent;color:white;font-size:16px;font-weight:700;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='rgba(255,255,255,0.15)'" onmouseout="this.style.background='transparent'">
            로그인
          </button>
        </div>
      </div>

      <!-- 마스코트 -->
      <div style="flex-shrink:0;animation:fb_float 4s ease-in-out infinite;">
        <div style="width:200px;height:200px;border-radius:50%;background:rgba(255,255,255,0.18);backdrop-filter:blur(10px);display:flex;align-items:center;justify-content:center;box-shadow:0 16px 48px rgba(0,0,0,0.15);">
          <svg width="140" height="140" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
            <ellipse cx="100" cy="148" rx="52" ry="36" fill="rgba(255,255,255,0.85)"/>
            <circle cx="100" cy="85" r="44" fill="rgba(255,255,255,0.9)"/>
            <circle cx="76" cy="60" r="15" fill="rgba(255,255,255,0.9)"/><circle cx="124" cy="60" r="15" fill="rgba(255,255,255,0.9)"/>
            <circle cx="76" cy="60" r="9" fill="#F4A0A0"/><circle cx="124" cy="60" r="9" fill="#F4A0A0"/>
            <ellipse cx="100" cy="90" rx="28" ry="22" fill="#E8E8F0"/>
            <path d="M58 70 Q100 55 142 70" stroke="#FFD166" stroke-width="7" fill="none" stroke-linecap="round"/>
            <circle cx="87" cy="80" r="6" fill="#1A1F36"/><circle cx="113" cy="80" r="6" fill="#1A1F36"/>
            <circle cx="88.5" cy="78.5" r="2" fill="white"/><circle cx="114.5" cy="78.5" r="2" fill="white"/>
            <ellipse cx="100" cy="93" rx="7" ry="5" fill="#1A1F36"/>
            <path d="M87 103 Q100 115 113 103" stroke="#FF6B35" stroke-width="3.5" fill="none" stroke-linecap="round"/>
            <ellipse cx="80" cy="97" rx="8" ry="5" fill="#FFB4A2" opacity="0.8"/>
            <ellipse cx="120" cy="97" rx="8" ry="5" fill="#FFB4A2" opacity="0.8"/>
            <rect x="24" y="112" width="36" height="9" rx="4.5" fill="rgba(255,255,255,0.7)"/>
            <rect x="18" y="106" width="10" height="22" rx="5" fill="rgba(255,255,255,0.6)"/>
            <rect x="56" y="106" width="10" height="22" rx="5" fill="rgba(255,255,255,0.6)"/>
          </svg>
        </div>
      </div>
    </div>

    <!-- 통계 -->
    <div style="position:relative;z-index:1;display:flex;gap:20px;margin-top:40px;">
      <% String[][] stats={{"12,000+","활성 회원"},{"500+","전문 트레이너"},{"200+","파트너 헬스장"},{"98%","회원 만족도"}};
         for(String[] s : stats){ %>
      <div style="background:rgba(255,255,255,0.15);backdrop-filter:blur(8px);border:1.5px solid rgba(255,255,255,0.25);border-radius:14px;padding:14px 22px;text-align:center;">
        <div style="font-size:22px;font-weight:900;color:white;"><%= s[0] %></div>
        <div style="font-size:11px;color:rgba(255,255,255,0.8);font-weight:600;margin-top:2px;"><%= s[1] %></div>
      </div>
      <% } %>
    </div>
  </div>

  <!-- 추천 트레이너 -->
  <div class="section" style="background:linear-gradient(135deg,#FAFBFF,#F7F9FC);padding-top:40px;padding-bottom:40px;">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
      <div class="section-title">전문 트레이너</div>
      <a href="<%=contextPath%>/trainer" style="font-size:13px;font-weight:700;color:#FF6B35;text-decoration:none;">모두 보기 →</a>
    </div>
    <div class="card-slider">
      <% String[][] trainers = {
        {"김지훈","바디프로필 / 근력","4.9","128","65,000"},
        {"이서연","요가 / 체형교정","5.0","210","70,000"},
        {"박민호","재활 / 기능성","4.8","85","60,000"},
        {"최유리","필라테스 / 다이어트","4.9","156","68,000"}
      };
      String[] seeds={"jh","sy","mh","yr"};
      for(int i=0;i<trainers.length;i++){
        String[] t=trainers[i]; %>
      <div class="slide-card" style="padding:20px;text-align:center;">
        <div style="position:relative;display:inline-block;margin-bottom:14px;">
          <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=<%= seeds[i] %>" style="width:72px;height:72px;border-radius:50%;border:3px solid #FF6B35;object-fit:cover;" alt="<%= t[0] %>">
          <div style="position:absolute;bottom:1px;right:1px;width:13px;height:13px;background:#00BFA5;border-radius:50%;border:2.5px solid white;"></div>
        </div>
        <div style="font-weight:800;font-size:15px;color:#1A1F36;margin-bottom:4px;"><%= t[0] %> 트레이너</div>
        <div style="font-size:12px;color:#FF6B35;font-weight:700;margin-bottom:8px;"><%= t[1] %></div>
        <div style="display:flex;justify-content:center;align-items:center;gap:6px;margin-bottom:14px;">
          <span style="font-size:14px;font-weight:900;color:#1A1F36;"><%= t[2] %></span>
          <span style="font-size:12px;color:#9DA8C0;">(후기 <%= t[3] %>)</span>
        </div>
        <div style="border-top:1.5px solid #E8EDF5;padding-top:14px;display:flex;justify-content:space-between;align-items:center;">
          <span style="font-size:12px;color:#9DA8C0;">1회 PT</span>
          <span style="font-size:15px;font-weight:900;color:#1A1F36;"><%= t[4] %>원~</span>
        </div>
        <button onclick="requireLogin()" style="width:100%;margin-top:12px;padding:9px;border-radius:10px;border:none;background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-size:13px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">PT 신청하기</button>
      </div>
      <% } %>
    </div>
  </div>
  
  <!-- 운동 가이드 -->
  <div class="section">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
      <div class="section-title">운동 가이드</div>
      <a href="<%=contextPath%>/guide" style="font-size:13px;font-weight:700;color:#FF6B35;text-decoration:none;" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'">모두 보기 →</a>
    </div>
    <div class="card-slider" id="guideSlider">
      <% String[][] guides = {
        {"데드리프트","하체 / 전신","중급","rgba(255,107,53,0.1)","💪"},
        {"벤치프레스","가슴 / 어깨","초급","rgba(0,191,165,0.1)","🏋️"},
        {"스쿼트","하체","초급","rgba(255,209,102,0.15)","🦵"},
        {"런닝머신","유산소","고급","rgba(147,51,234,0.1)","🏃"}
      };
      for(String[] g : guides){ %>
      <div class="slide-card">
        <div style="height:140px;background:<%= g[3] %>;display:flex;align-items:center;justify-content:center;font-size:56px;"><%= g[4] %></div>
        <div style="padding:14px 16px;">
          <div style="display:flex;gap:6px;margin-bottom:8px;flex-wrap:wrap;">
            <span style="padding:3px 9px;border-radius:99px;font-size:10px;font-weight:700;background:#F7F9FC;color:#5A6480;border:1px solid #E8EDF5;"><%= g[1] %></span>
            <span style="padding:3px 9px;border-radius:99px;font-size:10px;font-weight:700;background:<%= g[2].equals("초급") ? "#E8F8F6" : g[2].equals("중급") ? "#FFF9E6" : "#FFF3EE" %>;color:<%= g[2].equals("초급") ? "#00897B" : g[2].equals("중급") ? "#B7791F" : "#FF4D1F" %>;"><%= g[2] %></span>
          </div>
          <div style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:12px;"><%= g[0] %></div>
          <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;">
            <button style="padding:8px;border-radius:10px;border:1.5px solid #E8EDF5;background:white;font-size:12px;font-weight:700;color:#5A6480;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'" onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#5A6480'">▶ 영상 보기</button>
            <!-- <button onclick="requireLogin()" style="padding:8px;border-radius:10px;border:none;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:12px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.transform='scale(1.03)'" onmouseout="this.style.transform='none'">기록 시작</button> -->
          </div>
        </div>
      </div>
      <% } %>
    </div>
  </div>

  <!-- 핫한 커뮤니티 -->
  <div class="section">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px;">
      <div class="section-title">🔥 핫한 오운완</div>
      <a href="<%=contextPath%>/member/community" style="font-size:13px;font-weight:700;color:#FF6B35;text-decoration:none;">커뮤니티 →</a>
    </div>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;">
      <% String[][] posts={{"벤치 100kg 달성! 🔥","근육왕철수","34","12"},{"스쿼트 120kg 오운완 💪","헬창여왕","28","9"},{"다이어트 -10kg 성공 🥗","날씬해져요","52","21"}};
         for(String[] p : posts){ %>
      <div class="slide-card" onclick="requireLogin()">
        <div style="height:120px;background:linear-gradient(135deg,#FFF3EE,#E8F8F6);display:flex;align-items:center;justify-content:center;font-size:48px;">🏆</div>
        <div style="padding:14px 16px;">
          <span style="display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FFD166);color:white;font-size:11px;font-weight:800;margin-bottom:8px;">🏆 오운완</span>
          <div style="font-size:14px;font-weight:800;color:#1A1F36;margin-bottom:5px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><%= p[0] %></div>
          <div style="font-size:12px;color:#9DA8C0;margin-bottom:10px;"><%= p[1] %></div>
          <div style="display:flex;gap:12px;">
            <span style="font-size:12px;color:#9DA8C0;">❤️ <%= p[2] %></span>
            <span style="font-size:12px;color:#9DA8C0;">💬 <%= p[3] %></span>
          </div>
        </div>
      </div>
      <% } %>
    </div>
  </div>

</div>

<!-- ── 하단 CTA 바 ── -->
<div class="cta-bar">
  <div>
    <div style="font-size:15px;font-weight:800;color:#1A1F36;">로그인하면 더 많은 기능을 사용할 수 있어요!</div>
    <div style="font-size:13px;color:#9DA8C0;margin-top:3px;">맞춤 운동 플랜 · 트레이너 PT · 오운완 커뮤니티</div>
  </div>
  <div style="display:flex;gap:10px;align-items:center;">
    <span style="font-size:11px;font-weight:800;color:#C4CEDE;letter-spacing:2px;">FITSBUG</span>
    <button onclick="location.href='<%=contextPath%>/member/join'" style="padding:12px 28px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(255,107,53,0.3);transition:all 0.2s;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">무료 회원가입</button>
    <button onclick="location.href='<%=contextPath%>/member/login'" style="padding:12px 28px;border-radius:99px;border:2px solid #FF6B35;cursor:pointer;background:white;color:#FF6B35;font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='#FFF3EE'" onmouseout="this.style.background='white'">로그인</button>
  </div>
</div>

<!-- 로그인 유도 모달 -->
<div id="loginModal" style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.55);z-index:200;align-items:center;justify-content:center;backdrop-filter:blur(6px);">
  <div style="background:white;border-radius:28px;padding:40px;width:100%;max-width:380px;text-align:center;box-shadow:0 16px 48px rgba(0,0,0,0.18);animation:fb_in 0.3s ease;">
    <div style="width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#FFD166);display:flex;align-items:center;justify-content:center;margin:0 auto 18px;font-size:38px;">🔒</div>
    <h2 style="font-size:20px;font-weight:900;color:#1A1F36;margin-bottom:8px;">로그인이 필요해요!</h2>
    <p style="font-size:14px;color:#9DA8C0;line-height:1.6;margin-bottom:28px;">이 기능은 회원만 사용 가능해요.<br>지금 가입하면 모든 기능을 무료로 이용할 수 있어요 🐾</p>
    <div style="display:flex;gap:10px;">
      <button onclick="closeLoginModal()" style="flex:1;padding:13px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;">취소</button>
      <button onclick="location.href='<%=contextPath%>/member/join'" style="flex:1;padding:13px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 14px rgba(255,107,53,0.3);">회원가입</button>
    </div>
    <button onclick="location.href='<%=contextPath%>/member/login'" style="width:100%;margin-top:10px;padding:11px;border-radius:99px;border:none;background:none;color:#FF6B35;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;">이미 계정이 있어요 →</button>
  </div>
</div>

<style>
@keyframes fb_float{0%,100%{transform:translateY(0);}50%{transform:translateY(-14px);}}
@keyframes fb_in{from{opacity:0;transform:scale(0.9) translateY(20px);}to{opacity:1;transform:scale(1) translateY(0);}}
</style>
<script>
function requireLogin(){ document.getElementById('loginModal').style.display='flex'; }
function closeLoginModal(){ document.getElementById('loginModal').style.display='none'; }
</script>
</body>
</html>
