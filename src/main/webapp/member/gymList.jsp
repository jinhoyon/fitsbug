<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dto.common.Gym" %>
<%
List<Gym> list = (List<Gym>) request.getAttribute("gymList");
if (list == null) list = new ArrayList<>();

String keyword  = request.getParameter("keyword");
String category = request.getParameter("category");
String sort     = request.getParameter("sort");

if (keyword  == null) keyword  = "";
if (category == null) category = "전체";
if (sort     == null) sort     = "distance"; // 기본 정렬: 거리순
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>핏츠버그 - 헬스장 찾기</title>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;display:flex;min-height:100vh;}
::-webkit-scrollbar{width:6px;}
::-webkit-scrollbar-thumb{background:#00BFA5;border-radius:99px;}
.gym-card{background:white;border-radius:20px;overflow:hidden;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);transition:all 0.25s ease;cursor:pointer;}
.gym-card:hover{box-shadow:0 10px 32px rgba(0,0,0,0.13);transform:translateY(-4px);border-color:rgba(0,191,165,0.3);}
.cat-chip{padding:8px 18px;border-radius:99px;font-size:13px;font-weight:700;cursor:pointer;border:1.5px solid #E8EDF5;background:white;color:#5A6480;transition:all 0.2s;font-family:'Noto Sans KR',sans-serif;white-space:nowrap;}
.cat-chip:hover{border-color:#00BFA5;color:#00BFA5;}
.cat-chip.active{background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;border-color:transparent;box-shadow:0 3px 12px rgba(0,191,165,0.3);}
.fb-search{flex:1;padding:13px 20px 13px 48px;border-radius:99px;border:2px solid #E8EDF5;background:white;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;transition:all 0.2s;box-shadow:0 2px 8px rgba(0,0,0,0.05);}
.fb-search:focus{border-color:#00BFA5;box-shadow:0 0 0 3px rgba(0,191,165,0.12);}
.fb-search::placeholder{color:#C4CEDE;}
.fb-select{padding:13px 18px;border-radius:99px;border:2px solid #E8EDF5;background:white;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;cursor:pointer;transition:all 0.2s;min-width:120px;}
.fb-select:focus{border-color:#00BFA5;}
.fb-spinner{display:none;width:36px;height:36px;border-radius:50%;border:3px solid #E8EDF5;border-top-color:#00BFA5;animation:spin 0.8s linear infinite;}
@keyframes spin{to{transform:rotate(360deg);}}

/* 위치 배너 */
.loc-banner{
    background:linear-gradient(135deg,#E8F8F6,#F0FBF9);
    border:1.5px solid rgba(0,191,165,0.25);
    border-radius:14px; padding:14px 18px; margin-bottom:18px;
    display:none; align-items:center; gap:10px;
}
.loc-banner.error{
    background:#FFF8F0; border-color:rgba(255,107,53,0.25);
}
.loc-dot{
    width:10px; height:10px; border-radius:50%;
    background:#00BFA5; animation:pulse 1.5s infinite;
}
.loc-dot.error{ background:#FF6B35; animation:none; }
@keyframes pulse{0%,100%{transform:scale(1);opacity:1;}50%{transform:scale(1.4);opacity:.6;}}
</style>
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<div style="flex:1;margin-left:260px;padding:32px 36px;max-width:calc(100vw - 260px);">

  <!-- 헤더 -->
  <div style="margin-bottom:28px;display:flex;justify-content:space-between;align-items:flex-end;">
    <div>
      <h1 style="font-size:26px;font-weight:900;color:#1A1F36;letter-spacing:-.5px;">헬스장 찾기 🏢</h1>
      <p style="font-size:14px;color:#9DA8C0;margin-top:4px;">내 주변 파트너 헬스장을 찾아보세요!</p>
    </div>
    <a href="<%=contextPath%>/member/gymJoin"
       style="padding:11px 22px;border-radius:99px;background:linear-gradient(135deg,#00BFA5,#26D4BB);
              color:white;text-decoration:none;font-size:13px;font-weight:700;
              box-shadow:0 4px 12px rgba(0,191,165,0.3);">
      🏢 헬스장 등록
    </a>
  </div>

  <!-- 위치 배너 -->
  <div id="locBanner" class="loc-banner">
    <div id="locDot" class="loc-dot"></div>
    <span id="locMsg" style="font-size:13px;font-weight:600;color:#00897B;"></span>
    <div class="fb-spinner" id="locSpinner" style="width:20px;height:20px;border-width:2px;"></div>
  </div>

  <!-- 검색 + 정렬 -->
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:20px 24px;margin-bottom:24px;">
    <form id="searchForm" style="display:flex;gap:10px;margin-bottom:16px;">
      <div style="position:relative;flex:1;">
        <span class="material-symbols-outlined" style="position:absolute;left:18px;top:50%;transform:translateY(-50%);font-size:20px;color:#9DA8C0;">search</span>
        <input type="text" id="keyword" value="<%=keyword%>"
               placeholder="헬스장 이름, 주소로 검색..." class="fb-search">
      </div>
      <select id="sort" class="fb-select">
        <option value="distance"  <%=sort.equals("distance") ?"selected":""%>>📍 거리순</option>
        <option value="recommend" <%=sort.equals("recommend")?"selected":""%>>⭐ 추천순</option>
        <option value="rating"    <%=sort.equals("rating")   ?"selected":""%>>🏆 평점순</option>
      </select>
    </form>

    <!-- 카테고리 칩 -->
    <%-- <div style="display:flex;gap:8px;flex-wrap:wrap;align-items:center;">
      <span style="font-size:12px;font-weight:700;color:#9DA8C0;margin-right:4px;">전문분야</span>
      <% String[] cats = {"전체","다이어트","근력","체형교정","재활","필라테스","크로스핏"};
         for (String c : cats) { %>
      <button class="cat-chip <%=c.equals(category)?"active":""%>"
              onclick="setCategory('<%=c%>',this)"><%=c%></button>
      <% } %>
    </div> --%>
  </div>

  <!-- 결과 카운트 -->
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
    <div style="font-size:14px;color:#5A6480;font-weight:600;">
      총 <span id="countText" style="color:#00BFA5;font-weight:900;"><%=list.size()%></span>개 헬스장
    </div>
    <div id="spinner" class="fb-spinner"></div>
  </div>

  <!-- 카드 그리드 -->
  <div id="gymContainer" style="display:grid;grid-template-columns:repeat(4,1fr);gap:18px;">
    <jsp:include page="gymListFragment.jsp"/>
  </div>

  <!-- 빈 상태 -->
  <div id="emptyState" style="display:none;text-align:center;padding:80px 20px;">
    <div style="font-size:60px;margin-bottom:16px;">🏋️</div>
    <div style="font-size:18px;font-weight:800;color:#1A1F36;margin-bottom:8px;">주변에 헬스장이 없어요</div>
    <div style="font-size:14px;color:#9DA8C0;">다른 검색어나 카테고리로 찾아보세요!</div>
  </div>

</div>

<form action="<%=contextPath%>/member/gymList" id="locForm">
	<input type="hidden" name="keyword" id="keywordLoc"/>
	<input type="hidden" name="sort" id="sortLoc"/>
	<input type="hidden" name="category" id="categoryLoc"/>
	<input type="hidden" name="lat" id="latLoc"/>
	<input type="hidden" name="lng" id="lngLoc"/>
</form>

<script>
var userLat = null, userLng = null;
var currentCategory = '<%=category%>';
var debounceTimer;

/* ── 위치 취득 ─────────────────────────────────────────────── */
showLocBanner('loading', '📍 현재 위치를 파악하는 중...');

if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
        function(pos) {
            userLat = pos.coords.latitude;
            userLng = pos.coords.longitude;
            showLocBanner('ok', '📍 내 위치 기준으로 가까운 헬스장을 표시하고 있어요');
            // 거리순 자동 선택
            document.getElementById('sort').value = 'distance';
            //fetchData();
        },
        function(err) {
            showLocBanner('error', '위치 정보를 가져올 수 없습니다. 추천순으로 표시합니다.');
            document.getElementById('sort').value = 'recommend';
			//fetchData();
        },
        { timeout: 8000 }
    );
} else {
    showLocBanner('error', '이 브라우저는 위치 서비스를 지원하지 않습니다.');
    fetchData();
}

function showLocBanner(type, msg) {
    var b  = document.getElementById('locBanner');
    var d  = document.getElementById('locDot');
    var m  = document.getElementById('locMsg');
    var sp = document.getElementById('locSpinner');

    b.style.display = 'flex';
    m.textContent   = msg;

    if (type === 'loading') {
        b.classList.remove('error');
        d.className = 'loc-dot';
        sp.style.display = 'block';
        m.style.color = '#00897B';
    } else if (type === 'ok') {
        b.classList.remove('error');
        d.className = 'loc-dot';
        sp.style.display = 'none';
        m.style.color = '#00897B';
    } else {
        b.classList.add('error');
        d.className = 'loc-dot error';
        sp.style.display = 'none';
        m.style.color = '#BF6A38';
    }
}

/* ── 카테고리 선택 ─────────────────────────────────────────── */
function setCategory(c, el) {
    currentCategory = c;
    document.querySelectorAll('.cat-chip').forEach(function(b){ b.classList.remove('active'); });
    el.classList.add('active');
    fetchData();
}

/* ── 검색 debounce ─────────────────────────────────────────── */
document.getElementById('keyword').addEventListener('input', function() {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(fetchData, 400);
});
document.getElementById('sort').addEventListener('change', fetchData);

/* ── 헬스장 목록 AJAX 요청 ─────────────────────────────────── */
function fetchData() {
    var keyword = document.getElementById('keyword').value;
    var sort    = document.getElementById('sort').value;
    var spinner = document.getElementById('spinner');
    
    document.getElementById('keywordLoc').value = document.getElementById('keyword').value
    document.getElementById('sortLoc').value = document.getElementById('sort').value
    document.getElementById('categoryLoc').value = currentCategory
    document.getElementById('latLoc').value = userLat
    document.getElementById('lngLoc').value = userLng

    document.getElementById("locForm").submit();
    
<%--     var url = '<%=contextPath%>/member/gymList?ajax=true'
        + '&keyword=' + encodeURIComponent(keyword)
        + '&sort='    + encodeURIComponent(sort)
        + '&category='+ encodeURIComponent(currentCategory);

    // 위도/경도가 있으면 파라미터 추가
    if (userLat !== null && userLng !== null) {
        url += '&lat=' + userLat + '&lng=' + userLng;
    }

    spinner.style.display = 'block';

    fetch(url)
        .then(function(res){ return res.text(); })
        .then(function(html){
            document.getElementById('gymContainer').innerHTML = html;
            spinner.style.display = 'none';
            updateCount();
        })
        .catch(function(){ spinner.style.display = 'none'; }); --%>
}

function updateCount() {
    var cards = document.querySelectorAll('#gymContainer .gym-card');
    document.getElementById('countText').innerText = cards.length;
    document.getElementById('emptyState').style.display = cards.length === 0 ? 'block' : 'none';
}

window.onload = function(){ updateCount(); };
</script>
</body>
</html>
