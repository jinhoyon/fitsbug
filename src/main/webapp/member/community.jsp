<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.common.UserDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
  String nickname = (loginUser != null) ? loginUser.getNickname() : "";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>핏츠버그 - 커뮤니티</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
*, *::before, *::after { box-sizing: border-box; }
body { font-family: 'Noto Sans KR', 'Nunito', sans-serif; background: #F7F9FC; display: flex; min-height: 100vh; }

/* 포스트 카드 hover */
.fb-post-card {
  background: white; border-radius: 20px; overflow: hidden;
  border: 1.5px solid #E8EDF5; box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  transition: box-shadow 0.2s, transform 0.2s;
  margin-bottom: 16px;
}
.fb-post-card:hover { box-shadow: 0 6px 24px rgba(0,0,0,0.1); transform: translateY(-2px); }

/* 리액션 버튼 */
.react-btn {
  display: inline-flex; align-items: center; gap: 5px;
  padding: 7px 14px; border-radius: 99px;
  border: 1.5px solid #E8EDF5; background: white;
  font-size: 13px; cursor: pointer; transition: all 0.2s;
  font-family: 'Noto Sans KR', sans-serif; font-weight: 600;
  color: #5A6480;
}
.react-btn:hover { border-color: #FF6B35; background: #FFF3EE; color: #FF6B35; transform: scale(1.05); }
.react-btn.reacted { background: #FFF3EE; border-color: #FF6B35; color: #FF6B35; }

/* 탭 버튼 */
.cat-tab { padding: 8px 20px; border-radius: 99px; font-size: 13px; font-weight: 700; cursor: pointer; border: none; background: transparent; transition: all 0.2s; font-family: 'Noto Sans KR', sans-serif; color: #5A6480; }
.cat-tab.active { background: white; color: #FF6B35; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }

/* 댓글 입력 */
.comment-input { flex: 1; padding: 10px 16px; border-radius: 99px; border: 2px solid #E8EDF5; outline: none; font-family: 'Noto Sans KR', sans-serif; font-size: 13px; transition: border-color 0.2s; }
.comment-input:focus { border-color: #FF6B35; }

/* 스트릭 원 */
.streak-dot {
  width: 34px; height: 34px; border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 13px; font-weight: 700;
}
.streak-dot.done { background: linear-gradient(135deg,#FF6B35,#FFD166); color: white; box-shadow: 0 2px 8px rgba(255,107,53,0.3); }
.streak-dot.empty { background: #F0F0F0; color: #C4CEDE; }

@keyframes fb_modal_in { from { opacity:0; transform:scale(0.9) translateY(20px); } to { opacity:1; transform:scale(1) translateY(0); } }
</style>
</head>

<body>
<!-- 사이드바 -->
<jsp:include page="sidebar.jsp" />

<!-- 신고 모달 (include) -->
<jsp:include page="reportModal.jsp" />

<!-- 게시글 작성 모달 (include) -->
<jsp:include page="postModal.jsp" />

<!-- 메인 -->
<main style="flex:1;margin-left:260px;padding:32px 36px;display:flex;gap:28px;max-width:calc(100vw - 260px);">

<!-- ============ 피드 영역 ============ -->
<div style="flex:1;min-width:0;">

  <!-- 헤더 -->
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
    <div>
      <h2 style="font-size:26px;font-weight:900;color:#1A1F36;letter-spacing:-0.5px;">커뮤니티 💬</h2>
      <p style="font-size:14px;color:#9DA8C0;margin-top:3px;">핏불 멤버들의 오운완 인증 & 자유게시판</p>
    </div>
    <div style="display:flex;gap:10px;align-items:center;">
      <div style="position:relative;">
        <input type="text" placeholder="🔍 검색..." style="
          padding:10px 18px;border-radius:99px;border:2px solid #E8EDF5;
          background:white;font-family:'Noto Sans KR',sans-serif;font-size:13px;
          outline:none;width:200px;transition:border-color 0.2s;
        " onfocus="this.style.borderColor='#FF6B35'" onblur="this.style.borderColor='#E8EDF5'">
      </div>
      <button onclick="openPostModal()" style="
        padding:10px 22px;border-radius:99px;border:none;cursor:pointer;
        background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;
        font-size:14px;font-weight:700;font-family:'Noto Sans KR',sans-serif;
        box-shadow:0 4px 16px rgba(255,107,53,0.3);transition:all 0.2s;
      " onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='none'">
        ✏️ 글 작성
      </button>
    </div>
  </div>

  <!-- 카테고리 탭 -->
  <div style="background:#F7F9FC;border:1.5px solid #E8EDF5;border-radius:99px;padding:4px;display:inline-flex;gap:2px;margin-bottom:20px;">
    <button onclick="filterPost('all',this)" class="cat-tab active">전체</button>
    <button onclick="filterPost('exerciseComplete',this)" class="cat-tab">🏆 오운완</button>
    <button onclick="filterPost('free',this)" class="cat-tab">💬 자유게시판</button>
  </div>

  <!-- ── 테스트 게시글 (owun) ── -->
<!--   <article class="post owun fb-post-card"> -->
<!--     <div style="padding:14px 18px 0;"> -->
<!--       <span style="display:inline-flex;align-items:center;gap:5px;padding:4px 12px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FFD166);color:white;font-size:12px;font-weight:800;"> -->
<!--         🏆 오운완 -->
<!--       </span> -->
<!--     </div> -->
<!--     <div style="display:flex;justify-content:space-between;align-items:center;padding:14px 18px 10px;"> -->
<!--       <div style="display:flex;gap:12px;align-items:center;"> -->
<!--         <img src="https://api.dicebear.com/7.x/adventurer/svg?seed=user1" style="width:42px;height:42px;border-radius:50%;border:2px solid #E8EDF5;" alt="프로필"> -->
<!--         <div> -->
<!--           <div style="font-weight:700;font-size:14px;color:#1A1F36;">테스트유저</div> -->
<!--           <div style="font-size:12px;color:#9DA8C0;">방금 전</div> -->
<!--         </div> -->
<!--       </div> -->
<!--       <button onclick="openReportModal(999)" style="display:flex;align-items:center;gap:4px;font-size:12px;color:#C4CEDE;background:none;border:none;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:color 0.2s;" onmouseover="this.style.color='#FF4D4D'" onmouseout="this.style.color='#C4CEDE'"> -->
<!--         <span class="material-symbols-outlined" style="font-size:16px;">flag</span> 신고 -->
<!--       </button> -->
<!--     </div> -->
<!--     <img src="https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=800&q=80" style="width:100%;height:300px;object-fit:cover;" alt="운동 사진"> -->
<!--     <div style="padding:18px;"> -->
<!--       <h3 style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:6px;">오늘 벤치 신기록 달성! 🔥</h3> -->
<!--       <p style="font-size:14px;color:#5A6480;line-height:1.6;">드디어 100kg 벤치 달성했습니다. 핏불이 응원해줘서 더 힘이 났어요!</p> -->
<!--       <div style="font-size:13px;color:#00BFA5;font-weight:600;margin-top:8px;">#오운완 #벤치프레스 #신기록</div> -->
<!--       <div style="display:flex;gap:8px;margin-top:14px;align-items:center;"> -->
<!--         <button onclick="react(this, 999, 'like')" id="btn-like-999" class="react-btn">❤️ <span id="like-999">24</span></button> -->
<!--         <button onclick="react(this, 999, 'good')" id="btn-good-999" class="react-btn">👍 <span id="good-999">18</span></button> -->
<!--         <button onclick="react(this, 999, 'muscle')" id="btn-muscle-999" class="react-btn">💪 <span id="muscle-999">31</span></button> -->
<!--         <button onclick="toggleComment(this, 999)" style="margin-left:auto;display:flex;align-items:center;gap:5px;font-size:13px;color:#9DA8C0;background:none;border:none;cursor:pointer;font-family:'Noto Sans KR',sans-serif;font-weight:600;" onmouseover="this.style.color='#FF6B35'" onmouseout="this.style.color='#9DA8C0'"> -->
<!--           <span class="material-symbols-outlined" style="font-size:18px;">chat_bubble</span> 댓글 12 -->
<!--         </button> -->
<!--       </div> -->
<!--     </div> -->
<!--     <div class="comment-box" style="display:none;background:#F7F9FC;border-top:1.5px solid #E8EDF5;padding:16px 18px;"> -->
<!--       <div id="commentList-999" style="margin-bottom:12px;display:flex;flex-direction:column;gap:8px;"></div> -->
<!--       <div style="display:flex;gap:10px;align-items:center;"> -->
<!--         <img src="https://api.dicebear.com/7.x/adventurer/svg?seed=me" style="width:32px;height:32px;border-radius:50%;border:2px solid #E8EDF5;flex-shrink:0;" alt="내 프로필"> -->
<!--         <input id="commentInput-999" class="comment-input" placeholder="댓글을 입력하세요..."> -->
<!--         <button onclick="writeComment(999)" style="padding:8px 16px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:13px;font-weight:700;font-family:'Noto Sans KR',sans-serif;white-space:nowrap;">작성</button> -->
<!--       </div> -->
<!--     </div> -->
<!--   </article> -->

  <!-- DB 게시글 출력 -->
  <c:forEach var="post" items="${postList}">
  <article class="post ${post.postType} fb-post-card" data-post-id="${post.id}">
    <div style="padding:14px 18px 0;">
      <c:choose>
        <c:when test="${post.postType eq 'exerciseComplete'}">
          <span style="display:inline-flex;align-items:center;gap:5px;padding:4px 12px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FFD166);color:white;font-size:12px;font-weight:800;">🏆 오운완</span>
        </c:when>
        <c:otherwise>
          <span style="display:inline-flex;align-items:center;gap:5px;padding:4px 12px;border-radius:99px;background:#E8F8F6;color:#00897B;font-size:12px;font-weight:800;">💬 자유</span>
        </c:otherwise>
      </c:choose>
    </div>
    <div style="display:flex;justify-content:space-between;align-items:center;padding:14px 18px 10px;">
      <div style="display:flex;gap:12px;align-items:center;">
        <img src="${pageContext.request.contextPath}/trainer/profile-img/${post.profileImage}" style="width:42px;height:42px;border-radius:50%;border:2px solid #E8EDF5;" alt="프로필">
        <div>
          <div style="font-weight:700;font-size:14px;color:#1A1F36;">${not empty post.nickName ? post.nickName : "회원"}</div>
          <div style="font-size:12px;color:#9DA8C0;">${post.createdAt}</div>
        </div>
      </div>
      <button onclick="openReportModal(${post.id},${post.userId})" style="display:flex;align-items:center;gap:4px;font-size:12px;color:#C4CEDE;background:none;border:none;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:color 0.2s;" onmouseover="this.style.color='#FF4D4D'" onmouseout="this.style.color='#C4CEDE'">
        <span class="material-symbols-outlined" style="font-size:16px;">flag</span> 신고
      </button>
    </div>
    <c:if test="${not empty post.image}">
      <img src="${pageContext.request.contextPath}/trainer/profile-img/${post.image}" style="width:100%;max-height:340px;object-fit:cover;" alt="게시글 이미지">
    </c:if>
    <div style="padding:18px;">
      <h3 style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:6px;">${post.title}</h3>
      <p style="font-size:14px;color:#5A6480;line-height:1.6;">${post.body}</p>
      <div style="font-size:13px;color:#00BFA5;font-weight:600;margin-top:8px;">${post.hashtags}</div>
      <div style="display:flex;gap:8px;margin-top:14px;align-items:center;">
        <button onclick="react(this,${post.id},'like')" id="btn-like-${post.id}" class="react-btn">❤️ <span id="like-${post.id}">0</span></button>
        <button onclick="react(this,${post.id},'good')" id="btn-good-${post.id}" class="react-btn">👍 <span id="good-${post.id}">0</span></button>
        <button onclick="react(this,${post.id},'muscle')" id="btn-muscle-${post.id}" class="react-btn">💪 <span id="muscle-${post.id}">0</span></button>
        <button onclick="toggleComment(this,${post.id})" style="margin-left:auto;display:flex;align-items:center;gap:5px;font-size:13px;color:#9DA8C0;background:none;border:none;cursor:pointer;font-family:'Noto Sans KR',sans-serif;font-weight:600;" onmouseover="this.style.color='#FF6B35'" onmouseout="this.style.color='#9DA8C0'">
          <span class="material-symbols-outlined" style="font-size:18px;">chat_bubble</span> 댓글
        </button>
      </div>
    </div>
    <div class="comment-box" style="display:none;background:#F7F9FC;border-top:1.5px solid #E8EDF5;padding:16px 18px;">
      <div id="commentList-${post.id}" style="margin-bottom:12px;"></div>
      <div style="display:flex;gap:10px;align-items:center;">
        <input id="commentInput-${post.id}" class="comment-input" placeholder="댓글을 입력하세요...">
        <button onclick="writeComment(${post.id})" style="padding:8px 16px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:13px;font-weight:700;font-family:'Noto Sans KR',sans-serif;white-space:nowrap;">작성</button>
      </div>
    </div>
  </article>
  </c:forEach>

</div><!-- end feed -->

<!-- ============ 사이드 패널 ============ -->
<aside style="width:280px;flex-shrink:0;display:flex;flex-direction:column;gap:18px;">

  <!-- 오운완 랭킹 -->
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:22px;">
    <h3 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:16px;">🏆 이번 주 오운완 랭킹</h3>
    <div style="display:flex;flex-direction:column;gap:10px;">
      <c:forEach var="post" items="${postList}" varStatus="status">
        <c:if test="${status.index < 3}">
        <div style="display:flex;align-items:center;gap:12px;padding:12px;border-radius:12px;background:#F7F9FC;border:1.5px solid #E8EDF5;">
          <div style="font-size:22px;">
            <c:choose>
              <c:when test="${status.index == 0}">&#129351;</c:when>
              <c:when test="${status.index == 1}">&#129352;</c:when>
              <c:otherwise>&#129353;</c:otherwise>
            </c:choose>
          </div>
          <img src="https://api.dicebear.com/7.x/adventurer/svg?seed=${post.userId}" style="width:38px;height:38px;border-radius:50%;border:2px solid #E8EDF5;" alt="랭킹">
          <div style="flex:1;min-width:0;">
            <div style="font-weight:700;font-size:13px;color:#1A1F36;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${not empty post.userId ? post.userId : "회원"}</div>
            <div style="font-size:12px;color:#FF6B35;font-weight:700;">🔥 <span class="rank-score" data-post-id="${post.id}">-</span></div>
          </div>
        </div>
        </c:if>
      </c:forEach>
    </div>
  </div>

  <!-- 핏불 응원 카드 -->
  <div style="background:linear-gradient(135deg,#FF6B35,#FFD166);border-radius:20px;padding:22px;text-align:center;box-shadow:0 4px 20px rgba(255,107,53,0.28);">
    <div style="font-size:40px;margin-bottom:8px;">🐾</div>
    <div style="font-size:15px;font-weight:900;color:white;margin-bottom:6px;">핏불이 응원해요!</div>
    <div style="font-size:13px;color:rgba(255,255,255,0.85);line-height:1.5;">오운완 게시글을 올리면<br>핏불이 따봉 🤙을 보내줄 거예요!</div>
    <button onclick="openPostModal()" style="margin-top:14px;padding:9px 22px;border-radius:99px;border:2px solid white;background:transparent;color:white;font-weight:700;font-size:13px;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='rgba(255,255,255,0.2)'" onmouseout="this.style.background='transparent'">
      오운완 인증하기 →
    </button>
  </div>

  <!-- 핫 해시태그 -->
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:22px;">
    <h3 style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:14px;">🔥 인기 태그</h3>
    <div style="display:flex;flex-wrap:wrap;gap:8px;">
      <% String[] tags = {"#오운완","#벤치프레스","#스쿼트","#다이어트","#헬스","#단백질","#인바디","#PT"};
         for(String t : tags){ %>
      <span style="padding:5px 12px;border-radius:99px;background:#F7F9FC;border:1.5px solid #E8EDF5;font-size:12px;font-weight:700;color:#5A6480;cursor:pointer;transition:all 0.2s;" onmouseover="this.style.borderColor='#FF6B35';this.style.color='#FF6B35'" onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#5A6480'">
        <%= t %>
      </span>
      <% } %>
    </div>
  </div>

</aside>

</main>

<script>
// 카테고리 필터
function filterPost(type, el) {
  document.querySelectorAll('.post').forEach(p => {
    p.style.display = (type === 'all' || p.classList.contains(type)) ? 'block' : 'none';
  });
  document.querySelectorAll('.cat-tab').forEach(b => {
    b.classList.remove('active'); b.style.background = 'transparent'; b.style.color = '#5A6480'; b.style.boxShadow = 'none';
  });
  el.classList.add('active'); el.style.background = 'white'; el.style.color = '#FF6B35'; el.style.boxShadow = '0 2px 8px rgba(0,0,0,0.08)';
}

// 댓글 토글
function toggleComment(btn, postNum) {
  const article = btn.closest('article');
  const box = article.querySelector('.comment-box');
  const isHidden = box.style.display === 'none';
  box.style.display = isHidden ? 'block' : 'none';
  if (isHidden) loadComments(postNum);
}

// 댓글 로드
function loadComments(postNum) {
  fetch('commentList?postNum=' + postNum)
    .then(res => res.json())
    .then(list => {
      const box = document.getElementById('commentList-' + postNum);
      if (!box) return;
      // ★ JSON 키: userId (CommentListController 에서 "userId" 로 통일)
      // ★ JSP 파일 안에서 달러+중괄호 는 JSTL EL로 해석되므로
      //    템플릿 리터럴 대신 문자열 연결(+) 사용
      box.innerHTML = list.map(function(c) {
        return '<div style="display:flex;gap:10px;align-items:flex-start;">'
          + '<img src="https://api.dicebear.com/7.x/adventurer/svg?seed=' + c.userId + '"'
          + ' style="width:30px;height:30px;border-radius:50%;border:2px solid #E8EDF5;flex-shrink:0;">'
          + '<div style="background:white;border:1.5px solid #E8EDF5;border-radius:12px;padding:8px 14px;flex:1;">'
          + '<div style="font-weight:700;font-size:12px;color:#1A1F36;">' + c.userId + '</div>'
          + '<div style="font-size:13px;color:#5A6480;margin-top:2px;">' + c.body + '</div>'
          + '</div>'
          + '</div>';
      }).join('');
    }).catch(err => console.error('댓글 로드 실패:', err));
}

// 댓글 작성
// ★ 파라미터: postNum + body (세션에서 userId는 서버가 직접 가져감)
function writeComment(postNum) {
  const input = document.getElementById('commentInput-' + postNum);
  const body = input.value.trim();
  if (!body) return;
  fetch('comment', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNum=' + postNum + '&body=' + encodeURIComponent(body)
  }).then(res => res.json()).then(data => {
    if (data.result === 'ok') {
      input.value = '';
      loadComments(postNum);
    } else if (data.result === 'notLogin') {
      alert('로그인 후 댓글을 작성할 수 있습니다.');
    }
  }).catch(err => console.error('댓글 작성 실패:', err));
}

// 리액션
// ★ ReactionController 응답이 JSON으로 변경됨 {"result":"ok"|"duplicate"|"notLogin"}
function react(btn, postNum, type) {
  if (btn.classList.contains('reacted')) return;
  fetch('reaction', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: 'postNum=' + postNum + '&type=' + type
  }).then(res => res.json()).then(data => {
    if (data.result === 'ok') {
      const span = document.getElementById(type + '-' + postNum);
      if (span) span.innerText = parseInt(span.innerText || '0') + 1;
      btn.classList.add('reacted');
      // 오운완 게시글 + muscle 이면 핏불 응원
      const article = btn.closest('article');
      if (article && article.classList.contains('exerciseComplete') && type === 'muscle') {
        showFitbullCheer('💪 대단해! 같이 운동해요!');
      }
    } else if (data.result === 'duplicate') {
      btn.classList.add('reacted'); // 이미 눌렀으면 UI만 동기화
    } else if (data.result === 'notLogin') {
      alert('로그인 후 리액션을 누를 수 있습니다.');
    }
  }).catch(err => console.error('리액션 오류:', err));
}

// 리액션 카운트 AJAX 로드 (ReactionCountController)
function loadReactionCounts(postId) {
  fetch('reactionCount?postId=' + postId)
    .then(res => res.json())
    .then(data => {
      var total = 0;
      ['like', 'good', 'muscle'].forEach(function(type) {
        var span = document.getElementById(type + '-' + postId);
        var btn  = document.getElementById('btn-' + type + '-' + postId);
        if (span && data[type]) {
          span.innerText = data[type].count;
          total += data[type].count;
        }
        if (btn && data[type] && data[type].reacted) {
          btn.classList.add('reacted');
        }
      });
      // 사이드 랭킹 점수 업데이트
      var rankEl = document.querySelector('.rank-score[data-post-id="' + postId + '"]');
      if (rankEl) rankEl.innerText = total + '점';
    }).catch(function(err) { console.error('리액션 카운트 로드 실패:', err); });
}

// 페이지 로드 시 DB 게시글 카드 리액션 카운트 일괄 로드
document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('article.fb-post-card[data-post-id]').forEach(article => {
    const postId = article.getAttribute('data-post-id');
    if (postId) loadReactionCounts(postId);
  });
});

// 신고 모달
function openReportModal(postNum, targetId) {
  const m = document.getElementById('reportModal');
  if (m) { m.style.display = 'flex'; 
  			document.getElementById('reportPostNum').value = postNum; 
  			document.getElementById('targetId').value = targetId;
  }
}
function closeModal() {
  const m = document.getElementById('reportModal');
  if (m) m.style.display = 'none';
}

// 게시글 모달
function openPostModal() {
  const m = document.getElementById('postModal');
  if (m) m.style.display = 'flex';
}
function closePostModal() {
  const m = document.getElementById('postModal');
  if (m) m.style.display = 'none';
}

function selectCategory(type) {
  const owunBtn = document.getElementById('owunBtn');
  const freeBtn = document.getElementById('freeBtn');
  const uploadText = document.getElementById('uploadText');
  const hashtagInput = document.getElementById('hashtagInput');
  const categoryInput = document.getElementById('category');
  if (type === 'owun') {
    owunBtn.style.background = 'linear-gradient(135deg,#FF6B35,#FF8C5A)'; owunBtn.style.color = 'white';
    freeBtn.style.background = '#F7F9FC'; freeBtn.style.color = '#5A6480';
    if (uploadText) uploadText.innerText = '🏋️ 오늘 운동 인증샷을 공유해보세요!';
    if (hashtagInput) hashtagInput.value = '#오운완 #운동';
    if (categoryInput) categoryInput.value = 'owun';
  } else {
    freeBtn.style.background = 'linear-gradient(135deg,#00BFA5,#26D4BB)'; freeBtn.style.color = 'white';
    owunBtn.style.background = '#F7F9FC'; owunBtn.style.color = '#5A6480';
    if (uploadText) uploadText.innerText = '💬 자유롭게 사진을 공유해보세요!';
    if (hashtagInput) hashtagInput.value = '#헬스 #운동';
    if (categoryInput) categoryInput.value = 'free';
  }
}

function toggleEtc(show) {
  const el = document.getElementById('etcBox');
  if (el) el.style.display = show ? 'block' : 'none';
}
</script>
</body>
</html>
