<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 핏불 신고 모달 -->
<div id="reportModal" style="
  display:none; position:fixed; inset:0; z-index:2000;
  background:rgba(26,31,54,0.55); align-items:center; justify-content:center;
  backdrop-filter:blur(6px);
">
  <div style="
    background:white; border-radius:24px; width:100%; max-width:440px;
    box-shadow:0 12px 40px rgba(0,0,0,0.16);
    animation:fb_modal_in 0.3s ease;
    font-family:'Noto Sans KR','Nunito',sans-serif;
    overflow:hidden; max-height:90vh; overflow-y:auto;
  ">

    <!-- 헤더 -->
    <div style="background:linear-gradient(135deg,#FF4D4D,#FF6B35);padding:24px 28px;text-align:center;">
      <div style="font-size:36px;margin-bottom:6px;">&#128680;</div>
      <h2 style="font-size:18px;font-weight:900;color:white;margin-bottom:3px;">신고 사유 선택</h2>
      <p style="font-size:13px;color:rgba(255,255,255,0.85);">부적절한 게시글을 신고해 주세요</p>
    </div>

	<form action="report" method="POST">
    <!-- 폼 -->
    <div style="padding:24px 28px;">
      <input type="hidden" id="reportPostNum" value="" name="postId">
      <input type="hidden" id="targetId" value="" name="targetId">

      <!-- 신고 사유 라디오 -->
      <div style="display:flex;flex-direction:column;gap:8px;margin-bottom:16px;">
        <p style="font-size:13px;font-weight:700;color:#5A6480;margin-bottom:4px;">신고 유형을 선택해주세요</p>
        <%
          String[][] reasons = {
            {"광고",    "&#128226; 광고 / 홍보"},
            {"음란물",  "&#128286; 음란물"},
            {"욕설",    "&#128172; 욕설 / 비방"},
            {"개인정보","&#128274; 개인정보 노출"},
            {"기타",    "&#128221; 기타"}
          };
          for(String[] r : reasons){
        %>
        <label style="
          display:flex;align-items:center;gap:12px;padding:12px 16px;
          border-radius:12px;border:1.5px solid #E8EDF5;cursor:pointer;transition:all 0.2s;
        " onmouseover="this.style.background='#FFF3EE';this.style.borderColor='#FF6B35'"
           onmouseout="this.style.background='white';this.style.borderColor='#E8EDF5'">
          <input type="radio" name="reason" value="<%= r[0] %>" 
                 style="accent-color:#FF6B35;width:16px;height:16px;flex-shrink:0;"
                 onclick="showReportDetail('<%= r[0] %>')">
          <span style="font-size:14px;font-weight:600;color:#1A1F36;"><%= r[1] %></span>
        </label>
        <% } %>
      </div>

      <!-- 신고 사유 상세 입력 (모든 항목 선택 시 표시) -->
      <div id="reportDetailBox" style="display:none;margin-bottom:20px;">
        <p style="font-size:13px;font-weight:700;color:#5A6480;margin-bottom:8px;">
          신고 사유를 자세히 입력해주세요 <span style="color:#FF4D4D;">*</span>
        </p>
        <textarea id="reportDetailText" placeholder="어떤 문제가 있는지 구체적으로 작성해주세요..." style="
          width:100%;padding:12px 16px;border-radius:12px;border:2px solid #E8EDF5;
          font-family:'Noto Sans KR',sans-serif;font-size:13px;color:#1A1F36;
          resize:none;outline:none;min-height:90px;box-sizing:border-box;transition:border-color 0.2s;
          background:#F7F9FC;
        " name="detail" onfocus="this.style.borderColor='#FF6B35';this.style.background='white'"
           onblur="this.style.borderColor='#E8EDF5';this.style.background='#F7F9FC'"></textarea>
      </div>

      <!-- 버튼 -->
      <div style="display:flex;gap:10px;">
        <button type="button" onclick="closeReportModal()" style="
          flex:1;padding:13px;border-radius:99px;border:1.5px solid #E8EDF5;
          background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;
          font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
        " onmouseover="this.style.background='#F7F9FC'" onmouseout="this.style.background='white'">
          취소
        </button>
        <button type="submit" style="
          flex:1;padding:13px;border-radius:99px;border:none;cursor:pointer;
          background:linear-gradient(135deg,#FF4D4D,#FF6B35);color:white;
          font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;
          box-shadow:0 4px 14px rgba(255,77,77,0.35);transition:all 0.2s;
        " onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
          신고하기
        </button>
      </div>
      
    </div>
	</form>

  </div>
</div>

<script>
function showReportDetail(reason) {
  // 모든 항목 선택 시 상세 입력란 표시
  var box = document.getElementById('reportDetailBox');
  if (box) box.style.display = 'block';
}

function closeReportModal() {
  var m = document.getElementById('reportModal');
  if (m) m.style.display = 'none';
  // 초기화
  var radios = document.querySelectorAll('input[name="reportReason"]');
  radios.forEach(function(r){ r.checked = false; });
  var box = document.getElementById('reportDetailBox');
  if (box) box.style.display = 'none';
  var txt = document.getElementById('reportDetailText');
  if (txt) txt.value = '';
}

/* function submitReport() {
  var postNum = document.getElementById('reportPostNum').value;
  var reason  = '';
  var radios  = document.querySelectorAll('input[name="reportReason"]');
  radios.forEach(function(r){ if(r.checked) reason = r.value; });
  var detail  = document.getElementById('reportDetailText').value.trim();

  if (!reason) { alert('신고 유형을 선택해주세요.'); return; }
  if (!detail)  { alert('신고 사유를 입력해주세요.'); return; }

  fetch('report', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postId=' + encodeURIComponent(postNum)
        + '&reason=' + encodeURIComponent(reason)
        + '&detail=' + encodeURIComponent(detail)
  })
  .then(function(res){ return res.json(); })
  .then(function(data){
    if (data.result === 'ok') {
      closeReportModal();
      // 신고된 게시글 카드 숨김
      var article = document.querySelector('article[data-post-id="' + postNum + '"]');
      if (article) {
        article.style.transition = 'all 0.4s';
        article.style.opacity = '0';
        article.style.transform = 'scale(0.95)';
        setTimeout(function(){ article.style.display = 'none'; }, 400);
      }
      alert('신고가 접수되었습니다. 검토 후 처리됩니다.');
    } else if (data.result === 'already') {
      alert('이미 신고한 게시글입니다.');
      closeReportModal();
    } else if (data.result === 'notLogin') {
      alert('로그인 후 신고할 수 있습니다.');
      closeReportModal();
    } else {
      alert('신고 처리 중 오류가 발생했습니다.');
    }
  })
  .catch(function(err){
	  console.log(err)
	  alert('서버 연결 오류가 발생했습니다.'); });
} */

// 기존 openReportModal 함수 호환
function openReportModal(postNum,targetId) {
  var m = document.getElementById('reportModal');
  if (m) {
    m.style.display = 'flex';
    document.getElementById('reportPostNum').value = postNum;
    document.getElementById('targetId').value = targetId;
  }
}
// community.jsp의 closeModal() 호환
function closeModal() { closeReportModal(); }
// community.jsp의 toggleEtc() 호환 (더 이상 필요없으나 오류 방지)
function toggleEtc(show) {}
</script>
