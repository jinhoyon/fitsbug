<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 트레이너 회원가입</title>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;min-height:100vh;display:flex;}
.form-side{width:52%;display:flex;flex-direction:column;justify-content:center;padding:60px 56px;overflow-y:auto;}
.brand-side{flex:1;background:linear-gradient(145deg,#1A1F36 0%,#2D3561 50%,#FF6B35 100%);position:relative;overflow:hidden;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:60px 48px;}
.brand-side::before{content:'';position:absolute;width:500px;height:500px;border-radius:50%;background:rgba(255,107,53,0.12);top:-100px;right:-80px;}
.fb-inp{width:100%;padding:13px 18px;border-radius:14px;border:2px solid #E8EDF5;background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;transition:all 0.2s;}
.fb-inp:focus{border-color:#FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.12);background:white;}
.fb-inp::placeholder{color:#C4CEDE;}
@media(max-width:768px){.brand-side{display:none;}.form-side{width:100%;padding:40px 28px;}}
</style>
</head>
<body>

<!-- ── 왼쪽: 폼 ── -->
<div class="form-side">

  <!-- 로고 + 역할 선택 -->
  <a href="<%=request.getContextPath()%>/member/login" style="display:flex;align-items:center;gap:10px;text-decoration:none;margin-bottom:32px;">
    <div style="width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#00BFA5);display:flex;align-items:center;justify-content:center;font-size:18px;">🐾</div>
    <span style="font-family:'Nunito',sans-serif;font-size:22px;font-weight:900;background:linear-gradient(135deg,#FF6B35,#00BFA5);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">핏츠버그</span>
  </a>

  <!-- 역할 탭 -->
  <div style="display:flex;gap:8px;margin-bottom:28px;">
    <button onclick="location.href="<%=request.getContextPath()%>/member/join"" style="padding:10px 22px;border-radius:99px;border:2px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;">🏃 일반 회원</button>
    <button style="padding:10px 22px;border-radius:99px;border:none;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 14px rgba(255,107,53,0.3);">🏋️ 트레이너</button>
    <button onclick="location.href="<%=request.getContextPath()%>/member/gymJoin"" style="padding:10px 22px;border-radius:99px;border:2px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;">🏢 헬스장</button>
  </div>

  <h1 style="font-size:28px;font-weight:900;color:#1A1F36;margin-bottom:6px;">트레이너 가입 💪</h1>
  <p style="font-size:14px;color:#9DA8C0;margin-bottom:28px;">핏츠버그 인증 트레이너로 활동해보세요!</p>

  <form action="trainerJoin" method="post" style="display:flex;flex-direction:column;gap:14px;max-width:440px;">
    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">아이디 (이메일)</label>
      <input name="username" class="fb-inp" placeholder="example@email.com" autocomplete="email">
    </div>
    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">비밀번호</label>
      <input name="password" type="password" class="fb-inp" placeholder="비밀번호 (8자 이상)" autocomplete="new-password">
    </div>
    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">이름 / 닉네임</label>
      <input name="nickname" class="fb-inp" placeholder="활동명 또는 실명">
    </div>
    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">주민등록번호</label>
      <div style="display:grid;grid-template-columns:1fr auto 1fr;gap:8px;align-items:center;">
        <input name="ssn1" class="fb-inp" placeholder="앞 6자리" maxlength="6">
        <div style="width:20px;height:2px;background:#E8EDF5;border-radius:99px;flex-shrink:0;"></div>
        <input name="ssn2" class="fb-inp" type="password" placeholder="뒤 7자리" maxlength="7">
      </div>
    </div>
    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">주소</label>
      <input name="address" class="fb-inp" placeholder="활동 지역 주소">
    </div>
    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">연락처</label>
      <input name="phone" class="fb-inp" placeholder="010-0000-0000">
    </div>

    <button type="submit" style="margin-top:6px;width:100%;padding:14px;border:none;border-radius:99px;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-family:'Noto Sans KR',sans-serif;font-size:16px;font-weight:800;box-shadow:0 6px 20px rgba(255,107,53,0.35);transition:all 0.2s;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
      🚀 가입 완료하기
    </button>
    <p style="text-align:center;font-size:14px;color:#9DA8C0;">
      이미 계정이 있으신가요? <a href="<%=request.getContextPath()%>/member/login" style="color:#FF6B35;font-weight:700;text-decoration:none;">로그인하기 →</a>
    </p>
  </form>
</div>

<!-- ── 오른쪽: 브랜드 (헬스장 분위기) ── -->
<div class="brand-side">
  <div style="position:relative;z-index:1;text-align:center;margin-bottom:32px;">
    <div style="font-size:60px;margin-bottom:16px;filter:drop-shadow(0 8px 20px rgba(0,0,0,0.3));">🏋️</div>
    <div style="font-family:'Nunito',sans-serif;font-size:32px;font-weight:900;color:white;letter-spacing:-0.5px;margin-bottom:8px;">트레이너 파트너</div>
    <div style="font-size:14px;color:rgba(255,255,255,0.8);line-height:1.6;">핏츠버그와 함께 더 많은 회원을<br>만나고 수익을 늘려보세요</div>
  </div>

  <!-- 혜택 카드 -->
  <div style="position:relative;z-index:1;display:flex;flex-direction:column;gap:12px;width:100%;max-width:320px;">
    <% String[][] benefits = {
      {"🎯","정확한 회원 매칭","AI 기반으로 나와 잘 맞는 회원을 연결해드려요"},
      {"💰","수입 관리 대시보드","PT 수익과 일정을 한 눈에 관리하세요"},
      {"⭐","인증 뱃지 제공","자격증 인증 후 신뢰도 높은 인증 마크 부여"},
      {"📱","실시간 채팅","회원과 피드백을 실시간으로 주고받아요"}
    }; for(String[] b : benefits){ %>
    <div style="background:rgba(255,255,255,0.1);backdrop-filter:blur(8px);border:1.5px solid rgba(255,255,255,0.2);border-radius:14px;padding:14px 18px;display:flex;align-items:center;gap:14px;">
      <div style="font-size:24px;flex-shrink:0;"><%= b[0] %></div>
      <div>
        <div style="font-size:13px;font-weight:800;color:white;"><%= b[1] %></div>
        <div style="font-size:11px;color:rgba(255,255,255,0.7);margin-top:2px;"><%= b[2] %></div>
      </div>
    </div>
    <% } %>
  </div>

  <div style="position:relative;z-index:1;margin-top:24px;text-align:center;">
    <div style="font-size:13px;color:rgba(255,255,255,0.6);">현재 <strong style="color:white;">500+</strong> 트레이너가 활동 중이에요</div>
  </div>
</div>

</body>
</html>
