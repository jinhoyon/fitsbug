<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
  <c:when test="${empty trainerList}">
    <div style="grid-column:1/-1;text-align:center;padding:60px 20px;">
      <div style="font-size:50px;margin-bottom:16px;">🏋️</div>
      <div style="font-size:18px;font-weight:800;color:#1A1F36;margin-bottom:8px;">등록된 트레이너가 없습니다</div>
      <div style="font-size:14px;color:#9DA8C0;">검색 조건을 변경해보세요</div>
    </div>
  </c:when>
  <c:otherwise>
    <c:forEach var="t" items="${trainerList}">
      <c:set var="specs" value="${fn:split(t.specialty, ', ')}"/>
      <div class="trainer-card"
           onclick="location.href='${pageContext.request.contextPath}/member/trainerDetail?trainerId=${t.id}'">

        <!-- 프로필 이미지 -->
        <div style="position:relative;overflow:hidden;height:220px;background:#F0F4FF;">
          <img src="${not empty t.profileImg ? pageContext.request.contextPath.concat('/uploads/').concat(t.profileImg) : ''}"
               style="width:100%;height:100%;object-fit:cover;transition:transform 0.3s;"
               onmouseover="this.style.transform='scale(1.05)'"
               onmouseout="this.style.transform='scale(1)'"
               onerror="this.src='https://api.dicebear.com/7.x/avataaars/svg?seed=${fn:escapeXml(t.name)}'"
               alt="${fn:escapeXml(t.name)}"/>

          <c:if test="${not empty t.specialty}">
            <span style="position:absolute;top:10px;left:10px;padding:5px 12px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:11px;font-weight:800;">
              ${specs[0]}
            </span>
          </c:if>

          <c:if test="${t.isVerified == 1}">
            <div style="position:absolute;top:10px;right:10px;background:rgba(0,191,165,0.9);color:white;padding:4px 10px;border-radius:99px;font-size:11px;font-weight:700;">
              ✓ 인증
            </div>
          </c:if>
        </div>

        <!-- 카드 내용 -->
        <div style="padding:16px 18px 18px;">
          <h3 style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:2px;">${fn:escapeXml(t.name)}</h3>

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

          <c:if test="${not empty t.specialty}">
            <div style="margin-bottom:10px;">
              <c:forEach var="s" items="${specs}" begin="0" end="2">
                <span style="display:inline-block;padding:3px 10px;border-radius:99px;font-size:10px;font-weight:700;background:#FFF0EB;color:#FF6B35;margin:2px 2px 0 0;">${s}</span>
              </c:forEach>
            </div>
          </c:if>

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

          <button style="width:100%;padding:10px;border-radius:12px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:13px;font-weight:700;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 12px rgba(255,107,53,0.3);transition:all 0.2s;"
                  onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">
            상세보기 →
          </button>
        </div>
      </div>
    </c:forEach>
  </c:otherwise>
</c:choose>
