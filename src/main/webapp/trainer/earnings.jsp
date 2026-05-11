<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitsbug - 수익</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                        "on-background": "#1a1c1f", "inverse-surface": "#2e3034",
                        "inverse-on-surface": "#f0f0f5", "inverse-primary": "#adc6ff",
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
        .kinetic-gradient { background: linear-gradient(135deg, #0058bc 0%, #0070eb 100%); }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-surface text-on-surface">

<!-- Sidebar -->
<c:set var="activePage" value="earnings" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>
<jsp:include page="/trainer/mobileTopHeader.jsp"/>


<div class="lg:ml-64 pt-16 lg:pt-0 pb-24 lg:pb-0">
    <main class="p-4 md:p-8 max-w-5xl mx-auto space-y-8">

        <div class="flex items-center justify-between pt-2">
            <h2 class="text-2xl font-bold tracking-tight">수익 관리</h2>
            <span class="text-sm text-on-surface-variant font-medium">${currentMonth}</span>
        </div>

        <!-- ── 1. Current Month Settlement Card ─────────────────────── -->
        <c:choose>
            <c:when test="${currentSettlement != null}">
                <!-- This month has completed PT payments -->
                <section class="kinetic-gradient rounded-2xl p-6 md:p-8 text-white shadow-xl relative overflow-hidden">
                    <div class="absolute -right-16 -top-16 w-56 h-56 bg-white/5 rounded-full blur-3xl"></div>
                    <div class="relative z-10">
                        <div class="flex items-start justify-between mb-6">
                            <div>
                                <p class="text-white/60 text-xs font-bold uppercase tracking-widest mb-1">${currentSettlement.settlementMonth} 이번 달 수익</p>
                                <span class="px-2.5 py-0.5 bg-blue-400/20 text-blue-100 text-xs font-bold rounded-full border border-blue-300/30">결제완료 기준</span>
                            </div>
                            <div class="text-right">
                                <p class="text-white/60 text-[10px] uppercase tracking-wider mb-1">결제 건수</p>
                                <p class="text-sm font-bold">${currentSettlement.txCount}건</p>
                            </div>
                        </div>
                        <div class="mb-2">
                            <p class="text-white/60 text-[10px] uppercase tracking-wider mb-1">순 수익 (수수료 차감 후)</p>
                            <h2 class="text-4xl font-bold tracking-tight">
                                ₩<fmt:formatNumber value="${currentSettlement.netAmount}" pattern="#,###"/>
                            </h2>
                        </div>
                        <div class="grid grid-cols-2 gap-4 pt-6 border-t border-white/10">
                            <div>
                                <p class="text-white/60 text-[10px] uppercase tracking-wider mb-1">총 매출</p>
                                <p class="text-base font-semibold">₩<fmt:formatNumber value="${currentSettlement.totalSales}" pattern="#,###"/></p>
                            </div>
                            <div>
                                <p class="text-white/60 text-[10px] uppercase tracking-wider mb-1">플랫폼 수수료</p>
                                <p class="text-base font-semibold text-red-300">-₩<fmt:formatNumber value="${currentSettlement.totalFee}" pattern="#,###"/></p>
                            </div>
                        </div>
                    </div>
                </section>
            </c:when>
            <c:otherwise>
                <!-- No completed PT payments this month -->
                <div class="flex items-start gap-3 bg-yellow-50 border border-yellow-200 rounded-2xl px-4 py-3.5 shadow-sm">
                    <div class="w-8 h-8 rounded-full bg-yellow-400 flex items-center justify-center shrink-0 mt-0.5">
                        <span class="material-symbols-outlined text-white text-[18px]" style="font-variation-settings:'FILL' 1;">notifications</span>
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="text-sm font-semibold text-yellow-900 leading-snug">${currentMonth} 결제 내역 없음</p>
                        <p class="text-xs text-yellow-700 mt-0.5 leading-snug">이번 달 완료된 PT 결제가 없습니다.</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- ── 2. Monthly Chart ──────────────────────────────────────── -->
        <section class="bg-surface-container-lowest rounded-2xl p-6 border border-outline-variant/10 shadow-sm">
            <div class="flex items-center justify-between mb-6">
                <h3 class="text-base font-bold">월별 수익 내역</h3>
                <span class="text-xs text-on-surface-variant">최근 12개월</span>
            </div>
            <c:choose>
                <c:when test="${empty settlementHistory}">
                    <div class="flex flex-col items-center justify-center h-40 gap-2 text-center">
                        <span class="material-symbols-outlined text-4xl text-slate-300">bar_chart</span>
                        <p class="text-sm font-semibold text-on-surface">정산 내역이 없습니다</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <canvas id="earningsChart" height="80"></canvas>
                </c:otherwise>
            </c:choose>
        </section>

        <!-- ── 3. Settlement History Table ──────────────────────────── -->
        <c:if test="${not empty settlementHistory}">
        <section class="space-y-3">
            <div class="flex items-center justify-between px-1">
                <h3 class="text-base font-bold">월별 수익 내역</h3>
            </div>
            <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 shadow-sm overflow-hidden">
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
                        <c:forEach var="s" items="${settlementHistory}" varStatus="st">
                            <c:if test="${st.count <= 5}">
                            <tr class="hover:bg-surface-container-low transition-colors">
                                <td class="px-5 py-4 font-semibold text-on-surface">${s.settlementMonth}</td>
                                <td class="px-5 py-4 text-center text-on-surface-variant">${s.txCount}건</td>
                                <td class="px-5 py-4 text-right text-on-surface-variant">
                                    ₩<fmt:formatNumber value="${s.totalSales}" pattern="#,###"/>
                                </td>
                                <td class="px-5 py-4 text-right text-red-500">
                                    -₩<fmt:formatNumber value="${s.totalFee}" pattern="#,###"/>
                                </td>
                                <td class="px-5 py-4 text-right font-bold text-primary">
                                    ₩<fmt:formatNumber value="${s.netAmount}" pattern="#,###"/>
                                </td>
                            </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${settlementHistory.size() >= 5}">
                <div class="border-t border-outline-variant/10">
                    <a href="${pageContext.request.contextPath}/trainer/earnings/settlement"
                       class="flex items-center justify-center gap-1.5 py-3 text-sm text-primary font-semibold hover:bg-surface-container-low transition-colors">
                        <span class="material-symbols-outlined text-base">expand_more</span>
                        전체 월별 내역 보기
                    </a>
                </div>
                </c:if>
            </div>
        </section>
        </c:if>

        <!-- ── 4. Transaction Panel (shown on chart bar click) ─────────── -->
        <section id="tx-section" class="space-y-3 hidden">
            <div class="flex items-center justify-between px-1">
                <h3 class="text-base font-bold">
                    <span id="tx-month-label"></span> 결제 내역
                </h3>
                <button onclick="closeTxSection()"
                        class="text-xs text-on-surface-variant hover:text-on-surface flex items-center gap-1">
                    <span class="material-symbols-outlined text-base">close</span>
                    닫기
                </button>
            </div>
            <div class="bg-surface-container-lowest rounded-2xl border border-outline-variant/10 shadow-sm overflow-hidden">
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="bg-surface-container-low text-on-surface-variant text-xs font-bold uppercase tracking-wider">
                            <tr>
                                <th class="text-left px-5 py-3">회원</th>
                                <th class="text-left px-5 py-3">결제일</th>
                                <th class="text-left px-5 py-3">시간</th>
                                <th class="text-left px-5 py-3">수단</th>
                                <th class="text-right px-5 py-3">결제 금액</th>
                                <th class="text-right px-5 py-3">수수료</th>
                                <th class="text-right px-5 py-3">순 수익</th>
                            </tr>
                        </thead>
                        <tbody id="tx-tbody" class="divide-y divide-outline-variant/10"></tbody>
                    </table>
                </div>
                <div id="tx-empty" class="hidden p-10 flex flex-col items-center gap-3 text-center">
                    <span class="material-symbols-outlined text-4xl text-slate-300">receipt_long</span>
                    <p class="text-sm font-semibold text-on-surface">해당 월 결제 내역이 없습니다</p>
                </div>
            </div>
        </section>

    </main>
</div>

<script>
    const allTransactions = [
        <c:forEach var="tx" items="${transactions}" varStatus="st">
        {
            clientName:     "${tx.clientName}",
            paymentDate:    "${tx.paymentDate}",
            paymentTime:    "${tx.paymentTime}",
            settlementMonth:"${tx.settlementMonth}",
            price:          ${tx.price},
            platformFee:    ${tx.platformFee},
            netAmount:      ${tx.netAmount},
            method:         "${tx.method}",
            status:         "${tx.status}"
        }<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    function formatKRW(n) {
        return '₩' + Number(n).toLocaleString('ko-KR');
    }

    function showTransactions(month) {
        const filtered = allTransactions.filter(tx => tx.settlementMonth === month);
        const tbody = document.getElementById('tx-tbody');
        const empty = document.getElementById('tx-empty');
        tbody.innerHTML = '';
        document.getElementById('tx-month-label').textContent = month;

        if (filtered.length === 0) {
            empty.classList.remove('hidden');
        } else {
            empty.classList.add('hidden');
            filtered.forEach(function(tx) {
                var tr = document.createElement('tr');
                tr.className = 'hover:bg-surface-container-low transition-colors';
                var html = '';
                html += '<td class="px-5 py-4 font-semibold text-on-surface">' + tx.clientName + '</td>';
                html += '<td class="px-5 py-4 text-on-surface-variant">' + tx.paymentDate + '</td>';
                html += '<td class="px-5 py-4 text-on-surface-variant">' + tx.paymentTime + '</td>';
                html += '<td class="px-5 py-4 text-on-surface-variant">' + tx.method + '</td>';
                html += '<td class="px-5 py-4 text-right text-on-surface">' + formatKRW(tx.price) + '</td>';
                html += '<td class="px-5 py-4 text-right text-red-500">-' + formatKRW(tx.platformFee) + '</td>';
                html += '<td class="px-5 py-4 text-right font-bold text-primary">' + formatKRW(tx.netAmount) + '</td>';
                tr.innerHTML = html;
                tbody.appendChild(tr);
            });
        }
        document.getElementById('tx-section').classList.remove('hidden');
        document.getElementById('tx-section').scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function closeTxSection() {
        document.getElementById('tx-section').classList.add('hidden');
        if (earningsChart) {
            earningsChart.data.datasets[0].backgroundColor = earningsChart.data.labels.map(() => 'rgba(0,88,188,0.8)');
            earningsChart.update();
        }
    }

    <c:if test="${not empty settlementHistory}">
    const labels = [
        <c:forEach var="s" items="${settlementHistory}" varStatus="st">
        '${s.settlementMonth}'<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ].reverse();

    const netData = [
        <c:forEach var="s" items="${settlementHistory}" varStatus="st">
        ${s.netAmount}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ].reverse();

    const earningsChart = new Chart(document.getElementById('earningsChart'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: '순 수익 (₩)',
                data: netData,
                backgroundColor: labels.map(() => 'rgba(0,88,188,0.8)'),
                borderRadius: 6,
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(v) { return '₩' + v.toLocaleString(); }
                    }
                }
            },
            onClick: function(event, elements) {
                if (elements.length === 0) return;
                const idx = elements[0].index;
                const month = labels[idx];
                const colors = labels.map((_, i) => i === idx ? 'rgba(0,88,188,1)' : 'rgba(0,88,188,0.35)');
                earningsChart.data.datasets[0].backgroundColor = colors;
                earningsChart.update();
                showTransactions(month);
            },
            onHover: function(event) {
                event.native.target.style.cursor =
                    earningsChart.getElementsAtEventForMode(event.native, 'nearest', { intersect: true }, true).length
                    ? 'pointer' : 'default';
            }
        }
    });
    </c:if>
</script>
</body>
</html>
