<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitsbug - ${client.name} 운동 기록</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
          rel="stylesheet"/>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        surface: "#f9f9fe", "surface-bright": "#f9f9fe",
                        "surface-container": "#ededf2", "surface-container-low": "#f3f3f8",
                        "surface-container-high": "#e8e8ed", "surface-container-highest": "#e2e2e7",
                        "surface-container-lowest": "#ffffff", "surface-dim": "#d9dade",
                        "on-surface": "#1a1c1f", "on-surface-variant": "#414755",
                        "outline-variant": "#c1c6d7", outline: "#717786",
                        primary: "#0058bc", "primary-container": "#0070eb",
                        "on-primary": "#ffffff", "on-primary-container": "#fefcff",
                        secondary: "#405e96", "secondary-container": "#a1befd",
                        "on-secondary-container": "#2d4c83",
                        tertiary: "#9e3d00", "tertiary-container": "#c64f00",
                        background: "#f9f9fe", "on-background": "#1a1c1f",
                    },
                    fontFamily: {headline: ["Inter"], body: ["Inter"], label: ["Inter"]},
                    borderRadius: {DEFAULT: "0.125rem", lg: "0.25rem", xl: "0.5rem", full: "0.75rem"}
                }
            }
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; -webkit-font-smoothing: antialiased; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
        .log-details { display: none; }
        .log-details.open { display: block; }
        .chevron-icon { transition: transform 0.2s; }
        .chevron-icon.open { transform: rotate(180deg); }
    </style>
</head>
<body class="bg-surface text-on-surface min-h-screen">

<!-- Mobile Top Bar -->
<header class="lg:hidden fixed top-0 left-0 right-0 z-30 bg-slate-50 border-b border-slate-200 px-4 py-3 flex items-center justify-between">
    <div class="flex items-center gap-2">
        <div class="w-8 h-8 bg-[#007AFF] rounded-lg flex items-center justify-center">
            <span class="material-symbols-outlined text-white text-lg">exercise</span>
        </div>
        <h1 class="text-lg font-bold text-on-surface">Fitsbug</h1>
    </div>
    <a href="${pageContext.request.contextPath}/trainer/profile" class="p-1 rounded-full">
        <img alt="profile" class="w-8 h-8 rounded-full object-cover"
             src="${not empty sessionScope.loginUser.profileImg ? pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.loginUser.profileImg) : pageContext.request.contextPath.concat('/img/profile_img.jpg')}"/>
    </a>
</header>

<!-- Sidebar -->
<c:set var="activePage" value="clients" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>

<div class="lg:ml-64 min-h-screen flex flex-col pt-14 pb-20 lg:pt-0 lg:pb-0">

    <!-- Page header -->
    <header class="sticky top-0 w-full z-40 bg-white/80 backdrop-blur-xl border-b border-outline-variant/20 flex justify-between items-center px-8 h-16">
        <div class="flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/trainer/clients">
                <button class="hover:opacity-70 transition-opacity active:scale-95 duration-150 text-blue-700">
                    <span class="material-symbols-outlined">arrow_back</span>
                </button>
            </a>
            <h1 class="font-sans tracking-tight text-lg font-semibold text-on-surface">회원목록</h1>
        </div>
    </header>

    <main class="flex-1 p-4 md:p-6 lg:p-8 max-w-6xl mx-auto w-full space-y-6 lg:space-y-8">

        <!-- Client Overview Section -->
        <section class="bg-surface-container-lowest p-4 md:p-8 rounded-2xl md:rounded-3xl shadow-sm border border-outline-variant/10">
            <div class="flex flex-col md:flex-row items-start md:items-center gap-4 md:gap-8">
                <div class="relative">
                    <img alt="${client.name}"
                         class="w-20 h-20 md:w-32 md:h-32 rounded-3xl object-cover shadow-lg"
                         src="${not empty client.profileImage ? pageContext.request.contextPath.concat('/uploads/').concat(client.profileImage) : pageContext.request.contextPath.concat('/img/profile_img.jpg')}"/>
                </div>
                <div class="flex-1 space-y-2">
                    <h2 class="text-4xl font-bold tracking-tighter text-on-surface">${client.name}</h2>
                    <p class="text-on-surface-variant text-lg font-medium">회원님</p>
                    <div class="flex flex-wrap gap-2 mt-3">
                        <c:if test="${not empty client.goals}">
                            <span class="inline-flex items-center gap-1.5 px-3 py-1 bg-surface-container-low rounded-full border border-outline-variant/20 text-xs font-semibold text-on-surface-variant">
                                <span class="material-symbols-outlined text-[14px] text-tertiary">track_changes</span>
                                ${client.goals}
                            </span>
                        </c:if>
                        <c:if test="${not empty client.purpose}">
                            <span class="inline-flex items-center gap-1.5 px-3 py-1 bg-blue-50 rounded-full border border-blue-100 text-xs font-semibold text-blue-700">
                                <span class="material-symbols-outlined text-[14px]">fitness_center</span>
                                <c:choose>
                                    <c:when test="${client.purpose == 'diet'}">다이어트</c:when>
                                    <c:when test="${client.purpose == 'balance'}">밸런스</c:when>
                                    <c:when test="${client.purpose == 'bulk-up'}">벌크업</c:when>
                                    <c:otherwise>${client.purpose}</c:otherwise>
                                </c:choose>
                            </span>
                        </c:if>
                        <c:if test="${not empty client.experience}">
                            <span class="inline-flex items-center gap-1.5 px-3 py-1 bg-green-50 rounded-full border border-green-100 text-xs font-semibold text-green-700">
                                <span class="material-symbols-outlined text-[14px]">military_tech</span>
                                <c:choose>
                                    <c:when test="${client.experience == 'first(0)'}">입문</c:when>
                                    <c:when test="${client.experience == 'beginner(<1)'}">초보</c:when>
                                    <c:when test="${client.experience == 'intermediate(1~3)'}">중급</c:when>
                                    <c:when test="${client.experience == 'high(>3)'}">고급</c:when>
                                    <c:otherwise>${client.experience}</c:otherwise>
                                </c:choose>
                            </span>
                        </c:if>
                        <c:if test="${not empty client.exerciseCountGoal}">
                            <span class="inline-flex items-center gap-1.5 px-3 py-1 bg-purple-50 rounded-full border border-purple-100 text-xs font-semibold text-purple-700">
                                <span class="material-symbols-outlined text-[14px]">calendar_today</span>
                                <c:choose>
                                    <c:when test="${client.exerciseCountGoal == '<=2'}">주 2회 이하</c:when>
                                    <c:when test="${client.exerciseCountGoal == '3~4'}">주 3~4회</c:when>
                                    <c:when test="${client.exerciseCountGoal == '>5'}">주 5회 이상</c:when>
                                    <c:otherwise>${client.exerciseCountGoal}</c:otherwise>
                                </c:choose>
                            </span>
                        </c:if>
                        <c:if test="${not empty client.diet}">
                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full border text-xs font-semibold
                                ${client.diet == 'YES' ? 'bg-emerald-50 border-emerald-100 text-emerald-700' :
                                  client.diet == 'Intermediate' ? 'bg-amber-50 border-amber-100 text-amber-700' :
                                  'bg-slate-50 border-slate-100 text-slate-500'}">
                                <span class="material-symbols-outlined text-[14px]">restaurant</span>
                                <c:choose>
                                    <c:when test="${client.diet == 'YES'}">식단 관리 중</c:when>
                                    <c:when test="${client.diet == 'Intermediate'}">부분 식단</c:when>
                                    <c:when test="${client.diet == 'NO'}">식단 없음</c:when>
                                    <c:otherwise>${client.diet}</c:otherwise>
                                </c:choose>
                            </span>
                        </c:if>
                    </div>
                </div>
                <div class="flex gap-4 w-full md:w-auto">
                    <div class="bg-surface-container-low px-4 py-3 md:px-6 md:py-4 rounded-2xl flex-1 md:flex-initial text-center border border-outline-variant/10">
                        <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">나이</p>
                        <div class="flex items-baseline justify-center gap-1">
                            <span class="text-3xl font-bold text-on-surface">${client.age}</span>
                            <span class="text-sm font-medium text-on-surface-variant">살</span>
                        </div>
                    </div>
                    <div class="bg-surface-container-low px-4 py-3 md:px-6 md:py-4 rounded-2xl flex-1 md:flex-initial text-center border border-outline-variant/10">
                        <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">키</p>
                        <div class="flex items-baseline justify-center gap-1">
                            <span class="text-3xl font-bold text-on-surface">${client.height}</span>
                            <span class="text-sm font-medium text-on-surface-variant">cm</span>
                        </div>
                    </div>
                    <div class="bg-surface-container-low px-4 py-3 md:px-6 md:py-4 rounded-2xl flex-1 md:flex-initial text-center border border-outline-variant/10">
                        <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">남은 수업</p>
                        <div class="flex items-baseline justify-center gap-1">
                            <span class="text-3xl font-bold text-on-surface">${client.lessonCount}</span>
                            <span class="text-sm font-medium text-on-surface-variant">회</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Nav tabs -->
        <nav class="flex gap-1 p-1.5 bg-surface-container-low rounded-2xl w-max max-w-full overflow-x-auto no-scrollbar">
            <a href="${pageContext.request.contextPath}/trainer/clientInbodyLog?clientId=${client.clientId}"
               class="px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors rounded-xl">
                인바디
            </a>
            <a href="${pageContext.request.contextPath}/trainer/meals?clientId=${client.clientId}"
               class="px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors rounded-xl">
                식단 기록
            </a>
            <span class="px-8 py-2.5 text-sm font-semibold bg-white text-on-surface rounded-xl shadow-sm">
                운동 기록
            </span>
        </nav>

        <!-- Workout Logs -->
        <c:choose>
            <c:when test="${empty workoutLogs}">
                <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 p-16 flex flex-col items-center gap-3 text-center">
                    <span class="material-symbols-outlined text-5xl text-slate-300">fitness_center</span>
                    <p class="text-base font-bold text-on-surface">운동 기록이 없습니다</p>
                    <p class="text-sm text-on-surface-variant">트레이너가 운동을 기록하면 여기에 표시됩니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <section class="space-y-4">
                    <div class="flex justify-between items-end">
                        <div class="space-y-1">
                            <h3 class="text-2xl font-bold tracking-tight">운동 기록</h3>
                            <p class="text-sm text-on-surface-variant font-medium">총 ${fn:length(workoutLogs)}개의 운동 세션</p>
                        </div>
                    </div>
                    <div class="space-y-3">
                        <c:forEach var="log" items="${workoutLogs}" varStatus="st">
                            <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 overflow-hidden">
                                <!-- Log header (clickable) -->
                                <button onclick="toggleLog(${log.id})"
                                        class="w-full text-left px-5 py-4 flex items-center justify-between gap-4 hover:bg-surface-container-low transition-colors">
                                    <div class="flex items-center gap-4">
                                        <!-- Date badge -->
                                        <div class="shrink-0 w-12 h-12 rounded-xl bg-primary/8 flex flex-col items-center justify-center">
                                            <span class="text-[10px] font-bold text-primary uppercase tracking-wider">
                                                ${fn:substring(log.date, 5, 7)}월
                                            </span>
                                            <span class="text-lg font-bold text-primary leading-none">
                                                ${fn:substring(log.date, 8, 10)}
                                            </span>
                                        </div>
                                        <div>
                                            <p class="text-sm font-bold text-on-surface">${log.date}</p>
                                            <p class="text-xs text-on-surface-variant mt-0.5">
                                                <c:choose>
                                                    <c:when test="${not empty log.startTime and not empty log.endTime}">
                                                        ${log.startTime} ~ ${log.endTime}
                                                    </c:when>
                                                    <c:when test="${not empty log.startTime}">
                                                        ${log.startTime} 시작
                                                    </c:when>
                                                    <c:otherwise>시간 미기록</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="flex items-center gap-3 shrink-0">
                                        <span class="px-2.5 py-1 bg-primary/8 text-primary text-xs font-bold rounded-lg">
                                            ${fn:length(log.details)}가지 운동
                                        </span>
                                        <span class="material-symbols-outlined text-outline chevron-icon" id="chevron-${log.id}">
                                            expand_more
                                        </span>
                                    </div>
                                </button>

                                <!-- Exercise detail table (hidden by default) -->
                                <div class="log-details" id="details-${log.id}">
                                    <c:choose>
                                        <c:when test="${empty log.details}">
                                            <div class="px-5 py-4 border-t border-outline-variant/10 text-sm text-on-surface-variant text-center">
                                                운동 항목이 없습니다.
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="border-t border-outline-variant/10 overflow-x-auto">
                                                <table class="w-full text-sm">
                                                    <thead class="bg-surface-container-low text-on-surface-variant text-xs font-bold uppercase tracking-wider">
                                                    <tr>
                                                        <th class="text-left px-5 py-3">운동</th>
                                                        <th class="text-center px-4 py-3">세트</th>
                                                        <th class="text-center px-4 py-3">횟수</th>
                                                        <th class="text-center px-4 py-3">무게 (kg)</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody class="divide-y divide-outline-variant/10">
                                                    <c:forEach var="d" items="${log.details}">
                                                        <tr class="hover:bg-surface-container-low transition-colors">
                                                            <td class="px-5 py-3 font-semibold text-on-surface">${d.title}</td>
                                                            <td class="px-4 py-3 text-center text-on-surface-variant">${d.set}</td>
                                                            <td class="px-4 py-3 text-center text-on-surface-variant">${d.rep}</td>
                                                            <td class="px-4 py-3 text-center text-on-surface-variant">
                                                                <c:choose>
                                                                    <c:when test="${d.weight > 0}">${d.weight}</c:when>
                                                                    <c:otherwise>—</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </c:otherwise>
        </c:choose>

    </main>
</div>

<script>
    function toggleLog(id) {
        const details = document.getElementById('details-' + id);
        const chevron = document.getElementById('chevron-' + id);
        details.classList.toggle('open');
        chevron.classList.toggle('open');
    }
</script>

</body>
</html>
