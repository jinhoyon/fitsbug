<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.member.UserDTO"%>
<%
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    if(loginUser == null){ response.sendRedirect(request.getContextPath() + "/member/login"); return; }

    // ChatController에서 setAttribute로 전달
    int    roomId          = request.getAttribute("roomId")          != null ? (int) request.getAttribute("roomId")          : 0;
    int    trainerUserId   = request.getAttribute("trainerUserId")   != null ? (int) request.getAttribute("trainerUserId")   : 0;
    String trainerNickname = request.getAttribute("trainerNickname") != null ? (String) request.getAttribute("trainerNickname") : "트레이너";
    int    myUserId        = loginUser.getId();
    String myNickname      = loginUser.getNickname();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 채팅</title>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;display:flex;min-height:100vh;}
</style>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
</head>
<body>

<jsp:include page="sidebar.jsp" />

<div style="margin-left:260px;flex:1;display:flex;height:100vh;overflow:hidden;">

  <!-- ── 채팅 창 ── -->
  <div style="flex:1;display:flex;flex-direction:column;background:white;border-right:1.5px solid #E8EDF5;">

    <!-- 헤더 -->
    <div style="padding:20px 24px;border-bottom:1.5px solid #E8EDF5;display:flex;align-items:center;gap:14px;background:white;">
      <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=<%=trainerNickname%>"
           style="width:46px;height:46px;border-radius:50%;border:2.5px solid #FF6B35;object-fit:cover;" alt="트레이너">
      <div style="flex:1;">
        <div style="font-weight:800;font-size:16px;color:#1A1F36;"><%=trainerNickname%></div>
      </div>
    </div>

    <!-- 메시지 영역 -->
    <div id="chatBox" style="flex:1;overflow-y:auto;padding:24px;display:flex;flex-direction:column;gap:12px;background:linear-gradient(180deg,#F7F9FC 0%,#FFFFFF 100%);"></div>

    <!-- 입력 영역 -->
    <div style="padding:16px 20px;border-top:1.5px solid #E8EDF5;background:white;display:flex;align-items:flex-end;gap:10px;">
      <textarea id="msgInput" placeholder="메시지를 입력하세요..." rows="1" style="
        flex:1;padding:12px 18px;border-radius:22px;border:2px solid #E8EDF5;
        font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;
        outline:none;resize:none;transition:border-color 0.2s;max-height:120px;line-height:1.5;
      " onfocus="this.style.borderColor='#FF6B35'" onblur="this.style.borderColor='#E8EDF5'"
         oninput="autoResize(this)" onkeydown="handleKey(event)"></textarea>
      <button onclick="sendMsg()" style="
        width:44px;height:44px;border-radius:50%;border:none;cursor:pointer;
        background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;
        display:flex;align-items:center;justify-content:center;flex-shrink:0;
        box-shadow:0 4px 14px rgba(255,107,53,0.35);transition:all 0.2s;
      " onmouseover="this.style.transform='scale(1.08)'" onmouseout="this.style.transform='scale(1)'">
        <span class="material-symbols-outlined" style="font-size:20px;">send</span>
      </button>
    </div>
  </div>

  <!-- ── 트레이너 정보 사이드 ── -->
  <div style="width:260px;flex-shrink:0;background:white;border-left:1.5px solid #E8EDF5;overflow-y:auto;">
    <div style="padding:28px 22px;text-align:center;border-bottom:1.5px solid #E8EDF5;background:linear-gradient(180deg,#FFF3EE,white);">
      <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=<%=trainerNickname%>"
           style="width:80px;height:80px;border-radius:50%;border:3px solid #FF6B35;object-fit:cover;margin-bottom:14px;">
      <h3 style="font-size:17px;font-weight:900;color:#1A1F36;margin-bottom:4px;"><%=trainerNickname%></h3>
      <div style="display:inline-flex;align-items:center;gap:6px;padding:4px 12px;border-radius:99px;background:#E8F8F6;color:#00897B;font-size:12px;font-weight:700;">🏅 전문 트레이너</div>
    </div>
    <div style="padding:20px 22px;">
      <button onclick="goFeedback()" style="
        width:100%;padding:12px;border-radius:14px;border:none;cursor:pointer;
        background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;
        font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;
        box-shadow:0 4px 14px rgba(0,191,165,0.3);
      ">최신 피드백 보기</button>
    </div>
    <div style="margin:0 16px 20px;padding:20px;border-radius:18px;background:linear-gradient(135deg,#FF6B35,#FFD166);text-align:center;">
      <div style="font-size:34px;margin-bottom:8px;">🐾</div>
      <div style="font-size:14px;font-weight:800;color:white;margin-bottom:4px;">오늘도 화이팅!</div>
      <div style="font-size:12px;color:rgba(255,255,255,0.85);">트레이너와 함께라면<br>무조건 성공해요!</div>
    </div>
  </div>

</div>

<script>
const ROOM_ID  = <%=roomId%>;
const MY_ID    = <%=myUserId%>;
const CTX      = '<%=request.getContextPath()%>';

// 날짜 포맷
function formatTime(dateStr) {
  if (!dateStr) return '';
  const d = new Date(dateStr);
  return d.getHours().toString().padStart(2,'0') + ':' + d.getMinutes().toString().padStart(2,'0');
}

// 메시지 로드
function loadChat() {
  fetch(CTX + '/member/chat/message?roomId=' + ROOM_ID)
    .then(res => res.json())
    .then(function(data) {
      const box = document.getElementById('chatBox');
      const wasBottom = box.scrollHeight - box.clientHeight <= box.scrollTop + 60;
      box.innerHTML = '';

      data.forEach(function(m) {
        const isMe = m.isMe;
        const wrap = document.createElement('div');
        wrap.style.cssText = 'display:flex;justify-content:' + (isMe ? 'flex-end' : 'flex-start') + ';gap:8px;align-items:flex-end;';

        if (!isMe) {
          const av = document.createElement('img');
          av.src = 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + m.nickname;
          av.style.cssText = 'width:32px;height:32px;border-radius:50%;border:2px solid #E8EDF5;flex-shrink:0;';
          wrap.appendChild(av);
        }

        const inner = document.createElement('div');
        inner.style.cssText = 'display:flex;flex-direction:column;align-items:' + (isMe ? 'flex-end' : 'flex-start') + ';gap:3px;max-width:68%;';

        const bubble = document.createElement('div');
        bubble.style.cssText = isMe
          ? 'background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;border-radius:18px 18px 4px 18px;padding:11px 16px;font-size:14px;line-height:1.5;box-shadow:0 2px 8px rgba(255,107,53,0.25);'
          : 'background:white;color:#1A1F36;border:1.5px solid #E8EDF5;border-radius:18px 18px 18px 4px;padding:11px 16px;font-size:14px;line-height:1.5;box-shadow:0 2px 6px rgba(0,0,0,0.06);';
        bubble.innerText = m.content;

        const timeEl = document.createElement('div');
        timeEl.style.cssText = 'font-size:11px;color:#C4CEDE;';
        timeEl.innerText = formatTime(m.createdAt);

        inner.appendChild(bubble);
        inner.appendChild(timeEl);
        wrap.appendChild(inner);
        box.appendChild(wrap);
      });

      if (wasBottom || data.length === 0) box.scrollTop = box.scrollHeight;
    })
    .catch(function(e) { console.error('채팅 로드 실패:', e); });
}

// 메시지 전송
function sendMsg() {
  const input = document.getElementById('msgInput');
  const msg = input.value.trim();
  if (!msg) return;
  input.value = '';
  input.style.height = 'auto';

  fetch(CTX + '/member/chat/message', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'roomId=' + ROOM_ID + '&message=' + encodeURIComponent(msg)
  }).then(function() { loadChat(); });
}

function handleKey(e) {
  if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMsg(); }
}

function autoResize(el) {
  el.style.height = 'auto';
  el.style.height = Math.min(el.scrollHeight, 120) + 'px';
}

function goFeedback() {
  location.href = CTX + '/member/mypage?tab=feedback';
}

loadChat();
setInterval(loadChat, 2000);
</script>
</body>
</html>
