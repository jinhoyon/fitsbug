<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitsbug - 일정</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script id="tailwind-config">tailwind.config = { darkMode: "class", theme: { extend: { colors: { "tertiary-container": "#c64f00", "error-container": "#ffdad6", "primary-fixed": "#d8e2ff", "on-primary-fixed-variant": "#004493", surface: "#f9f9fe", "secondary-fixed-dim": "#adc6ff", "secondary-fixed": "#d8e2ff", "on-background": "#1a1c1f", "surface-container-high": "#e8e8ed", "surface-container-lowest": "#ffffff", "surface-variant": "#e2e2e7", "surface-dim": "#d9dade", "on-error": "#ffffff", "surface-tint": "#005bc1", "on-surface": "#1a1c1f", "inverse-on-surface": "#f0f0f5", tertiary: "#9e3d00", primary: "#0058bc", "on-tertiary-container": "#fffbff", "on-tertiary": "#ffffff", "on-error-container": "#93000a", error: "#ba1a1a", "surface-container-highest": "#e2e2e7", "primary-container": "#0070eb", "on-secondary-container": "#2d4c83", "on-tertiary-fixed": "#351000", "on-primary": "#ffffff", "surface-container-low": "#f3f3f8", "outline-variant": "#c1c6d7", "on-secondary-fixed": "#001a41", "on-primary-container": "#fefcff", "on-primary-fixed": "#001a41", secondary: "#405e96", "on-surface-variant": "#414755", "tertiary-fixed": "#ffdbcc", "surface-container": "#ededf2", "tertiary-fixed-dim": "#ffb595", "primary-fixed-dim": "#adc6ff", outline: "#717786", "on-tertiary-fixed-variant": "#7c2e00", "surface-bright": "#f9f9fe", "secondary-container": "#a1befd", "on-secondary": "#ffffff", "inverse-surface": "#2e3034", "on-secondary-fixed-variant": "#26467d", "inverse-primary": "#adc6ff", background: "#f9f9fe" }, borderRadius: { DEFAULT: "0.125rem", lg: "0.25rem", xl: "0.5rem", full: "0.75rem" }, fontFamily: { headline: ["Inter"], body: ["Inter"], label: ["Inter"], display: "Inter" } } } };</script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }

        /* Lesson card colours (clientId % 5) */
        .lc-0 { background: #dbeafe; color: #1d4ed8; border-left: 3px solid #2563eb; }
        .lc-1 { background: #dcfce7; color: #15803d; border-left: 3px solid #16a34a; }
        .lc-2 { background: #ede9fe; color: #5b21b6; border-left: 3px solid #7c3aed; }
        .lc-3 { background: #ffedd5; color: #c2410c; border-left: 3px solid #ea580c; }
        .lc-4 { background: #fce7f3; color: #9d174d; border-left: 3px solid #db2777; }

        /* 1px horizontal line every 80px (= 1 hour) */
        .time-grid-bg {
            background-image: repeating-linear-gradient(
                to bottom,
                transparent       0px,
                transparent      79px,
                #f0f0f5           79px,
                #f0f0f5           80px
            );
        }

        /* Hide scrollbar visually but keep scroll */
        #cal-scroll::-webkit-scrollbar { width: 6px; }
        #cal-scroll::-webkit-scrollbar-track { background: transparent; }
        #cal-scroll::-webkit-scrollbar-thumb { background: #c1c6d7; border-radius: 3px; }
    </style>
</head>

<body class="bg-white text-on-surface overflow-hidden h-screen">

<!-- SideNavBar -->
<c:set var="activePage" value="calendar" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>

<%-- ═════════════════════════════════════════════════════════════ MAIN ════ --%>
<main class="lg:pl-64 flex flex-col h-screen overflow-hidden">

    <%-- ── Sub-header: view toggle + navigation ── --%>
    <div class="flex-shrink-0 flex items-center justify-between px-5 h-14 border-b border-gray-100 bg-white">

        <%-- View toggle --%>
        <div class="flex items-center bg-surface-container-low rounded-lg p-1 gap-0.5">
            <a href="${pageContext.request.contextPath}/trainer/calendar?view=day&date=${selectedDate}"
               class="px-3 py-1.5 rounded-md text-xs font-semibold transition-colors ${view == 'day' ? 'bg-white shadow text-primary' : 'text-outline hover:text-on-surface'}">일</a>
            <a href="${pageContext.request.contextPath}/trainer/calendar?view=week&date=${selectedDate}"
               class="px-3 py-1.5 rounded-md text-xs font-semibold transition-colors ${view == 'week' ? 'bg-white shadow text-primary' : 'text-outline hover:text-on-surface'}">주</a>
            <a href="${pageContext.request.contextPath}/trainer/calendar?view=month&date=${selectedDate}"
               class="px-3 py-1.5 rounded-md text-xs font-semibold transition-colors ${view == 'month' ? 'bg-white shadow text-primary' : 'text-outline hover:text-on-surface'}">월</a>
        </div>

        <%-- Navigation --%>
        <div class="flex items-center gap-1">
            <a href="${pageContext.request.contextPath}/trainer/calendar?view=${view}&date=${prevDate}"
               class="p-1.5 hover:bg-surface-container-low rounded-full transition-colors text-on-surface-variant">
                <span class="material-symbols-outlined text-xl">chevron_left</span>
            </a>
            <span class="text-sm font-bold text-on-surface w-52 text-center">${dateLabel}</span>
            <a href="${pageContext.request.contextPath}/trainer/calendar?view=${view}&date=${nextDate}"
               class="p-1.5 hover:bg-surface-container-low rounded-full transition-colors text-on-surface-variant">
                <span class="material-symbols-outlined text-xl">chevron_right</span>
            </a>
        </div>

        <%-- Today button --%>
        <a href="${pageContext.request.contextPath}/trainer/calendar?view=${view}&date=${todayDate}"
           class="text-xs font-bold text-primary hover:bg-primary/10 px-3 py-1.5 rounded-lg transition-colors">오늘</a>
    </div>

    <%-- ── Week view: sticky day-name column headers ── --%>
    <c:if test="${view == 'week'}">
        <div class="flex-shrink-0 border-b border-gray-100 bg-white"
             style="display:grid; grid-template-columns:56px repeat(7,1fr);">
            <div class="h-12 border-r border-gray-100"></div>
            <c:forEach items="${weekColumns}" var="col">
                <a href="${pageContext.request.contextPath}/trainer/calendar?view=day&date=${col.dateStr}"
                   class="h-12 flex flex-col items-center justify-center border-l border-gray-100 hover:bg-gray-50 transition-colors ${col.isToday ? 'bg-blue-50' : ''}">
                    <span class="text-[10px] font-bold uppercase tracking-wider ${col.isToday ? 'text-primary' : 'text-slate-400'}">${col.dayName}</span>
                    <span class="text-base font-bold mt-0.5 ${col.isToday ? 'text-primary' : 'text-on-surface'}">${col.dayNum}</span>
                </a>
            </c:forEach>
        </div>
    </c:if>

    <%-- ── Month view: day-of-week header row ── --%>
    <c:if test="${view == 'month'}">
        <div class="flex-shrink-0 grid grid-cols-7 border-b border-gray-100 bg-white">
            <c:forEach items="${['월','화','수','목','금','토','일']}" var="dow">
                <div class="h-8 flex items-center justify-center text-[10px] font-bold text-slate-400 uppercase tracking-wider">${dow}</div>
            </c:forEach>
        </div>
    </c:if>

    <%-- ════════════════════════════ SCROLLABLE CONTENT ════════════════════ --%>
    <div id="cal-scroll" class="flex-1 overflow-y-auto">

        <%-- ────────────────────────── DAY VIEW ─────────────────────────── --%>
        <%-- Grid runs 06:00 – 24:00  (18 h × 80 px = 1440 px)           --%>
        <c:if test="${view == 'day'}">
            <div style="display:grid; grid-template-columns:56px 1fr; height:1440px; position:relative;">

                <%-- Time labels — offset so row 0 = 06:00 --%>
                <div class="relative border-r border-gray-100" style="height:1440px;">
                    <c:forEach begin="6" end="23" var="h">
                        <div style="position:absolute; top:${(h-6) * 80}px; right:0; height:80px; width:100%;
                                    display:flex; align-items:flex-start; justify-content:flex-end;
                                    padding-right:8px; padding-top:4px;">
                            <span style="font-size:10px; color:#717786; font-weight:500; white-space:nowrap;">
                                <c:choose>
                                    <c:when test="${h < 10}">0${h}:00</c:when>
                                    <c:otherwise>${h}:00</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </c:forEach>
                    <%-- Midnight label at the very bottom --%>
                    <div style="position:absolute; top:1440px; right:0; width:100%;
                                display:flex; align-items:flex-start; justify-content:flex-end;
                                padding-right:8px; padding-top:4px; transform:translateY(-100%);">
                        <span style="font-size:10px; color:#717786; font-weight:500; white-space:nowrap;">24:00</span>
                    </div>
                </div>

                <%-- Day column — lesson topPx is midnight-relative so subtract 480 px (6 h) --%>
                <div class="relative time-grid-bg ${isToday ? 'bg-blue-50/20' : ''}" style="height:1440px;">

                    <%-- Current time indicator (only if viewing today) --%>
                    <c:if test="${isToday}">
                        <div class="time-indicator absolute left-0 right-0 z-20 pointer-events-none flex items-center" style="top:0;">
                            <div class="w-2 h-2 rounded-full bg-primary flex-shrink-0 -ml-1 shadow-sm"></div>
                            <div class="flex-1 h-0.5 bg-primary"></div>
                        </div>
                    </c:if>

                    <%-- Lesson cards --%>
                    <c:choose>
                        <c:when test="${empty dayLessons}">
                            <div class="absolute inset-0 flex items-center justify-center pointer-events-none">
                                <p class="text-sm text-slate-400 font-medium">오늘 예약된 수업이 없습니다</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${dayLessons}" var="lesson">
                                <div style="position:absolute; top:${lesson.topPx - 480}px; height:${lesson.heightPx}px; left:6px; right:6px; z-index:10;"
                                     class="lc-${lesson.clientId % 5} rounded-xl overflow-hidden cursor-pointer hover:opacity-90 transition-opacity shadow-sm p-2">
                                    <c:choose>
                                        <c:when test="${lesson.heightPx < 32}">
                                            <div style="font-size:10px; font-weight:700; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.memberName}</div>
                                        </c:when>
                                        <c:when test="${lesson.heightPx < 56}">
                                            <div style="font-size:11px; font-weight:700; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.memberName}</div>
                                            <div style="font-size:10px; opacity:.7; margin-top:1px;">${lesson.startTime} – ${lesson.endTime}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="font-size:12px; font-weight:700; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.memberName}</div>
                                            <div style="font-size:10px; opacity:.7; margin-top:2px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.goal}</div>
                                            <div style="font-size:10px; margin-top:4px; font-weight:600;">${lesson.startTime} – ${lesson.endTime}</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>

        <%-- ───────────────────────── WEEK VIEW ─────────────────────────── --%>
        <%-- Grid runs 06:00 – 24:00  (18 h × 80 px = 1440 px)           --%>
        <c:if test="${view == 'week'}">
            <div style="display:grid; grid-template-columns:56px repeat(7,1fr); height:1440px; position:relative;">

                <%-- Time labels column — offset so row 0 = 06:00 --%>
                <div class="relative border-r border-gray-100" style="height:1440px;">
                    <c:forEach begin="6" end="23" var="h">
                        <div style="position:absolute; top:${(h-6) * 80}px; right:0; height:80px; width:100%;
                                    display:flex; align-items:flex-start; justify-content:flex-end;
                                    padding-right:8px; padding-top:4px;">
                            <span style="font-size:10px; color:#717786; font-weight:500; white-space:nowrap;">
                                <c:choose>
                                    <c:when test="${h < 10}">0${h}:00</c:when>
                                    <c:otherwise>${h}:00</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </c:forEach>
                    <%-- Midnight label at the very bottom --%>
                    <div style="position:absolute; top:1440px; right:0; width:100%;
                                display:flex; align-items:flex-start; justify-content:flex-end;
                                padding-right:8px; padding-top:4px; transform:translateY(-100%);">
                        <span style="font-size:10px; color:#717786; font-weight:500; white-space:nowrap;">24:00</span>
                    </div>
                </div>

                <%-- 7 day columns — lesson topPx is midnight-relative so subtract 480 px (6 h) --%>
                <c:forEach items="${weekColumns}" var="col">
                    <div class="relative border-l border-gray-100 time-grid-bg ${col.isToday ? 'bg-blue-50/20' : ''}"
                         style="height:1440px;">

                        <%-- Current time indicator on today's column --%>
                        <c:if test="${col.isToday}">
                            <div class="time-indicator absolute left-0 right-0 z-20 pointer-events-none flex items-center" style="top:0;">
                                <div class="w-2 h-2 rounded-full bg-primary flex-shrink-0 -ml-1 shadow-sm"></div>
                                <div class="flex-1 h-0.5 bg-primary"></div>
                            </div>
                        </c:if>

                        <%-- Lesson cards --%>
                        <c:forEach items="${col.lessons}" var="lesson">
                            <div style="position:absolute; top:${lesson.topPx - 480}px; height:${lesson.heightPx}px; left:2px; right:2px; z-index:10;"
                                 class="lc-${lesson.clientId % 5} rounded-lg overflow-hidden cursor-pointer hover:opacity-90 transition-opacity shadow-sm p-1.5">
                                <c:choose>
                                    <c:when test="${lesson.heightPx < 32}">
                                        <div style="font-size:9px; font-weight:700; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.memberName}</div>
                                    </c:when>
                                    <c:when test="${lesson.heightPx < 56}">
                                        <div style="font-size:10px; font-weight:700; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.memberName}</div>
                                        <div style="font-size:9px; opacity:.7; margin-top:1px;">${lesson.startTime}</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="font-size:10px; font-weight:700; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.memberName}</div>
                                        <div style="font-size:9px; opacity:.7; margin-top:1px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${lesson.goal}</div>
                                        <div style="font-size:9px; margin-top:3px; font-weight:600;">${lesson.startTime}</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <%-- ──────────────────────── MONTH VIEW ──────────────────────────── --%>
        <c:if test="${view == 'month'}">
            <div class="grid grid-cols-7" style="min-height:100%;">
                <c:forEach items="${monthGrid}" var="cell">
                    <c:choose>
                        <c:when test="${cell.blank}">
                            <div class="min-h-24 border-b border-r border-gray-100 bg-gray-50/50"></div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/trainer/calendar?view=day&date=${cell.dateStr}"
                               class="min-h-24 border-b border-r border-gray-100 p-2 flex flex-col gap-1 hover:bg-gray-50 transition-colors cursor-pointer group ${cell.isToday ? 'bg-blue-50/40' : ''}">
                                <%-- Day number --%>
                                <span class="text-sm font-semibold self-start
                                             ${cell.isToday
                                               ? 'bg-primary text-white w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold'
                                               : 'text-on-surface group-hover:text-primary transition-colors'}">
                                    ${cell.day}
                                </span>
                                <%-- Lesson count badge --%>
                                <c:if test="${cell.count > 0}">
                                    <span class="text-[10px] font-bold bg-primary/10 text-primary px-1.5 py-0.5 rounded self-start">
                                        ${cell.count}개
                                    </span>
                                </c:if>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </c:if>

    </div><%-- /cal-scroll --%>
</main>

<script>
    const CALENDAR_VIEW = '${view}';
    // Day and week views both start at 06:00 (480 px = 6 h × 80 px offset).
    const DAY_OFFSET_PX = (CALENDAR_VIEW === 'day' || CALENDAR_VIEW === 'week') ? 480 : 0;

    // ── Current time indicator ──────────────────────────────────────────────
    function positionTimeIndicator() {
        const now = new Date();
        const top = now.getHours() * 80 + now.getMinutes() * 80 / 60 - DAY_OFFSET_PX;
        document.querySelectorAll('.time-indicator').forEach(el => {
            el.style.top = top + 'px';
        });
    }
    positionTimeIndicator();
    setInterval(positionTimeIndicator, 60000);

    // ── Auto-scroll to current time on load ────────────────────────────────
    document.addEventListener('DOMContentLoaded', function () {
        const scroll = document.getElementById('cal-scroll');
        if (scroll) {
            const now = new Date();
            // Scroll so current time is ~1 hour from the top of the viewport
            const rawTop = now.getHours() * 80 + now.getMinutes() * 80 / 60 - DAY_OFFSET_PX;
            scroll.scrollTop = Math.max(0, rawTop - 80);
        }
    });
</script>
</body>
</html>
