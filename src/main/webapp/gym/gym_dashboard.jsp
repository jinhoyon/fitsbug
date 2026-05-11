<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitsbug 대시보드</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            colors: {
              "surface-variant": "#e1e2e4",
              "background": "#f8f9fb",
              "outline-variant": "#c2c6d6",
              "on-surface": "#191c1e",
              "on-tertiary-fixed-variant": "#723600",
              "inverse-on-surface": "#f0f1f3",
              "on-error": "#ffffff",
              "error": "#ba1a1a",
              "on-primary-fixed": "#001a42",
              "inverse-primary": "#adc6ff",
              "error-container": "#ffdad6",
              "on-secondary-fixed-variant": "#304671",
              "on-primary-fixed-variant": "#004395",
              "surface-dim": "#d9dadc",
              "secondary-container": "#b6ccff",
              "surface-container-lowest": "#ffffff",
              "surface-container-high": "#e7e8ea",
              "tertiary-fixed-dim": "#ffb786",
              "secondary-fixed-dim": "#b1c6f9",
              "primary-container": "#2170e4",
              "on-primary": "#ffffff",
              "surface-bright": "#f8f9fb",
              "on-secondary-fixed": "#001a42",
              "surface": "#f8f9fb",
              "on-background": "#191c1e",
              "on-tertiary": "#ffffff",
              "on-primary-container": "#fefcff",
              "tertiary-container": "#b75b00",
              "on-secondary-container": "#405682",
              "primary": "#3B82F6",
              "tertiary": "#924700",
              "inverse-surface": "#2e3132",
              "primary-fixed": "#d8e2ff",
              "surface-container": "#edeef0",
              "secondary-fixed": "#d8e2ff",
              "tertiary-fixed": "#ffdcc6",
              "outline": "#727785",
              "on-error-container": "#93000a",
              "surface-container-highest": "#e1e2e4",
              "surface-container-low": "#f3f4f6",
              "on-tertiary-container": "#fffbff",
              "primary-fixed-dim": "#adc6ff",
              "on-secondary": "#ffffff",
              "secondary": "#495e8a",
              "on-tertiary-fixed": "#311400",
              "surface-tint": "#3B82F6",
              "on-surface-variant": "#424754"
            },
            fontFamily: {
              "headline": ["Inter"],
              "body": ["Inter"],
              "label": ["Inter"]
            },
            borderRadius: {"DEFAULT": "8px", "lg": "8px", "xl": "24px", "full": "9999px"},
          },
        },
      }
    </script>
<style>
      .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
      }
      .glass-nav {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(20px);
      }
      body {
        font-family: 'Inter', sans-serif;
        background-color: #f8f9fb;
        color: #191c1e;
      }
      .chart-transition {
        transition: d 0.3s ease-in-out;
      }
    </style>
</head>
<body class="antialiased overflow-x-hidden">
<jsp:include page="common/sidebar.jsp"></jsp:include>

<!-- Main Content Canvas -->
<main class="ml-64 pt-16 min-h-screen bg-surface">
<div class="p-8">

<!-- Content Header -->
<div class="mb-8">
<h2 class="text-2xl font-black text-on-surface tracking-tight" style="">대시보드</h2>
</div>

<!-- Top Section: Key Statistics (Bento Style) -->
<section class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">

<!-- User Analytics Card -->
<a href="${pageContext.request.contextPath}/gym/memberManage"
   class="md:col-span-1 block bg-surface-container-lowest p-6 rounded-lg 
          shadow-[0_4px_24px_rgba(0,0,0,0.04)] border border-outline-variant/15 
          flex flex-col justify-between h-full hover:shadow-lg transition cursor-pointer">

    <div>
        <span class="label-sm text-[0.6875rem] font-bold text-on-surface-variant uppercase">
            User Analytics
        </span>
        <h3 class="text-on-surface font-medium text-lg mt-1">
            이번 달 신규 회원
        </h3>
    </div>

    <div class="flex items-baseline gap-4 mt-4">
        <span class="text-4xl font-black">
            <fmt:formatNumber value="${dashboard.newMemberCount}" />
        </span>
        <div class="flex items-center text-primary font-bold text-sm">
            <span class="material-symbols-outlined text-sm mr-1">trending_up</span>
            <span>${dashboard.newMemberGrowthRate}%</span>
        </div>
    </div>

    <div class="mt-6 space-y-3">
        <div class="flex justify-between text-[10px] font-bold text-on-surface-variant uppercase">
            <span>신규 이용권 분포</span>
        </div>

        <div class="space-y-2">
            <c:forEach var="dist" items="${dashboard.membershipDistributionList}">
                <div class="space-y-1">
                    <div class="flex justify-between text-[9px]">
                        <span>${dist.month}개월</span>
                        <span>${dist.percent}%</span>
                    </div>
                    <div class="h-1.5 w-full bg-surface-container-low rounded-full">
                        <div class="h-full bg-primary rounded-full"
                             style="width: ${dist.percent}%"></div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</a>

<!-- Today's Scheduled Sessions Card -->
<div class="md:col-span-3 bg-surface-container-lowest p-6 rounded-lg shadow-[0_4px_24px_rgba(0,0,0,0.04)] border border-outline-variant/15">
<div class="flex justify-between items-center mb-4">
<div>
<span class="label-sm text-[0.6875rem] font-bold text-on-surface-variant tracking-[0.05em] uppercase" style="">Today's Schedule</span>
<h3 class="text-on-surface font-medium text-lg mt-1" style="">오늘의 예약 일정</h3>
</div>
<a href="${pageContext.request.contextPath}/gym/schedule"
   class="text-xs font-bold text-primary hover:underline uppercase tracking-wider">
    전체보기
</a>
</div>
<div class="overflow-x-auto">
<table class="w-full text-left">
<thead>
<tr class="border-b border-outline-variant/10 text-[10px] font-bold text-on-surface-variant uppercase tracking-wider">
<th class="pb-3 px-2" style="">시간</th>
<th class="pb-3 px-2" style="">트레이너</th>
<th class="pb-3 px-2" style="">회원명</th>
<th class="pb-3 px-2" style="">결제 이용권</th><th class="pb-3 px-2 text-right" style="">상태</th>
</tr>
</thead>
<tbody class="text-xs">
<c:choose>
    <c:when test="${empty dashboard.todayScheduleList}">
        <tr>
            <td colspan="5" class="py-6 px-2 text-center text-on-surface-variant">
                오늘 예약된 PT 일정이 없습니다.
            </td>
        </tr>
    </c:when>

    <c:otherwise>
        <c:forEach var="schedule" items="${dashboard.todayScheduleList}">
            <tr class="border-b border-outline-variant/5 hover:bg-surface-container-low/50 transition-colors">
                <td class="py-3 px-2 font-bold">${schedule.startTime}</td>
                <td class="py-3 px-2">${schedule.trainerName}</td>
                <td class="py-3 px-2 text-on-surface-variant">${schedule.memberName}</td>
                <td class="py-3 px-2 text-on-surface-variant">${schedule.membershipName}</td>
                <td class="py-3 px-2 text-right">
                    <c:choose>
                        <c:when test="${schedule.status eq '예약완료'}">
                            <span class="bg-primary/10 text-primary px-2 py-0.5 rounded-full font-bold text-[10px]">예정</span>
                        </c:when>
                        <c:when test="${schedule.status eq '완료'}">
                            <span class="bg-surface-container-high text-on-surface-variant px-2 py-0.5 rounded-full font-bold text-[10px]">종료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="bg-error-container text-on-error-container px-2 py-0.5 rounded-full font-bold text-[10px]">취소</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </c:otherwise>
</c:choose>
</tbody>
</table>
</div>
</div>
</section>

<!-- Middle Section: Charts -->
<section class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-12">

<!-- Weekly Traffic -->
<div class="bg-surface-container-lowest p-8 rounded-lg shadow-[0_4px_24px_rgba(0,0,0,0.04)] border border-outline-variant/15">
<div class="flex justify-between items-center mb-8">
<h3 class="text-xl font-bold tracking-tight" style="">주간 방문 현황</h3>
<form action="${pageContext.request.contextPath}/gym/dashboard" method="get" class="flex gap-2">
    <input type="date" name="weekStart"
           value="${dashboard.weekStart}"
           class="text-[10px] font-bold bg-surface-container-low rounded-lg border-none px-3 py-1.5">

    <button type="submit"
            class="px-3 py-1.5 bg-primary text-white rounded-lg text-[10px] font-bold">
        조회
    </button>
</form>
</div>
<div class="flex items-end justify-between h-64 gap-2">
    <c:choose>
        <c:when test="${empty dashboard.weeklyVisitList}">
            <div class="w-full text-center text-xs text-on-surface-variant">
                방문 데이터가 없습니다.
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="visit" items="${dashboard.weeklyVisitList}">
    <div class="flex flex-col items-center flex-1 h-full gap-2">

        <!-- 막대 영역 -->
        <div class="flex items-end w-full h-full">
            
            <!-- 실제 막대 -->
            <div class="w-full bg-primary rounded-t-lg min-h-[18px] 
                        flex items-center justify-center"
                 style="height: ${visit.heightPercent == 0 ? 5 : visit.heightPercent}%">

                <!-- 숫자 (가운데) -->
                <span class="text-[10px] font-bold text-white">
                    ${visit.visitCount}
                </span>

            </div>

        </div>

        <!-- 요일 -->
        <div class="flex flex-col items-center leading-tight">
    <span class="text-[10px] font-bold text-on-surface-variant">
        ${visit.dayName}
    </span>
    <span class="text-[9px] font-medium text-on-surface-variant opacity-70">
        ${visit.dateLabel}
    </span>
</div>

    </div>
</c:forEach>
        </c:otherwise>
    </c:choose>
</div>
</div>

<!-- Hourly Congestion -->
<div class="bg-surface-container-lowest p-8 rounded-lg shadow-[0_4px_24px_rgba(0,0,0,0.04)] border border-outline-variant/15">
<div class="flex justify-between items-center mb-4">
<h3 class="text-xl font-bold tracking-tight" style="">시간대별 혼잡도</h3>
<div class="flex items-center gap-2">
<div class="w-2 h-2 rounded-full bg-primary"></div>
<span class="text-[10px] font-bold" id="peak-time-label" style="">PEAK TIME: - </span>
</div>
</div>
<!-- Day Selector Tabs -->
<form id="hotTimeForm"
      action="${pageContext.request.contextPath}/gym/dashboard"
      method="get"
      class="flex flex-wrap items-center gap-4 mb-6">

    <input type="hidden" name="weekStart" value="${dashboard.weekStart}">

    <div class="flex p-1 bg-surface-container-low rounded-lg w-fit">

    <button type="button"
class="px-4 py-1.5 text-[10px] font-bold rounded-md transition-all day-tab
${selectedDay eq 'MON' ? 'bg-surface-container-lowest shadow-sm text-primary' : 'text-on-surface-variant'}"
data-day="MON">MON</button>

<button type="button"
class="px-4 py-1.5 text-[10px] font-bold rounded-md transition-all day-tab
${selectedDay eq 'TUE' ? 'bg-surface-container-lowest shadow-sm text-primary' : 'text-on-surface-variant'}"
data-day="TUE">TUE</button>

<button type="button"
class="px-4 py-1.5 text-[10px] font-bold rounded-md transition-all day-tab
${selectedDay eq 'WED' ? 'bg-surface-container-lowest shadow-sm text-primary' : 'text-on-surface-variant'}"
data-day="WED">WED</button>

<button type="button"
class="px-4 py-1.5 text-[10px] font-bold rounded-md transition-all day-tab
${selectedDay eq 'THU' ? 'bg-surface-container-lowest shadow-sm text-primary' : 'text-on-surface-variant'}"
data-day="THU">THU</button>

<button type="button"
class="px-4 py-1.5 text-[10px] font-bold rounded-md transition-all day-tab
${selectedDay eq 'FRI' ? 'bg-surface-container-lowest shadow-sm text-primary' : 'text-on-surface-variant'}"
data-day="FRI">FRI</button>

<button type="button"
class="px-4 py-1.5 text-[10px] font-bold rounded-md transition-all day-tab
${selectedDay eq 'SAT' ? 'bg-surface-container-lowest shadow-sm text-primary' : 'text-on-surface-variant'}"
data-day="SAT">SAT</button>

<button type="button"
class="px-4 py-1.5 text-[10px] font-bold rounded-md transition-all day-tab
${selectedDay eq 'SUN' ? 'bg-surface-container-lowest shadow-sm text-primary' : 'text-on-surface-variant'}"
data-day="SUN">SUN</button>

    

</div>

    <div class="relative">
        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <span class="material-symbols-outlined text-sm text-on-surface-variant">calendar_today</span>
        </div>
        <input id="congestionDate"
               name="selectedDate"
               class="block w-full pl-9 pr-3 py-1.5 text-[10px] font-bold border-none bg-surface-container-low rounded-lg focus:ring-1 focus:ring-primary text-on-surface-variant"
               type="date"
               value="${dashboard.todayDate}">
    </div>
</form>
<div class="relative h-48 w-full border-b border-l border-outline-variant/20">
<svg class="w-full h-full" viewBox="0 0 400 100">
<defs>
<linearGradient id="grad" x1="0%" x2="0%" y1="0%" y2="100%">
<stop offset="0%" style="stop-color:rgba(59, 130, 246, 0.2); stop-opacity:1"></stop>
<stop offset="100%" style="stop-color:rgba(59, 130, 246, 0); stop-opacity:1"></stop>
</linearGradient>
</defs>
<path id="chart-area"
      fill="url(#grad)"
      d="M0,90 L400,90 V100 H0 Z">
</path>

<path id="chart-line"
      stroke="#3B82F6"
      stroke-width="3"
      fill="none"
      stroke-linecap="round"
      stroke-linejoin="round"
      d="M0,90 L400,90">
</path>

<circle id="chart-peak-dot"
        cx="0"
        cy="90"
        r="5"
        fill="#3B82F6">
</circle>
</svg>
<div class="absolute bottom-0 left-0 w-full flex justify-between px-2 pt-2 -mb-6">
<span class="text-[9px] font-bold opacity-50 uppercase" style="">06:00</span>
<span class="text-[9px] font-bold opacity-50 uppercase" style="">12:00</span>
<span class="text-[9px] font-bold opacity-50 uppercase" style="">18:00</span>
<span class="text-[9px] font-bold opacity-50 uppercase" style="">00:00</span>
</div>
</div>
</div>
</section>
<!-- Revenue Overview Section -->
<section class="mb-12">
<div class="mb-6">
<span class="label-sm text-[0.6875rem] font-bold text-on-surface-variant tracking-[0.05em] uppercase" style=""></span>
<h3 class="text-2xl font-black tracking-tighter mt-1" style="">매출 현황 요약</h3>
</div>
<!-- 5 Key Stats Cards -->
<div class="grid grid-cols-1 gap-4 mb-8 md:grid-cols-3">
<!-- Total Revenue -->
<a href="${pageContext.request.contextPath}/gym/sales"
   class="block bg-surface-container-lowest p-6 rounded-lg border border-outline-variant/15 shadow-sm flex flex-col justify-between group hover:shadow-md transition-shadow h-36 cursor-pointer">

    <div class="flex justify-between items-start">
        <div class="w-10 h-10 bg-primary/10 rounded-full flex items-center justify-center text-primary">
            <span class="material-symbols-outlined text-xl">account_balance_wallet</span>
        </div>
        <span class="text-[10px] font-bold bg-emerald-100 text-emerald-700 px-2 py-0.5 rounded-full">
            +${dashboard.totalRevenueGrowthRate}%
        </span>
    </div>

    <div class="mt-4">
        <p class="text-on-surface-variant text-[10px] font-bold uppercase tracking-wider">
            총 매출액 (이번 달)
        </p>
        <h3 class="text-lg font-black text-on-surface">
            <fmt:formatNumber value="${dashboard.totalRevenue}" />
            <span class="text-[10px] font-medium text-on-surface-variant">원</span>
        </h3>
    </div>

</a>

<!-- Membership Sales -->
<a href="${pageContext.request.contextPath}/gym/sales"
   class="block bg-surface-container-lowest p-6 rounded-lg border border-outline-variant/15 shadow-sm flex flex-col justify-between group hover:shadow-md transition-shadow h-36 cursor-pointer">
<div class="flex justify-between items-start">
<div class="w-10 h-10 bg-secondary/10 rounded-full flex items-center justify-center text-secondary">
<span class="material-symbols-outlined text-xl" style="">card_membership</span>
</div>
<span class="text-[10px] font-bold bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full" style="">+<span>${dashboard.membershipGrowthRate}%</span></span>
</div>
<div class="mt-4">
<p class="text-on-surface-variant text-[10px] font-bold uppercase tracking-wider" style="">이용권 판매액 (이번 달)</p>
<h3 class="text-lg font-black text-on-surface" style="">
    <fmt:formatNumber value="${dashboard.membershipRevenue}" />
    <span class="text-[10px] font-medium text-on-surface-variant">원</span>
</h3>
</div>
</a>

<!-- PT Session Sales -->
<a href="${pageContext.request.contextPath}/gym/sales"
   class="block bg-surface-container-lowest p-6 rounded-lg border border-outline-variant/15 shadow-sm flex flex-col justify-between group hover:shadow-md transition-shadow h-36 cursor-pointer">
<div class="flex justify-between items-start">
<div class="w-10 h-10 bg-tertiary/10 rounded-full flex items-center justify-center text-tertiary">
<span class="material-symbols-outlined text-xl" style="">fitness_center</span>
</div>
<span class="text-[10px] font-bold bg-orange-100 text-orange-700 px-2 py-0.5 rounded-full" style="">+<span>${dashboard.ptGrowthRate}%</span></span>
</div>
<div class="mt-4">
<p class="text-on-surface-variant text-[10px] font-bold uppercase tracking-wider" style="">PT 세션 판매액 (이번 달)</p>
<h3 class="text-lg font-black text-on-surface" style="">
    <fmt:formatNumber value="${dashboard.ptRevenue}" />
    <span class="text-[10px] font-medium text-on-surface-variant">원</span>
</h3> 
</div>
</a>

<!-- Gym 1-Day Pass -->
<!-- PT 1-Session Pass -->
</div>

<!-- Secondary Revenue Data -->
<div class="grid grid-cols-1 lg:grid-cols-2 gap-8 md:grid-cols-3">

<!-- Revenue Trends Chart -->
<div class="bg-surface-container-lowest p-6 rounded-lg border border-outline-variant/15 shadow-sm">
<div class="flex justify-between items-center mb-6">
<div class="flex items-center gap-4">
<h4 class="font-bold text-on-surface text-lg" style="">기간 별 매출 추이</h4>
<a href="${pageContext.request.contextPath}/gym/sales"
   class="bg-[#3B82F6] text-white px-3 py-1 rounded-[8px] text-[10px] font-bold hover:opacity-90 transition-opacity">
    자세히 보기
</a>
</div>
<div class="flex gap-2">
<span class="flex items-center gap-1.5 text-[10px] font-bold text-on-surface-variant uppercase" style=""><span class="w-2 h-2 rounded-full bg-primary"></span>이용권</span>
<span class="flex items-center gap-1.5 text-[10px] font-bold text-on-surface-variant uppercase" style=""><span class="w-2 h-2 rounded-full bg-secondary"></span>PT 세션</span>
</div>
</div>
<div class="h-48 flex items-end justify-between gap-4 px-2">
<c:forEach var="rev" items="${dashboard.revenueTrendList}">
    <div class="flex-1 bg-surface-container-low rounded-t-lg relative group"
         style="height: ${rev.totalPercent}%">
        <div class="absolute inset-x-0 bottom-0 bg-primary rounded-t-lg"
             style="height: ${rev.membershipPercent}%"></div>
    </div>
</c:forEach>
</div>

<div class="flex justify-between mt-4 text-[10px] font-bold text-on-surface-variant uppercase">
<c:forEach var="rev" items="${dashboard.revenueTrendList}">
    <span>${rev.month}월</span>
</c:forEach>
</div>
</div>

<!-- Top Revenue Trainers -->
<div class="bg-surface-container-lowest p-6 rounded-lg border border-outline-variant/15 shadow-sm">
<div class="flex justify-between items-center mb-6">
<h4 class="font-bold text-on-surface text-lg" style="">최고 매출 트레이너</h4>
<a href="${pageContext.request.contextPath}/gym/sales"
   class="text-[10px] font-bold text-primary hover:underline uppercase tracking-wider">
    전체보기
</a>
</div>
<div class="space-y-4">
<c:choose>
    <c:when test="${empty dashboard.topTrainerList}">
        <div class="p-4 text-center text-xs text-on-surface-variant">
            이번 달 트레이너 매출 데이터가 없습니다.
        </div>
    </c:when>

    <c:otherwise>
        <c:forEach var="trainer" items="${dashboard.topTrainerList}">
            <div class="flex items-center justify-between p-3 bg-surface-container-low rounded-lg border border-transparent hover:border-primary/20 transition-colors">
                <div class="flex items-center gap-3">
                    
                    <div>
                        <p class="text-xs font-bold text-on-surface">${trainer.trainerName}</p>
                        <p class="text-[10px] text-on-surface-variant">
                            이번 달 세션 수: ${trainer.sessionCount}
                        </p>
                    </div>
                </div>

                <span class="text-sm font-bold text-primary">
                    <fmt:formatNumber value="${trainer.revenue}" />원
                </span>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
</div>
</div>
</div>
</section>
</div>
</main>
<div id="hotTimeData" class="hidden">
<c:forEach var="h" items="${dashboard.hotTimeList}">
${h.hour},${h.heightPercent},${h.visitCount}|
</c:forEach>
</div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("hotTimeForm");
    const tabs = document.querySelectorAll(".day-tab");
    const chartLine = document.getElementById("chart-line");
    const chartArea = document.getElementById("chart-area");
    const peakDot = document.getElementById("chart-peak-dot");
    const peakLabel = document.getElementById("peak-time-label");
    const congestionDate = document.getElementById("congestionDate");

    const rawData = document.getElementById("hotTimeData").innerText.trim();

    const data = rawData
        .split("|")
        .filter(row => row.trim() !== "")
        .map(row => {
            const [hour, percent, count] = row.trim().split(",");
            return {
                hour: parseInt(hour),
                percent: parseInt(percent),
                count: parseInt(count)
            };
        });

    function drawChart(data) {
        if (data.length === 0) {
            chartLine.setAttribute("d", "M0,90 L400,90");
            chartArea.setAttribute("d", "M0,90 L400,90 V100 H0 Z");
            peakDot.setAttribute("cx", 0);
            peakDot.setAttribute("cy", 90);
            peakLabel.textContent = "PEAK TIME: -";
            return;
        }

        const maxHour = 24;
        let path = "";
        let area = "";

        data.forEach((d, i) => {
            const x = (d.hour / maxHour) * 400;
            const y = 100 - d.percent;

            if (i === 0) {
            	path += "M" + x + "," + y;
            	area += "M" + x + ",100 L" + x + "," + y;
            } else {
            	path += " L" + x + "," + y;
            	area += " L" + x + "," + y;
            }
        });

        const lastX = (data[data.length - 1].hour / maxHour) * 400;
        area += " L" + lastX + ",100 Z";

        chartLine.setAttribute("d", path);
        chartArea.setAttribute("d", area);

        const peak = data.reduce((max, cur) =>
            cur.count > max.count ? cur : max
        );

        const peakX = (peak.hour / maxHour) * 400;
        const peakY = 100 - peak.percent;

        peakDot.setAttribute("cx", peakX);
        peakDot.setAttribute("cy", peakY);
        peakLabel.textContent =  "PEAK TIME: " + peak.hour + ":00 ~ " + (peak.hour + 1) + ":00";
    }

    function getDateOfCurrentWeek(day) {
        const dayIndex = { MON: 1, TUE: 2, WED: 3, THU: 4, FRI: 5, SAT: 6, SUN: 7 };

        const today = new Date(congestionDate.value || new Date());
        const currentDay = today.getDay() === 0 ? 7 : today.getDay();

        const monday = new Date(today);
        monday.setDate(today.getDate() - currentDay + 1);

        const targetDate = new Date(monday);
        targetDate.setDate(monday.getDate() + dayIndex[day] - 1);

        return targetDate.toISOString().slice(0, 10);
    }

    drawChart(data);

    tabs.forEach(tab => {
        tab.addEventListener("click", () => {

            // 선택 표시 변경
            tabs.forEach(t => {
                t.classList.remove("bg-surface-container-lowest", "shadow-sm", "text-primary");
                t.classList.add("text-on-surface-variant");
            });

            tab.classList.add("bg-surface-container-lowest", "shadow-sm", "text-primary");
            tab.classList.remove("text-on-surface-variant");

            const day = tab.dataset.day;
            congestionDate.value = getDateOfCurrentWeek(day);

            form.submit();
        });
    });

    congestionDate.addEventListener("change", () => {
        form.submit();
    });
});
</script>

</body>
</html>