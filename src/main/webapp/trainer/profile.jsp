<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitsbug - 내 프로필</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <%-- Kakao Maps JS SDK — replace YOUR_KAKAO_APPKEY with your JavaScript key from developers.kakao.com --%>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?19743c7131c8d369e6b723f116371fa7"></script>

<%--    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_KAKAO_APPKEY&autoload=false"></script>--%>
    <script id="tailwind-config">tailwind.config = { darkMode: "class", theme: { extend: { colors: { "tertiary-container": "#c64f00", "error-container": "#ffdad6", "primary-fixed": "#d8e2ff", "on-primary-fixed-variant": "#004493", surface: "#f9f9fe", "secondary-fixed-dim": "#adc6ff", "secondary-fixed": "#d8e2ff", "on-background": "#1a1c1f", "surface-container-high": "#e8e8ed", "surface-container-lowest": "#ffffff", "surface-variant": "#e2e2e7", "surface-dim": "#d9dade", "on-error": "#ffffff", "surface-tint": "#005bc1", "on-surface": "#1a1c1f", "inverse-on-surface": "#f0f0f5", tertiary: "#9e3d00", primary: "#0058bc", "on-tertiary-container": "#fffbff", "on-tertiary": "#ffffff", "on-error-container": "#93000a", error: "#ba1a1a", "surface-container-highest": "#e2e2e7", "primary-container": "#0070eb", "on-secondary-container": "#2d4c83", "on-tertiary-fixed": "#351000", "on-primary": "#ffffff", "surface-container-low": "#f3f3f8", "outline-variant": "#c1c6d7", "on-secondary-fixed": "#001a41", "on-primary-container": "#fefcff", "on-primary-fixed": "#001a41", secondary: "#405e96", "on-surface-variant": "#414755", "tertiary-fixed": "#ffdbcc", "surface-container": "#ededf2", "tertiary-fixed-dim": "#ffb595", "primary-fixed-dim": "#adc6ff", outline: "#717786", "on-tertiary-fixed-variant": "#7c2e00", "surface-bright": "#f9f9fe", "secondary-container": "#a1befd", "on-secondary": "#ffffff", "inverse-surface": "#2e3034", "on-secondary-fixed-variant": "#26467d", "inverse-primary": "#adc6ff", background: "#f9f9fe" }, borderRadius: { DEFAULT: "0.125rem", lg: "0.25rem", xl: "0.5rem", full: "0.75rem" }, fontFamily: { headline: ["Inter"], body: ["Inter"], label: ["Inter"], display: "Inter" } } } };</script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-surface text-on-surface min-h-screen">

<!-- SideNavBar -->
<c:set var="activePage" value="profile" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>
<jsp:include page="/trainer/mobileTopHeader.jsp"/>



<!-- Main -->
<main class="lg:pl-64 min-h-screen">
    <div class="max-w-4xl mx-auto p-6 md:p-8">

        <!-- Page Header -->
        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
            <div>
                <h1 class="text-3xl font-bold tracking-tight text-on-surface">내 프로필</h1>
                <p class="text-on-surface-variant">공개 프로필 및 코칭 정보를 관리하세요.</p>
            </div>
            <a href="${pageContext.request.contextPath}/trainer/profileEdit"
               class="px-5 py-2.5 rounded-xl bg-surface-container-high hover:bg-surface-variant text-on-surface font-semibold text-sm transition-all active:scale-95 border border-outline-variant/30 text-center">
                수정하기
            </a>
        </div>

        <c:choose>
            <c:when test="${empty trainer}">
                <!-- No trainer profile yet -->
                <div class="bg-surface-container-lowest rounded-[2rem] p-12 text-center border border-surface-variant/30 shadow-sm">
                    <span class="material-symbols-outlined text-5xl text-on-surface-variant/40 mb-4 block">person_off</span>
                    <p class="text-on-surface font-semibold mb-2">아직 트레이너 프로필이 없습니다.</p>
                    <p class="text-on-surface-variant text-sm">회원가입 단계를 완료하여 프로필을 만들어 보세요.</p>
                </div>
            </c:when>
            <c:otherwise>
        <div class="space-y-6">
            <!-- Identity Card -->
            <section class="bg-surface-container-lowest rounded-[2rem] overflow-hidden border border-surface-variant/30 shadow-sm">
                <div class="pt-6 pb-6 md:pt-8">
                    <div class="flex flex-col md:flex-row md:items-end justify-between gap-4 px-8">
                        <div class="flex flex-col md:flex-row md:items-end gap-5 md:gap-6">
                            <!-- Avatar -->
                            <div class="-mt-16 md:-mt-20 rounded-full flex-shrink-0">
                                <img alt="프로필 사진"
                                     class="w-28 h-28 md:w-32 md:h-32 rounded-full object-cover ring-4 ring-surface-container-lowest shadow-xl"
                                     src="${not empty sessionScope.loginUser.profileImg
                                             ? pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.loginUser.profileImg)
                                             : pageContext.request.contextPath.concat('/img/profile_img.jpg')}"/>
                            </div>
                            <div class="pt-1 space-y-2">
                                <div class="flex items-center flex-wrap gap-2">
                                    <h2 class="text-2xl md:text-3xl font-extrabold text-on-surface tracking-tight">${sessionScope.loginUser.name}</h2>
                                    <c:if test="${not empty trainer.businessRegistrationNum}">
                                        <span class="flex items-center gap-1 px-3 py-0.5 rounded-full bg-blue-50 text-blue-600 text-[10px] font-bold uppercase tracking-wider border border-blue-100"
                                              title="사업자 등록 인증 완료">
                                            <span class="material-symbols-outlined text-xs" style='font-variation-settings: "FILL" 1;'>verified</span>사업자 인증
                                        </span>
                                    </c:if>
                                    <c:if test="${trainer.approvalStatus == 'APPROVED'}">
                                        <span class="flex items-center gap-1 px-3 py-0.5 rounded-full bg-blue-50 text-blue-600 text-[10px] font-bold uppercase tracking-wider border border-blue-200"
                                              title="플랫폼 인증 트레이너">
                                            <span class="material-symbols-outlined text-xs" style='font-variation-settings: "FILL" 1;'>verified</span>인증 트레이너
                                        </span>
                                    </c:if>
                                    <%-- Trainer type label --%>
                                    <c:choose>
                                        <c:when test="${trainer.trainerType == 'GYM_EMPLOYED'}">
                                            <span class="px-3 py-0.5 rounded-full bg-slate-100 text-slate-600 text-[10px] font-bold border border-slate-200">헬스장 소속</span>
                                        </c:when>
                                        <c:when test="${trainer.trainerType == 'GYM_RENTAL'}">
                                            <span class="px-3 py-0.5 rounded-full bg-amber-50 text-amber-700 text-[10px] font-bold border border-amber-200">독립 운영 (임대)</span>
                                        </c:when>
                                        <c:when test="${trainer.trainerType == 'FREELANCE'}">
                                            <span class="px-3 py-0.5 rounded-full bg-purple-50 text-purple-700 text-[10px] font-bold border border-purple-200">프리랜서</span>
                                        </c:when>
                                    </c:choose>
                                </div>
                                <c:if test="${not empty sessionScope.loginUser.nickname}">
                                    <p class="text-sm text-on-surface-variant font-medium">@${sessionScope.loginUser.nickname}</p>
                                </c:if>
                                <div class="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs text-on-surface-variant">
                                    <c:if test="${not empty sessionScope.loginUser.email}">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">mail</span>${sessionScope.loginUser.email}
                                        </span>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.loginUser.phone}">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">phone</span>${sessionScope.loginUser.phone}
                                        </span>
                                    </c:if>
                                    <c:if test="${sessionScope.loginUser.age > 0}">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">cake</span>${sessionScope.loginUser.age}세
                                        </span>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.loginUser.gender}">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">person</span>${sessionScope.loginUser.gender == 'MALE' ? '남성' : '여성'}
                                        </span>
                                    </c:if>
                                    <c:if test="${not empty gym}">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">fitness_center</span>${gym.name}
                                        </span>
                                    </c:if>
                                    <c:if test="${not empty trainer.address}">
                                        <span class="flex items-center gap-1">
                                            <span class="material-symbols-outlined text-sm">location_on</span>${trainer.address}
                                        </span>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Bio & Specializations -->
            <section class="bg-surface-container-lowest p-6 md:p-8 rounded-[1.5rem] space-y-6 border border-surface-variant/30 shadow-sm">
                <!-- Description -->
                <div>
                    <h3 class="text-lg font-bold text-on-surface mb-3">소개</h3>
                    <c:choose>
                        <c:when test="${not empty trainer.description}">
                            <p class="text-on-surface-variant leading-relaxed text-sm">${trainer.description}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-on-surface-variant/50 text-sm italic">아직 작성된 소개가 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Specializations -->
                <c:if test="${not empty specializations}">
                    <div>
                        <h4 class="text-[11px] font-bold text-on-surface-variant uppercase tracking-widest mb-3">전문 분야</h4>
                        <div class="flex flex-wrap gap-2" id="spec-tags">
                            <c:forEach items="${specializations}" var="s">
                                <span class="spec-tag px-3 py-1.5 rounded-full bg-primary/8 border border-primary/20 text-[11px] font-bold text-primary" data-val="${s}">${s}</span>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Traits -->
                <c:if test="${not empty traits}">
                    <div>
                        <h4 class="text-[11px] font-bold text-on-surface-variant uppercase tracking-widest mb-3">강점</h4>
                        <div class="flex flex-wrap gap-2" id="trait-tags">
                            <c:forEach items="${traits}" var="t">
                                <span class="trait-tag px-3 py-1.5 rounded-full bg-surface-container-low border border-outline-variant/30 text-[11px] font-bold text-on-surface-variant" data-val="${t}">${t}</span>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Certifications -->
                <div class="pt-4 border-t border-surface-variant/30">
                    <h4 class="text-[11px] font-bold text-on-surface-variant uppercase tracking-widest mb-4">자격증</h4>
                    <c:choose>
                        <c:when test="${not empty certifications}">
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <c:forEach items="${certifications}" var="cert">
                                    <div class="flex items-center gap-3 p-3 rounded-2xl bg-surface-container-low/50 border border-outline-variant/20">
                                        <div class="w-10 h-10 rounded-xl bg-white shadow-sm flex items-center justify-center text-primary flex-shrink-0">
                                            <span class="material-symbols-outlined text-2xl">workspace_premium</span>
                                        </div>
                                        <div class="min-w-0">
                                            <p class="font-bold text-sm text-on-surface truncate">${cert.certName}</p>
                                            <c:if test="${not empty cert.issuingOrg}">
                                                <p class="text-[10px] text-on-surface-variant font-medium truncate">${cert.issuingOrg}</p>
                                            </c:if>
                                            <c:if test="${not empty cert.issueDate}">
                                                <p class="text-[10px] text-on-surface-variant/60">${cert.issueDate}
                                                    <c:if test="${not empty cert.expiryDate}"> ~ ${cert.expiryDate}</c:if>
                                                </p>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-on-surface-variant/50 text-sm italic">등록된 자격증이 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <!-- Location Map -->
            <section class="bg-surface-container-lowest p-6 md:p-8 rounded-[1.5rem] space-y-4 border border-surface-variant/30 shadow-sm">
                <h3 class="text-lg font-bold text-on-surface flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary" style='font-variation-settings:"FILL" 1;'>location_on</span>활동 위치
                </h3>
                <c:choose>
                    <c:when test="${not empty trainer.latitude and trainer.latitude != 0 and not empty trainer.longitude and trainer.longitude != 0}">
                        <%-- Map container — lat/lng passed via data attributes so JS can read them safely --%>
                        <div id="kakao-map"
                             data-lat="${trainer.latitude}"
                             data-lng="${trainer.longitude}"
                             data-address="${not empty gym ? gym.name : trainer.address}"
                             style="width:100%; height:300px; border-radius:16px; overflow:hidden; background:#e8e8ed;">
                        </div>
                        <c:if test="${not empty trainer.address}">
                            <div class="flex items-start gap-2 text-sm text-on-surface-variant pt-1">
                                <span class="material-symbols-outlined text-base flex-shrink-0 mt-0.5 text-primary/70">pin_drop</span>
                                <span>
                                    <c:if test="${not empty gym}">${gym.name} · </c:if>${trainer.address}<c:if test="${not empty trainer.addressDetail}"> ${trainer.addressDetail}</c:if>
                                    <c:if test="${not empty trainer.postcode}"> (${trainer.postcode})</c:if>
                                </span>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="flex flex-col items-center justify-center py-10 text-center gap-2">
                            <span class="material-symbols-outlined text-4xl text-on-surface-variant/30">location_off</span>
                            <p class="text-sm text-on-surface-variant/50">등록된 위치 정보가 없습니다.</p>
                            <a href="${pageContext.request.contextPath}/trainer/profileEdit"
                               class="text-xs font-semibold text-primary hover:underline mt-1">위치 추가하기</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Pricing & Availability -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <!-- Pricing -->
                <div class="bg-surface-container-lowest p-6 rounded-[1.5rem] space-y-4 border border-surface-variant/30 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary text-xl">payments</span>
                            <h3 class="font-bold text-sm text-on-surface">1:1 트레이닝 비용</h3>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${not empty pricing}">
                            <div class="space-y-2">
                                <c:forEach items="${pricing}" var="p">
                                    <c:choose>
                                        <c:when test="${p.popular}">
                                            <div class="flex justify-between items-center p-3 rounded-xl bg-primary/5 border border-primary/20">
                                                <div class="flex flex-col">
                                                    <span class="text-xs font-bold text-primary">${p.label}</span>
                                                    <span class="text-[9px] text-primary/70 font-bold uppercase tracking-wider">가장 인기</span>
                                                </div>
                                                <span class="font-bold text-primary text-base">₩<fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/></span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="flex justify-between items-center p-3 rounded-xl bg-surface-container-low">
                                                <span class="text-xs font-medium">${p.label}</span>
                                                <span class="font-bold text-on-surface text-base">₩${p.price}</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-on-surface-variant/50 text-sm italic">등록된 요금제가 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Availability -->
                <div class="bg-surface-container-lowest p-6 rounded-[1.5rem] space-y-4 border border-surface-variant/30 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary text-xl">calendar_month</span>
                            <h3 class="font-bold text-sm text-on-surface">가능 일정</h3>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${not empty availability}">
                            <div class="space-y-2">
                                <c:forEach items="${availability}" var="av">
                                    <div class="p-3 rounded-xl bg-surface-container-low border border-outline-variant/10 flex justify-between items-center">
                                        <p class="text-xs font-bold day-label" data-day="${av.dayOfWeek}">${av.dayOfWeek}</p>
                                        <p class="text-[11px] text-on-surface-variant">${av.startTime} ~ ${av.endTime}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-on-surface-variant/50 text-sm italic">등록된 가능 일정이 없습니다.
                                <a href="${pageContext.request.contextPath}/trainer/pricing" class="text-primary font-semibold not-italic">추가하기</a>
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>


<script>
    // Map enum values to Korean display labels
    const specLabels = {
        YOGA: '요가', WEIGHT_LOSS: '체중 감량', MUSCLE_GAIN: '근비대',
        BODY_RECOMPOSITION: '체형 교정', STRENGTH_TRAINING: '스트렝스',
        FUNCTIONAL_TRAINING: '기능성 트레이닝', POSTURE_CORRECTION: '자세 교정',
        PILATES: '필라테스', CROSSFIT: '크로스핏', REHABILITATION: '재활',
        ATHLETIC_PERFORMANCE: '운동 퍼포먼스'
    };
    const traitLabels = {
        KIND: '친절한', BEGINNER_FRIENDLY: '입문자 친화적', FUN: '즐거운',
        MOTIVATIONAL: '동기부여', DETAIL_ORIENTED: '꼼꼼한', PATIENT: '인내심 있는',
        RESULT_FOCUSED: '결과 중심', FLEXIBLE: '유연한', COMMUNICATIVE: '소통 잘 하는'
    };
    const dayLabels = { MON: '월요일', TUE: '화요일', WED: '수요일', THU: '목요일', FRI: '금요일', SAT: '토요일', SUN: '일요일' };

    document.querySelectorAll('.spec-tag').forEach(el => {
        el.textContent = specLabels[el.dataset.val] || el.dataset.val;
    });
    document.querySelectorAll('.trait-tag').forEach(el => {
        el.textContent = traitLabels[el.dataset.val] || el.dataset.val;
    });
    document.querySelectorAll('.day-label').forEach(el => {
        el.textContent = dayLabels[el.dataset.day] || el.dataset.day;
    });

    // ── Kakao Map ──────────────────────────────────────────────────────────
    const mapEl = document.getElementById('kakao-map');
    if (mapEl && typeof kakao !== 'undefined') {
        kakao.maps.load(function () {
            const lat     = parseFloat(mapEl.dataset.lat);
            const lng     = parseFloat(mapEl.dataset.lng);
            const address = mapEl.dataset.address || '';

            const center = new kakao.maps.LatLng(lat, lng);

            const map = new kakao.maps.Map(mapEl, {
                center: center,
                level: 4          // zoom: 1(close) – 14(far), 4 ≈ neighbourhood
            });

            // Marker
            const marker = new kakao.maps.Marker({ position: center, map: map });

            // Info bubble showing location name / address
            if (address) {
                const infoWindow = new kakao.maps.InfoWindow({
                    content: '<div style="padding:7px 12px; font-size:12px; font-weight:700; '
                           + 'color:#1a1c1f; white-space:nowrap; border-radius:8px;">'
                           + address + '</div>'
                });
                infoWindow.open(map, marker);

                // Re-open on marker click if user closes it
                kakao.maps.event.addListener(marker, 'click', function () {
                    infoWindow.open(map, marker);
                });
            }
        });
    }
</script>
</body>
</html>
