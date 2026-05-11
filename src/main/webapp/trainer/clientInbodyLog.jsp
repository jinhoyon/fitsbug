<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitsbug - ${client.name} InBody</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns"></script>
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
        body {
            font-family: 'Inter', sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }

        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
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

    <!-- Page header with back button -->
    <header
            class="sticky top-0 w-full z-40 bg-white/80 backdrop-blur-xl border-b border-outline-variant/20 flex justify-between items-center px-8 h-16">
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
                    <a href="${pageContext.request.contextPath}/trainer/clientInbodyLog?clientId=${client.clientId}"
                       class="px-8 py-2.5 text-sm font-semibold bg-white text-on-surface rounded-xl shadow-sm">
                        인바디
                    </a>
                    <a href="${pageContext.request.contextPath}/trainer/meals?clientId=${client.clientId}"
                       class="btn-primary px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors">
                        식단 기록
                    </a>
                    <a href="${pageContext.request.contextPath}/trainer/clientWorkoutLog?clientId=${client.clientId}"
                       class="px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors">
                        운동 기록
                    </a>
                </nav>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty inbodyRows}">
                <!-- Empty state -->
                <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 p-16 flex flex-col items-center gap-3 text-center">
                    <span class="material-symbols-outlined text-5xl text-slate-300">monitor_weight</span>
                    <p class="text-base font-bold text-on-surface">InBody 기록이 없습니다</p>
                    <p class="text-sm text-on-surface-variant">회원이 InBody를 측정하면 여기에 표시됩니다.</p>
                </div>
            </c:when>
            <c:otherwise>

                <!-- Body Composition Trends -->
                <c:set var="latest" value="${inbodyRows[0]}"/>
                <section class="space-y-4">
                    <div class="flex justify-between items-end">
                        <div class="space-y-1">
                            <h3 class="text-2xl font-bold tracking-tight">체성분 트렌드</h3>
                            <p class="text-sm text-on-surface-variant font-medium">체중, 골격근량, 체지방량의 변화를 추적합니다</p>
                        </div>
                    </div>
                    <div class="bg-surface-container-lowest p-6 md:p-8 rounded-3xl border border-outline-variant/10 space-y-6 md:space-y-8">
                        <!-- Metric stat cards -->
                        <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 md:gap-4">
                            <!-- Weight -->
                            <div class="p-4 rounded-2xl bg-primary/5 border border-primary/10">
                                <p class="text-[10px] font-bold text-primary uppercase tracking-widest mb-1">체중</p>
                                <div class="flex items-baseline gap-2">
                                    <span class="text-2xl font-bold text-on-surface">${latest.weight}</span>
                                    <span class="text-xs font-medium text-on-surface-variant">kg</span>
                                </div>
                                <c:if test="${latest.weightDelta != null}">
                                    <p class="text-xs mt-1 font-semibold
                                       ${latest.weightDelta < 0 ? 'text-blue-600' : (latest.weightDelta > 0 ? 'text-red-500' : 'text-slate-400')}">
                                        <c:choose>
                                            <c:when test="${latest.weightDelta < 0}">&#9660; ${latest.weightDelta}kg</c:when>
                                            <c:when test="${latest.weightDelta > 0}">&#9650; +${latest.weightDelta}kg</c:when>
                                            <c:otherwise>&mdash;</c:otherwise>
                                        </c:choose>
                                    </p>
                                </c:if>
                            </div>
                            <!-- Muscle Mass -->
                            <div class="p-4 rounded-2xl bg-green-50 border border-green-100">
                                <p class="text-[10px] font-bold text-green-700 uppercase tracking-widest mb-1">골격근량</p>
                                <div class="flex items-baseline gap-2">
                                    <span class="text-2xl font-bold text-on-surface">${latest.muscleMass}</span>
                                    <span class="text-xs font-medium text-on-surface-variant">kg</span>
                                </div>
                                <c:if test="${latest.muscleDelta != null}">
                                    <p class="text-xs mt-1 font-semibold
                                       ${latest.muscleDelta > 0 ? 'text-green-600' : (latest.muscleDelta < 0 ? 'text-red-500' : 'text-slate-400')}">
                                        <c:choose>
                                            <c:when test="${latest.muscleDelta > 0}">&#9650; +${latest.muscleDelta}kg</c:when>
                                            <c:when test="${latest.muscleDelta < 0}">&#9660; ${latest.muscleDelta}kg</c:when>
                                            <c:otherwise>&mdash;</c:otherwise>
                                        </c:choose>
                                    </p>
                                </c:if>
                            </div>
                            <!-- Body Fat -->
                            <div class="p-4 rounded-2xl bg-orange-50 border border-orange-100">
                                <p class="text-[10px] font-bold text-tertiary uppercase tracking-widest mb-1">체지방량</p>
                                <div class="flex items-baseline gap-2">
                                    <span class="text-2xl font-bold text-on-surface">${latest.bodyFat}</span>
                                    <span class="text-xs font-medium text-on-surface-variant">kg</span>
                                </div>
                                <c:if test="${latest.fatDelta != null}">
                                    <p class="text-xs mt-1 font-semibold
                                       ${latest.fatDelta < 0 ? 'text-green-600' : (latest.fatDelta > 0 ? 'text-red-500' : 'text-slate-400')}">
                                        <c:choose>
                                            <c:when test="${latest.fatDelta < 0}">&#9660; ${latest.fatDelta}kg</c:when>
                                            <c:when test="${latest.fatDelta > 0}">&#9650; +${latest.fatDelta}kg</c:when>
                                            <c:otherwise>&mdash;</c:otherwise>
                                        </c:choose>
                                    </p>
                                </c:if>
                            </div>
                            <!-- Body Fat % -->
                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                                <p class="text-[10px] font-bold text-slate-500 uppercase tracking-widest mb-1">체지방률</p>
                                <div class="flex items-baseline gap-2">
                                    <span class="text-2xl font-bold text-on-surface">${latest.fatPct}</span>
                                    <span class="text-xs font-medium text-on-surface-variant">%</span>
                                </div>
                                <c:if test="${latest.fatPctDelta != null}">
                                    <p class="text-xs mt-1 font-semibold
                                       ${latest.fatPctDelta < 0 ? 'text-green-600' : (latest.fatPctDelta > 0 ? 'text-red-500' : 'text-slate-400')}">
                                        <c:choose>
                                            <c:when test="${latest.fatPctDelta < 0}">&#9660; ${latest.fatPctDelta}%</c:when>
                                            <c:when test="${latest.fatPctDelta > 0}">&#9650; +${latest.fatPctDelta}%</c:when>
                                            <c:otherwise>&mdash;</c:otherwise>
                                        </c:choose>
                                    </p>
                                </c:if>
                            </div>
                        </div>
                        <!-- Chart area -->
                        <c:choose>
                            <c:when test="${recordCount >= 2}">
                                <div class="space-y-4">
                                    <!-- Metric toggle buttons -->
                                    <div class="flex gap-1.5 p-1 bg-surface-container-low rounded-xl w-fit">
                                        <button onclick="showMetric('all', this)"
                                                class="metric-btn px-4 py-1.5 rounded-lg text-xs font-semibold transition-all text-on-surface-variant hover:text-on-surface">
                                            전체
                                        </button>
                                        <button onclick="showMetric('weight', this)"
                                                class="metric-btn active-metric-btn px-4 py-1.5 rounded-lg text-xs font-semibold transition-all bg-white text-primary shadow-sm">
                                            체중
                                        </button>
                                        <button onclick="showMetric('muscle', this)"
                                                class="metric-btn px-4 py-1.5 rounded-lg text-xs font-semibold transition-all text-on-surface-variant hover:text-on-surface">
                                            골격근량
                                        </button>
                                        <button onclick="showMetric('bodyFat', this)"
                                                class="metric-btn px-4 py-1.5 rounded-lg text-xs font-semibold transition-all text-on-surface-variant hover:text-on-surface">
                                            체지방량
                                        </button>
                                        <button onclick="showMetric('fatPct', this)"
                                                class="metric-btn px-4 py-1.5 rounded-lg text-xs font-semibold transition-all text-on-surface-variant hover:text-on-surface">
                                            체지방률
                                        </button>
                                    </div>
                                    <canvas id="inbodyChart"></canvas>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="flex flex-col items-center justify-center py-8 text-center text-on-surface-variant gap-2">
                                    <span class="material-symbols-outlined text-3xl">show_chart</span>
                                    <p class="text-sm font-medium">2개 이상의 기록이 있어야 추이 그래프가 표시됩니다.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <!-- Detail table -->
                <section
                        class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 shadow-sm overflow-hidden">
                    <div class="px-5 py-4 border-b border-outline-variant/10 flex items-center justify-between">
                        <h3 class="text-sm font-bold text-on-surface">전체 기록</h3>
                        <span class="text-xs text-on-surface-variant">${recordCount}건</span>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-surface-container-low text-on-surface-variant text-xs font-bold uppercase tracking-wider">
                            <tr>
                                <th class="text-left px-5 py-3">측정일</th>
                                <th class="text-right px-5 py-3">체중 (kg)</th>
                                <th class="text-right px-5 py-3">골격근량 (kg)</th>
                                <th class="text-right px-5 py-3">체지방량 (kg)</th>
                                <th class="text-right px-5 py-3">체지방률 (%)</th>
                                <th class="text-center px-5 py-3">이미지</th>
                            </tr>
                            </thead>
                            <tbody class="divide-y divide-outline-variant/10">
                            <c:forEach var="row" items="${inbodyRows}" varStatus="st">
                                <tr class="hover:bg-surface-container-low transition-colors">

                                    <!-- Date -->
                                    <td class="px-5 py-4 font-semibold text-on-surface whitespace-nowrap">
                                            ${row.recordDate}
                                        <c:if test="${st.first}">
                                            <span class="ml-1.5 px-1.5 py-0.5 bg-primary/10 text-primary text-[9px] font-bold rounded">최신</span>
                                        </c:if>
                                    </td>

                                    <!-- Weight -->
                                    <td class="px-5 py-4 text-right whitespace-nowrap">
                                        <span class="font-semibold text-on-surface">${row.weight}</span>
                                        <c:if test="${row.weightDelta != null}">
                                                <span class="ml-1 text-[10px] font-bold
                                                    ${row.weightDelta < 0 ? 'text-blue-600' : (row.weightDelta > 0 ? 'text-red-500' : 'text-slate-400')}">
                                                    <c:choose>
                                                        <c:when test="${row.weightDelta < 0}">&#9660;${row.weightDelta}</c:when>
                                                        <c:when test="${row.weightDelta > 0}">&#9650;+${row.weightDelta}</c:when>
                                                    </c:choose>
                                                </span>
                                        </c:if>
                                    </td>

                                    <!-- Muscle mass -->
                                    <td class="px-5 py-4 text-right whitespace-nowrap">
                                        <span class="font-semibold text-on-surface">${row.muscleMass}</span>
                                        <c:if test="${row.muscleDelta != null}">
                                                <span class="ml-1 text-[10px] font-bold
                                                    ${row.muscleDelta > 0 ? 'text-green-600' : (row.muscleDelta < 0 ? 'text-red-500' : 'text-slate-400')}">
                                                    <c:choose>
                                                        <c:when test="${row.muscleDelta > 0}">&#9650;+${row.muscleDelta}</c:when>
                                                        <c:when test="${row.muscleDelta < 0}">&#9660;${row.muscleDelta}</c:when>
                                                    </c:choose>
                                                </span>
                                        </c:if>
                                    </td>

                                    <!-- Body fat -->
                                    <td class="px-5 py-4 text-right whitespace-nowrap">
                                        <span class="font-semibold text-on-surface">${row.bodyFat}</span>
                                        <c:if test="${row.fatDelta != null}">
                                                <span class="ml-1 text-[10px] font-bold
                                                    ${row.fatDelta < 0 ? 'text-green-600' : (row.fatDelta > 0 ? 'text-red-500' : 'text-slate-400')}">
                                                    <c:choose>
                                                        <c:when test="${row.fatDelta < 0}">&#9660;${row.fatDelta}</c:when>
                                                        <c:when test="${row.fatDelta > 0}">&#9650;+${row.fatDelta}</c:when>
                                                    </c:choose>
                                                </span>
                                        </c:if>
                                    </td>

                                    <!-- Body fat % -->
                                    <td class="px-5 py-4 text-right whitespace-nowrap">
                                        <span class="font-semibold text-on-surface">${row.fatPct}</span>
                                        <c:if test="${row.fatPctDelta != null}">
                                                <span class="ml-1 text-[10px] font-bold
                                                    ${row.fatPctDelta < 0 ? 'text-green-600' : (row.fatPctDelta > 0 ? 'text-red-500' : 'text-slate-400')}">
                                                    <c:choose>
                                                        <c:when test="${row.fatPctDelta < 0}">&#9660;${row.fatPctDelta}%</c:when>
                                                        <c:when test="${row.fatPctDelta > 0}">&#9650;+${row.fatPctDelta}%</c:when>
                                                    </c:choose>
                                                </span>
                                        </c:if>
                                    </td>

                                    <!-- Image thumbnail -->
                                    <td class="px-5 py-4 text-center whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${not empty row.img}">
                                                <a href="${pageContext.request.contextPath}/uploads/${row.img}"
                                                   target="_blank"
                                                   class="inline-flex items-center gap-1 text-xs text-primary font-semibold hover:underline">
                                                    <span class="material-symbols-outlined text-sm">image</span>
                                                    보기
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-xs text-slate-300">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </section>

            </c:otherwise>
        </c:choose>

    </main>
</div>

<script>
    let chartInstance = null;

    <c:if test="${recordCount >= 2}">
    // Build chart data (rows are newest-first → reverse for chronological order)
    const chartLabels = [];
    const weightData = [];
    const muscleData = [];
    const fatData = [];
    const fatPctData = [];

    const rows = [
        <c:forEach var="row" items="${inbodyRows}" varStatus="st">
        {
            date: '${row.recordDate}',
            weight: ${row.weight},
            muscle: ${row.muscleMass},
            fat: ${row.bodyFat},
            fatPct: ${row.fatPct}
        }<c:if test="${!st.last}">, </c:if>
        </c:forEach>
    ];

    rows.reverse().forEach(r => {
        chartLabels.push(r.date);
        weightData.push(r.weight);
        muscleData.push(r.muscle);
        fatData.push(r.fat);
        fatPctData.push(r.fatPct);
    });

    chartInstance = new Chart(document.getElementById('inbodyChart'), {
        type: 'line',
        data: {
            labels: chartLabels,
            datasets: [
                {
                    label: '체중 (kg)',
                    data: weightData,
                    hidden: false,
                    borderColor: '#0058bc',
                    backgroundColor: 'rgba(0,88,188,0.08)',
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    fill: true
                },
                {
                    label: '골격근량 (kg)',
                    data: muscleData,
                    hidden: true,
                    borderColor: '#16a34a',
                    backgroundColor: 'rgba(22,163,74,0.08)',
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    fill: true
                },
                {
                    label: '체지방량 (kg)',
                    data: fatData,
                    hidden: true,
                    borderColor: '#ea580c',
                    backgroundColor: 'rgba(234,88,12,0.08)',
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    fill: true
                },
                {
                    label: '체지방률 (%)',
                    data: fatPctData,
                    hidden: true,
                    borderColor: '#64748b',
                    backgroundColor: 'rgba(100,116,139,0.08)',
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    fill: true
                }
            ]
        },
        options: {
            animation: false,
            responsive: true,
            interaction: {mode: 'index', intersect: false},
            plugins: {
                legend: {display: false}
            },
            scales: {
                x: {ticks: {font: {size: 11}}, grid: {color: '#f0f0f5'}},
                y: {
                    beginAtZero: false,
                    ticks: {font: {size: 11}, callback: v => v + ' kg'},
                    grid: {color: '#f0f0f5'}
                }
            }
        }
    });
    </c:if>

    let _currentMetric = 'weight';

    function showMetric(metric, el) {
        _currentMetric = metric;

        // Update button active state
        const colours = {
            all: 'text-on-surface',
            weight: 'text-primary',
            muscle: 'text-green-700',
            bodyFat: 'text-tertiary',
            fatPct: 'text-slate-500'
        };
        document.querySelectorAll('.metric-btn').forEach(btn => {
            btn.classList.remove('active-metric-btn', 'bg-white', 'shadow-sm', ...Object.values(colours));
            btn.classList.add('text-on-surface-variant');
        });
        el.classList.remove('text-on-surface-variant');
        el.classList.add('active-metric-btn', 'bg-white', 'shadow-sm', colours[metric] || 'text-primary');

        // Switch chart datasets and y-axis label
        if (chartInstance) {
            const order = ['weight', 'muscle', 'bodyFat', 'fatPct'];
            chartInstance.data.datasets.forEach((ds, i) => {
                ds.hidden = metric !== 'all' && order[i] !== metric;
            });
            // Mixed units when showing all; single unit otherwise
            chartInstance.options.scales.y.ticks.callback =
                metric === 'all'    ? v => v :
                metric === 'fatPct' ? v => v + ' %' :
                                      v => v + ' kg';
            chartInstance.update();
        }
    }
</script>

</body>
</html>
