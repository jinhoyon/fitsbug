<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - PT 피드백</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;display:flex;min-height:100vh;}
.tab-btn{padding:9px 20px;border-radius:99px;border:none;cursor:pointer;font-size:13px;font-weight:700;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;background:transparent;color:#5A6480;}
.tab-btn.active{background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;box-shadow:0 3px 12px rgba(255,107,53,0.3);}
.cal-dot{width:38px;height:38px;border-radius:50%;display:flex;align-items:center;justify-content:center;cursor:pointer;transition:all 0.2s;border:2px solid #E8EDF5;font-size:12px;font-weight:700;color:#5A6480;}
.cal-dot:hover{border-color:#FF6B35;color:#FF6B35;transform:scale(1.1);}
.cal-dot.has-data{background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;border-color:transparent;box-shadow:0 2px 8px rgba(255,107,53,0.3);}
.cal-dot.selected{ring:3px solid #FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.2);}
.fb-tab-content{display:none;}
.fb-tab-content.active{display:block;}
</style>
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<main style="flex:1;margin-left:260px;padding:32px 36px;max-width:calc(100vw - 260px);">

  <!-- 헤더 -->
  <div style="margin-bottom:28px;">
    <div style="display:flex;align-items:center;gap:12px;margin-bottom:6px;">
      <button onclick="history.back()" style="width:36px;height:36px;border-radius:50%;border:1.5px solid #E8EDF5;background:white;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:all 0.2s;" onmouseover="this.style.borderColor='#FF6B35'" onmouseout="this.style.borderColor='#E8EDF5'">
        <span class="material-symbols-outlined" style="font-size:18px;color:#5A6480;">arrow_back</span>
      </button>
      <h2 style="font-size:26px;font-weight:900;color:#1A1F36;letter-spacing:-0.5px;">PT 세션 피드백 🏋️</h2>
    </div>
    <p style="font-size:14px;color:#9DA8C0;margin-left:48px;">트레이너가 남긴 맞춤 피드백을 확인하세요</p>
  </div>

  <div style="display:grid;grid-template-columns:300px 1fr;gap:24px;align-items:start;">

    <!-- ── 왼쪽: 세션 캘린더 ── -->
    <div style="display:flex;flex-direction:column;gap:16px;">

      <!-- 트레이너 미니 카드 -->
      <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:20px;text-align:center;">
        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=trainer" style="width:70px;height:70px;border-radius:50%;border:3px solid #FF6B35;margin-bottom:10px;" alt="트레이너">
        <div style="font-size:15px;font-weight:800;color:#1A1F36;">김태훈 트레이너</div>
        <div style="font-size:12px;color:#9DA8C0;margin-top:3px;">근력 / 체형교정 전문</div>
        <div style="display:flex;justify-content:center;gap:16px;margin-top:14px;">
          <div style="text-align:center;">
            <div style="font-size:18px;font-weight:900;color:#FF6B35;" id="sessionCount">-</div>
            <div style="font-size:11px;color:#9DA8C0;font-weight:600;">총 세션</div>
          </div>
          <div style="text-align:center;">
            <div style="font-size:18px;font-weight:900;color:#00BFA5;" id="remainCount">-</div>
            <div style="font-size:11px;color:#9DA8C0;font-weight:600;">남은 횟수</div>
          </div>
        </div>
      </div>

      <!-- 세션 날짜 목록 -->
      <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:20px;">
        <h3 style="font-size:14px;font-weight:800;color:#1A1F36;margin-bottom:14px;">📅 PT 수업 날짜</h3>
        <div id="calendarBox" style="display:flex;flex-direction:column;gap:8px;max-height:360px;overflow-y:auto;"></div>
      </div>

    </div>

    <!-- ── 오른쪽: 피드백 상세 ── -->
    <div style="display:flex;flex-direction:column;gap:20px;">

      <!-- 빈 상태 -->
      <div id="emptyState" style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:60px;text-align:center;">
        <div style="font-size:56px;margin-bottom:16px;">📋</div>
        <div style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:8px;">수업 날짜를 선택해보세요!</div>
        <div style="font-size:14px;color:#9DA8C0;">왼쪽 캘린더에서 PT 수업 날짜를 클릭하면<br>해당 세션의 피드백을 확인할 수 있어요.</div>
      </div>

      <!-- 피드백 내용 (숨김) -->
      <div id="feedbackContent" style="display:none;">

        <!-- 날짜 + 탭 -->
        <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:22px 26px;">
          <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
            <div>
              <div style="font-size:13px;color:#9DA8C0;font-weight:600;">선택한 세션</div>
              <div id="selectedDate" style="font-size:18px;font-weight:900;color:#FF6B35;margin-top:3px;"></div>
            </div>
            <span style="padding:5px 14px;border-radius:99px;background:linear-gradient(135deg,#E8F8F6,#D0F5F0);color:#00897B;font-size:12px;font-weight:800;">✔ 피드백 완료</span>
          </div>

          <!-- 탭 -->
          <div style="background:#F7F9FC;border:1.5px solid #E8EDF5;border-radius:99px;padding:4px;display:inline-flex;gap:2px;margin-bottom:20px;">
            <button onclick="changeTab('exercise',this)" class="tab-btn active">💪 운동</button>
            <button onclick="changeTab('food',this)" class="tab-btn">🥗 식단</button>
            <button onclick="changeTab('inbody',this)" class="tab-btn">📊 인바디</button>
          </div>

          <!-- 운동 탭 -->
          <div id="exerciseBox" class="fb-tab-content active">
            <div style="background:#FFF3EE;border:1.5px solid rgba(255,107,53,0.2);border-radius:14px;padding:18px;">
              <h4 style="font-size:13px;font-weight:700;color:#FF6B35;margin-bottom:8px;">🏋️ 운동 피드백</h4>
              <p id="exerciseText" style="font-size:14px;color:#1A1F36;line-height:1.7;"></p>
            </div>
          </div>

          <!-- 식단 탭 -->
          <div id="foodBox" class="fb-tab-content">
            <div style="background:#E8F8F6;border:1.5px solid rgba(0,191,165,0.2);border-radius:14px;padding:18px;">
              <h4 style="font-size:13px;font-weight:700;color:#00897B;margin-bottom:8px;">🥗 식단 피드백</h4>
              <p id="foodText" style="font-size:14px;color:#1A1F36;line-height:1.7;"></p>
            </div>
          </div>

          <!-- 인바디 탭 -->
          <div id="inbodyBox" class="fb-tab-content">
            <div style="background:#F3E8FF;border:1.5px solid rgba(147,51,234,0.2);border-radius:14px;padding:18px;">
              <h4 style="font-size:13px;font-weight:700;color:#9333EA;margin-bottom:8px;">📊 인바디 피드백</h4>
              <p id="inbodyText" style="font-size:14px;color:#1A1F36;line-height:1.7;"></p>
            </div>
          </div>
        </div>

        <!-- 성장 포인트 & 다음 계획 -->
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
          <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:22px;">
            <h3 style="font-size:14px;font-weight:800;color:#1A1F36;margin-bottom:12px;display:flex;align-items:center;gap:8px;">
              <div style="width:30px;height:30px;border-radius:8px;background:linear-gradient(135deg,#FF6B35,#FFD166);display:flex;align-items:center;justify-content:center;font-size:14px;">📈</div>
              성장 포인트
            </h3>
            <p id="growth" style="font-size:14px;color:#5A6480;line-height:1.7;"></p>
          </div>
          <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:22px;">
            <h3 style="font-size:14px;font-weight:800;color:#1A1F36;margin-bottom:12px;display:flex;align-items:center;gap:8px;">
              <div style="width:30px;height:30px;border-radius:8px;background:linear-gradient(135deg,#00BFA5,#26D4BB);display:flex;align-items:center;justify-content:center;font-size:14px;">📅</div>
              다음 계획
            </h3>
            <p id="nextPlan" style="font-size:14px;color:#5A6480;line-height:1.7;"></p>
          </div>
        </div>

        <!-- 핏불 응원 -->
        <div style="background:linear-gradient(135deg,#FF6B35,#FFD166);border-radius:20px;padding:22px;display:flex;align-items:center;gap:20px;box-shadow:0 4px 20px rgba(255,107,53,0.28);">
          <svg width="70" height="70" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
            <circle cx="100" cy="85" r="44" fill="rgba(255,255,255,0.9)"/>
            <circle cx="76" cy="60" r="15" fill="rgba(255,255,255,0.9)"/><circle cx="124" cy="60" r="15" fill="rgba(255,255,255,0.9)"/>
            <circle cx="76" cy="60" r="9" fill="#F4A0A0"/><circle cx="124" cy="60" r="9" fill="#F4A0A0"/>
            <ellipse cx="100" cy="90" rx="28" ry="22" fill="#E8E8F0"/>
            <path d="M58 70 Q100 55 142 70" stroke="#FFD166" stroke-width="7" fill="none" stroke-linecap="round"/>
            <circle cx="87" cy="80" r="6" fill="#1A1F36"/><circle cx="113" cy="80" r="6" fill="#1A1F36"/>
            <circle cx="88.5" cy="78.5" r="2" fill="white"/><circle cx="114.5" cy="78.5" r="2" fill="white"/>
            <ellipse cx="100" cy="93" rx="7" ry="5" fill="#1A1F36"/>
            <path d="M87 103 Q100 115 113 103" stroke="#FF6B35" stroke-width="3.5" fill="none" stroke-linecap="round"/>
          </svg>
          <div>
            <div style="font-size:16px;font-weight:900;color:white;margin-bottom:4px;">핏불이 응원해요! 💪</div>
            <div style="font-size:13px;color:rgba(255,255,255,0.9);line-height:1.5;">트레이너 피드백을 잘 반영해서<br>오늘도 최고의 운동을 해봐요!</div>
          </div>
        </div>

      </div><!-- end feedbackContent -->
    </div><!-- end right -->
  </div>
</main>

<script>
let feedbackList = [];

window.onload = function(){
  fetch("ptFeedback")
    .then(r => r.json())
    .then(data => {
      feedbackList = data;
      document.getElementById("sessionCount").innerText = data.length + "회";
      document.getElementById("remainCount").innerText = Math.max(0, 20 - data.length) + "회";
      drawCalendar();
    }).catch(() => {
      // 더미 데이터
      feedbackList = [
        {id:1, sessionDate:"2026-04-27T11:00:00", exercise:"벤치프레스 자세가 훨씬 안정됐어요! 어깨 너비를 좀 더 좁혀보세요.", food:"단백질 섭취가 부족합니다. 운동 후 30분 이내 섭취를 권장해요.", inbody:"체지방이 0.5kg 줄었어요. 꾸준히 유지하세요!", growth:"벤치프레스 중량 5kg 증가. 정말 잘하고 있어요!", nextPlan:"다음 세션에서 인클라인 벤치프레스 추가 예정입니다."},
        {id:2, sessionDate:"2026-04-20T11:00:00", exercise:"스쿼트 깊이가 좋아졌어요. 허리가 조금 둥글어지니 코어에 집중하세요.", food:"야식을 줄이는 게 좋겠어요. 전반적으로 식단은 좋습니다!", inbody:"골격근량이 0.3kg 증가했어요. 훌륭합니다!", growth:"스쿼트 자세 크게 개선. 하체 근력이 눈에 띄게 늘었어요.", nextPlan:"레그프레스와 레그컬 추가 예정입니다."}
      ];
      document.getElementById("sessionCount").innerText = feedbackList.length + "회";
      document.getElementById("remainCount").innerText = (20 - feedbackList.length) + "회";
      drawCalendar();
    });
};

function drawCalendar(){
  const box = document.getElementById("calendarBox");
  box.innerHTML = "";
  if(!feedbackList || !feedbackList.length){
    box.innerHTML = "<p style='color:#9DA8C0;font-size:14px;text-align:center;padding:20px;'>세션 데이터 없음</p>";
    return;
  }
  feedbackList.forEach(function(f, idx){
    const date = f.sessionDate ? f.sessionDate.split("T")[0] : "날짜 없음";
    const el = document.createElement("div");
    el.style.cssText = "display:flex;align-items:center;gap:12px;padding:12px 14px;border-radius:12px;border:1.5px solid #E8EDF5;cursor:pointer;transition:all 0.2s;background:white;";
    el.innerHTML = `
      <div style="width:42px;height:42px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#FFD166);display:flex;align-items:center;justify-content:center;color:white;font-weight:800;font-size:13px;flex-shrink:0;">${idx+1}</div>
      <div>
        <div style="font-weight:700;font-size:13px;color:#1A1F36;">${date}</div>
        <div style="font-size:11px;color:#9DA8C0;margin-top:2px;">피드백 완료 ✔</div>
      </div>
    `;
    el.onmouseover = function(){ this.style.borderColor='#FF6B35'; this.style.background='#FFF9F7'; };
    el.onmouseout  = function(){ this.style.borderColor='#E8EDF5'; this.style.background='white'; };
    el.onclick = function(){ loadDetail(f.id); };
    box.appendChild(el);
  });
}

function changeTab(type, el){
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
  document.querySelectorAll('.fb-tab-content').forEach(t => t.classList.remove('active'));
  if(el) el.classList.add('active');
  document.getElementById(type+'Box').classList.add('active');
}

function loadDetail(id){
  document.getElementById("emptyState").style.display = "none";
  document.getElementById("feedbackContent").style.display = "flex";
  document.getElementById("feedbackContent").style.flexDirection = "column";
  document.getElementById("feedbackContent").style.gap = "20px";

  // 로컬 더미 먼저 표시
  const local = feedbackList.find(f => f.id === id);
  if(local) renderDetail(local);

  fetch("ptFeedback?mode=detail&id=" + id)
    .then(r => r.json())
    .then(d => renderDetail(d))
    .catch(() => { if(local) renderDetail(local); });
}

function renderDetail(d){
  const dateStr = d.sessionDate ? d.sessionDate.split("T")[0] : "";
  document.getElementById("selectedDate").innerText = dateStr + " 세션";
  document.getElementById("exerciseText").innerText = d.exercise || "운동 피드백 없음";
  document.getElementById("foodText").innerText     = d.food     || "식단 피드백 없음";
  document.getElementById("inbodyText").innerText   = d.inbody   || "인바디 피드백 없음";
  document.getElementById("growth").innerText   = d.growth   || "성장 포인트 없음";
  document.getElementById("nextPlan").innerText = d.nextPlan || "다음 계획 없음";
}
</script>
</body>
</html>
