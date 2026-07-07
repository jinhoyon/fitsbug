<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="t"   value="${trainer}"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>핏츠버그 - ${fn:escapeXml(t.name)} 트레이너</title>
<script src="https://js.tosspayments.com/v1"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;display:flex;min-height:100vh;}
.pkg-label{display:flex;align-items:center;justify-content:space-between;padding:16px 18px;border:2px solid #E8EDF5;border-radius:14px;cursor:pointer;transition:all 0.2s;}
.pkg-label:hover{border-color:#FF6B35;background:#FFF9F7;}
.pkg-label.selected{border-color:#FF6B35;background:#FFF9F7;}
.review-card{background:white;border:1.5px solid #E8EDF5;border-radius:16px;padding:18px;}
@keyframes fb_modal_in{from{opacity:0;transform:scale(0.9) translateY(20px);}to{opacity:1;transform:scale(1) translateY(0);}}
</style>
</head>
<body>

<jsp:include page="sidebar.jsp"/>

<main style="flex:1;margin-left:260px;max-width:calc(100vw - 260px);">

  <!-- 커버 배너 -->
  <div style="background:linear-gradient(135deg,#FF6B35 0%,#FF8C5A 50%,#00BFA5 100%);padding:40px 48px;position:relative;overflow:hidden;">
    <div style="position:absolute;width:400px;height:400px;border-radius:50%;background:rgba(255,255,255,0.07);top:-100px;right:-60px;"></div>
    <div style="position:relative;z-index:1;display:flex;align-items:center;gap:28px;">

      <!-- 프로필 이미지 -->
      <img src="${not empty t.profileImg ? ctx.concat('/uploads/').concat(t.profileImg) : ''}"
           style="width:110px;height:110px;border-radius:50%;border:4px solid white;object-fit:cover;box-shadow:0 8px 24px rgba(0,0,0,0.2);"
           onerror="this.src='https://api.dicebear.com/7.x/avataaars/svg?seed=${fn:escapeXml(t.name)}'"
           alt="${fn:escapeXml(t.name)}"/>

      <div>
        <div style="font-size:13px;color:rgba(255,255,255,0.8);font-weight:600;margin-bottom:6px;">
          <c:choose>
            <c:when test="${t.trainerType == 'GYM_EMPLOYED'}">헬스장 소속 트레이너</c:when>
            <c:when test="${t.trainerType == 'GYM_RENTAL'}">헬스장 임대 트레이너</c:when>
            <c:otherwise>프리랜서 트레이너</c:otherwise>
          </c:choose>
        </div>
        <h1 style="font-size:32px;font-weight:900;color:white;margin-bottom:10px;">
          ${fn:escapeXml(t.name)} 트레이너
          <c:if test="${t.isVerified == 1}">
            <span style="font-size:14px;background:rgba(0,191,165,0.85);padding:4px 12px;border-radius:99px;vertical-align:middle;margin-left:8px;">✓ 인증</span>
          </c:if>
        </h1>
        <div style="display:flex;gap:10px;flex-wrap:wrap;">
          <c:forEach var="s" items="${specList}">
            <span style="background:rgba(255,255,255,0.2);backdrop-filter:blur(6px);border:1.5px solid rgba(255,255,255,0.3);padding:5px 14px;border-radius:99px;font-size:13px;font-weight:700;color:white;">
              ${fn:escapeXml(s.type)}
            </span>
          </c:forEach>
          <c:if test="${empty specList}">
            <span style="background:rgba(255,255,255,0.2);padding:5px 14px;border-radius:99px;font-size:13px;font-weight:700;color:white;">💪 트레이너</span>
          </c:if>
        </div>
      </div>
    </div>
  </div>

  <!-- 본문 그리드 -->
  <div style="padding:32px 48px;display:grid;grid-template-columns:1fr 340px;gap:28px;align-items:start;">

    <!-- 왼쪽 -->
    <div style="display:flex;flex-direction:column;gap:22px;">

      <!-- 트레이너 소개 -->
      <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
        <h2 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:14px;">👋 트레이너 소개</h2>
        <c:choose>
          <c:when test="${not empty t.description}">
            <p style="font-size:14px;color:#5A6480;line-height:1.8;">${fn:escapeXml(t.description)}</p>
          </c:when>
          <c:otherwise>
            <p style="font-size:14px;color:#9DA8C0;line-height:1.8;">아직 소개글이 없습니다.</p>
          </c:otherwise>
        </c:choose>
        <c:if test="${not empty t.address}">
          <div style="margin-top:14px;display:flex;align-items:center;gap:6px;font-size:13px;color:#5A6480;">
            <span class="material-symbols-outlined" style="font-size:16px;color:#FF6B35;">location_on</span>
            ${fn:escapeXml(t.address)}
          </div>
        </c:if>
      </div>

      <!-- PT 이용권 선택 -->
      <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
        <h2 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:18px;">🎫 PT 이용권 선택</h2>
        <c:choose>
          <c:when test="${empty pricingList}">
            <p style="font-size:14px;color:#9DA8C0;text-align:center;padding:20px 0;">등록된 이용권이 없습니다.</p>
          </c:when>
          <c:otherwise>
            <div style="display:flex;flex-direction:column;gap:12px;" id="ptPackages">
              <c:forEach var="pkg" items="${pricingList}" varStatus="st">
                <label class="pkg-label ${st.first ? 'selected' : ''}"
                       onclick="selectPkg(this, '${fn:escapeXml(pkg.label)}', ${pkg.price})">
                  <div style="display:flex;align-items:center;gap:14px;">
                    <input type="radio" name="ptPkg" value="${pkg.price}"
                           data-name="${fn:escapeXml(pkg.label)}"
                           data-count="${pkg.sessionCount}"
                           style="accent-color:#FF6B35;width:18px;height:18px;"
                           ${st.first ? 'checked' : ''}/>
                    <div>
                      <div style="font-weight:800;font-size:14px;color:#1A1F36;">
                        ${fn:escapeXml(pkg.label)}
                        <c:if test="${pkg.popular}">
                          <span style="font-size:12px;margin-left:6px;padding:2px 8px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FFD166);color:white;">🔥 인기</span>
                        </c:if>
                      </div>
                      <c:if test="${pkg.sessionCount > 1}">
                        <div style="font-size:12px;color:#9DA8C0;margin-top:2px;">${pkg.sessionCount}회</div>
                      </c:if>
                    </div>
                  </div>
                  <div style="font-size:16px;font-weight:900;color:#FF6B35;">
                    <fmt:formatNumber value="${pkg.price}" pattern="#,###"/>원
                  </div>
                </label>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 자격증 -->
      <c:if test="${not empty certList}">
        <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
          <h2 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:16px;">🏅 자격증 / 경력</h2>
          <div style="display:flex;flex-direction:column;gap:10px;">
            <c:forEach var="cert" items="${certList}">
              <div style="display:flex;align-items:flex-start;gap:12px;padding:12px 14px;background:#F7F9FC;border-radius:12px;">
                <span class="material-symbols-outlined" style="font-size:20px;color:#FF6B35;margin-top:1px;">verified</span>
                <div>
                  <div style="font-size:14px;font-weight:700;color:#1A1F36;">${fn:escapeXml(cert.certName)}</div>
                  <div style="font-size:12px;color:#9DA8C0;margin-top:2px;">
                    ${fn:escapeXml(cert.issuingOrg)}
                    <c:if test="${not empty cert.issueDate}"> · ${cert.issueDate}</c:if>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </c:if>

      <!-- 리뷰 -->
      <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:26px;">
        <h2 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:18px;">⭐ 수강생 후기</h2>
        <p style="color:#9DA8C0;font-size:14px;text-align:center;padding:20px 0;">아직 후기가 없습니다.</p>
      </div>

    </div><!-- end left -->

    <!-- 오른쪽: 결제 패널 -->
    <div style="position:sticky;top:24px;display:flex;flex-direction:column;gap:16px;">

      <!-- 요약 카드 -->
      <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 4px 20px rgba(0,0,0,0.08);padding:24px;">
        <h3 style="font-size:15px;font-weight:800;color:#1A1F36;margin-bottom:16px;">📋 결제 요약</h3>
        <div style="display:flex;flex-direction:column;gap:10px;margin-bottom:16px;">
          <div style="display:flex;justify-content:space-between;font-size:13px;">
            <span style="color:#9DA8C0;font-weight:600;">트레이너</span>
            <span style="font-weight:700;color:#1A1F36;">${fn:escapeXml(t.name)} 트레이너</span>
          </div>
          <div style="display:flex;justify-content:space-between;font-size:13px;">
            <span style="color:#9DA8C0;font-weight:600;">이용권</span>
            <span style="font-weight:700;color:#1A1F36;" id="summaryPkg">
              <c:choose>
                <c:when test="${not empty pricingList}">${fn:escapeXml(pricingList[0].label)}</c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </span>
          </div>
        </div>
        <div style="border-top:1.5px solid #E8EDF5;padding-top:14px;display:flex;justify-content:space-between;align-items:center;">
          <span style="font-size:14px;font-weight:700;color:#1A1F36;">총 결제금액</span>
          <span style="font-size:22px;font-weight:900;color:#FF6B35;" id="summaryPrice">
            <c:choose>
              <c:when test="${not empty pricingList}">
                <fmt:formatNumber value="${pricingList[0].price}" pattern="#,###"/>원
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </span>
        </div>
      </div>

      <!-- 결제 버튼 -->
      <c:if test="${not empty pricingList}">
        <button onclick="pay()" style="width:100%;padding:16px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:16px;font-weight:900;font-family:'Noto Sans KR',sans-serif;box-shadow:0 6px 24px rgba(255,107,53,0.35);transition:all 0.2s;display:flex;align-items:center;justify-content:center;gap:10px;"
                onmouseover="this.style.transform='translateY(-2px)';this.style.boxShadow='0 8px 28px rgba(255,107,53,0.45)'"
                onmouseout="this.style.transform='none';this.style.boxShadow='0 6px 24px rgba(255,107,53,0.35)'">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none"><rect x="2" y="5" width="20" height="14" rx="3" stroke="white" stroke-width="2"/><path d="M2 10h20" stroke="white" stroke-width="2"/></svg>
          결제하기
        </button>
      </c:if>

      <!-- 채팅 버튼 -->
      <button onclick="goChat()" style="width:100%;padding:13px;border-radius:99px;border:1.5px solid #E8EDF5;cursor:pointer;background:white;color:#5A6480;font-size:14px;font-weight:700;font-family:'Noto Sans KR',sans-serif;display:flex;align-items:center;justify-content:center;gap:8px;transition:all 0.2s;"
              onmouseover="this.style.borderColor='#00BFA5';this.style.color='#00BFA5'"
              onmouseout="this.style.borderColor='#E8EDF5';this.style.color='#5A6480'">
        <span class="material-symbols-outlined" style="font-size:18px;">chat</span>
        트레이너에게 문의하기
      </button>

      <!-- 안내 -->
      <div style="background:#F7F9FC;border-radius:14px;padding:14px 16px;">
        <div style="font-size:12px;color:#9DA8C0;line-height:1.7;">
          🔒 안전한 토스 결제<br/>
          📅 수업 7일 전 무료 취소<br/>
          ⭐ 불만족 시 100% 환불 보장
        </div>
      </div>

    </div><!-- end right -->
  </div><!-- end grid -->
</main>

<script>
const CTX = '${ctx}';
const TRAINER_ID   = ${t.id};
const TRAINER_NAME = '${fn:escapeXml(t.name)}';
const TRAINER_TYPE = '${t.trainerType}'; // GYM_EMPLOYED / GYM_RENTAL / FREELANCE

function selectPkg(label, pkgName, price) {
  document.querySelectorAll('.pkg-label').forEach(l => l.classList.remove('selected'));
  label.classList.add('selected');
  const radio = label.querySelector('input[type=radio]');
  if (radio) radio.checked = true;
  document.getElementById('summaryPkg').innerText   = pkgName;
  document.getElementById('summaryPrice').innerText = price.toLocaleString() + '원';
}

document.querySelectorAll('input[name="ptPkg"]').forEach(radio => {
  radio.addEventListener('change', function() {
    document.getElementById('summaryPkg').innerText   = this.dataset.name;
    document.getElementById('summaryPrice').innerText = parseInt(this.value).toLocaleString() + '원';
  });
});

function pay() {
  const radio = document.querySelector('input[name="ptPkg"]:checked');
  if (!radio) { alert('이용권을 선택해주세요.'); return; }
  const amount       = parseInt(radio.value);
  const productName  = radio.dataset.name || 'PT';
  const sessionCount = parseInt(radio.dataset.count) || 1;
  // orderId 형식: PT-{trainerId}-{sessionCount}-{trainerType}-{timestamp}
  // PaymentSuccessController에서 파싱해 gymId/trainerId 분기에 사용
  const orderId      = 'PT-' + TRAINER_ID + '-' + sessionCount + '-' + TRAINER_TYPE + '-' + Date.now();
  const tossPayments = TossPayments("${tossClientKey}");
  tossPayments.requestPayment("카드", {
    amount,
    orderId,
    orderName: productName,
    successUrl: window.location.origin + CTX + '/member/paymentSuccess',
    failUrl:    window.location.origin + CTX + '/member/paymentFail'
  });
}

function goChat() {
  location.href = CTX + '/member/chat?trainerId=' + TRAINER_ID;
}
</script>
</body>
</html>
