<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 운동 상세</title>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:rgba(26,31,54,0.6);min-height:100vh;display:flex;align-items:center;justify-content:center;backdrop-filter:blur(6px);}
.fb-inp{width:100%;padding:11px 16px;border-radius:12px;border:2px solid #E8EDF5;background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;transition:all 0.2s;}
.fb-inp:focus{border-color:#FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.12);background:white;}
.set-row{display:flex;gap:10px;align-items:center;padding:10px 14px;background:#F7F9FC;border-radius:12px;border:1.5px solid #E8EDF5;}
@keyframes fb_modal_in{from{opacity:0;transform:scale(0.92) translateY(24px);}to{opacity:1;transform:scale(1) translateY(0);}}
</style>
</head>
<body>

<!-- 모달 -->
<div style="
  background:white; border-radius:28px; width:100%; max-width:680px; max-height:92vh;
  overflow-y:auto; margin:20px;
  box-shadow:0 24px 80px rgba(0,0,0,0.2);
  animation:fb_modal_in 0.35s ease;
">

  <!-- 헤더 이미지 영역 -->
  <div style="position:relative;">
    <div style="height:220px;background:linear-gradient(135deg,#FFF3EE,#E8F8F6);display:flex;align-items:center;justify-content:center;font-size:80px;border-radius:28px 28px 0 0;overflow:hidden;">
      <div id="exerciseEmoji">💪</div>
      <img id="exerciseImg" src="${exercise.imageUrl}" onerror="this.style.display='none'"
           style="position:absolute;inset:0;width:100%;height:100%;object-fit:cover;border-radius:28px 28px 0 0;" alt="운동">
    </div>
    <!-- 닫기 버튼 -->
    <button onclick="window.close()" style="
      position:absolute;top:16px;right:16px;
      width:36px;height:36px;border-radius:50%;border:none;cursor:pointer;
      background:rgba(255,255,255,0.9);backdrop-filter:blur(6px);
      display:flex;align-items:center;justify-content:center;
      box-shadow:0 2px 8px rgba(0,0,0,0.15);transition:all 0.2s;
    " onmouseover="this.style.background='#FEE2E2'" onmouseout="this.style.background='rgba(255,255,255,0.9)'">
      <span class="material-symbols-outlined" style="font-size:18px;color:#5A6480;">close</span>
    </button>
    <!-- 난이도 뱃지 -->
    <div style="position:absolute;bottom:14px;left:18px;display:flex;gap:8px;">
      <span style="padding:5px 12px;border-radius:99px;background:rgba(255,255,255,0.92);backdrop-filter:blur(6px);font-size:12px;font-weight:800;color:#5A6480;">${exercise.target}</span>
      <span style="padding:5px 12px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FF8C5A);font-size:12px;font-weight:800;color:white;">근력 운동</span>
    </div>
  </div>

  <!-- 컨텐츠 -->
  <div style="padding:28px 32px;">

    <!-- 제목 + 영상 버튼 -->
    <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;">
      <div>
        <h2 id="exName" style="font-size:24px;font-weight:900;color:#1A1F36;letter-spacing:-0.5px;">${exercise.name}</h2>
        <div style="font-size:13px;color:#9DA8C0;margin-top:4px;">타겟 근육 · ${exercise.target}</div>
      </div>
      <button id="videoBtn" onclick="toggleVideo()" style="
        padding:10px 18px;border-radius:99px;border:none;cursor:pointer;
        background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;
        font-size:13px;font-weight:700;font-family:'Noto Sans KR',sans-serif;
        display:flex;align-items:center;gap:6px;flex-shrink:0;
        box-shadow:0 4px 14px rgba(255,107,53,0.3);transition:all 0.2s;
      " onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">
        <span class="material-symbols-outlined" style="font-size:16px;">play_circle</span>
        영상으로 보기
      </button>
    </div>

    <!-- 유튜브 영상 (숨김) -->
    <div id="videoBox" style="display:none;margin-bottom:20px;border-radius:16px;overflow:hidden;box-shadow:0 4px 16px rgba(0,0,0,0.12);">
      <iframe id="videoFrame" width="100%" height="280" src="" frameborder="0" allowfullscreen style="display:block;"></iframe>
    </div>

    <!-- 설명 -->
    <div style="background:#F7F9FC;border-radius:14px;padding:16px 18px;margin-bottom:20px;">
      <div style="font-size:12px;font-weight:700;color:#FF6B35;margin-bottom:6px;">📋 운동 설명</div>
      <p id="exDesc" style="font-size:14px;color:#5A6480;line-height:1.7;">${exercise.description}</p>
    </div>

    <!-- 구분선 -->
    <div style="height:1.5px;background:#E8EDF5;margin-bottom:20px;"></div>

    <!-- 기록 시작 섹션 -->
    <h3 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:14px;">🏋️ 오늘의 기록</h3>

    <!-- 세트 목록 -->
    <div id="setList" style="display:flex;flex-direction:column;gap:8px;margin-bottom:14px;"></div>

    <!-- 세트 추가 버튼 -->
    <button onclick="addSet()" style="
      width:100%;padding:11px;border-radius:12px;
      border:2px dashed #E8EDF5;background:white;cursor:pointer;
      font-size:13px;font-weight:700;color:#9DA8C0;
      font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
      display:flex;align-items:center;justify-content:center;gap:6px;
    " onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'" onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#9DA8C0'">
      <span class="material-symbols-outlined" style="font-size:18px;">add_circle</span>
      세트 추가
    </button>

    <!-- 저장 버튼 -->
    <button onclick="saveRecord()" style="
      width:100%;margin-top:14px;padding:14px;border-radius:99px;border:none;cursor:pointer;
      background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;
      font-size:15px;font-weight:800;font-family:'Noto Sans KR',sans-serif;
      box-shadow:0 6px 20px rgba(255,107,53,0.3);transition:all 0.2s;
    " onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
      🔥 기록 저장하기
    </button>

    <!-- 저장 성공 메시지 -->
    <div id="saveMsg" style="display:none;margin-top:12px;padding:12px 16px;background:#E8F8F6;border-radius:12px;color:#00897B;font-size:13px;font-weight:700;text-align:center;">
      ✔ 저장 완료! 핏불이 응원해요 💪
    </div>

  </div>
</div>

<script>
let setCount = 0;

// 초기 3세트
window.onload = function(){ addSet(); addSet(); addSet(); };

function addSet(){
  setCount++;
  const row = document.createElement('div');
  row.className = 'set-row';
  row.innerHTML = `
    <div style="width:32px;height:32px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:12px;font-weight:800;display:flex;align-items:center;justify-content:center;flex-shrink:0;">${setCount}</div>
    <div style="flex:1;display:grid;grid-template-columns:1fr 1fr;gap:8px;">
      <div>
        <label style="font-size:11px;color:#9DA8C0;font-weight:700;display:block;margin-bottom:3px;">무게 (kg)</label>
        <input type="number" placeholder="0" class="fb-inp" style="padding:8px 12px;font-size:14px;font-weight:700;" oninput="calc1RM(this.closest('.set-row'))">
      </div>
      <div>
        <label style="font-size:11px;color:#9DA8C0;font-weight:700;display:block;margin-bottom:3px;">횟수 (회)</label>
        <input type="number" placeholder="0" class="fb-inp" style="padding:8px 12px;font-size:14px;font-weight:700;" oninput="calc1RM(this.closest('.set-row'))">
      </div>
    </div>
    <div id="rm-${setCount}" style="font-size:11px;color:#FF6B35;font-weight:700;white-space:nowrap;min-width:56px;text-align:right;"></div>
    <button onclick="this.closest('.set-row').remove()" style="width:28px;height:28px;border-radius:50%;border:none;background:#FEE2E2;color:#EF4444;cursor:pointer;font-size:14px;display:flex;align-items:center;justify-content:center;flex-shrink:0;transition:all 0.2s;" onmouseover="this.style.background='#FECACA'" onmouseout="this.style.background='#FEE2E2'">✕</button>
  `;
  document.getElementById('setList').appendChild(row);
}

function calc1RM(row){
  const inputs = row.querySelectorAll('input');
  const w = parseFloat(inputs[0].value) || 0;
  const r = parseFloat(inputs[1].value) || 0;
  const rmEl = row.querySelector('[id^="rm-"]');
  if(rmEl && w > 0 && r > 0){
    const rm = (w * (1 + r / 30)).toFixed(1);
    rmEl.innerText = '1RM\n≈' + rm + 'kg';
    rmEl.style.whiteSpace = 'pre';
  }
}

function toggleVideo(){
  const box   = document.getElementById('videoBox');
  const frame = document.getElementById('videoFrame');
  const btn   = document.getElementById('videoBtn');
  const videoUrl = '${exercise.videoUrl}';
  if(box.style.display === 'none'){
    if(videoUrl && videoUrl !== '' && videoUrl !== 'null'){
      frame.src = 'https://www.youtube.com/embed/' + videoUrl + '?autoplay=1';
    } else {
      frame.src = 'https://www.youtube.com/embed/dQw4w9WgXcQ';
    }
    box.style.display = 'block';
    btn.innerHTML = '<span class="material-symbols-outlined" style="font-size:16px;">stop_circle</span> 영상 닫기';
    btn.style.background = 'linear-gradient(135deg,#5A6480,#9DA8C0)';
  } else {
    box.style.display = 'none';
    frame.src = '';
    btn.innerHTML = '<span class="material-symbols-outlined" style="font-size:16px;">play_circle</span> 영상으로 보기';
    btn.style.background = 'linear-gradient(135deg,#FF6B35,#FF8C5A)';
  }
}

function saveRecord(){
  const rows = document.querySelectorAll('.set-row');
  const sets = [];
  rows.forEach(function(row, i){
    const inputs = row.querySelectorAll('input');
    const w = inputs[0].value;
    const r = inputs[1].value;
    if(w && r) sets.push({ set: i+1, weight: w, reps: r });
  });
  if(!sets.length){ alert('무게와 횟수를 입력해주세요!'); return; }

  const name = document.getElementById('exName')?.innerText || '${exercise.name}';
  fetch('workout', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({ name, sets })
  }).then(r => r.text()).then(() => {
    const msg = document.getElementById('saveMsg');
    msg.style.display = 'block';
    // 오운완 따봉 애니메이션 (부모 창에 알림)
    if(window.opener && window.opener.showFitbullCheer){
      window.opener.showFitbullCheer('🔥 기록 저장! 최고야!');
    }
    setTimeout(() => msg.style.display = 'none', 3000);
  }).catch(() => {
    // 오프라인 테스트용
    const msg = document.getElementById('saveMsg');
    msg.style.display = 'block';
    if(window.opener && window.opener.showFitbullCheer){
      window.opener.showFitbullCheer('🔥 기록 저장! 최고야!');
    }
    setTimeout(() => msg.style.display = 'none', 3000);
  });
}
</script>
</body>
</html>
