<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitsbug - 전체 결제 내역</title>
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
        th.sortable { cursor: pointer; user-select: none; }
        th.sortable:hover { color: #0058bc; }
        th.sort-active { color: #0058bc; }
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


<%-- Helper: build a sort URL toggling direction for a given column --%>
<c:set var="oppDir"   value="${sortDir == 'ASC' ? 'DESC' : 'ASC'}"/>
<%-- Carry date params through sort/pagination links --%>
<c:set var="drParams" value="&dateFrom=${dateFrom}&dateTo=${dateTo}"/>

<div class="lg:ml-64 pt-16 lg:pt-0 pb-24 lg:pb-0">
    <main class="p-4 md:p-8 max-w-6xl mx-auto space-y-6">

        <!-- Header -->
        <div class="flex items-center gap-3 pt-2">
            <a href="${pageContext.request.contextPath}/trainer/earnings"
               class="p-1.5 rounded-lg hover:bg-surface-container transition-colors text-on-surface-variant">
                <span class="material-symbols-outlined text-xl">arrow_back</span>
            </a>
            <div>
                <h2 class="text-2xl font-bold tracking-tight">전체 결제 내역</h2>
                <p class="text-sm text-on-surface-variant mt-0.5">총 ${totalCount}건</p>
            </div>
        </div>

        <!-- Date Range Filter -->
        <section class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 shadow-sm p-4">
            <form method="get" action="" class="flex flex-wrap items-end gap-3">
                <input type="hidden" name="page"    value="1"/>
                <input type="hidden" name="sortBy"  value="${sortBy}"/>
                <input type="hidden" name="sortDir" value="${sortDir}"/>

                <div class="flex flex-col gap-1">
                    <label class="text-xs font-bold text-on-surface-variant uppercase tracking-wider">시작일</label>
                    <input type="date" name="dateFrom" id="dateFrom" value="${dateFrom}"
                           class="px-3 py-2 text-sm border border-outline-variant rounded-lg bg-surface focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary"/>
                </div>

                <span class="text-on-surface-variant pb-2">–</span>

                <div class="flex flex-col gap-1">
                    <label class="text-xs font-bold text-on-surface-variant uppercase tracking-wider">종료일</label>
                    <input type="date" name="dateTo" id="dateTo" value="${dateTo}"
                           class="px-3 py-2 text-sm border border-outline-variant rounded-lg bg-surface focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary"/>
                </div>

                <button type="submit"
                        class="px-5 py-2 bg-primary text-white text-sm font-bold rounded-lg hover:bg-primary-container transition-colors">
                    조회
                </button>

                <c:if test="${not empty dateFrom or not empty dateTo}">
                    <a href="?page=1&sortBy=${sortBy}&sortDir=${sortDir}"
                       class="px-4 py-2 text-sm font-semibold text-on-surface-variant border border-outline-variant rounded-lg hover:bg-surface-container transition-colors">
                        초기화
                    </a>
                </c:if>

                <!-- Quick presets -->
                <div class="flex gap-2 ml-auto flex-wrap">
                    <button type="button" onclick="setPreset('today')"
                            class="px-3 py-2 text-xs font-semibold rounded-lg border border-outline-variant text-on-surface-variant hover:bg-surface-container transition-colors">오늘</button>
                    <button type="button" onclick="setPreset('week')"
                            class="px-3 py-2 text-xs font-semibold rounded-lg border border-outline-variant text-on-surface-variant hover:bg-surface-container transition-colors">이번 주</button>
                    <button type="button" onclick="setPreset('month')"
                            class="px-3 py-2 text-xs font-semibold rounded-lg border border-outline-variant text-on-surface-variant hover:bg-surface-container transition-colors">이번 달</button>
                    <button type="button" onclick="setPreset('3months')"
                            class="px-3 py-2 text-xs font-semibold rounded-lg border border-outline-variant text-on-surface-variant hover:bg-surface-container transition-colors">3개월</button>
                </div>
            </form>
        </section>

        <!-- Transaction Table -->
        <c:choose>
            <c:when test="${empty transactions}">
                <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 p-16 flex flex-col items-center gap-3 text-center">
                    <span class="material-symbols-outlined text-5xl text-slate-300">receipt_long</span>
                    <p class="text-sm font-semibold text-on-surface">결제 내역이 없습니다</p>
                    <p class="text-xs text-on-surface-variant">회원이 PT를 구매하면 여기에 표시됩니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 shadow-sm overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead class="bg-surface-container-low text-on-surface-variant text-xs font-bold uppercase tracking-wider">
                                <tr>
                                    <%-- 회원 --%>
                                    <c:set var="isActive" value="${sortBy == 'clientName'}"/>
                                    <th class="text-left px-5 py-3 sortable ${isActive ? 'sort-active' : ''}"
                                        onclick="location.href='?page=1&sortBy=clientName&sortDir=${isActive ? oppDir : 'DESC'}${drParams}'">
                                        <span class="inline-flex items-center gap-1">
                                            회원
                                            <span class="material-symbols-outlined text-sm">
                                                <c:choose>
                                                    <c:when test="${isActive && sortDir == 'ASC'}">arrow_upward</c:when>
                                                    <c:when test="${isActive && sortDir == 'DESC'}">arrow_downward</c:when>
                                                    <c:otherwise>unfold_more</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </span>
                                    </th>

                                    <%-- 결제일 (date only, sortable) --%>
                                    <c:set var="isActive" value="${sortBy == 'date' || sortBy == null || sortBy == ''}"/>
                                    <th class="text-left px-5 py-3 sortable ${isActive ? 'sort-active' : ''}"
                                        onclick="location.href='?page=1&sortBy=date&sortDir=${isActive ? oppDir : 'DESC'}${drParams}'">
                                        <span class="inline-flex items-center gap-1">
                                            결제일
                                            <span class="material-symbols-outlined text-sm">
                                                <c:choose>
                                                    <c:when test="${isActive && sortDir == 'ASC'}">arrow_upward</c:when>
                                                    <c:when test="${isActive && sortDir == 'DESC'}">arrow_downward</c:when>
                                                    <c:otherwise>unfold_more</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </span>
                                    </th>

                                    <%-- 시간 (not sortable, tied to date) --%>
                                    <th class="text-left px-5 py-3">시간</th>

                                    <%-- 수단 --%>
                                    <th class="text-left px-5 py-3">수단</th>

                                    <%-- 결제 금액 --%>
                                    <c:set var="isActive" value="${sortBy == 'price'}"/>
                                    <th class="text-right px-5 py-3 sortable ${isActive ? 'sort-active' : ''}"
                                        onclick="location.href='?page=1&sortBy=price&sortDir=${isActive ? oppDir : 'DESC'}${drParams}'">
                                        <span class="inline-flex items-center justify-end gap-1">
                                            결제 금액
                                            <span class="material-symbols-outlined text-sm">
                                                <c:choose>
                                                    <c:when test="${isActive && sortDir == 'ASC'}">arrow_upward</c:when>
                                                    <c:when test="${isActive && sortDir == 'DESC'}">arrow_downward</c:when>
                                                    <c:otherwise>unfold_more</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </span>
                                    </th>

                                    <%-- 수수료 --%>
                                    <th class="text-right px-5 py-3">수수료</th>

                                    <%-- 순 수익 --%>
                                    <c:set var="isActive" value="${sortBy == 'netAmount'}"/>
                                    <th class="text-right px-5 py-3 sortable ${isActive ? 'sort-active' : ''}"
                                        onclick="location.href='?page=1&sortBy=netAmount&sortDir=${isActive ? oppDir : 'DESC'}${drParams}'">
                                        <span class="inline-flex items-center justify-end gap-1">
                                            순 수익
                                            <span class="material-symbols-outlined text-sm">
                                                <c:choose>
                                                    <c:when test="${isActive && sortDir == 'ASC'}">arrow_upward</c:when>
                                                    <c:when test="${isActive && sortDir == 'DESC'}">arrow_downward</c:when>
                                                    <c:otherwise>unfold_more</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </span>
                                    </th>

                                    <%-- 상태 --%>
                                    <c:set var="isActive" value="${sortBy == 'status'}"/>
                                    <th class="text-center px-5 py-3 sortable ${isActive ? 'sort-active' : ''}"
                                        onclick="location.href='?page=1&sortBy=status&sortDir=${isActive ? oppDir : 'ASC'}${drParams}'">
                                        <span class="inline-flex items-center justify-center gap-1">
                                            상태
                                            <span class="material-symbols-outlined text-sm">
                                                <c:choose>
                                                    <c:when test="${isActive && sortDir == 'ASC'}">arrow_upward</c:when>
                                                    <c:when test="${isActive && sortDir == 'DESC'}">arrow_downward</c:when>
                                                    <c:otherwise>unfold_more</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-outline-variant/10">
                                <c:forEach var="tx" items="${transactions}">
                                    <tr class="hover:bg-surface-container-low transition-colors">
                                        <td class="px-5 py-4 font-semibold text-on-surface whitespace-nowrap">${tx.clientName}</td>
                                        <td class="px-5 py-4 text-on-surface-variant whitespace-nowrap">${tx.paymentDate}</td>
                                        <td class="px-5 py-4 text-on-surface-variant whitespace-nowrap text-xs">${tx.paymentTime}</td>
                                        <td class="px-5 py-4 text-on-surface-variant whitespace-nowrap">${tx.method}</td>
                                        <td class="px-5 py-4 text-right text-on-surface whitespace-nowrap">
                                            ₩<fmt:formatNumber value="${tx.price}" pattern="#,###"/>
                                        </td>
                                        <td class="px-5 py-4 text-right text-red-500 whitespace-nowrap">
                                            -₩<fmt:formatNumber value="${tx.platformFee}" pattern="#,###"/>
                                        </td>
                                        <td class="px-5 py-4 text-right font-bold text-primary whitespace-nowrap">
                                            ₩<fmt:formatNumber value="${tx.netAmount}" pattern="#,###"/>
                                        </td>
                                        <td class="px-5 py-4 text-center whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${tx.status == '결제완료'}">
                                                    <span class="px-2.5 py-0.5 bg-green-100 text-green-700 text-[10px] font-bold rounded-full">결제완료</span>
                                                </c:when>
                                                <c:when test="${tx.status == '취소완료'}">
                                                    <span class="px-2.5 py-0.5 bg-red-100 text-red-700 text-[10px] font-bold rounded-full">취소완료</span>
                                                </c:when>
                                                <c:when test="${tx.status == '환불요청'}">
                                                    <span class="px-2.5 py-0.5 bg-orange-100 text-orange-700 text-[10px] font-bold rounded-full">환불요청</span>
                                                </c:when>
                                                <c:when test="${tx.status == '환불완료'}">
                                                    <span class="px-2.5 py-0.5 bg-slate-100 text-slate-600 text-[10px] font-bold rounded-full">환불완료</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2.5 py-0.5 bg-yellow-100 text-yellow-700 text-[10px] font-bold rounded-full">대기</span>
                                                </c:otherwise>
                                            </c:choose>
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
                            ${(currentPage - 1) * 20 + 1}–${currentPage * 20 > totalCount ? totalCount : currentPage * 20} / 총 ${totalCount}건
                        </p>
                        <div class="flex items-center gap-1">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}&sortBy=${sortBy}&sortDir=${sortDir}${drParams}"
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
                                        <a href="?page=${p}&sortBy=${sortBy}&sortDir=${sortDir}${drParams}"
                                           class="w-8 h-8 flex items-center justify-center rounded-lg text-sm text-on-surface-variant hover:bg-surface-container transition-colors">${p}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}&sortBy=${sortBy}&sortDir=${sortDir}${drParams}"
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

<script>
function setPreset(preset) {
    const today = new Date();
    const fmt = d => d.toISOString().slice(0, 10);
    let from, to = fmt(today);
    if (preset === 'today') {
        from = to;
    } else if (preset === 'week') {
        const day = today.getDay();
        const mon = new Date(today);
        mon.setDate(today.getDate() - (day === 0 ? 6 : day - 1));
        from = fmt(mon);
    } else if (preset === 'month') {
        from = fmt(new Date(today.getFullYear(), today.getMonth(), 1));
    } else if (preset === '3months') {
        const d = new Date(today);
        d.setMonth(d.getMonth() - 3);
        from = fmt(d);
    }
    document.getElementById('dateFrom').value = from;
    document.getElementById('dateTo').value   = to;
    document.getElementById('dateFrom').closest('form').submit();
}
</script>
</body>
</html>
