<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 맞춤 플랜 설정 (2/3)</title>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:rgba(26,31,54,0.65);min-height:100vh;display:flex;align-items:center;justify-content:center;backdrop-filter:blur(8px);}
.fb-inp{width:100%;padding:13px 18px;border-radius:14px;border:2px solid #E8EDF5;background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;transition:all 0.2s;}
.fb-inp:focus{border-color:#FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.12);background:white;}
.radio-card{display:flex;align-items:center;gap:14px;padding:16px 18px;border:2px solid #E8EDF5;border-radius:14px;cursor:pointer;transition:all 0.2s;background:white;}
.radio-card:hover{border-color:#FF6B35;background:#FFF9F7;}
.radio-card input[type="radio"]:checked+.radio-label{color:#FF6B35;}
.radio-card:has(input:checked){border-color:#FF6B35;background:#FFF3EE;box-shadow:0 0 0 3px rgba(255,107,53,0.08);}
@keyframes fb_modal_in{from{opacity:0;transform:scale(0.9) translateY(20px);}to{opacity:1;transform:scale(1) translateY(0);}}
</style>
</head>
<body>

<div style="background:white;border-radius:28px;width:100%;max-width:480px;margin:20px;box-shadow:0 24px 80px rgba(0,0,0,0.2);overflow:hidden;animation:fb_modal_in 0.3s ease;">

  <!-- 헤더 -->
  <div style="background:linear-gradient(135deg,#FF6B35,#FF8C5A);padding:28px 32px;">
    <div style="display:flex;align-items:center;gap:12px;margin-bottom:18px;">
      <div style="width:38px;height:38px;border-radius:50%;background:rgba(255,255,255,0.25);display:flex;align-items:center;justify-content:center;font-size:18px;">🐾</div>
      <span style="font-size:16px;font-weight:800;color:white;">맞춤형 운동 플랜 설정</span>
    </div>
    <!-- 스텝 바 -->
    <div style="display:flex;gap:6px;margin-bottom:8px;">
      <div style="flex:1;height:6px;background:white;border-radius:99px;"></div>
      <div style="flex:1;height:6px;background:white;border-radius:99px;"></div>
      <div style="flex:1;height:6px;background:rgba(255,255,255,0.35);border-radius:99px;"></div>
    </div>
    <div style="font-size:12px;color:rgba(255,255,255,0.85);font-weight:600;">단계 2 / 3 · 체형 정보 & 식단 유형</div>
  </div>

  <!-- 폼 -->
  <form action="<%=request.getContextPath()%>/member/step2" method="post" style="padding:28px 32px;display:flex;flex-direction:column;gap:22px;">

    <!-- Q3 키·몸무게 -->
    <div>
      <div style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:5px;">Q3. 현재 체형 정보를 알려주세요 📏</div>
      <div style="font-size:13px;color:#9DA8C0;margin-bottom:14px;">정확한 맞춤 플랜을 위해 필요해요</div>
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;">
        <div>
          <label style="font-size:12px;font-weight:700;color:#5A6480;display:block;margin-bottom:6px;">키 (cm)</label>
          <input name="height" class="fb-inp" type="number" placeholder="예: 175" min="140" max="220">
        </div>
        <div>
          <label style="font-size:12px;font-weight:700;color:#5A6480;display:block;margin-bottom:6px;">몸무게 (kg)</label>
          <input name="weight" class="fb-inp" type="number" placeholder="예: 70" min="30" max="200">
        </div>
      </div>
    </div>

    <!-- Q4 식단 -->
    <div>
      <div style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:5px;">Q4. 현재 식단 관리를 하고 계신가요? 🥗</div>
      <div style="font-size:13px;color:#9DA8C0;margin-bottom:14px;">가장 가까운 유형을 선택해주세요</div>
      <div style="display:flex;flex-direction:column;gap:8px;">
        <label class="radio-card">
          <input type="radio" name="diet" value="strict" style="accent-color:#FF6B35;width:18px;height:18px;flex-shrink:0;">
          <div>
            <div class="radio-label" style="font-size:14px;font-weight:700;color:#1A1F36;transition:color 0.2s;">🥦 철저한 식단 관리 중</div>
            <div style="font-size:12px;color:#9DA8C0;margin-top:2px;">칼로리와 영양소를 꼼꼼히 체크해요</div>
          </div>
        </label>
        <label class="radio-card">
          <input type="radio" name="diet" value="protein" checked style="accent-color:#FF6B35;width:18px;height:18px;flex-shrink:0;">
          <div>
            <div class="radio-label" style="font-size:14px;font-weight:700;color:#1A1F36;transition:color 0.2s;">🍗 단백질 위주 식사</div>
            <div style="font-size:12px;color:#9DA8C0;margin-top:2px;">닭가슴살·계란 등 단백질에 집중해요</div>
          </div>
        </label>
        <label class="radio-card">
          <input type="radio" name="diet" value="normal" style="accent-color:#FF6B35;width:18px;height:18px;flex-shrink:0;">
          <div>
            <div class="radio-label" style="font-size:14px;font-weight:700;color:#1A1F36;transition:color 0.2s;">🍚 일반식 (별도 관리 없음)</div>
            <div style="font-size:12px;color:#9DA8C0;margin-top:2px;">특별한 식단 관리는 하지 않아요</div>
          </div>
        </label>
      </div>
    </div>

    <!-- 버튼 -->
    <div style="display:flex;gap:10px;margin-top:4px;">
      <button type="button" onclick="history.back()" style="flex:1;padding:13px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='#F7F9FC'" onmouseout="this.style.background='white'">
        ← 이전
      </button>
      <button type="submit" style="flex:2;padding:13px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:15px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(255,107,53,0.3);transition:all 0.2s;" onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">
        다음 단계 →
      </button>
    </div>

  </form>
</div>

</body>
</html>
