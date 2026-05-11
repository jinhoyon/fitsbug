<%--
  Created by IntelliJ IDEA.
  User: jinhoyon
  Date: 4/22/26
  Time: 10:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitzberg - Trainer Dashboard</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
    <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet"/>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        surface: "#f9f9fe",
                        "inverse-primary": "#adc6ff",
                        outline: "#717786",
                        "on-secondary-container": "#2d4c83",
                        "on-primary-container": "#fefcff",
                        "surface-bright": "#f9f9fe",
                        "on-secondary-fixed": "#001a41",
                        "on-secondary": "#ffffff",
                        "error-container": "#ffdad6",
                        "on-primary": "#ffffff",
                        "surface-container": "#ededf2",
                        "surface-tint": "#005bc1",
                        "secondary-fixed-dim": "#adc6ff",
                        "surface-dim": "#d9dade",
                        "inverse-surface": "#2e3034",
                        "on-background": "#1a1c1f",
                        error: "#ba1a1a",
                        "primary-fixed-dim": "#adc6ff",
                        secondary: "#405e96",
                        "on-tertiary-fixed-variant": "#7c2e00",
                        "on-primary-fixed-variant": "#004493",
                        "on-surface-variant": "#414755",
                        "tertiary-fixed": "#ffdbcc",
                        "secondary-fixed": "#d8e2ff",
                        "outline-variant": "#c1c6d7",
                        "inverse-on-surface": "#f0f0f5",
                        tertiary: "#9e3d00",
                        "on-tertiary": "#ffffff",
                        "on-surface": "#1a1c1f",
                        "on-error": "#ffffff",
                        "secondary-container": "#a1befd",
                        background: "#f9f9fe",
                        "primary-container": "#0070eb",
                        "tertiary-container": "#c64f00",
                        "primary-fixed": "#d8e2ff",
                        "tertiary-fixed-dim": "#ffb595",
                        primary: "#0058bc",
                        "on-secondary-fixed-variant": "#26467d",
                        "on-tertiary-fixed": "#351000",
                        "surface-container-highest": "#e2e2e7",
                        "surface-container-lowest": "#ffffff",
                        "surface-container-high": "#e8e8ed",
                        "on-error-container": "#93000a",
                        "on-primary-fixed": "#001a41",
                        "surface-variant": "#e2e2e7",
                        "surface-container-low": "#f3f3f8",
                        "on-tertiary-container": "#fffbff"
                    },
                    borderRadius: {
                        DEFAULT: "0.125rem",
                        lg: "0.25rem",
                        xl: "0.5rem",
                        full: "0.75rem"
                    },
                    fontFamily: {
                        headline: ["Inter"],
                        body: ["Inter"],
                        label: ["Inter"],
                        display: "Inter"
                    }
                }
            }
        };
    </script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        .signature-gradient {
            background: linear-gradient(135deg, #0058bc 0%, #0070eb 100%);
        }

        .glass-header {
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }

        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }

        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        .schedule-scrollbar::-webkit-scrollbar {
            width: 5px;
        }

        .schedule-scrollbar::-webkit-scrollbar-track {
            background: transparent;
        }

        .schedule-scrollbar::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }

        .schedule-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }
    </style>
</head>
<body class="bg-surface text-on-surface antialiased">

<!-- SideNavBar -->
<c:set var="activePage" value="dashboard" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>
<jsp:include page="/trainer/mobileTopHeader.jsp"/>

<!-- Main Content Shell -->
<main class="lg:ml-64 min-h-screen flex flex-col pt-20 lg:pt-8 pb-20 lg:pb-0">
    <!-- Dashboard Canvas -->
    <div class="p-4 md:p-8 max-w-6xl mx-auto flex-1 flex flex-col space-y-8 w-full">
        <!-- 1. Lesson Info Card-->
        <section class="flex-shrink-0">
            <div class="relative overflow-hidden rounded-2xl p-6 md:p-8 bg-slate-900 text-white shadow-2xl shadow-blue-900/20">
                <div class="absolute -right-20 -top-20 w-64 h-64 bg-blue-600/20 rounded-full blur-3xl"></div>
                <div class="relative flex flex-col gap-4">

                    <!-- Session Info -->
                    <div class="space-y-2">
                        <c:choose>
                            <c:when test="${hasSelectedLesson}">
                                <div class="flex items-center gap-2 flex-wrap">
                                    <c:choose>
                                        <c:when test="${selectedLesson.status eq 'Now'}">
                                            <span id="lesson-status-badge"
                                                  class="whitespace-nowrap px-2.5 py-0.5 bg-primary/20 text-green-300 text-xs font-bold rounded-full border border-green-400/30 tracking-wider">${selectedLesson.status}</span>
                                        </c:when>
                                        <c:when test="${selectedLesson.status eq 'Up Next'}">
                                            <span id="lesson-status-badge"
                                                  class="whitespace-nowrap px-2.5 py-0.5 bg-primary/20 text-blue-300 text-xs font-bold rounded-full border border-blue-500/30 tracking-wider">${selectedLesson.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span id="lesson-status-badge"
                                                  class="whitespace-nowrap px-2.5 py-0.5 bg-primary/20 text-slate-300 text-xs font-bold rounded-full border border-slate-400/30 tracking-wider">${selectedLesson.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span id="lesson-time-range"
                                          class="whitespace-nowrap flex items-center gap-1 text-blue-200 text-xs font-medium">
                                    <span class="material-symbols-outlined text-xs">schedule</span>
                                        ${selectedLesson.startTime} - ${selectedLesson.endTime}
                                    </span>
                                </div>
                                <div>
                                    <h2 id="lesson-member-name"
                                        class="text-2xl md:text-3xl font-bold tracking-tight whitespace-nowrap">${selectedLesson.memberName}</h2>
                                    <div class="flex items-center gap-2">
                                        <p id="lesson-name"
                                           class="whitespace-nowrap text-blue-100/70 text-sm md:text-lg">${selectedLesson.goal}</p>
                                        <span class="h-1 w-1 rounded-full bg-blue-100/30 shrink-0"></span>
                                        <p id="lesson-duration"
                                           class="whitespace-nowrap text-blue-100/50 text-xs md:text-sm font-medium">
                                            <c:choose>
                                                <c:when test="${client != null}">${client.lessonCount}회 남음</c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                                <!-- Actions Row -->
                                <div class="flex items-center gap-2">
                                    <!-- Mobile: icon buttons -->
                                    <a href="${pageContext.request.contextPath}/trainer/clientDetail?clientId=${client.clientId}"
                                       class="flex items-center justify-center md:hidden p-2.5 bg-white/10 hover:bg-white/20 text-white rounded-xl backdrop-blur-md transition-colors active:scale-95">
                                        <span class="material-symbols-outlined text-[20px]">person</span>
                                    </a>
                                    <button onclick="openWorkoutDrawer(this)"
                                            data-client-id="${client.clientId}"
                                            data-lesson-id="${selectedLesson.lessonId}"
                                            data-start-time="${selectedLesson.startTime}"
                                            data-end-time="${selectedLesson.endTime}"
                                            data-client-name="${selectedLesson.memberName}"
                                            class="flex items-center justify-center md:hidden p-2.5 bg-white/10 hover:bg-white/20 text-white rounded-xl backdrop-blur-md transition-colors active:scale-95">
                                        <span class="material-symbols-outlined text-[20px]">fitness_center</span>
                                    </button>
                                    <button
                                            class="flex items-center justify-center md:hidden p-2.5 bg-white/10 hover:bg-white/20 text-white rounded-xl backdrop-blur-md transition-colors active:scale-95">
                                        <span class="material-symbols-outlined text-[20px]">chat_bubble</span>
                                    </button>

                                    <!-- Desktop: full buttons -->
                                    <div class="hidden md:flex flex-wrap gap-3">
                                        <a href="${pageContext.request.contextPath}/trainer/clientDetail?clientId=${client.clientId}"
                                           class="px-8 py-3 bg-white text-slate-900 rounded-xl font-bold hover:bg-blue-50 transition-colors active:scale-95">
                                            프로필 보기
                                        </a>
                                        <button onclick="openWorkoutDrawer(this)"
                                                data-client-id="${client.clientId}"
                                                data-lesson-id="${selectedLesson.lessonId}"
                                                data-start-time="${selectedLesson.startTime}"
                                                data-end-time="${selectedLesson.endTime}"
                                                data-client-name="${selectedLesson.memberName}"
                                                class="px-6 py-3 bg-white/10 hover:bg-white/20 text-white rounded-xl font-semibold backdrop-blur-md transition-colors active:scale-95">
                                            + 운동 추가
                                        </button>
                                        <button
                                                class="p-3 bg-white/10 hover:bg-white/20 text-white rounded-xl backdrop-blur-md transition-colors">
                                            <span class="material-symbols-outlined">chat_bubble</span>
                                        </button>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="flex flex-col gap-2">
                                    <div class="flex items-center gap-2">
            <span class="whitespace-nowrap px-2.5 py-0.5 bg-white/10 text-blue-200
                         text-xs font-bold rounded-full border border-white/20 tracking-wider">
                오늘 일정 없음
            </span>
                                    </div>
                                    <div class="flex flex-col gap-1">
                                        <h2 class="text-2xl md:text-3xl font-bold tracking-tight">
                                            수업이 없습니다
                                        </h2>
                                        <p class="text-blue-100/70 text-sm md:text-lg">
                                            내일 일정을 확인해 주세요
                                        </p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
        <!-- Grid Layout for Tools & Stats -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 flex-1 min-h-0 w-full">
            <!-- 2. Today's Schedule (2/3 width) -->
            <div class="lg:col-span-2 flex flex-col">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-xl font-semibold text-on-surface">오늘의 일정</h3>
                    <a class="text-xs font-bold text-primary hover:underline" href="#">캘린더 보기</a>
                </div>
                <div class="space-y-3 overflow-y-auto schedule-scrollbar max-h-[250px] md:max-h-[280px] lg:h-[320px] xl:h-[535px]">
                    <c:choose>
                        <%-- 수업이 없을 때 빈 상태 표시 --%>
                        <c:when test="${empty todayLessons}">
                            <div class="bg-surface-container-low rounded-2xl overflow-hidden shadow-sm">
                                <div class="flex flex-col items-center justify-center gap-3 text-center h-[200px] px-4">
                                    <span class="material-symbols-outlined text-4xl text-slate-300">event_busy</span>
                                    <p class="text-sm font-semibold text-on-surface">오늘 예정된 수업이 없습니다</p>
                                    <p class="text-xs text-slate-400">새로운 수업을 추가하거나 내일 일정을 확인해보세요.</p>
                                </div>
                            </div>
                        </c:when>
                        <%-- 수업이 있을 때 목록 표시 --%>
                        <c:otherwise>
                            <c:forEach var="lesson" items="${todayLessons}">
                                <a href="dashboard?lessonId=${lesson.lessonId}" class="block lesson-item"
                                   data-lesson-id="${lesson.lessonId}">
                                    <div class="lesson-item-card flex items-center justify-between p-4 mx-0.5 rounded-xl border-2 transition-all ${hasSelectedLesson and selectedLesson.lessonId eq lesson.lessonId ? 'bg-blue-50 border-blue-200 hover:bg-blue-100' : 'bg-surface-container-low border-transparent hover:bg-surface-container-high'}">
                                        <div class="flex items-center gap-4">
                                            <div class="w-12 text-center">
                                                <p class="text-sm font-bold text-on-surface">${lesson.startTime}</p>
                                                <p class="text-[10px] font-medium text-on-surface-variant">${lesson.durationMinutes}m</p>
                                            </div>
                                            <div class="h-10 w-[2px] bg-slate-300"></div>
                                            <div>
                                                <p class="text-lg text-on-surface font-semibold">${lesson.memberName}</p>
                                                <div class="flex items-center gap-2">
                                                    <span class="text-[10px] font-bold text-slate-500 uppercase">${lesson.goal}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <c:choose>
                                            <c:when test="${lesson.status eq 'Now'}">
                                                <span class="px-2.5 py-0.5 bg-green-100 text-green-700 text-[10px] font-bold rounded-full">${lesson.status}</span>
                                            </c:when>
                                            <c:when test="${lesson.status eq 'Up Next'}">
                                                <span class="px-2.5 py-0.5 bg-blue-100 text-blue-700 text-[10px] font-bold rounded-full">${lesson.status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-2.5 py-0.5 bg-slate-100 text-slate-500 text-[10px] font-bold rounded-full">${lesson.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <!-- 3. Sidebar Tools & Notifications (1/3 width) -->
            <div class="flex flex-col space-y-8">
                <!-- Notifications Panel -->
                <section class="flex flex-col flex-1 min-h-0 w-full h-full">
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-semibold text-on-surface">알림</h3>
                        <button id="notifications-mark-all" class="text-xs font-bold text-primary hover:underline">모두
                            읽음으로 표시
                        </button>
                    </div>
                    <div
                            class="bg-surface-container-low rounded-2xl overflow-hidden flex flex-col shadow-sm flex-1 max-h-[540px]">
                        <div id="notifications-list" class="overflow-y-auto schedule-scrollbar">
                            <c:choose>
                                <c:when test="${empty notifications}">
                                    <div class="flex flex-col items-center justify-center gap-3 text-center h-[200px] px-4">
                                        <span class="material-symbols-outlined text-4xl text-slate-300">notifications_off</span>
                                        <p class="text-sm font-semibold text-on-surface">알림이 없습니다</p>
                                        <p class="text-xs text-slate-400">새로운 알림이 오면 여기에 표시됩니다.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="notification" items="${notifications}">
                                        <div class="notification-item relative p-4 pr-12 border-b border-slate-200/60 hover:bg-surface-container-high transition-colors cursor-pointer ${notification.read ? '' : 'group'}"
                                             data-notification-id="${notification.notificationId}"
                                             data-target-url="${notification.targetUrl}">
                                            <div class="flex items-start gap-3">
                                                <c:choose>
                                                    <c:when test="${notification.type eq 'SCHEDULE'}">
                                                        <div class="w-9 h-9 rounded-full bg-blue-100 flex items-center justify-center text-primary flex-shrink-0">
                                                            <span class="material-symbols-outlined text-[18px]"
                                                                  data-icon="event_note">event_note</span>
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${notification.type eq 'DIET'}">
                                                        <div class="w-9 h-9 rounded-full bg-green-100 flex items-center justify-center text-green-600 flex-shrink-0">
                                                            <span class="material-symbols-outlined text-[18px]"
                                                                  data-icon="restaurant">restaurant</span>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="w-9 h-9 rounded-full bg-purple-100 flex items-center justify-center text-purple-600 flex-shrink-0">
                                                            <span class="material-symbols-outlined text-[18px]"
                                                                  data-icon="task_alt">task_alt</span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div>
                                                    <p class="text-xs font-bold text-on-surface">${notification.title}</p>
                                                    <p class="text-[11px] text-on-surface-variant mt-0.5">${notification.message}</p>
                                                </div>
                                            </div>
                                            <div class="absolute right-4 top-4 flex flex-col items-end gap-1.5">
                                                <span class="text-[10px] text-slate-400">${notification.createdAtLabel}</span>
                                                <c:if test="${not notification.read}">
                                                    <div class="notification-unread-dot w-2 h-2 bg-primary rounded-full"></div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="p-3 bg-slate-50 text-center border-t border-slate-200/60">
                                        <button class="text-[11px] font-bold text-slate-500 hover:text-on-surface transition-colors">
                                            모든 알림 보기
                                        </button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</main>
<!-- ── Workout Log Drawer ──────────────────────────────────────────── -->
<div id="workout-drawer" class="fixed inset-0 z-50 hidden">
    <div onclick="closeWorkoutDrawer()"
         class="absolute inset-0 bg-black/40 backdrop-blur-sm"></div>

    <!-- Panel -->
    <div class="absolute right-0 top-0 h-full w-full max-w-md bg-white shadow-2xl flex flex-col">

        <!-- Header -->
        <div class="flex items-start justify-between px-5 py-4 border-b border-slate-200">
            <div>
                <h2 class="font-bold text-slate-800 text-lg">운동 기록 추가</h2>
                <p id="workout-drawer-client" class="text-sm text-slate-500 mt-0.5"></p>
            </div>
            <button onclick="closeWorkoutDrawer()"
                    class="p-1.5 hover:bg-slate-100 rounded-lg transition-colors ml-4 flex-shrink-0">
                <span class="material-symbols-outlined text-slate-500 text-xl">close</span>
            </button>
        </div>

        <!-- Scrollable body -->
        <div class="flex-1 overflow-y-auto p-5 space-y-5">

            <!-- Step 1: Log Picker -->
            <div>
                <p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-2">기록 선택</p>
                <div id="log-picker" class="space-y-2">
                    <p class="text-sm text-slate-400 animate-pulse">불러오는 중...</p>
                </div>
            </div>

            <!-- Existing exercises (read-only, shown when appending to existing log) -->
            <div id="existing-exercises" class="hidden space-y-1"></div>

            <!-- Step 2: New exercise rows (shown after log is selected/created) -->
            <div id="exercise-section" class="hidden">
                <div class="flex items-center justify-between mb-2">
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">추가할 운동</p>
                    <button type="button" onclick="addExerciseRow()"
                            class="text-xs font-bold text-primary hover:underline flex items-center gap-0.5">
                        <span class="material-symbols-outlined text-sm">add</span>운동 추가
                    </button>
                </div>
                <!-- Column headers -->
                <div class="grid gap-1.5 mb-1.5 px-0.5 text-[10px] font-bold text-slate-400"
                     style="grid-template-columns: 1fr 52px 52px 58px 28px;">
                    <span>이름</span>
                    <span class="text-center">세트</span>
                    <span class="text-center">횟수</span>
                    <span class="text-center">무게(kg)</span>
                    <span></span>
                </div>
                <div id="exercise-list" class="space-y-1.5"></div>
            </div>

        </div>

        <!-- Footer -->
        <div class="px-5 py-4 border-t border-slate-200 bg-slate-50">
            <button id="workout-save-btn" onclick="saveWorkout()" disabled
                    class="w-full py-3 bg-primary text-white font-bold rounded-xl text-sm
                           hover:bg-blue-700 active:scale-[0.98] transition-all
                           disabled:opacity-40 disabled:cursor-not-allowed disabled:active:scale-100">
                저장
            </button>
        </div>
    </div>
</div>

<!-- Toast -->
<div id="workout-toast"
     class="hidden fixed bottom-6 left-1/2 -translate-x-1/2 z-[60]
            px-6 py-3 rounded-xl shadow-lg text-sm font-semibold text-white
            transition-opacity duration-300 opacity-0 pointer-events-none">
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    // ── State ─────────────────────────────────────────────────────────────
    let _clientId   = null;
    let _lessonId   = null;
    let _startTime  = null;
    let _endTime    = null;
    let _mode       = null;   // 'new' | 'append'
    let _logId      = null;

    // ── Open / Close ──────────────────────────────────────────────────────
    function openWorkoutDrawer(btn) {
        _clientId  = btn.dataset.clientId;
        _lessonId  = btn.dataset.lessonId;
        _startTime = btn.dataset.startTime;
        _endTime   = btn.dataset.endTime;
        const name = btn.dataset.clientName || '';

        _mode  = null;
        _logId = null;

        document.getElementById('workout-drawer-client').textContent =
            name + (_startTime ? '  ·  ' + _startTime + ' – ' + _endTime : '');

        // Reset UI
        document.getElementById('log-picker').innerHTML =
            '<p class="text-sm text-slate-400 animate-pulse">불러오는 중...</p>';
        document.getElementById('exercise-section').classList.add('hidden');
        document.getElementById('existing-exercises').innerHTML = '';
        document.getElementById('existing-exercises').classList.add('hidden');
        document.getElementById('exercise-list').innerHTML = '';
        document.getElementById('workout-save-btn').disabled = true;

        document.getElementById('workout-drawer').classList.remove('hidden');
        document.body.style.overflow = 'hidden';

        fetchLogs();
    }

    function closeWorkoutDrawer() {
        document.getElementById('workout-drawer').classList.add('hidden');
        document.body.style.overflow = '';
    }

    // ── Fetch existing logs ───────────────────────────────────────────────
    function fetchLogs() {
        fetch(contextPath + '/trainer/workoutLog?action=list&clientId=' + _clientId)
            .then(r => r.json())
            .then(data => renderLogPicker(data.logs || []))
            .catch(() => {
                document.getElementById('log-picker').innerHTML =
                    '<p class="text-sm text-red-400">기록 불러오기 실패</p>';
            });
    }

    function renderLogPicker(logs) {
        const picker = document.getElementById('log-picker');
        picker.innerHTML = '';

        // "새 기록 만들기" card
        const newCard = document.createElement('button');
        newCard.type = 'button';
        newCard.className = 'log-opt w-full text-left px-4 py-3 rounded-xl border-2 border-dashed border-slate-200 text-slate-500 hover:border-primary hover:text-primary hover:bg-primary/5 transition-colors text-sm font-semibold flex items-center gap-2';
        newCard.innerHTML = '<span class="material-symbols-outlined text-base">add</span>새 기록 만들기';
        newCard.onclick = () => onSelectNew(newCard);
        picker.appendChild(newCard);

        // Existing log cards
        logs.forEach(log => {
            const card = document.createElement('button');
            card.type = 'button';
            card.className = 'log-opt w-full text-left px-4 py-3 rounded-xl border border-slate-200 bg-slate-50 hover:bg-primary/5 hover:border-primary transition-colors';
            card.dataset.logId = log.id;
            card.innerHTML =
                '<div class="flex justify-between items-center">' +
                  '<span class="text-sm font-semibold text-slate-700">' + log.date + '</span>' +
                  '<span class="text-xs text-slate-400">' + log.exerciseCount + '가지 운동</span>' +
                '</div>' +
                '<div class="text-xs text-slate-400 mt-0.5">' +
                  (log.startTime || '') + (log.endTime ? ' – ' + log.endTime : '') +
                '</div>';
            card.onclick = () => onSelectExisting(card, log.id);
            picker.appendChild(card);
        });
    }

    // ── Log selection ─────────────────────────────────────────────────────
    function onSelectNew(card) {
        highlightCard(card);
        _mode  = 'new';
        _logId = null;

        document.getElementById('existing-exercises').innerHTML = '';
        document.getElementById('existing-exercises').classList.add('hidden');
        document.getElementById('exercise-section').classList.remove('hidden');

        if (document.getElementById('exercise-list').children.length === 0) addExerciseRow();
        document.getElementById('workout-save-btn').disabled = false;
    }

    function onSelectExisting(card, logId) {
        highlightCard(card);
        _mode  = 'append';
        _logId = logId;

        document.getElementById('exercise-section').classList.remove('hidden');
        document.getElementById('workout-save-btn').disabled = false;

        // Load & display existing exercises (read-only)
        fetch(contextPath + '/trainer/workoutLog?action=detail&logId=' + logId)
            .then(r => r.json())
            .then(data => renderExistingExercises(data.details || []));
    }

    function renderExistingExercises(details) {
        const box = document.getElementById('existing-exercises');
        if (!details.length) { box.classList.add('hidden'); return; }

        box.classList.remove('hidden');
        box.innerHTML = '<p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider mb-1.5">기존 운동</p>';
        details.forEach(d => {
            const row = document.createElement('div');
            row.className = 'flex items-center gap-3 px-3 py-2 bg-slate-100 rounded-lg text-sm text-slate-600';
            row.innerHTML =
                '<span class="flex-1 font-medium truncate">' + escHtml(d.title) + '</span>' +
                '<span class="text-xs text-slate-400 whitespace-nowrap">' + d.set + '세트 × ' + d.rep + '회</span>' +
                '<span class="text-xs text-slate-400 whitespace-nowrap">' + d.weight + 'kg</span>';
            box.appendChild(row);
        });
    }

    function highlightCard(selected) {
        document.querySelectorAll('.log-opt').forEach(c => {
            c.classList.remove('border-primary', 'bg-primary/5', 'text-primary', 'border-2');
            c.classList.add('border', 'border-slate-200');
        });
        selected.classList.add('border-2', 'border-primary', 'bg-primary/5', 'text-primary');
        selected.classList.remove('border-dashed', 'border-slate-200', 'text-slate-500');
    }

    // ── Exercise rows ─────────────────────────────────────────────────────
    function addExerciseRow() {
        const row = document.createElement('div');
        row.className = 'exercise-row grid gap-1.5 items-center';
        row.style.gridTemplateColumns = '1fr 52px 52px 58px 28px';
        row.innerHTML =
            '<input type="text" name="exerciseName" placeholder="운동 이름"' +
            '       class="px-2.5 py-2 text-sm bg-white border border-slate-200 rounded-lg outline-none focus:ring-1 focus:ring-primary/30 min-w-0"/>' +
            '<input type="number" name="exerciseSet" placeholder="세트" min="0"' +
            '       class="px-1 py-2 text-sm bg-white border border-slate-200 rounded-lg outline-none focus:ring-1 focus:ring-primary/30 text-center w-full"/>' +
            '<input type="number" name="exerciseRep" placeholder="횟수" min="0"' +
            '       class="px-1 py-2 text-sm bg-white border border-slate-200 rounded-lg outline-none focus:ring-1 focus:ring-primary/30 text-center w-full"/>' +
            '<input type="number" name="exerciseWeight" placeholder="0" min="0" step="0.5"' +
            '       class="px-1 py-2 text-sm bg-white border border-slate-200 rounded-lg outline-none focus:ring-1 focus:ring-primary/30 text-center w-full"/>' +
            '<button type="button" onclick="this.closest(\'.exercise-row\').remove()"' +
            '        class="flex items-center justify-center w-7 h-7 text-slate-400 hover:text-red-500 transition-colors">' +
            '    <span class="material-symbols-outlined text-base">close</span>' +
            '</button>';
        document.getElementById('exercise-list').appendChild(row);
        row.querySelector('[name="exerciseName"]').focus();
    }

    // ── Save ──────────────────────────────────────────────────────────────
    function saveWorkout() {
        if (!_mode) {
            showToast('기록을 선택하거나 새 기록을 만들어 주세요.', 'error');
            return;
        }
        if (_mode === 'new' && (!_clientId || !_lessonId)) {
            showToast('세션 정보가 없습니다. 대시보드를 새로고침해 주세요.', 'error');
            return;
        }
        if (_mode === 'append' && !_logId) {
            showToast('기존 기록을 선택해 주세요.', 'error');
            return;
        }
        const rows = document.querySelectorAll('#exercise-list .exercise-row');
        const hasExercise = [...rows].some(r => r.querySelector('[name="exerciseName"]').value.trim());
        if (!hasExercise) {
            showToast('운동을 한 개 이상 추가해 주세요.', 'error');
            return;
        }

        const saveBtn = document.getElementById('workout-save-btn');
        saveBtn.disabled  = true;
        saveBtn.textContent = '저장 중...';

        const params = new URLSearchParams();
        params.append('mode', _mode);

        if (_mode === 'new') {
            params.append('clientId',  _clientId);
            params.append('lessonId',  _lessonId);
            params.append('startTime', _startTime || '');
            params.append('endTime',   _endTime   || '');
        } else {
            params.append('logId', _logId);
        }

        rows.forEach(row => {
            const name = row.querySelector('[name="exerciseName"]').value.trim();
            if (!name) return;
            params.append('exerciseName',   name);
            params.append('exerciseSet',    row.querySelector('[name="exerciseSet"]').value    || '0');
            params.append('exerciseRep',    row.querySelector('[name="exerciseRep"]').value    || '0');
            params.append('exerciseWeight', row.querySelector('[name="exerciseWeight"]').value || '0');
        });

        fetch(contextPath + '/trainer/workoutLog', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params
        })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    closeWorkoutDrawer();
                    showToast('운동이 저장되었습니다.');
                } else {
                    showToast('저장 실패: ' + (data.message || ''), 'error');
                    saveBtn.disabled  = false;
                    saveBtn.textContent = '저장';
                }
            })
            .catch(() => {
                showToast('저장에 실패했습니다.', 'error');
                saveBtn.disabled  = false;
                saveBtn.textContent = '저장';
            });
    }

    // ── Toast ─────────────────────────────────────────────────────────────
    function showToast(msg, type) {
        const toast = document.getElementById('workout-toast');
        toast.textContent = msg;
        toast.className = 'fixed bottom-6 left-1/2 -translate-x-1/2 z-[60] px-6 py-3 rounded-xl shadow-lg text-sm font-semibold text-white transition-opacity duration-300 ' +
            (type === 'error' ? 'bg-red-600' : 'bg-emerald-600');
        toast.classList.remove('hidden', 'opacity-0');
        toast.classList.add('opacity-100');
        setTimeout(() => {
            toast.classList.remove('opacity-100');
            toast.classList.add('opacity-0');
            setTimeout(() => toast.classList.add('hidden'), 300);
        }, 2500);
    }

    // ── Util ──────────────────────────────────────────────────────────────
    function escHtml(s) {
        return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
    }
</script>
</body>
</html>
