<%--
  Created by IntelliJ IDEA.
  User: jinhoyon
  Date: 4/28/26
  Time: 1:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0, viewport-fit=cover" name="viewport"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
    <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script
            id="tailwind-config">tailwind.config = {
        darkMode: "class", theme: {
            extend: {
                colors: {
                    "surface-container": "#ededf2",
                    "surface-dim": "#d9dade",
                    "on-tertiary-fixed": "#351000",
                    "on-error": "#ffffff",
                    "on-surface-variant": "#414755",
                    "inverse-surface": "#2e3034",
                    error: "#ba1a1a",
                    "secondary-fixed": "#d8e2ff",
                    "on-tertiary-container": "#fffbff",
                    "on-primary-fixed-variant": "#004493",
                    "surface-container-low": "#f3f3f8",
                    "outline-variant": "#c1c6d7",
                    "tertiary-fixed": "#ffdbcc",
                    "primary-fixed-dim": "#adc6ff",
                    "on-secondary": "#ffffff",
                    "surface-tint": "#005bc1",
                    "error-container": "#ffdad6",
                    outline: "#717786",
                    "on-primary": "#ffffff",
                    "secondary-container": "#a1befd",
                    "on-secondary-container": "#2d4c83",
                    "tertiary-fixed-dim": "#ffb595",
                    "on-error-container": "#93000a",
                    background: "#f9f9fe",
                    "primary-container": "#0070eb",
                    "on-surface": "#1a1c1f",
                    secondary: "#405e96",
                    tertiary: "#9e3d00",
                    "surface-container-lowest": "#ffffff",
                    "on-primary-fixed": "#001a41",
                    "on-secondary-fixed": "#001a41",
                    "surface-bright": "#f9f9fe",
                    "on-primary-container": "#fefcff",
                    "on-tertiary": "#ffffff",
                    "inverse-on-surface": "#f0f0f5",
                    "on-tertiary-fixed-variant": "#7c2e00",
                    "secondary-fixed-dim": "#adc6ff",
                    "surface-container-high": "#e8e8ed",
                    surface: "#f9f9fe",
                    "surface-container-highest": "#e2e2e7",
                    "tertiary-container": "#c64f00",
                    "inverse-primary": "#adc6ff",
                    "primary-fixed": "#d8e2ff",
                    "on-secondary-fixed-variant": "#26467d",
                    primary: "#0058bc",
                    "on-background": "#1a1c1f",
                    "surface-variant": "#e2e2e7"
                },
                fontFamily: {headline: ["Inter"], body: ["Inter"], label: ["Inter"], display: "Inter"},
                borderRadius: {DEFAULT: "0.125rem", lg: "0.25rem", xl: "0.5rem", full: "0.75rem"}
            }
        }
    };</script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            display: inline-block;
            line-height: 1;
            text-transform: none;
            letter-spacing: normal;
            word-wrap: normal;
            white-space: nowrap;
            direction: ltr;
        }

        body {
            font-family: 'Inter', sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        .glass-nav {
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }

        .hide-scrollbar::-webkit-scrollbar {
            display: none;
        }

        .hide-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
    </style>
</head>

<body class="bg-surface text-on-surface">
<input type="hidden" id="clientId" value="${clientId}">
<!-- Mobile Top Bar -->
<header
        class="lg:hidden fixed top-0 left-0 right-0 z-30 bg-slate-50 border-b border-slate-200 px-4 py-3 flex items-center justify-between">
    <div class="flex items-center gap-2">
        <div class="w-8 h-8 bg-[#007AFF] rounded-lg flex items-center justify-center">
            <span class="material-symbols-outlined text-white text-lg">exercise</span>
        </div>
        <h1 class="text-lg font-bold text-on-surface">Fitsbug</h1>
    </div>
    <div class="flex items-center gap-1">
        <button class="p-2 rounded-lg hover:bg-slate-200">
            <span class="material-symbols-outlined">notifications</span>
        </button>
        <a href="${pageContext.request.contextPath}/trainer/profile" class="p-1 rounded-full hover:ring-2 hover:ring-primary/30 transition-all">
            <img alt="연진호" class="w-8 h-8 rounded-full object-cover"
                 src="${not empty sessionScope.loginUser.profileImg ? pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.loginUser.profileImg) : pageContext.request.contextPath.concat('/img/profile_img.jpg')}"/>
        </a>
    </div>
</header>

<!-- SideNavBar -->
<c:set var="activePage" value="clients" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>



<div class="lg:ml-64">
    <!-- TopAppBar -->
    <%--    <header class="fixed top-0 w-full lg:w-[calc(100%-16rem)] z-50 bg-white/80 dark:bg-slate-900/80 backdrop-blur-xl flex items-center justify-between px-6 h-16 border-b border-outline-variant/10">--%>
    <%--        <div class="flex items-center gap-4">--%>
    <%--            <button--%>
    <%--                    class="flex items-center gap-1 text-primary active:scale-95 transition-transform hover:opacity-80">--%>
    <%--                <span class="material-symbols-outlined" data-icon="arrow_back">arrow_back</span>--%>
    <%--                <span class="text-sm font-semibold">Back</span>--%>
    <%--            </button>--%>
    <%--            <h1--%>
    <%--                    class="text-on-surface font-headline text-lg font-bold tracking-tight border-l border-outline-variant/30 pl-4">--%>
    <%--                Diet Log</h1>--%>
    <%--        </div>--%>
    <%--        <button class="text-on-surface-variant hover:text-primary active:scale-95 transition-transform">--%>
    <%--            <span class="material-symbols-outlined" data-icon="tune">tune</span>--%>
    <%--        </button>--%>
    <%--    </header>--%>

    <header
            class="sticky top-0 w-full z-40 bg-white/80 backdrop-blur-xl border-b border-outline-variant/20 flex justify-between items-center px-8 h-16">
        <div class="flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/trainer/clients"
               class="hover:opacity-70 transition-opacity active:scale-95 duration-150 text-blue-700">
                <span class="material-symbols-outlined">arrow_back</span>
            </a>
            <h1 class="font-sans tracking-tight text-lg font-semibold text-on-surface">회원목록</h1>
        </div>
    </header>
<%--    <main class="pt-4 pb-28 lg:pt-4 lg:pb-8 px-4 max-w-lg mx-auto space-y-6 md:max-w-4xl md:px-8">--%>
        <main class="flex-1 p-4 md:p-6 lg:p-8 max-w-6xl mx-auto w-full space-y-6 lg:space-y-8">
            <!-- Client Overview Section -->
            <section
                    class="bg-surface-container-lowest p-4 md:p-8 rounded-2xl md:rounded-3xl shadow-sm border border-outline-variant/10">
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
                            <!-- Goals -->
                            <c:if test="${not empty client.goals}">
                            <span class="inline-flex items-center gap-1.5 px-3 py-1 bg-surface-container-low rounded-full border border-outline-variant/20 text-xs font-semibold text-on-surface-variant">
                                <span class="material-symbols-outlined text-[14px] text-tertiary">track_changes</span>
                                ${client.goals}
                            </span>
                            </c:if>
                            <!-- Purpose -->
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
                            <!-- Experience -->
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
                            <!-- Exercise count goal -->
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
                            <!-- Diet -->
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
                            <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">
                                나이</p>
                            <div class="flex items-baseline justify-center gap-1">
                                <span class="text-3xl font-bold text-on-surface">${client.age}</span>
                                <span class="text-sm font-medium text-on-surface-variant">살</span>
                            </div>
                        </div>
                        <div class="bg-surface-container-low px-4 py-3 md:px-6 md:py-4 rounded-2xl flex-1 md:flex-initial text-center border border-outline-variant/10">
                            <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">
                                키</p>
                            <div class="flex items-baseline justify-center gap-1">
                                <span class="text-3xl font-bold text-on-surface">${client.height}</span>
                                <span class="text-sm font-medium text-on-surface-variant">cm</span>
                            </div>
                        </div>
                        <div class="bg-surface-container-low px-4 py-3 md:px-6 md:py-4 rounded-2xl flex-1 md:flex-initial text-center border border-outline-variant/10">
                            <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">
                                남은 수업</p>
                            <div class="flex items-baseline justify-center gap-1">
                                <span class="text-3xl font-bold text-on-surface">${client.lessonCount}</span>
                                <span class="text-sm font-medium text-on-surface-variant">회</span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Main Layout Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
                <!-- Left Column: Overview & Stats -->
                <div class="lg:col-span-8 space-y-8">
                    <!-- Segmented Control -->
                    <nav class="flex gap-1 p-1.5 bg-surface-container-low rounded-2xl w-max max-w-full overflow-x-auto no-scrollbar">
                        <a href="${pageContext.request.contextPath}/trainer/clientInbodyLog?clientId=${clientId}"
                           class="px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors rounded-xl">
                            인바디
                        </a>
                        <span class="px-8 py-2.5 text-sm font-semibold bg-white text-on-surface rounded-xl shadow-sm">
                            식단 기록
                        </span>
                        <a href="${pageContext.request.contextPath}/trainer/clientWorkoutLog?clientId=${clientId}"
                           class="px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors rounded-xl">
                            운동 기록
                        </a>
                    </nav>
                </div>
            </div>

        <!-- Summary Card: Bento Style -->
        <section class="bg-surface-container-lowest rounded-xl p-6 ...">
            <div class="flex items-end justify-between mb-2">
                <p id="perfLabel"
                   class="text-on-surface-variant font-label text-[10px] uppercase tracking-widest font-bold">
                    주간 영양소 분석
                </p>
                <span id="perfDate" class="text-[10px] text-on-surface-variant font-medium"></span>
            </div>
            <div class="grid gap-4 pt-2 grid-cols-2 md:grid-cols-4">
                <div class="space-y-1">
                    <span id="labelCal"
                          class="text-on-surface-variant font-label text-[10px] font-medium">평균 칼로리</span>
                    <div class="flex items-baseline gap-1">
                        <span id="valCal" class="text-2xl font-bold text-on-surface tracking-tighter">${avgCal}</span>
                        <span class="text-[10px] text-on-surface-variant font-medium">kcal</span>
                    </div>
                </div>
                <div class="space-y-1">
                    <span id="labelProt"
                          class="text-on-surface-variant font-label text-[10px] font-medium">평균 단백질</span>
                    <div class="flex items-baseline gap-1">
                        <span id="valProt" class="text-2xl font-bold text-on-surface tracking-tighter">${avgProt}</span>
                        <span class="text-[10px] text-on-surface-variant font-medium">g</span>
                    </div>
                </div>
                <div class="space-y-1">
                    <span id="labelCarbs"
                          class="text-on-surface-variant font-label text-[10px] font-medium">평균 탄수화물</span>
                    <div class="flex items-baseline gap-1">
                        <span id="valCarbs"
                              class="text-2xl font-bold text-on-surface tracking-tighter">${avgCarbs}</span>
                        <span class="text-[10px] text-on-surface-variant font-medium">g</span>
                    </div>
                </div>
                <div class="space-y-1">
                    <span id="labelFat"
                          class="text-on-surface-variant font-label text-[10px] font-medium">평균 지방</span>
                    <div class="flex items-baseline gap-1">
                        <span id="valFat" class="text-2xl font-bold text-on-surface tracking-tighter">${avgFat}</span>
                        <span class="text-[10px] text-on-surface-variant font-medium">g</span>
                    </div>
                </div>
            </div>
        </section>
        <!-- Trends Card (Bar Graph) -->
        <section class="bg-surface-container-lowest rounded-xl p-6 ...">
            <div class="flex items-center justify-between mb-6">
                <h3 class="text-on-surface font-semibold text-base">칼로리 섭취량</h3>
                <!-- week nav -->
                <div class="flex items-center gap-2">
                    <button onclick="changeWeek(-1)" class="p-1 rounded-lg hover:bg-slate-100 text-on-surface-variant">
                        <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                    </button>
                    <span class="text-[11px] font-medium text-on-surface-variant" id="weekLabel"></span>
                    <button id="btnNext" onclick="changeWeek(1)" class="p-1 rounded-lg hover:bg-slate-100 text-on-surface-variant">
                        <span class="material-symbols-outlined text-[18px]">chevron_right</span>
                    </button>
                </div>
            </div>
            <div>
                <canvas id="myChart"></canvas>
            </div>
        </section>

        <!-- Meal Log Section -->
        <section id="mealList" class="space-y-6">
            <div class="flex items-center justify-between px-1">
<%--                <h3 class="text-on-surface font-semibold text-base">Meals</h3>--%>
                <span class="text-on-surface-variant text-[12px] font-medium">${selectedDate}</span>
            </div>

            <c:forEach var="meal" items="${meals}" varStatus="status">

                <%-- Meal type divider label --%>
                <c:if test="${status.index == 0}">
                    <div class="flex items-center gap-3">
                <span class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest whitespace-nowrap">
                    아침
                </span>
                        <div class="h-px bg-outline-variant/30 flex-1"></div>
                    </div>
                </c:if>
                <c:if test="${status.index == 1}">
                    <div class="flex items-center gap-3">
                <span class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest whitespace-nowrap">
                    점심
                </span>
                        <div class="h-px bg-outline-variant/30 flex-1"></div>
                    </div>
                </c:if>
                <c:if test="${status.index == 2}">
                    <div class="flex items-center gap-3">
                <span class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest whitespace-nowrap">
                    저녁
                </span>
                        <div class="h-px bg-outline-variant/30 flex-1"></div>
                    </div>
                </c:if>

                <%-- Meal Card --%>
                <div class="bg-surface-container-lowest rounded-2xl overflow-hidden flex shadow-[0_4px_24px_rgba(0,88,188,0.06)] border border-outline-variant/10 hover:shadow-[0_8px_32px_rgba(0,88,188,0.10)] transition-shadow">

                        <%-- Food image --%>
                    <div class="w-28 h-32 flex-shrink-0">
                        <img src="${meal.imageUrl}" alt="${meal.mealName}"
                             class="w-full h-full object-cover"/>
                    </div>

                        <%-- Content --%>
                    <div class="p-4 flex-grow flex flex-col justify-between min-w-0">

                            <%-- Top row: name + time --%>
                        <div>
                            <div class="flex justify-between items-start gap-2">
                                <h4 class="font-bold text-on-surface text-sm leading-snug truncate">${meal.mealName}</h4>
                                <span class="text-[10px] font-medium text-on-surface-variant whitespace-nowrap shrink-0">${meal.mealTime}</span>
                            </div>
                            <p class="text-[11px] text-on-surface-variant mt-1 line-clamp-1">${meal.mealType}</p>
                        </div>

                            <%-- Bottom row: macros --%>
                        <div class="flex flex-wrap gap-x-3 gap-y-1 mt-2">
                            <div class="flex items-center gap-1">
                                <span class="text-xs font-bold text-on-surface">${meal.calories}</span>
                                <span class="text-[10px] text-on-surface-variant">kcal</span>
                            </div>
                            <div class="flex items-center gap-1 border-l border-outline-variant/30 pl-3">
                                <span class="text-xs font-bold text-primary">${meal.protein}</span>
                                <span class="text-[10px] text-on-surface-variant">단백질</span>
                            </div>
                            <div class="flex items-center gap-1 border-l border-outline-variant/30 pl-3">
                                <span class="text-xs font-bold text-orange-500">${meal.carbs}</span>
                                <span class="text-[10px] text-on-surface-variant">탄수화물</span>
                            </div>
                            <div class="flex items-center gap-1 border-l border-outline-variant/30 pl-3">
                                <span class="text-xs font-bold text-amber-500">${meal.fat}</span>
                                <span class="text-[10px] text-on-surface-variant">지방</span>
                            </div>
                        </div>

                    </div>
                </div>

            </c:forEach>
        </section>

        <!-- Daily Trainer Comment Card -->
<%--        <section--%>
<%--                class="bg-surface-container-lowest rounded-xl p-6 shadow-[0_4px_24px_rgba(0,88,188,0.04)] space-y-4">--%>
<%--            <div class="flex flex-col">--%>
<%--                <h3 class="text-on-surface font-semibold text-lg">Daily Trainer Comment</h3>--%>
<%--                <p class="text-sm text-on-surface-variant">May 24, Friday</p>--%>
<%--            </div>--%>
<%--            <div class="relative">--%>
<%--                    <textarea--%>
<%--                            class="w-full bg-surface-container-low border-none rounded-xl p-4 text-sm focus:ring-2 focus:ring-primary/20 min-h-[120px] resize-none"--%>
<%--                            placeholder="Write your feedback for the day..."></textarea>--%>
<%--            </div>--%>
<%--            <div class="flex justify-end">--%>
<%--                <button--%>
<%--                        class="bg-primary text-white px-6 py-2.5 rounded-full font-bold text-sm shadow-lg active:scale-95 transition-transform">--%>
<%--                    Post Comment--%>
<%--                </button>--%>
<%--            </div>--%>
<%--        </section>--%>
    </main>
</div>

<%-- Load Chart.js first, then our external file --%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/static/js/clientMealLog.js?v=2"></script>
<script>
    // Variables that need server-side values — JSP handles these
    let currentWeekOffset = ${weekOffset};
    let currentSelectedDate = '';
    const contextPath = '${pageContext.request.contextPath}';

    // Seed initial chart data from JSTL (avoids an extra AJAX call on first load)
    const initialMealData = {};
    <c:forEach var="meal" items="${weekMeals}">
    if (!initialMealData['${meal.mealDate}']) initialMealData['${meal.mealDate}'] = 0;
    initialMealData['${meal.mealDate}'] += ${meal.calories};
    </c:forEach>

    // Boot the chart
    const initialBarDates = buildWeekDates(currentWeekOffset);
    const initialCalData = initialBarDates.map(function(date) {
        return initialMealData[date] || 0;
    });

    updateWeekLabel(currentWeekOffset);

    const myChart = new Chart(document.getElementById('myChart'), {
        type: 'bar',
        data: {
            labels: buildLabels(initialBarDates),
            datasets: [{
                label: 'kcal',
                data: initialCalData,
                backgroundColor: 'rgba(0, 88, 188, 0.85)',
                borderWidth: 0,
                borderRadius: 4
            }]
        },
        options: {
            scales: {y: {beginAtZero: true}},
            onClick: function(event, elements) {
                if (elements.length === 0) {
                    loadData(currentWeekOffset, null);
                } else {
                    const clickedDate = myChart.data.datasets[0]._barDates[elements[0].index];
                    loadData(currentWeekOffset, clickedDate);
                }
            },
            onHover: function(event, elements) {
                event.native.target.style.cursor = elements.length > 0 ? 'pointer' : 'default';
            }
        }
    });

    myChart.data.datasets[0]._barDates = initialBarDates;
</script>