<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="keyword"  value="${param.keyword  != null ? param.keyword  : ''}"/>
<c:set var="category" value="${param.category != null ? param.category : '전체'}"/>
<c:set var="sort"     value="${param.sort     != null ? param.sort     : 'latest'}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>핏츠버그 - 트레이너 찾기</title>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;display:flex;min-height:100vh;}
::-webkit-scrollbar{width:6px;}
::-webkit-scrollbar-thumb{background:#FF6B35;border-radius:99px;}
.trainer-card{background:white;border-radius:20px;overflow:hidden;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.06);transition:all 0.25s ease;cursor:pointer;}
.trainer-card:hover{box-shadow:0 10px 32px rgba(0,0,0,0.13);transform:translateY(-4px);border-color:rgba(255,107,53,0.3);}
.cat-chip{padding:8px 18px;border-radius:99px;font-size:13px;font-weight:700;cursor:pointer;border:1.5px solid #E8EDF5;background:white;color:#5A6480;transition:all 0.2s;font-family:'Noto Sans KR',sans-serif;display:inline-block;white-space:nowrap;}
.cat-chip:hover{border-color:#FF6B35;color:#FF6B35;}
.cat-chip.active{background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;border-color:transparent;box-shadow:0 3px 12px rgba(255,107,53,0.3);}
.fb-search{flex:1;padding:13px 20px 13px 48px;border-radius:99px;border:2px solid #E8EDF5;background:white;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;transition:all 0.2s;box-shadow:0 2px 8px rgba(0,0,0,0.05);}
.fb-search:focus{border-color:#FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.12);}
.fb-search::placeholder{color:#C4CEDE;}
.fb-select{padding:13px 18px;border-radius:99px;border:2px solid #E8EDF5;background:white;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;cursor:pointer;transition:all 0.2s;min-width:130px;}
.fb-select:focus{border-color:#FF6B35;}
.spinner{display:none;width:32px;height:32px;border-radius:50%;border:3px solid #E8EDF5;border-top-color:#FF6B35;animation:spin 0.8s linear infinite;margin:0 auto;}
@keyframes spin{to{transform:rotate(360deg);}}
.spec-chip{display:inline-block;padding:3px 10px;border-radius:99px;font-size:10px;font-weight:700;background:#FFF0EB;color:#FF6B35;margin:2px 2px 0 0;}
</style>
</head>
<body>
<jsp:include page="sidebar.jsp"/>

<div style="flex:1;margin-left:260px;padding:32px 36px;max-width:calc(100vw - 260px);">

  <!-- 헤더 -->
  <div style="margin-bottom:28px;">
    <h1 style="font-size:26px;font-weight:900;color:#1A1F36;letter-spacing:-.5px;">트레이너 찾기 🏋️</h1>
    <p style="font-size:14px;color:#9DA8C0;margin-top:4px;">나에게 딱 맞는 트레이너를 찾아보세요!</p>
  </div>

  <!-- 검색 + 정렬 -->
  <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:20px 24px;margin-bottom:24px;">
    <div style="display:flex;gap:10px;margin-bottom:16px;">
      <div style="position:relative;flex:1;">
        <span class="material-symbols-outlined" style="position:absolute;left:18px;top:50%;transform:translateY(-50%);font-size:20px;color:#9DA8C0;">search</span>
        <input type="text" id="keyword" value="${fn:escapeXml(keyword)}"
               placeholder="트레이너명 검색..." class="fb-search"
               oninput="debounce(fetchData,400)"/>
      </div>
      <select id="sort" class="fb-select" onchange="fetchData()">
        <option value="latest" ${sort == 'latest' ? 'selected' : ''}>🕐 최신순</option>
        <option value="price"  ${sort == 'price'  ? 'selected' : ''}>💰 가격 낮은순</option>
      </select>
    </div>
    <!-- 카테고리 칩 -->
    <div style="display:flex;gap:8px;flex-wrap:wrap;">
      <button class="cat-chip ${category == '전체'      ? 'active' : ''}" onclick="setCategory('전체',this)">전체</button>
      <button class="cat-chip ${category == '근력'      ? 'active' : ''}" onclick="setCategory('근력',this)">근력</button>
      <button class="cat-chip ${category == '다이어트'   ? 'active' : ''}" onclick="setCategory('다이어트',this)">다이어트</button>
      <button class="cat-chip ${category == '체형교정'   ? 'active' : ''}" onclick="setCategory('체형교정',this)">체형교정</button>
      <button class="cat-chip ${category == '벌크업'     ? 'active' : ''}" onclick="setCategory('벌크업',this)">벌크업</button>
      <button class="cat-chip ${category == '재활'      ? 'active' : ''}" onclick="setCategory('재활',this)">재활</button>
      <button class="cat-chip ${category == '필라테스'   ? 'active' : ''}" onclick="setCategory('필라테스',this)">필라테스</button>
      <button class="cat-chip ${category == '크로스핏'   ? 'active' : ''}" onclick="setCategory('크로스핏',this)">크로스핏</button>
    </div>
  </div>

  <!-- 결과 카운트 + 스피너 -->
  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
    <div style="font-size:14px;color:#5A6480;font-weight:600;">
      총 <span id="countText" style="color:#FF6B35;font-weight:900;">${fn:length(trainerList)}</span>명의 트레이너
    </div>
    <div class="spinner" id="spinner"></div>
  </div>

  <!-- 카드 그리드 -->
  <div id="trainerContainer" style="display:grid;grid-template-columns:repeat(4,1fr);gap:18px;">
    <c:choose>
      <c:when test="${empty trainerList}">
        <div style="grid-column:1/-1;text-align:center;padding:80px 20px;">
          <div style="font-size:50px;margin-bottom:16px;">🏋️</div>
          <div style="font-size:18px;font-weight:800;color:#1A1F36;margin-bottom:8px;">등록된 트레이너가 없습니다</div>
          <div style="font-size:14px;color:#9DA8C0;">검색 조건을 변경하거나 나중에 다시 시도해주세요</div>
        </div>
      </c:when>
      <c:otherwise>
        <c:forEach var="t" items="${trainerList}">
          <c:set var="specs" value="${fn:split(t.specialty, ', ')}"/>
          <div class="trainer-card"
               onclick="location.href='${pageContext.request.contextPath}/member/trainerDetail?trainerId=${t.id}'">

            <!-- 프로필 이미지 -->
            <div style="position:relative;overflow:hidden;height:220px;background:#F0F4FF;">
              <img src="${not empty t.profileImg ? pageContext.request.contextPath.concat('/trainer/profile-img/').concat(t.profileImg) : ''}"
                   style="width:100%;height:100%;object-fit:cover;transition:transform 0.3s;"
                   onmouseover="this.style.transform='scale(1.05)'"
                   onmouseout="this.style.transform='scale(1)'"
                   onerror="this.src='https://api.dicebear.com/7.x/avataaars/svg?seed=${fn:escapeXml(t.name)}'"
                   alt="${fn:escapeXml(t.name)}"/>

              <!-- 첫 번째 전문 분야 뱃지 -->
              <c:if test="${not empty t.specialty}">
                <span style="position:absolute;top:10px;left:10px;padding:5px 12px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:11px;font-weight:800;">
                  ${specs[0]}
                </span>
              </c:if>

              <!-- 인증 뱃지 -->
              <c:if test="${t.isVerified == 1}">
                <div style="position:absolute;top:10px;right:10px;background:rgba(0,191,165,0.9);color:white;padding:4px 10px;border-radius:99px;font-size:11px;font-weight:700;">
                  ✓ 인증
                </div>
              </c:if>
            </div>

            <!-- 카드 내용 -->
            <div style="padding:16px 18px 18px;">
              <h3 style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:2px;">${fn:escapeXml(t.name)}</h3>

              <!-- 활동 유형 -->
              <p style="font-size:11px;color:#9DA8C0;margin-bottom:8px;">
                <c:choose>
                  <c:when test="${t.trainerType == 'GYM_EMPLOYED'}">헬스장 소속</c:when>
                  <c:when test="${t.trainerType == 'GYM_RENTAL'}">헬스장 임대</c:when>
                  <c:otherwise>프리랜서</c:otherwise>
                </c:choose>
                <c:if test="${not empty t.address}">
                  &nbsp;· ${fn:substring(t.address, 0, fn:length(t.address) > 15 ? 15 : fn:length(t.address))}
                </c:if>
              </p>

              <!-- 전문 분야 칩 -->
              <c:if test="${not empty t.specialty}">
                <div style="margin-bottom:10px;">
                  <c:forEach var="s" items="${specs}" begin="0" end="2">
                    <span class="spec-chip">${s}</span>
                  </c:forEach>
                </div>
              </c:if>

              <!-- 가격 -->
              <div style="display:flex;justify-content:space-between;align-items:center;padding:10px 12px;background:#F7F9FC;border-radius:10px;margin-bottom:12px;">
                <span style="font-size:12px;color:#9DA8C0;font-weight:600;">최저가</span>
                <c:choose>
                  <c:when test="${t.minPrice > 0}">
                    <span style="font-size:15px;font-weight:900;color:#1A1F36;">
                      <fmt:formatNumber value="${t.minPrice}" pattern="#,###"/>원~
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span style="font-size:13px;font-weight:700;color:#9DA8C0;">가격 미등록</span>
                  </c:otherwise>
                </c:choose>
              </div>

              <!-- 상세보기 버튼 -->
              <form action="${pageContext.request.contextPath}/member/trainerDetail">
              <input type="hidden" name="trainerId" value="${t.id}"/>
              <button style="width:100%;padding:10px;border-radius:12px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:13px;font-weight:700;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 12px rgba(255,107,53,0.3);transition:all 0.2s;"
                      onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">
                상세보기 →
              </button>
              </form>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>

</div>

<script>
let currentCategory = '${fn:escapeXml(category)}';
let debounceTimer;

function debounce(fn, delay) {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(fn, delay);
}

function setCategory(c, el) {
  currentCategory = c;
  document.querySelectorAll('.cat-chip').forEach(b => b.classList.remove('active'));
  el.classList.add('active');
  fetchData();
}

function fetchData() {
  const kw   = document.getElementById('keyword').value;
  const sort = document.getElementById('sort').value;
  const sp   = document.getElementById('spinner');
  sp.style.display = 'block';

  const url = '${pageContext.request.contextPath}/member/trainerList?ajax=true'
    + '&keyword='  + encodeURIComponent(kw)
    + '&sort='     + encodeURIComponent(sort)
    + '&category=' + encodeURIComponent(currentCategory);

  fetch(url)
    .then(r => r.text())
    .then(html => {
      document.getElementById('trainerContainer').innerHTML = html;
      sp.style.display = 'none';
      document.getElementById('countText').innerText =
        document.querySelectorAll('#trainerContainer .trainer-card').length;
    })
    .catch(() => { sp.style.display = 'none'; });
}
</script>
</body>
</html>
