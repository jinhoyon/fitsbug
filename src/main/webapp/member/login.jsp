<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>핏츠버그 - 로그인</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body {
  font-family: 'Noto Sans KR', 'Nunito', sans-serif;
  background: #F7F9FC;
  min-height: 100vh;
  display: flex;
}

/* 왼쪽 브랜드 패널 */
.brand-panel {
  width: 48%;
  background: linear-gradient(145deg, #FF6B35 0%, #FF8C5A 45%, #00BFA5 100%);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 48px;
  position: relative;
  overflow: hidden;
}
.brand-panel::before {
  content: '';
  position: absolute;
  width: 500px; height: 500px;
  border-radius: 50%;
  background: rgba(255,255,255,0.07);
  top: -120px; left: -120px;
}
.brand-panel::after {
  content: '';
  position: absolute;
  width: 360px; height: 360px;
  border-radius: 50%;
  background: rgba(255,255,255,0.05);
  bottom: -80px; right: -80px;
}

.brand-mascot {
  width: 200px; height: 200px;
  border-radius: 50%;
  background: rgba(255,255,255,0.18);
  display: flex; align-items: center; justify-content: center;
  margin-bottom: 32px;
  box-shadow: 0 16px 48px rgba(0,0,0,0.15);
  backdrop-filter: blur(8px);
  position: relative; z-index: 1;
  animation: float 4s ease-in-out infinite;
}
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-12px); }
}

.brand-title {
  font-family: 'Nunito', sans-serif;
  font-size: 48px; font-weight: 900;
  color: white;
  letter-spacing: -1px;
  text-shadow: 0 3px 12px rgba(0,0,0,0.15);
  position: relative; z-index: 1;
}
.brand-sub {
  font-size: 16px; color: rgba(255,255,255,0.85);
  margin-top: 10px; font-weight: 500;
  position: relative; z-index: 1;
  text-align: center;
}

.brand-badges {
  display: flex; gap: 12px; margin-top: 36px;
  position: relative; z-index: 1;
}
.brand-badge {
  background: rgba(255,255,255,0.2);
  backdrop-filter: blur(8px);
  border: 1.5px solid rgba(255,255,255,0.35);
  border-radius: 12px;
  padding: 12px 18px;
  text-align: center;
  color: white;
}
.brand-badge .num { font-size: 22px; font-weight: 900; }
.brand-badge .lbl { font-size: 11px; opacity: 0.85; margin-top: 2px; }

/* 오른쪽 폼 */
.form-panel {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 48px 40px;
}

.login-card {
  width: 100%; max-width: 400px;
}

.login-card h1 {
  font-size: 30px; font-weight: 900;
  color: #1A1F36; margin-bottom: 6px;
}
.login-card .hint {
  font-size: 14px; color: #9DA8C0; margin-bottom: 36px;
}

.form-group { margin-bottom: 18px; }
.form-group label {
  display: block; font-size: 13px; font-weight: 700;
  color: #5A6480; margin-bottom: 7px;
}
.form-group input {
  width: 100%; padding: 13px 18px;
  border-radius: 12px; border: 2px solid #E8EDF5;
  background: #F7F9FC; color: #1A1F36;
  font-family: 'Noto Sans KR', sans-serif; font-size: 14px;
  outline: none; transition: border-color 0.2s, box-shadow 0.2s;
}
.form-group input:focus {
  border-color: #FF6B35;
  box-shadow: 0 0 0 3px rgba(255,107,53,0.12);
  background: white;
}
.form-group input::placeholder { color: #C4CEDE; }

.form-options {
  display: flex; justify-content: space-between;
  align-items: center; margin-bottom: 24px;
}
.form-options label { display: flex; align-items: center; gap: 6px; font-size: 13px; color: #5A6480; cursor: pointer; }
.form-options a { font-size: 13px; color: #FF6B35; text-decoration: none; font-weight: 700; }
.form-options a:hover { text-decoration: underline; }

.btn-login {
  width: 100%; padding: 14px; border: none; border-radius: 99px; cursor: pointer;
  background: linear-gradient(135deg, #FF6B35, #FF8C5A);
  color: white; font-family: 'Noto Sans KR', sans-serif;
  font-size: 16px; font-weight: 800;
  box-shadow: 0 6px 20px rgba(255,107,53,0.35);
  transition: all 0.2s;
  margin-bottom: 14px;
}
.btn-login:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(255,107,53,0.45); }

.divider {
  display: flex; align-items: center; gap: 12px;
  color: #C4CEDE; font-size: 13px; margin-bottom: 14px;
}
.divider::before, .divider::after {
  content: ''; flex: 1; height: 1.5px; background: #E8EDF5;
}

.btn-kakao {
  width: 100%; padding: 13px; border: none; border-radius: 99px; cursor: pointer;
  background: #FEE500; color: #3C1E1E;
  font-family: 'Noto Sans KR', sans-serif; font-size: 15px; font-weight: 800;
  display: flex; align-items: center; justify-content: center; gap: 10px;
  transition: all 0.2s;
  margin-bottom: 20px;
}
.btn-kakao:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(254,229,0,0.5); }

.signup-row {
  text-align: center; font-size: 14px; color: #9DA8C0;
}
.signup-row a {
  color: #FF6B35; text-decoration: none; font-weight: 700; margin-left: 4px;
}

.guest-link {
  display: block; text-align: center; margin-top: 16px;
  font-size: 13px; color: #9DA8C0; text-decoration: none;
  transition: color 0.2s;
}
.guest-link:hover { color: #5A6480; }

.error-box {
  background: #FFF0EE; border: 1.5px solid #FFCCBC;
  border-radius: 10px; padding: 10px 16px;
  color: #FF4D1F; font-size: 13px; font-weight: 600;
  margin-bottom: 18px; display: flex; align-items: center; gap: 8px;
}

@media (max-width: 768px) {
  .brand-panel { display: none; }
  .form-panel { padding: 32px 24px; }
}

.login-header {
  display: flex;
  align-items: baseline; /* 제목 밑선에 맞춤 */
  justify-content: space-between;
  margin-bottom: 8px;
}

.login-header h1 {
  margin-bottom: 0; /* flex 정렬을 위해 마진 제거 */
}

.btn-trainer-link {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 8px;
  border-radius: 6px;
  color: #6B7280; /* 부드러운 회색 */
  font-size: 13px;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.25s ease;
  background: transparent;
}

.btn-trainer-link:hover {
  color: #FF6B35; /* 브랜드 포인트 컬러 */
  background: rgba(255, 107, 53, 0.05); /* 아주 연한 주황빛 배경 */
  transform: translateX(2px); /* 오른쪽으로 살짝 이동하는 애니메이션 */
}

.btn-trainer-link svg {
  transition: transform 0.25s ease;
}

.btn-trainer-link:hover svg {
  transform: scale(1.1);
  color: #FF6B35;
}
</style>
</head>
<body>

<!-- 왼쪽 브랜드 패널 -->
<div class="brand-panel">
  <div class="brand-mascot">
    <svg width="140" height="140" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
      <circle cx="100" cy="85" r="44" fill="rgba(255,255,255,0.9)"/>
      <circle cx="76" cy="60" r="15" fill="rgba(255,255,255,0.9)"/>
      <circle cx="124" cy="60" r="15" fill="rgba(255,255,255,0.9)"/>
      <circle cx="76" cy="60" r="9" fill="#F4A0A0"/>
      <circle cx="124" cy="60" r="9" fill="#F4A0A0"/>
      <ellipse cx="100" cy="90" rx="28" ry="22" fill="#E8E8F0"/>
      <path d="M58 70 Q100 55 142 70" stroke="#FFD166" stroke-width="7" fill="none" stroke-linecap="round"/>
      <circle cx="87" cy="80" r="6" fill="#1A1F36"/>
      <circle cx="113" cy="80" r="6" fill="#1A1F36"/>
      <circle cx="88.5" cy="78.5" r="2" fill="white"/>
      <circle cx="114.5" cy="78.5" r="2" fill="white"/>
      <ellipse cx="100" cy="93" rx="7" ry="5" fill="#1A1F36"/>
      <path d="M87 103 Q100 115 113 103" stroke="#FF6B35" stroke-width="3.5" fill="none" stroke-linecap="round"/>
      <ellipse cx="80" cy="97" rx="8" ry="5" fill="#FFB4A2" opacity="0.8"/>
      <ellipse cx="120" cy="97" rx="8" ry="5" fill="#FFB4A2" opacity="0.8"/>
      <ellipse cx="100" cy="152" rx="50" ry="36" fill="rgba(255,255,255,0.85)"/>
      <rect x="24" y="112" width="36" height="9" rx="4.5" fill="rgba(255,255,255,0.7)"/>
      <rect x="18" y="106" width="10" height="22" rx="5" fill="rgba(255,255,255,0.6)"/>
      <rect x="56" y="106" width="10" height="22" rx="5" fill="rgba(255,255,255,0.6)"/>
    </svg>
  </div>
  <div class="brand-title">핏츠버그</div>
  <div class="brand-sub">🐾 핏불과 함께하는 나만의 피트니스 여정</div>
  <div class="brand-badges">
    <div class="brand-badge"><div class="num">12K+</div><div class="lbl">활성 회원</div></div>
    <div class="brand-badge"><div class="num">500+</div><div class="lbl">트레이너</div></div>
    <div class="brand-badge"><div class="num">98%</div><div class="lbl">만족도</div></div>
  </div>
</div>

<!-- 오른쪽 로그인 폼 -->
<div class="form-panel">
  <div class="login-card">
    <div class="login-header">
  <h1>로그인 👋</h1>
  <a href="<%=request.getContextPath()%>/trainer/login" class="btn-trainer-link">
    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M3 21h18"></path>
      <path d="M3 7v1a3 3 0 0 0 6 0V7m0 1a3 3 0 0 0 6 0V7m0 1a3 3 0 0 0 6 0V7H3"></path>
      <path d="M19 21V11"></path>
      <path d="M5 21V11"></path>
    </svg>
    <span>트레이너 로그인하기 →</span>
  </a>
</div>
    <p class="hint">오늘도 완벽한 운동을 시작해봐요!</p>

    <% if(request.getAttribute("error") != null){ %>
    <div class="error-box">⚠️ <%= request.getAttribute("error") %></div>
    <% } %>

    <form action="login" method="post">
      <div class="form-group">
        <label>이메일 (아이디)</label>
        <input type="text" name="email" placeholder="이메일을 입력하세요" autocomplete="email">
      </div>
      <div class="form-group">
        <label>비밀번호</label>
        <input type="password" name="password" placeholder="비밀번호를 입력하세요" autocomplete="current-password">
      </div>

      <div class="form-options">
        <label><input type="checkbox" style="accent-color:#FF6B35;"> 로그인 상태 유지</label>
        <a href="#">비밀번호 찾기</a>
      </div>

      <button type="submit" class="btn-login">🔥 로그인하기</button>
    </form>

    <div class="divider">또는</div>

    <button class="btn-kakao"
      onclick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=REST_API_KEY&redirect_uri=http://localhost:8080/kakaoLogin&response_type=code'">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none"><path d="M12 3C6.477 3 2 6.477 2 10.9c0 2.8 1.7 5.3 4.3 6.8l-1.1 4 4.1-2.7c.9.2 1.8.3 2.7.3 5.523 0 10-3.477 10-7.9C22 6.477 17.523 3 12 3z" fill="#3C1E1E"/></svg>
      카카오로 로그인
    </button>

    <div class="signup-row">
      아직 회원이 아니신가요?<a href="<%=request.getContextPath()%>/member/join">무료 회원가입 →</a>
    </div>
    <a href="<%=request.getContextPath()%>/member/guest" class="guest-link">🔍 로그인 없이 둘러보기</a>
  </div>
</div>

</body>
</html>
