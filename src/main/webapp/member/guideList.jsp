<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dto.member.ExerciseGuideDTO, dto.common.UserDTO" %>
<%
List<ExerciseGuideDTO> list =
    (List<ExerciseGuideDTO>) request.getAttribute("exerciseList");
if (list == null) list = new ArrayList<>();

UserDTO loginUser  = (UserDTO) session.getAttribute("loginUser");
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>운동 가이드 - FITSBURGH</title>
<style>
*{box-sizing:border-box;margin:0;padding:0;}

/* ✅ 수정1: body flex, main에 margin-left:260px → 사이드바 겹침 해결 */
body{
  font-family:'Segoe UI',sans-serif;
  background:#f4f6fa;color:#222;
  display:flex;min-height:100vh;
}
main{
  flex:1;
  margin-left:260px;                   /* 사이드바(260px)만큼 오른쪽으로 밀기 */
  max-width:calc(100vw - 260px);
  overflow-y:auto;
}
.page-wrap{padding:32px 36px;}
h2.section-title{font-size:22px;font-weight:700;margin-bottom:16px;}

/* 필터 */
.filter-row{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:10px;}
.chip{padding:6px 14px;border-radius:20px;border:1.5px solid #ddd;background:#fff;font-size:13px;cursor:pointer;transition:all .18s;}
.chip:hover{border-color:#ff6b35;color:#ff6b35;}
.chip.active{background:#ff6b35;color:#fff;border-color:#ff6b35;font-weight:600;}
.search-input{padding:9px 16px;border-radius:22px;border:1.5px solid #ddd;font-size:14px;outline:none;width:280px;margin-bottom:16px;}
.search-input:focus{border-color:#2563eb;}

/* 카드 그리드 */
.card-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:28px;}
@media(max-width:1200px){.card-grid{grid-template-columns:repeat(3,1fr);}}
@media(max-width:900px) {.card-grid{grid-template-columns:repeat(2,1fr);}}

/* ✅ 수정2: 카드 flex-column → 버튼 항상 하단 고정 */
.ex-card{
  background:#fff;border-radius:14px;border:2px solid transparent;
  overflow:hidden;cursor:pointer;transition:all .18s;
  box-shadow:0 2px 8px rgba(0,0,0,.07);
  display:flex;flex-direction:column;
}
.ex-card:hover{transform:translateY(-3px);box-shadow:0 6px 18px rgba(0,0,0,.12);}
.ex-card.selected{border-color:#2563eb;box-shadow:0 0 0 3px rgba(37,99,235,.15);}

.card-thumb{position:relative;width:100%;padding-bottom:63%;background:#e9eef5;overflow:hidden;flex-shrink:0;}
.card-thumb img{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;}
.gif-badge{position:absolute;bottom:8px;right:8px;background:rgba(0,0,0,.55);color:#fff;font-size:11px;font-weight:700;padding:2px 7px;border-radius:4px;}

/* ✅ 수정3: card-body flex + flex:1 → 버튼을 항상 하단에 */
.card-body{padding:12px 14px 14px;display:flex;flex-direction:column;flex:1;}
.card-name{font-size:15px;font-weight:700;margin-bottom:8px;}
.tag-row{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:10px;}
.tag{font-size:12px;padding:3px 9px;border-radius:12px;background:#f0f0f0;color:#555;font-weight:500;}
.tag.근력 {background:#fff0e8;color:#e06030;} .tag.유산소{background:#e8f0ff;color:#3060d0;}
.tag.초급 {background:#edfff1;color:#2d9f50;} .tag.중급 {background:#fff8e1;color:#b07000;} .tag.고급{background:#ffe8e8;color:#cc3333;}
.tag.가슴 {background:#fce8ff;color:#9030b0;} .tag.등  {background:#e8fff0;color:#208050;}
.tag.하체 {background:#e8f4ff;color:#2060a0;} .tag.어깨{background:#fff4e8;color:#b07030;}
.tag.전신 {background:#f0e8ff;color:#6030b0;} .tag.복근{background:#ffeef0;color:#c03050;}

/* ✅ 수정4: 카드 하단 버튼 영역 - margin-top:auto 로 항상 하단 */
.card-btns{
  display:flex;gap:8px;
  margin-top:auto;
  padding-top:10px;
  border-top:1px solid #f0f0f0;
}
.card-btn-video{
  flex:1;padding:9px 4px;
  border:1.5px solid #d0d5e0;background:#fff;
  border-radius:9px;font-size:12px;font-weight:600;color:#333;
  cursor:pointer;transition:all .18s;
  font-family:'Segoe UI',sans-serif;
}
.card-btn-video:hover{border-color:#2563eb;color:#2563eb;}
.card-btn-start{
  flex:1;padding:9px 4px;
  background:#2563eb;color:#fff;border:none;
  border-radius:9px;font-size:12px;font-weight:700;
  cursor:pointer;transition:background .18s;
  font-family:'Segoe UI',sans-serif;
}
.card-btn-start:hover{background:#1a4fc8;}

/* 상세 패널 */
#detail-panel{display:none;background:#fff;border-radius:16px;box-shadow:0 4px 20px rgba(0,0,0,.1);overflow:hidden;margin-bottom:28px;border:1px solid #e8eaf0;animation:slideDown .25s ease;}
@keyframes slideDown{from{opacity:0;transform:translateY(-10px);}to{opacity:1;transform:translateY(0);}}
.detail-top{display:grid;grid-template-columns:1fr 1fr;gap:0;}
@media(max-width:700px){.detail-top{grid-template-columns:1fr;}}
.detail-left{background:#1a1a2e;display:flex;flex-direction:column;}
.gif-wrap{position:relative;width:100%;padding-bottom:65%;background:#000;overflow:hidden;border-radius: 12px 0 0 0;}
.gif-wrap img{position:absolute;inset:0;width:100%;height:100%;object-fit:contain;}
.gif-label{position:absolute;bottom:10px;right:12px;background:rgba(0,0,0,.6);color:#fff;font-size:13px;font-weight:700;padding:3px 10px;border-radius:5px;}
.target-wrap{padding:18px 22px 22px;}
.target-title{font-size:13px;font-weight:700;color:#9ca3af;text-transform:uppercase;letter-spacing:1px;margin-bottom:12px;}
.muscle-figs{display:flex;gap:12px;justify-content:center;align-items:flex-end;}
.detail-right{padding:28px 30px;display:flex;flex-direction:column;justify-content:space-between;min-height:420px;}
.d-name{font-size:20px;font-weight:800;color:#111;margin-bottom:6px;}
.d-tags{display:flex;gap:7px;margin-bottom:20px;flex-wrap:wrap;}
.sec-title{font-size:14px;font-weight:700;color:#111;margin-bottom:7px;}
.sec-desc{font-size:14px;line-height:1.8;color:#444;margin-bottom:20px;}
.kp-list{list-style:none;margin-bottom:24px;}
.kp-list li{font-size:14px;color:#333;line-height:1.65;padding:6px 0 6px 22px;position:relative;border-bottom:1px solid #f2f2f2;}
.kp-list li:last-child{border-bottom:none;}
.kp-list li::before{content:"•";position:absolute;left:0;color:#2563eb;font-weight:900;font-size:18px;line-height:1.4;}
.btn-row{display:flex;gap:12px;}
.btn-video{flex:1;padding:13px;border:2px solid #d0d5e0;background:#fff;border-radius:10px;font-size:14px;font-weight:600;color:#333;cursor:pointer;transition:all .18s;}
.btn-video:hover{border-color:#2563eb;color:#2563eb;}
.btn-start{flex:1;padding:13px;background:#2563eb;color:#fff;border:none;border-radius:10px;font-size:14px;font-weight:700;cursor:pointer;transition:background .18s;}
.btn-start:hover{background:#1a4fc8;}
.empty-state{grid-column:1/-1;text-align:center;padding:80px 20px;}
.empty-state .icon{font-size:56px;margin-bottom:16px;}
.empty-state p{font-size:16px;color:#9DA8C0;font-weight:600;}
</style>
</head>
<body>

<jsp:include page="/member/sidebar.jsp"/>

<main>
<div class="page-wrap">

  <h1 style="font-size:26px;font-weight:900;color:#1A1F36;letter-spacing:-.5px;">운동 가이드 🎥</h1>
	<p style="font-size:14px;color:#9DA8C0;margin-top:4px;">운동에 도움이 되는 가이드입니다.</p>
	<p style="font-size:14px;color:#9DA8C0;">원하는 정보를 자유롭게 찾아보세요!</p>
	
  <input class="search-input" type="text" id="searchInput"
         placeholder="🔍 운동명 검색..." oninput="applyFilter()"
         style='margin-top:20px'>

  <div class="filter-row" id="muscleFilter">
    <% for (String m : new String[]{"전체","가슴","등","어깨","팔","전신","하체","복근"}) { %>
    <button class="chip <%=m.equals("전체")?"active":""%>"
            onclick="setMuscle('<%=m%>',this)"><%=m%></button>
    <% } %>
  </div>

  <div class="filter-row" style="margin-top:8px;" id="levelFilter">
    <% for (String lv : new String[]{"전체","초급","중급","고급"}) { %>
    <button class="chip <%=lv.equals("전체")?"active":""%>"
            onclick="setLevel('<%=lv%>',this)"><%=lv%></button>
    <% } %>
  </div>

  <br>

  <!-- 상세 패널 -->
  <div id="detail-panel">
    <div class="detail-top">
      <div class="detail-left">
        <div class="gif-wrap">
          <iframe id="d-video-iframe" src="" frameborder="0" allowfullscreen 
          	style="display:none; position:absolute; inset:0; width:100%; height:100%;"></iframe>
  
  		  <video id="d-video-file" controls playsinline
         	style="display:none; position:absolute; inset:0; width:100%; height:100%; object-fit:contain; background:#000;"></video>
  
  		 <img id="d-gif" src="" alt="운동" 
       		style="display:block; position:absolute; inset:0; width:100%; height:100%; object-fit:contain;">
        </div>
        <div class="target-wrap">
          <p class="target-title">Target Muscles</p>
          <div class="muscle-figs" id="muscle-figs"></div>
        </div>
      </div>
      <div class="detail-right">
        <div>
          <div class="d-name" id="d-name"></div>
          <div class="d-tags" id="d-tags"></div>
          <div class="sec-title">운동 설명</div>
          <p class="sec-desc" id="d-desc"></p>
          <div class="sec-title">핵심 자세 포인트</div>
          <ul class="kp-list" id="d-keypoints"></ul>
        </div>
        <div class="btn-row">
          <button class="btn-video" onclick="watchVideo()">📹 영상으로 보기</button>
          <button class="btn-start" onclick="startRecord()">기록 시작</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 카드 그리드 -->
  <div class="card-grid" id="card-grid">
  <%
  if (list.isEmpty()) {
  %>
    <div class="empty-state">
      <div class="icon">🏋️</div>
      <p>등록된 운동 가이드가 없습니다.</p>
      <p style="font-size:13px;margin-top:8px;">EXERCISE_GUIDE 테이블에 데이터를 추가해주세요.</p>
    </div>
  <%
  } else {
    for (ExerciseGuideDTO e : list) {
      String title  = e.getTitle()        != null ? e.getTitle()        : "";
      String muscle = e.getTargetMuscle() != null ? e.getTargetMuscle(): "";
      String image  = e.getImage()        != null ? e.getImage()        : "";
      String video  = e.getVideo()        != null ? e.getVideo()        : "";
      String typ    = e.getType()         != null ? e.getType()         : "";
      String dif    = e.getDifficulty()   != null ? e.getDifficulty()   : "";
      String desc   = e.getDescription()  != null
                      ? e.getDescription().replace("'","\\'")
                                          .replace("\r\n","\\n")
                                          .replace("\n","\\n") : "";
      String kp     = e.getKeyPoint()     != null ? e.getKeyPoint()     : "";
      String[] kpArr = kp.split("\\|");
      StringBuilder kpJson = new StringBuilder("[");
      for (int ki = 0; ki < kpArr.length; ki++) {
          kpJson.append("\"")
                .append(kpArr[ki].trim()
                    .replace("\\","\\\\").replace("\"","\\\"").replace("'","\\'"))
                .append("\"");
          if (ki < kpArr.length - 1) kpJson.append(",");
      }
      kpJson.append("]");

      String safeTitle = title.replace("'","\\'");
      String safeVideo = video.replace("'","\\'");
      int    eid       = e.getId();
  %>
    <div class="ex-card"
     data-id="<%=eid%>"
     data-name="<%=safeTitle%>"
     data-muscle="<%=muscle%>"
     data-level="<%=dif%>"
     data-type="<%=typ%>"
     data-video="<%=video%>"
     data-image="<%=image%>"
     data-desc="<%=desc%>"
     data-keypoints='<%=kpJson.toString()%>'
     onclick="openDetail(this)">

      <div class="card-thumb">
        <img src="<%= contextPath %>/uploads/<%=image%>" alt="<%=title%>"
             onerror="this.style.display='none';this.parentElement.style.background='#dee2e6'">
        <% if (!image.isEmpty()) { %>
        <% } %>
      </div>

      <div class="card-body">
        <div class="card-name"><%=title%></div>
        <div class="tag-row">
          <span class="tag <%=muscle%>"><%=muscle%></span>
          <span class="tag <%=typ%>"><%=typ%></span>
          <span class="tag <%=dif%>"><%=dif%></span>
        </div>

        <!-- ✅ 수정5: 카드 안에 버튼 직접 배치 (항상 하단 보임) -->
        <div class="card-btns" onclick="event.stopPropagation()">
          <button class="card-btn-start"
                  onclick="startRecordById(<%=eid%>)">기록 시작</button>
        </div>
      </div>
    </div>
  <%
    }
  }
  %>
  </div>

</div>

<% if (loginUser == null) { %>
<div style="position:fixed;bottom:0;left:260px;right:0;background:#2563eb;color:#fff;
            padding:13px 24px;display:flex;align-items:center;justify-content:center;
            gap:14px;font-size:14px;z-index:998;">
  <span>로그인 후 더 많은 기능을 이용하세요</span>
  <a href="<%=contextPath%>/member/login"
     style="background:#fff;color:#2563eb;padding:6px 18px;border-radius:6px;font-weight:700;text-decoration:none;">
    로그인
  </a>
</div>
<% } %>
</main>

<div id="video-modal"
     style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.78);
            z-index:9999;align-items:center;justify-content:center;"
     onclick="closeVideoOutside(event)">
  <div style="background:#000;border-radius:14px;overflow:hidden;max-width:720px;width:90%;position:relative;">
    <button onclick="closeVideo()"
            style="position:absolute;top:10px;right:12px;background:rgba(255,255,255,.15);border:none;
                   color:#fff;font-size:24px;cursor:pointer;border-radius:50%;width:34px;height:34px;
                   line-height:34px;text-align:center;">×</button>
    <iframe id="yt-frame" width="100%" height="405" src=""
            frameborder="0" allowfullscreen style="display:block;"></iframe>
  </div>
</div>

<script>
var curFilter = { muscle:'전체', level:'전체' };
var curYtUrl  = '';
var selCard   = null;

function setMuscle(v,el){
  curFilter.muscle = v;
  document.querySelectorAll('#muscleFilter .chip').forEach(function(b){b.classList.remove('active');});
  el.classList.add('active'); applyFilter();
}
function setLevel(v,el){
  curFilter.level = v;
  document.querySelectorAll('#levelFilter .chip').forEach(function(b){b.classList.remove('active');});
  el.classList.add('active'); applyFilter();
}
function applyFilter(){
  var kw = document.getElementById('searchInput').value.trim().toLowerCase();
  document.querySelectorAll('.ex-card').forEach(function(c){
    var mOk  = curFilter.muscle==='전체' || c.dataset.muscle===curFilter.muscle;
    var lOk  = curFilter.level ==='전체' || c.dataset.level ===curFilter.level;
    var kwOk = !kw || (c.dataset.name||'').toLowerCase().indexOf(kw)>=0;
    c.style.display = (mOk&&lOk&&kwOk)?'':'none';
  });
}

function showDetail(name, gifUrl, desc, ytUrl, muscle, type, diff, keypoints, cardEl) {
  if (selCard) selCard.classList.remove('selected');
  cardEl.classList.add('selected');
  selCard = cardEl;
  curYtUrl = ytUrl;

  document.getElementById('d-gif').src = gifUrl || '';
  document.getElementById('d-name').textContent = name;
  document.getElementById('d-tags').innerHTML =
    '<span class="tag '+muscle+'">'+muscle+'</span> '
    +'<span class="tag '+type+'">'+type+'</span> '
    +'<span class="tag '+diff+'">'+diff+'</span>';
  document.getElementById('d-desc').textContent = desc;

  var kpEl = document.getElementById('d-keypoints');
  kpEl.innerHTML = '';
  (Array.isArray(keypoints)?keypoints:[]).forEach(function(kp){
    if(!kp.trim()) return;
    var li = document.createElement('li');
    li.textContent = kp.trim();
    kpEl.appendChild(li);
  });

  document.getElementById('muscle-figs').innerHTML = buildFront(muscle) + buildBack(muscle);
  var panel = document.getElementById('detail-panel');
  panel.style.display = 'block';
  setTimeout(function(){ panel.scrollIntoView({behavior:'smooth',block:'start'}); }, 50);
}

function openVideoById(videoUrl){
  if(!videoUrl){ alert('영상 정보가 없습니다.'); return; }
  curYtUrl = videoUrl;
  watchVideo();
}

function openDetail(card){
	  if (selCard) selCard.classList.remove('selected');
	  card.classList.add('selected');
	  selCard = card;

	  const name = card.dataset.name;
	  const gifUrl = card.dataset.image;
	  const desc = card.dataset.desc;
	  const ytUrl = card.dataset.video;
	  const muscle = card.dataset.muscle;
	  const type = card.dataset.type;
	  const diff = card.dataset.level;
	  
	// 모든 미디어 엘리먼트 초기화 및 숨기기
	  const vIframe = document.getElementById('d-video-iframe');
	  const vFile = document.getElementById('d-video-file');
	  const imgGif = document.getElementById('d-gif');

	  vIframe.style.display = 'none';
	  vIframe.src = '';
	  vFile.style.display = 'none';
	  vFile.pause();
	  vFile.src = '';
	  imgGif.style.display = 'none';

	  // 영상 처리 로직
	  if (ytUrl && ytUrl.includes('youtube.com') || ytUrl.includes('youtu.be')) {
		// 유튜브 영상 ID 추출 정규식
	        const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
	        const match = ytUrl.match(regExp);
	        const videoId = (match && match[2].length === 11) ? match[2] : null;

	        if (videoId) {
	            // 임베드용 URL로 변환하여 할당
	            vIframe.src = "https://www.youtube.com/embed/" + videoId + "?rel=0&modestbranding=1";
	            vIframe.style.display = 'block';
	        } else {
	            // ID 추출 실패 시 기본 GIF 노출
	            imgGif.style.display = 'block';
	        }
	    } else if (ytUrl && ytUrl.trim() !== "") {
	        // 서버 내부의 일반 영상 파일(.mp4 등)인 경우
	        vFile.style.display = 'block';
	        vFile.src = "<%= contextPath %>/uploads/" + ytUrl;
	        vFile.load();
	    } else if (gifUrl) {
	        // 영상 정보가 전혀 없을 때 기존 GIF 이미지 노출
	        imgGif.style.display = 'block';
	        imgGif.src = "<%= contextPath %>/uploads/" + gifUrl;
	    }
	  

	  let keypoints = [];
	  try {
	    keypoints = JSON.parse(card.dataset.keypoints || "[]");
	  } catch(e){}

	  curYtUrl = ytUrl;

	  document.getElementById('d-gif').src = gifUrl || '';
	  document.getElementById('d-name').textContent = name;

	  document.getElementById('d-tags').innerHTML =
	    `<span class="tag ${muscle}">${muscle}</span>
	     <span class="tag ${type}">${type}</span>
	     <span class="tag ${diff}">${diff}</span>`;

	  document.getElementById('d-desc').textContent = desc;

	  const kpEl = document.getElementById('d-keypoints');
	  kpEl.innerHTML = '';
	  keypoints.forEach(kp => {
	    if(!kp) return;
	    const li = document.createElement('li');
	    li.textContent = kp;
	    kpEl.appendChild(li);
	  });

	  document.getElementById('muscle-figs').innerHTML =
	    buildFront(muscle) + buildBack(muscle);

	  const panel = document.getElementById('detail-panel');
	  panel.style.display = 'block';

	  setTimeout(() => {
	    panel.scrollIntoView({behavior:'smooth', block:'start'});
	  }, 50);
	}

function startRecordById(id){
  <% if (loginUser == null) { %>
  if(confirm('기록 시작은 로그인 후 이용 가능합니다.\n로그인 페이지로 이동할까요?'))
    location.href='<%=contextPath%>/member/login';
  <% } else { %>
  location.href='<%=contextPath%>/member/main';
  <% } %>
}

function watchVideo(){
  if(!curYtUrl){ alert('영상 정보가 없습니다.'); return; }
  document.querySelector('.gif-wrap').scrollIntoView({ behavior: 'smooth', block: 'center' });
}
function closeVideo(){
  document.getElementById('yt-frame').src='';
  document.getElementById('video-modal').style.display='none';
}
function closeVideoOutside(e){
  if(e.target===document.getElementById('video-modal')) closeVideo();
}
function startRecord(){
  <% if (loginUser == null) { %>
  if(confirm('기록 시작은 로그인 후 이용 가능합니다.\n로그인 페이지로 이동할까요?'))
    location.href='<%=contextPath%>/member/login';
  <% } else { %>
  location.href='<%=contextPath%>/member/main';
  <% } %>
}

var HL = {
  '가슴':{ f:['chest'],                                 b:[] },
  '등':  { f:[],                                        b:['back','lat'] },
  '어깨':{ f:['shoulder'],                               b:['shoulder'] },
  '팔':  { f:['bicep'],                                 b:['tricep'] },
  '하체':{ f:['quad','calf'],                           b:['hamstring','glute','calf'] },
  '전신':{ f:['chest','shoulder','bicep','quad','abs'], b:['back','lat','glute','hamstring'] },
  '복근':{ f:['abs'],                                   b:[] }
};
var ON='#3b82f6', OFF='#374151';
function fA(m,ids){ return ((HL[m]||{f:[]}).f.some(function(id){return ids.indexOf(id)>=0;}))?ON:OFF; }
function bA(m,ids){ return ((HL[m]||{b:[]}).b.some(function(id){return ids.indexOf(id)>=0;}))?ON:OFF; }

function buildFront(muscle){
  var c=fA(muscle,['chest']),ab=fA(muscle,['abs']),sh=fA(muscle,['shoulder']),
      bi=fA(muscle,['bicep']),qu=fA(muscle,['quad']),ca=fA(muscle,['calf']);
  return '<div style="text-align:center;"><p style="color:#9ca3af;font-size:11px;margin-bottom:4px;font-weight:600;letter-spacing:.5px;">FRONT</p>'
    +'<svg viewBox="0 0 100 200" width="95" height="185" xmlns="http://www.w3.org/2000/svg">'
    +'<ellipse cx="50" cy="14" rx="11" ry="12" fill="#4b5563"/><rect x="46" y="25" width="8" height="6" fill="#4b5563"/>'
    +'<path d="M30 31 Q50 27 70 31 L68 80 Q50 84 32 80 Z" fill="#374151"/>'
    +'<ellipse cx="43" cy="44" rx="10" ry="9" fill="'+c+'"/><ellipse cx="57" cy="44" rx="10" ry="9" fill="'+c+'"/>'
    +'<rect x="44" y="55" width="12" height="21" rx="3" fill="'+ab+'"/>'
    +'<ellipse cx="27" cy="35" rx="8" ry="7" fill="'+sh+'"/><ellipse cx="73" cy="35" rx="8" ry="7" fill="'+sh+'"/>'
    +'<rect x="17" y="42" width="9" height="24" rx="4" fill="'+bi+'"/><rect x="74" y="42" width="9" height="24" rx="4" fill="'+bi+'"/>'
    +'<rect x="15" y="67" width="8" height="18" rx="3" fill="#374151"/><rect x="77" y="67" width="8" height="18" rx="3" fill="#374151"/>'
    +'<path d="M32 80 Q50 86 68 80 L66 98 Q50 102 34 98 Z" fill="#374151"/>'
    +'<rect x="33" y="98" width="15" height="38" rx="6" fill="'+qu+'"/><rect x="52" y="98" width="15" height="38" rx="6" fill="'+qu+'"/>'
    +'<ellipse cx="40" cy="138" rx="7" ry="5" fill="#374151"/><ellipse cx="60" cy="138" rx="7" ry="5" fill="#374151"/>'
    +'<rect x="34" y="143" width="12" height="30" rx="5" fill="'+ca+'"/><rect x="54" y="143" width="12" height="30" rx="5" fill="'+ca+'"/>'
    +'<ellipse cx="40" cy="176" rx="8" ry="4" fill="#374151"/><ellipse cx="60" cy="176" rx="8" ry="4" fill="#374151"/>'
    +'</svg></div>';
}
function buildBack(muscle){
  var bk=bA(muscle,['back']),la=bA(muscle,['lat']),sh=bA(muscle,['shoulder']),
      tr=bA(muscle,['tricep']),gl=bA(muscle,['glute']),ha=bA(muscle,['hamstring']),ca=bA(muscle,['calf']);
  return '<div style="text-align:center;"><p style="color:#9ca3af;font-size:11px;margin-bottom:4px;font-weight:600;letter-spacing:.5px;">BACK</p>'
    +'<svg viewBox="0 0 100 200" width="95" height="185" xmlns="http://www.w3.org/2000/svg">'
    +'<ellipse cx="50" cy="14" rx="11" ry="12" fill="#4b5563"/><rect x="46" y="25" width="8" height="6" fill="#4b5563"/>'
    +'<path d="M30 31 Q50 27 70 31 L68 56 Q50 60 32 56 Z" fill="'+bk+'"/>'
    +'<path d="M32 56 Q50 60 68 56 L66 80 Q50 84 34 80 Z" fill="'+bk+'"/>'
    +'<path d="M30 38 Q20 52 22 72 L32 70 L32 38 Z" fill="'+la+'"/>'
    +'<path d="M70 38 Q80 52 78 72 L68 70 L68 38 Z" fill="'+la+'"/>'
    +'<ellipse cx="27" cy="35" rx="8" ry="7" fill="'+sh+'"/><ellipse cx="73" cy="35" rx="8" ry="7" fill="'+sh+'"/>'
    +'<rect x="17" y="42" width="9" height="24" rx="4" fill="'+tr+'"/><rect x="74" y="42" width="9" height="24" rx="4" fill="'+tr+'"/>'
    +'<rect x="15" y="67" width="8" height="18" rx="3" fill="#374151"/><rect x="77" y="67" width="8" height="18" rx="3" fill="#374151"/>'
    +'<path d="M32 80 Q50 86 68 80 L66 102 Q50 108 34 102 Z" fill="#374151"/>'
    +'<ellipse cx="41" cy="93" rx="11" ry="10" fill="'+gl+'"/><ellipse cx="59" cy="93" rx="11" ry="10" fill="'+gl+'"/>'
    +'<rect x="33" y="103" width="15" height="33" rx="6" fill="'+ha+'"/><rect x="52" y="103" width="15" height="33" rx="6" fill="'+ha+'"/>'
    +'<ellipse cx="40" cy="138" rx="7" ry="5" fill="#374151"/><ellipse cx="60" cy="138" rx="7" ry="5" fill="#374151"/>'
    +'<rect x="34" y="143" width="12" height="30" rx="5" fill="'+ca+'"/><rect x="54" y="143" width="12" height="30" rx="5" fill="'+ca+'"/>'
    +'<ellipse cx="40" cy="176" rx="8" ry="4" fill="#374151"/><ellipse cx="60" cy="176" rx="8" ry="4" fill="#374151"/>'
    +'</svg></div>';
}
</script>
</body>
</html>
