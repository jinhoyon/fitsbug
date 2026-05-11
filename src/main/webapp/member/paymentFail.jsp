<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 결제 실패</title>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;min-height:100vh;display:flex;align-items:center;justify-content:center;}
@keyframes fb_shake{0%,100%{transform:rotate(0deg);}20%{transform:rotate(-6deg);}40%{transform:rotate(6deg);}60%{transform:rotate(-4deg);}80%{transform:rotate(4deg);}}
</style>
</head>
<body>

<div style="background:white;border-radius:32px;padding:56px 48px;width:100%;max-width:420px;text-align:center;box-shadow:0 16px 60px rgba(0,0,0,0.10);position:relative;overflow:hidden;">

  <div style="position:absolute;width:260px;height:260px;border-radius:50%;background:rgba(255,77,77,0.04);top:-60px;right:-50px;"></div>

  <!-- 핏불 슬픈 표정 -->
  <div style="margin-bottom:20px;animation:fb_shake 0.6s ease 0.3s both;">
    <svg width="120" height="120" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" style="filter:drop-shadow(0 6px 16px rgba(0,0,0,0.12));">
      <circle cx="100" cy="100" r="80" fill="#F0F0F8"/>
      <circle cx="100" cy="85" r="44" fill="#9A9EBA"/>
      <circle cx="76" cy="62" r="14" fill="#9A9EBA"/><circle cx="124" cy="62" r="14" fill="#9A9EBA"/>
      <circle cx="76" cy="62" r="8" fill="#D4A0A0"/><circle cx="124" cy="62" r="8" fill="#D4A0A0"/>
      <ellipse cx="100" cy="90" rx="26" ry="20" fill="#D8D8E8"/>
      <path d="M58 70 Q100 55 142 70" stroke="#DDB860" stroke-width="6" fill="none" stroke-linecap="round"/>
      <!-- 슬픈 눈 -->
      <path d="M81 78 Q87 82 93 78" stroke="#1A1F36" stroke-width="3" fill="none" stroke-linecap="round"/>
      <path d="M107 78 Q113 82 119 78" stroke="#1A1F36" stroke-width="3" fill="none" stroke-linecap="round"/>
      <ellipse cx="100" cy="93" rx="6" ry="4" fill="#1A1F36"/>
      <!-- 슬픈 입 -->
      <path d="M87 107 Q100 98 113 107" stroke="#5A6480" stroke-width="3" fill="none" stroke-linecap="round"/>
      <ellipse cx="80" cy="95" rx="7" ry="5" fill="#D4A0A0" opacity="0.7"/>
      <ellipse cx="120" cy="95" rx="7" ry="5" fill="#D4A0A0" opacity="0.7"/>
      <!-- 눈물 -->
      <ellipse cx="80" cy="88" rx="2" ry="4" fill="#7BCFF0" opacity="0.8"/>
      <ellipse cx="120" cy="88" rx="2" ry="4" fill="#7BCFF0" opacity="0.8"/>
    </svg>
  </div>

  <!-- X 뱃지 -->
  <div style="width:60px;height:60px;border-radius:50%;background:linear-gradient(135deg,#FF4D4D,#FF6B35);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;box-shadow:0 6px 18px rgba(255,77,77,0.3);">
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none"><path d="M18 6L6 18M6 6l12 12" stroke="white" stroke-width="2.5" stroke-linecap="round"/></svg>
  </div>

  <h1 style="font-size:26px;font-weight:900;color:#1A1F36;margin-bottom:10px;">결제 실패 😢</h1>
  <p style="font-size:14px;color:#9DA8C0;line-height:1.7;margin-bottom:28px;">
    결제 처리 중 문제가 발생했어요.<br>
    카드 정보를 확인하거나 다시 시도해주세요.
  </p>

  <div style="background:#FFF0EE;border:1.5px solid #FFCCBC;border-radius:14px;padding:16px;margin-bottom:28px;text-align:left;">
    <div style="font-size:13px;font-weight:700;color:#FF4D1F;margin-bottom:6px;">⚠️ 결제 실패 원인</div>
    <ul style="font-size:13px;color:#5A6480;line-height:1.8;padding-left:16px;">
      <li>카드 한도 초과</li>
      <li>카드 정보 불일치</li>
      <li>네트워크 오류</li>
    </ul>
  </div>

  <div style="display:flex;flex-direction:column;gap:10px;">
    <button onclick="history.back()" style="width:100%;padding:14px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:15px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 6px 20px rgba(255,107,53,0.3);transition:all 0.2s;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
      🔄 다시 시도하기
    </button>
    <button onclick="location.href='main'" style="width:100%;padding:12px;border-radius:99px;border:1.5px solid #E8EDF5;cursor:pointer;background:white;color:#5A6480;font-size:14px;font-weight:700;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='#F7F9FC'" onmouseout="this.style.background='white'">
      홈으로 돌아가기
    </button>
    <a href="<%=request.getContextPath()%>/member/support" style="display:block;font-size:13px;color:#FF6B35;text-decoration:none;font-weight:700;margin-top:4px;">고객센터에 문의하기 →</a>
  </div>

</div>

</body>
</html>
