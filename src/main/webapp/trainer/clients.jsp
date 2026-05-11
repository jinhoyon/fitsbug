<%--
  Created by IntelliJ IDEA.
  User: jinhoyon
  Date: 4/22/26
  Time: 2:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitzberg - Clients</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&amp;display=swap"
          rel="stylesheet"/>
    <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet"/>
    <script
            id="tailwind-config">tailwind.config = {
        darkMode: "class", theme: {
            extend: {
                colors: {
                    "on-tertiary": "#ffffff",
                    "on-surface": "#1a1c1f",
                    "on-secondary-container": "#2d4c83",
                    "surface-container-high": "#e8e8ed",
                    tertiary: "#9e3d00",
                    surface: "#f9f9fe",
                    "on-error": "#ffffff",
                    "surface-container-highest": "#e2e2e7",
                    "on-primary-fixed-variant": "#004493",
                    "on-tertiary-container": "#fffbff",
                    "secondary-fixed": "#d8e2ff",
                    "surface-container": "#ededf2",
                    "primary-fixed-dim": "#adc6ff",
                    "tertiary-fixed-dim": "#ffb595",
                    "on-background": "#1a1c1f",
                    "surface-variant": "#e2e2e7",
                    "inverse-primary": "#adc6ff",
                    "tertiary-fixed": "#ffdbcc",
                    "outline-variant": "#c1c6d7",
                    "on-secondary-fixed-variant": "#26467d",
                    "on-primary-container": "#fefcff",
                    "on-secondary": "#ffffff",
                    "surface-bright": "#f9f9fe",
                    "primary-fixed": "#d8e2ff",
                    "on-tertiary-fixed-variant": "#7c2e00",
                    "surface-dim": "#d9dade",
                    "on-surface-variant": "#414755",
                    "surface-container-low": "#f3f3f8",
                    outline: "#717786",
                    "on-tertiary-fixed": "#351000",
                    "error-container": "#ffdad6",
                    secondary: "#405e96",
                    "on-error-container": "#93000a",
                    "inverse-surface": "#2e3034",
                    "secondary-fixed-dim": "#adc6ff",
                    "on-primary-fixed": "#001a41",
                    primary: "#0058bc",
                    "tertiary-container": "#c64f00",
                    "on-secondary-fixed": "#001a41",
                    "secondary-container": "#a1befd",
                    "primary-container": "#0070eb",
                    "surface-container-lowest": "#ffffff",
                    "surface-tint": "#005bc1",
                    error: "#ba1a1a",
                    "on-primary": "#ffffff",
                    background: "#f9f9fe",
                    "inverse-on-surface": "#f0f0f5"
                },
                borderRadius: {DEFAULT: "0.125rem", lg: "0.25rem", xl: "0.5rem", full: "0.75rem"},
                fontFamily: {headline: ["Inter"], body: ["Inter"], label: ["Inter"], display: "Inter"},
                boxShadow: {"primary-glow": "0 0 15px -3px rgba(0, 88, 188, 0.2), 0 4px 6px -2px rgba(0, 88, 188, 0.1)"},
                keyframes: {
                    pulseCustom: {
                        "0%, 100%": {opacity: 1, transform: "scale(1)"},
                        "50%": {opacity: 0.5, transform: "scale(1.2)"}
                    }
                },
                animation: {"pulse-dot": "pulseCustom 2s cubic-bezier(0.4, 0, 0.6, 1) infinite"}
            }
        }
    };</script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        .scrollbar-hide::-webkit-scrollbar {
            display: none;
        }

        .scrollbar-hide {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        #client-list-container {
            scrollbar-width: thin;
            scrollbar-color: #e2e2e7 transparent;
        }

        #client-list-container::-webkit-scrollbar {
            width: 6px;
        }

        #client-list-container::-webkit-scrollbar-track {
            background: transparent;
        }

        #client-list-container::-webkit-scrollbar-thumb {
            background-color: #e2e2e7;
            border-radius: 20px;
        }

        .client-stats p {
            white-space: nowrap;
        }
    </style>
</head>

<body class="bg-surface text-on-surface antialiased">

<!-- SideNavBar -->
<c:set var="activePage" value="clients" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>
<jsp:include page="/trainer/mobileTopHeader.jsp"/>



<!-- Main Content Canvas (Adjusted with ml-64) -->
<div class="lg:ml-64 min-h-screen flex flex-col pt-20 lg:pt-8 pb-20 lg:pb-0">
    <!-- TopNavBar Shell -->
    <main class="flex-1 overflow-hidden pt-6 md:pt-8 px-4 md:px-8 pb-12 flex flex-col">
        <!-- Header & Control Bar -->
        <div class="flex-none max-w-7xl w-full mx-auto mb-8">
            <div class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-6">
                <div>
                    <h2 class="text-3xl font-extrabold tracking-tight text-on-surface" style="">회원 관리</h2>
                    <p class="text-on-surface-variant mt-1" style="">활성 교육 명단을 관리하고 성과를 추적하세요.</p>
                </div>
            </div>
            <!-- Control Row -->
            <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-4">
                <div class="flex flex-col md:flex-row md:items-center gap-4 flex-1">
                    <!-- Integrated Search Bar -->
                    <div class="relative w-full lg:max-w-[300px]">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline text-lg">search</span>
                        <input id="searchInput"
                               class="w-full bg-white border border-outline-variant rounded-xl pl-10 pr-4 py-2.5 text-sm focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all placeholder-outline text-on-surface"
                               placeholder="회원 검색..." type="text"
                               value="${currentSearch}"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Scrollable Client List Container -->
        <div class="flex-1 overflow-y-auto max-w-7xl w-full mx-auto" id="client-list-container">
            <div class="space-y-3 md:space-y-4 pr-2 pt-3 md:pt-0">
                <%-- Client Cards:--%>
                <c:choose>
                    <c:when test="${empty clients}">
                        <div class="bg-surface-container-low rounded-2xl overflow-hidden shadow-sm">
                            <div class="flex flex-col items-center justify-center gap-3 text-center h-[300px] px-4">
                                <span class="material-symbols-outlined text-4xl text-slate-300">group_off</span>
                                <p class="text-sm font-semibold text-on-surface">등록된 회원이 없습니다</p>
                                <p class="text-xs text-slate-400">새로운 회원을 추가하거나 수업을 등록해 보세요.</p>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="client" items="${clients}">
                            <div onclick="location.href='${pageContext.request.contextPath}/trainer/clientInbodyLog?clientId=${client.clientId}'"
                               class="block no-underline cursor-pointer">
                                <div class="bg-white border border-surface-container-highest rounded-2xl p-3 md:p-5
                grid grid-cols-[1fr_auto] md:grid-cols-[280px_1fr_auto]
                items-center gap-3 md:gap-6 hover:shadow-md transition-shadow
                min-h-[72px] md:min-h-[96px] group">
                                    <div class="flex items-start gap-3">
                                        <div class="w-12 h-12 rounded-full shrink-0 border-2 border-white shadow-sm overflow-hidden bg-primary/20 flex items-center justify-center">
                                            <c:choose>
                                                <c:when test="${not empty client.profileImage}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${client.profileImage}"
                                                         alt="${client.name}"
                                                         class="w-full h-full object-cover"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-primary font-bold text-base">${fn:substring(client.name, 0, 1)}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex flex-col gap-1">
                                            <h3 class="text-base font-bold text-on-surface leading-none">${client.name}</h3>
                                            <div class="flex flex-wrap gap-2 mt-1">
                                                <c:forEach var="tag" items="${fn:split(client.goals, ',')}">
                        <span class="text-[10px] bg-surface-container-low text-on-surface-variant
                                     font-medium px-2 py-0.5 rounded-full">
                                ${fn:trim(tag)}
                        </span>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="hidden md:grid grid-cols-3 gap-4 lg:gap-6 px-4 lg:px-6
                    border-x border-gray-50 items-start client-stats">
<%--                                        <div>--%>
<%--                                            <p class="text-[10px] uppercase font-bold text-outline tracking-widest mb-0.5">--%>
<%--                                                다음--%>
<%--                                                세션</p>--%>
<%--                                            <p class="text-sm font-bold text-on-surface">${client.nextSession}</p>--%>
<%--                                        </div>--%>
                                        <div>
                                            <p class="text-[10px] uppercase font-bold text-outline tracking-widest mb-0.5">
                                                남은 세션
                                                횟수</p>
                                                <%-- 2개 이하면 경고 색상 --%>
                                            <c:choose>
                                                <c:when test="${client.lessonCount <= 3}">
                                                    <p class="text-sm font-bold text-error flex items-center gap-1">
                                                            ${client.lessonCount}
                                                        <span class="material-symbols-outlined text-sm">warning</span>
                                                    </p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-sm font-bold text-on-surface">${client.lessonCount}</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
<%--                                        <div>--%>
<%--                                            <p class="text-[10px] uppercase font-bold text-outline tracking-widest mb-0.5">--%>
<%--                                                전--%>
<%--                                                세션</p>--%>
<%--                                            <p class="text-sm font-medium text-outline">${client.lastSession}</p>--%>
<%--                                        </div>--%>
                                    </div>
                                        <span class="material-symbols-outlined text-outline group-hover:text-primary transition-colors">
                                            chevron_right
                                        </span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="flex justify-center items-center py-6 mt-2 border-slate-100 sticky bottom-0">
            <nav aria-label="Pagination" class="flex items-center gap-1">

                <%-- 이전 버튼 --%>
                <c:choose>
                    <c:when test="${currentPage <= 1}">
                        <button disabled class="w-9 h-9 flex items-center justify-center rounded-lg
                                    text-slate-300 cursor-not-allowed">
                            <span class="material-symbols-outlined text-xl">chevron_left</span>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a href="clients?page=${currentPage - 1}&search=${currentSearch}"
                           class="w-9 h-9 flex items-center justify-center rounded-lg
                      text-slate-400 hover:bg-slate-100 hover:text-slate-600 transition-colors">
                            <span class="material-symbols-outlined text-xl">chevron_left</span>
                        </a>
                    </c:otherwise>
                </c:choose>

                <%-- 페이지 번호 버튼 --%>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <button class="w-9 h-9 flex items-center justify-center rounded-lg
                               text-sm font-semibold bg-[#007AFF] text-white shadow-sm shadow-blue-200">
                                    ${i}
                            </button>
                        </c:when>
                        <c:otherwise>
                            <a href="clients?page=${i}&search=${currentSearch}"
                               class="w-9 h-9 flex items-center justify-center rounded-lg
                          text-sm font-medium text-slate-600 hover:bg-slate-100 transition-colors">
                                    ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <%-- 다음 버튼 --%>
                <c:choose>
                    <c:when test="${currentPage >= totalPages}">
                        <button disabled class="w-9 h-9 flex items-center justify-center rounded-lg
                                    text-slate-300 cursor-not-allowed">
                            <span class="material-symbols-outlined text-xl">chevron_right</span>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a href="clients?page=${currentPage + 1}&search=${currentSearch}"
                           class="w-9 h-9 flex items-center justify-center rounded-lg
                      text-slate-400 hover:bg-slate-100 hover:text-slate-600 transition-colors">
                            <span class="material-symbols-outlined text-xl">chevron_right</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </main>
</div>
<script>
    const searchInput = document.getElementById('searchInput');

    // Re-focus and move cursor to end after page reload
    if (searchInput.value.length > 0) {
        searchInput.focus();
        searchInput.setSelectionRange(searchInput.value.length, searchInput.value.length);
    }

    let debounceTimer;
    searchInput.addEventListener('input', function () {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(function () {
            const query = searchInput.value.trim();
            const url = new URL(window.location.href);
            url.searchParams.set('search', query);
            url.searchParams.set('page', '1');
            window.location.href = url.toString();
        }, 400);
    });
</script>
</body>

</html>
