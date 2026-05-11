<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.member.UserDTO" %>
<%
UserDTO loginUser = (UserDTO)(session.getAttribute("loginUser"));
String contextPath = request.getContextPath();
String errorMsg = (String) request.getAttribute("errorMsg");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 헬스장 입점 신청</title>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<!-- 다음 우편번호 서비스 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
*,*::before,*::after { box-sizing:border-box; margin:0; padding:0; }
body {
    font-family:'Noto Sans KR','Nunito',sans-serif;
    background:#F7F9FC; min-height:100vh; display:flex;
}
.form-side {
    width:52%; display:flex; flex-direction:column;
    justify-content:center; padding:60px 56px; overflow-y:auto;
}
.brand-side {
    flex:1;
    background:linear-gradient(145deg,#00897B 0%,#00BFA5 50%,#26D4BB 100%);
    position:relative; overflow:hidden; display:flex;
    flex-direction:column; align-items:center; justify-content:center;
    padding:60px 48px;
}
.brand-side::before {
    content:''; position:absolute; width:500px; height:500px;
    border-radius:50%; background:rgba(255,255,255,0.07);
    top:-100px; right:-80px;
}
/* 인풋 공통 */
.fb-inp {
    width:100%; padding:13px 18px; border-radius:14px;
    border:2px solid #E8EDF5; background:#F7F9FC;
    font-family:'Noto Sans KR',sans-serif; font-size:14px;
    color:#1A1F36; outline:none; transition:all 0.2s;
}
.fb-inp:focus {
    border-color:#00BFA5;
    box-shadow:0 0 0 3px rgba(0,191,165,0.15);
    background:white;
}
.fb-inp::placeholder { color:#C4CEDE; }
.fb-inp:read-only {
    background:#F0F3F7; cursor:default; color:#7A8499;
}
/* 주소 버튼 */
.addr-btn {
    padding:13px 20px; border-radius:14px; border:none; cursor:pointer;
    background:linear-gradient(135deg,#00BFA5,#26D4BB); color:white;
    font-family:'Noto Sans KR',sans-serif; font-size:14px; font-weight:700;
    white-space:nowrap; transition:all 0.2s; flex-shrink:0;
}
.addr-btn:hover { transform:translateY(-1px); box-shadow:0 4px 12px rgba(0,191,165,0.35); }
/* 주소 상태 표시 */
.addr-status {
    display:none; align-items:center; gap:8px;
    padding:10px 14px; border-radius:10px;
    font-size:13px; font-weight:600;
}
.addr-status.ok  { background:#E8F8F4; color:#00897B; border:1.5px solid #B2DFDB; }
.addr-status.err { background:#FFF3F3; color:#C62828; border:1.5px solid #FFCDD2; }
/* 좌표 미리보기 */
.coord-box {
    display:none;
    background:#E8F8F4; border:1.5px solid #B2DFDB;
    border-radius:10px; padding:10px 14px;
    font-size:12px; color:#00695C; font-weight:600;
    line-height:1.6;
}
/* 라벨 */
.lbl {
    font-size:13px; font-weight:700; color:#5A6480;
    display:block; margin-bottom:7px;
}
/* 필수 표시 */
.req { color:#FF6B35; margin-left:2px; }
/* 오류 배너 */
.err-banner {
    background:#FFF3F3; border:1.5px solid #FFCDD2;
    border-radius:12px; padding:12px 16px;
    font-size:13px; color:#C62828; font-weight:600;
    margin-bottom:16px; display:flex; align-items:center; gap:8px;
}
@media(max-width:768px) { .brand-side{display:none;} .form-side{width:100%;padding:40px 28px;} }
</style>
</head>
<body>

<!-- ── 왼쪽: 폼 ── -->
<div class="form-side">

  <a href="<%=contextPath%>/member/login"
     style="display:flex;align-items:center;gap:10px;text-decoration:none;margin-bottom:32px;">
    <div style="width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#00BFA5);display:flex;align-items:center;justify-content:center;font-size:18px;">🐾</div>
    <span style="font-family:'Nunito',sans-serif;font-size:22px;font-weight:900;background:linear-gradient(135deg,#FF6B35,#00BFA5);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">핏츠버그</span>
  </a>

  <!-- 역할 탭 -->
  <div style="display:flex;gap:8px;margin-bottom:28px;">
    <button onclick="location.href='<%=contextPath%>/member/join'"
            style="padding:10px 22px;border-radius:99px;border:2px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;">🏃 일반 회원</button>
    <button onclick="location.href='<%=contextPath%>/member/trainerJoin'"
            style="padding:10px 22px;border-radius:99px;border:2px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;">🏋️ 트레이너</button>
    <button style="padding:10px 22px;border-radius:99px;border:none;background:linear-gradient(135deg,#00BFA5,#26D4BB);color:white;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 14px rgba(0,191,165,0.3);">🏢 헬스장</button>
  </div>

  <h1 style="font-size:28px;font-weight:900;color:#1A1F36;margin-bottom:6px;">헬스장 입점 신청 🏢</h1>
  <p style="font-size:14px;color:#9DA8C0;margin-bottom:28px;">핏츠버그 파트너 헬스장으로 더 많은 회원을 만나보세요!</p>

  <!-- 오류 배너 -->
  <% if (errorMsg != null) { %>
  <div class="err-banner">⚠️ <%=errorMsg%></div>
  <% } %>

  <form id="gymJoinForm" action="<%=contextPath%>/member/gymJoin" method="post"
        style="display:flex;flex-direction:column;gap:16px;max-width:440px;"
        onsubmit="return validateForm()">

    <!-- 이메일 -->
    <div>
      <label class="lbl">아이디 (이메일)<span class="req">*</span></label>
      <input name="username" class="fb-inp" type="email"
             placeholder="관리자 이메일 주소" autocomplete="email" required>
    </div>

    <!-- 비밀번호 -->
    <div>
      <label class="lbl">비밀번호<span class="req">*</span></label>
      <input name="password" class="fb-inp" type="password"
             placeholder="비밀번호 (8자 이상)" autocomplete="new-password" required minlength="8">
    </div>

    <!-- 헬스장 이름 -->
    <div>
      <label class="lbl">헬스장 이름 / 상호명<span class="req">*</span></label>
      <input name="gymName" class="fb-inp" placeholder="예: 더 프라임 피트니스 강남점" required>
    </div>

    <!-- ════════════════════════════════════════════════════════
         헬스장 주소 (다음 우편번호 + 카카오 지오코딩)
    ════════════════════════════════════════════════════════ -->
    <div>
      <label class="lbl">헬스장 주소<span class="req">*</span></label>

      <!-- 우편번호 + 검색 버튼 -->
      <div style="display:flex;gap:8px;margin-bottom:8px;">
        <input id="postcode" name="postcode" class="fb-inp"
               style="width:140px;flex-shrink:0;"
               placeholder="우편번호" readonly required>
        <button type="button" class="addr-btn" onclick="openPostcode()">
          🔍 주소 검색
        </button>
      </div>

      <!-- 기본 주소 (자동 입력) -->
      <input id="address" name="address" class="fb-inp"
             style="margin-bottom:8px;"
             placeholder="기본 주소 (우편번호 검색 후 자동 입력)" readonly required>

      <!-- 상세 주소 (직접 입력) -->
      <input id="addressDetail" name="addressDetail" class="fb-inp"
             placeholder="상세 주소 입력 (예: 3층, B동 201호)">

      <!-- 주소 상태 메시지 -->
      <div id="addrStatus" class="addr-status"></div>

      <!-- 위도/경도 좌표 미리보기 -->
      <div id="coordBox" class="coord-box">
        📍 위도: <span id="latDisplay"></span> / 경도: <span id="lngDisplay"></span>
        <br><span style="font-size:11px;color:#26A69A;">카카오 맵으로 자동 취득된 좌표입니다</span>
      </div>

      <!-- hidden: 위도/경도 (JS에서 채움) -->
      <input type="hidden" id="lat" name="lat">
      <input type="hidden" id="lng" name="lng">
    </div>

    <!-- 대표 연락처 -->
    <div>
      <label class="lbl">대표 연락처<span class="req">*</span></label>
      <input name="phone" class="fb-inp" placeholder="02-0000-0000 또는 010-0000-0000" required>
    </div>

    <!-- 대표자 이름 -->
    <div>
      <label class="lbl">대표자 이름<span class="req">*</span></label>
      <input name="ceo" class="fb-inp" placeholder="사업자 등록상 대표자명" required>
    </div>

    <!-- 제출 버튼 -->
    <button type="submit" id="submitBtn"
            style="margin-top:6px;width:100%;padding:14px;border:none;border-radius:99px;
                   cursor:pointer;background:linear-gradient(135deg,#00BFA5,#26D4BB);
                   color:white;font-family:'Noto Sans KR',sans-serif;font-size:16px;
                   font-weight:800;box-shadow:0 6px 20px rgba(0,191,165,0.35);
                   transition:all 0.2s;"
            onmouseover="this.style.transform='translateY(-2px)'"
            onmouseout="this.style.transform='none'">
      🚀 입점 신청하기
    </button>

    <p style="text-align:center;font-size:14px;color:#9DA8C0;">
      이미 계정이 있으신가요?
      <a href="<%=contextPath%>/member/login"
         style="color:#00BFA5;font-weight:700;text-decoration:none;">로그인하기 →</a>
    </p>

  </form>
</div>

<!-- ── 오른쪽: 브랜드 ── -->
<div class="brand-side">
  <div style="position:relative;z-index:1;text-align:center;margin-bottom:32px;">
    <div style="font-size:60px;margin-bottom:16px;">🏢</div>
    <div style="font-family:'Nunito',sans-serif;font-size:32px;font-weight:900;color:white;letter-spacing:-0.5px;margin-bottom:8px;">헬스장 파트너</div>
    <div style="font-size:14px;color:rgba(255,255,255,0.85);line-height:1.6;">핏츠버그와 함께 더 많은 회원을<br>효율적으로 유치하세요</div>
  </div>

  <div style="position:relative;z-index:1;display:flex;flex-direction:column;gap:12px;width:100%;max-width:300px;">
    <% String[][] bens = {
        {"📈","회원 유입 증가","검색 노출 최적화로 신규 회원 유치"},
        {"🗓","예약 시스템 제공","PT 수업 예약을 자동으로 관리"},
        {"📊","데이터 대시보드","이용자 통계와 혼잡도 분석 제공"},
        {"✅","인증 헬스장 뱃지","사업자 인증으로 신뢰도 강화"}
    };
    for (String[] b : bens) { %>
    <div style="background:rgba(255,255,255,0.15);backdrop-filter:blur(8px);border:1.5px solid rgba(255,255,255,0.25);border-radius:14px;padding:14px 18px;display:flex;align-items:center;gap:14px;">
      <div style="font-size:22px;flex-shrink:0;"><%=b[0]%></div>
      <div>
        <div style="font-size:13px;font-weight:800;color:white;"><%=b[1]%></div>
        <div style="font-size:11px;color:rgba(255,255,255,0.75);margin-top:2px;"><%=b[2]%></div>
      </div>
    </div>
    <% } %>
  </div>

  <div style="position:relative;z-index:1;margin-top:22px;background:rgba(255,255,255,0.15);backdrop-filter:blur(8px);border-radius:14px;padding:14px 20px;text-align:center;">
    <div style="font-size:22px;font-weight:900;color:white;">200+</div>
    <div style="font-size:12px;color:rgba(255,255,255,0.8);font-weight:600;">파트너 헬스장 운영 중</div>
  </div>
</div>

<script>
// ════════════════════════════════════════════════════════════════
//  카카오 REST API 키 (본인 키로 교체)
//  https://developers.kakao.com → 내 애플리케이션 → REST API 키
// ════════════════════════════════════════════════════════════════
var KAKAO_REST_KEY = '8f4eb9739b20ebd5580366d6839c08af';

/* ── ① 다음 우편번호 팝업 열기 ─────────────────────────────── */
function openPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {

            // 우편번호
            document.getElementById('postcode').value = data.zonecode;

            // 기본 주소 결정 (도로명 우선, 없으면 지번)
            var addr = data.roadAddress || data.jibunAddress;
            document.getElementById('address').value = addr;

            // 상세 주소 포커스
            document.getElementById('addressDetail').focus();

            // 상태 표시: 지오코딩 중
            setStatus('loading', '🔄 좌표 변환 중...');

            // ② 카카오 지오코딩으로 위도/경도 취득
            geocodeAddress(addr);
        }
    }).open();
}

/* ── ② 카카오 지오코딩 (REST API) ──────────────────────────── */
function geocodeAddress(address) {
    var url = 'https://dapi.kakao.com/v2/local/search/address.json'
            + '?query=' + encodeURIComponent(address);

    fetch(url, {
        method: 'GET',
        headers: { 'Authorization': 'KakaoAK ' + KAKAO_REST_KEY }
    })
    .then(function(res) {
        if (!res.ok) throw new Error('API 응답 오류: ' + res.status);
        return res.json();
    })
    .then(function(json) {
        if (!json.documents || json.documents.length === 0) {
            throw new Error('주소 결과 없음');
        }

        var doc = json.documents[0];
        var lat, lng;

        // road_address 우선, 없으면 address
        if (doc.road_address) {
            lat = doc.road_address.y;
            lng = doc.road_address.x;
        } else {
            lat = doc.y;
            lng = doc.x;
        }

        // hidden input에 저장
        document.getElementById('lat').value = lat;
        document.getElementById('lng').value = lng;

        // 좌표 미리보기
        document.getElementById('latDisplay').textContent = parseFloat(lat).toFixed(6);
        document.getElementById('lngDisplay').textContent = parseFloat(lng).toFixed(6);
        document.getElementById('coordBox').style.display  = 'block';

        // 성공 상태
        setStatus('ok', '✅ 주소가 확인되었습니다. 상세 주소를 입력해 주세요.');
    })
    .catch(function(err) {
        console.error('지오코딩 실패:', err);
        document.getElementById('lat').value = '';
        document.getElementById('lng').value = '';
        document.getElementById('coordBox').style.display = 'none';
        setStatus('err', '⚠️ 좌표 변환 실패: 주소를 다시 검색해 주세요.');
    });
}

/* ── 상태 표시 헬퍼 ─────────────────────────────────────────── */
function setStatus(type, msg) {
    var el = document.getElementById('addrStatus');
    el.className = 'addr-status ' + (type === 'ok' ? 'ok' : 'err');
    el.style.display = 'flex';
    el.textContent   = msg;
}

/* ── 폼 제출 전 검증 ────────────────────────────────────────── */
function validateForm() {
    var lat = document.getElementById('lat').value;
    var lng = document.getElementById('lng').value;
    var postcode = document.getElementById('postcode').value;

    if (!postcode || !lat || !lng) {
        setStatus('err', '⚠️ 주소 검색을 완료한 후 신청해 주세요.');
        document.getElementById('postcode').scrollIntoView({behavior:'smooth'});
        return false;
    }

    // 제출 버튼 비활성화 (중복 클릭 방지)
    document.getElementById('submitBtn').disabled = true;
    document.getElementById('submitBtn').textContent = '⏳ 처리 중...';
    return true;
}
</script>
</body>
</html>
