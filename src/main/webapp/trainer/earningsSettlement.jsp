<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitsbug - 월별 수익 내역</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
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
                        "tertiary-fixed-dim": "#ffb595", background: "#f9f9fe",
                        "on-background": "#1a1c1f",
                    },
                    fontFamily: { headline: ["Inter"], body: ["Inter"], label: ["Inter"] },
                    borderRadius: { DEFAULT: "0.125rem", lg: "0.25rem", xl: "0.5rem", full: "0.75rem" }
                }
            }
        };
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; -webkit-font-smoothing: antialiased; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
    </style>
</head>
<body class="bg-surface text-on-surface">

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
<c:set var="activePage" value="payments" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>


<div class="lg:ml-64 pt-16 lg:pt-0 pb-24 lg:pb-0">
    <main class="p-4 md:p-8 max-w-5xl mx-auto space-y-6">

        <!-- Header -->
        <div class="flex items-center gap-3 pt-2">
            <a href="${pageContext.request.contextPath}/trainer/earnings"
               class="p-1.5 rounded-lg hover:bg-surface-container transition-colors text-on-surface-variant">
                <span class="material-symbols-outlined text-xl">arrow_back</span>
            </a>
            <div>
                <h2 class="text-2xl font-bold tracking-tight">월별 수익 내역</h2>
                <p class="text-sm text-on-surface-variant mt-0.5">총 ${totalCount}개월</p>
            </div>
        </div>

        <!-- Settlement History Table -->
        <c:choose>
            <c:when test="${empty settlementHistory}">
                <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 p-16 flex flex-col items-center gap-3 text-center">
                    <span class="material-symbols-outlined text-5xl text-slate-300">bar_chart</span>
                    <p class="text-sm font-semibold text-on-surface">정산 내역이 없습니다</p>
                    <p class="text-xs text-on-surface-variant">결제완료된 PT 내역이 생기면 여기에 표시됩니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-surface-container-low text-on-surface-variant text-xs font-bold uppercase tracking-wider">
                                <tr>
                                    <th class="text-left px-5 py-3">월</th>
                                    <th class="text-center px-5 py-3">건수</th>
                                    <th class="text-right px-5 py-3">총 매출</th>
                                    <th class="text-right px-5 py-3">수수료</th>
                                    <th class="text-right px-5 py-3">순 수익</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-outline-variant/10">
                                <c:forEach var="s" items="${settlementHistory}">
                                    <tr class="hover:bg-surface-container-low transition-colors">
                                        <td class="px-5 py-4 font-semibold text-on-surface whitespace-nowrap">${s.settlementMonth}</td>
                                        <td class="px-5 py-4 text-center text-on-surface-variant whitespace-nowrap">${s.txCount}건</td>
                                        <td class="px-5 py-4 text-right text-on-surface-variant whitespace-nowrap">
                                            ₩<fmt:formatNumber value="${s.totalSales}" pattern="#,###"/>
                                        </td>
                                        <td class="px-5 py-4 text-right text-red-500 whitespace-nowrap">
                                            -₩<fmt:formatNumber value="${s.totalFee}" pattern="#,###"/>
                                        </td>
                                        <td class="px-5 py-4 text-right font-bold text-primary whitespace-nowrap">
                                            ₩<fmt:formatNumber value="${s.netAmount}" pattern="#,###"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                    <div class="border-t border-outline-variant/10 px-5 py-4 flex items-center justify-between">
                        <p class="text-xs text-on-surface-variant">
                            ${(currentPage - 1) * 12 + 1}–${currentPage * 12 > totalCount ? totalCount : currentPage * 12} / 총 ${totalCount}개월
                        </p>
                        <div class="flex items-center gap-1">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}"
                                   class="p-1.5 rounded-lg hover:bg-surface-container transition-colors text-on-surface-variant">
                                    <span class="material-symbols-outlined text-lg">chevron_left</span>
                                </a>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <span class="w-8 h-8 flex items-center justify-center rounded-lg bg-primary text-white text-sm font-bold">${p}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="?page=${p}"
                                           class="w-8 h-8 flex items-center justify-center rounded-lg text-sm text-on-surface-variant hover:bg-surface-container transition-colors">${p}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}"
                                   class="p-1.5 rounded-lg hover:bg-surface-container transition-colors text-on-surface-variant">
                                    <span class="material-symbols-outlined text-lg">chevron_right</span>
                                </a>
                            </c:if>
                        </div>
                    </div>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>

    </main>
</div>

</body>
</html>
