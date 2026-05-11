<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>정산 및 매출관리 - 핏츠버그 Fitness Admin</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "surface-container-lowest": "#ffffff",
                        "surface-container-highest": "#e1e2e4",
                        "surface-container": "#edeef0",
                        "on-primary": "#ffffff",
                        "on-error-container": "#93000a",
                        "background": "#f8f9fb",
                        "error": "#ba1a1a",
                        "outline": "#727785",
                        "secondary-container": "#dce2f3",
                        "on-secondary-fixed-variant": "#404754",
                        "tertiary": "#924700",
                        "tertiary-fixed-dim": "#ffb786",
                        "on-tertiary-fixed": "#311400",
                        "surface-variant": "#e1e2e4",
                        "primary-container": "#2170e4",
                        "on-surface-variant": "#424754",
                        "error-container": "#ffdad6",
                        "surface-container-low": "#f3f4f6",
                        "on-tertiary-fixed-variant": "#723600",
                        "secondary-fixed-dim": "#c0c7d6",
                        "outline-variant": "#c2c6d6",
                        "tertiary-container": "#b75b00",
                        "on-primary-fixed-variant": "#004395",
                        "on-error": "#ffffff",
                        "inverse-surface": "#2e3132",
                        "on-tertiary-container": "#fffbff",
                        "on-secondary": "#ffffff",
                        "tertiary-fixed": "#ffdcc6",
                        "inverse-primary": "#adc6ff",
                        "on-secondary-fixed": "#151c27",
                        "inverse-on-surface": "#f0f1f3",
                        "on-tertiary": "#ffffff",
                        "surface-container-high": "#e7e8ea",
                        "primary-fixed": "#d8e2ff",
                        "surface": "#f8f9fb",
                        "secondary": "#585f6c",
                        "on-primary-fixed": "#001a42",
                        "surface-tint": "#3B82F6",
                        "surface-bright": "#f8f9fb",
                        "secondary-fixed": "#dce2f3",
                        "on-surface": "#191c1e",
                        "surface-dim": "#d9dadc",
                        "on-background": "#191c1e",
                        "primary-fixed-dim": "#adc6ff",
                        "on-secondary-container": "#5e6572",
                        "on-primary-container": "#fefcff",
                        "primary": "#3B82F6"
                    },
                    fontFamily: {
                        "headline": ["Inter"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    },
                    borderRadius: {"DEFAULT": "0.5rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px"},
                },
            },
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        body { font-family: 'Inter', sans-serif; }
        .nowrap { white-space: nowrap; }
    </style>
</head>

<body class="bg-background text-on-surface">
<!-- SideNavBar Shell -->
<div class="flex">
<jsp:include page="sidebar.jsp"></jsp:include>
</div>
<!-- Main Content -->
<main class="ml-64 min-h-screen">
    <div class="pt-10 px-10 pb-10">
        
        <!-- Headline -->
        <div class="flex justify-between items-end mb-8">
            <div>
                <h2 class="text-2xl font-bold tracking-tight">매출 및 결제 관리</h2>
                <p class="text-gray-500 text-sm mt-1">플랫폼 전체의 매출내역과 결제내역을 세부적으로 확인합니다.</p>
            </div>
        </div>

<!-- Search & Filter Form -->
<form id="searchForm" action="${pageContext.request.contextPath}/admin/sales" method="get" class="bg-white p-5 rounded-xl shadow-sm border border-gray-100 flex flex-wrap items-center gap-4 mb-8">
    <div class="flex items-center gap-2">
        <input type="date" name="startDate" value="${startDate}" class="border-gray-200 rounded-lg text-sm focus:ring-primary">
        <span class="text-gray-400">~</span>
        <input type="date" name="endDate" value="${endDate}" class="border-gray-200 rounded-lg text-sm focus:ring-primary">
    </div>
    <div class="flex-1"></div> <!-- 여백용 -->
    <button type="submit" class="bg-primary text-white px-6 py-2 rounded-lg font-medium hover:bg-blue-600 transition-colors">기간 적용</button>
    <button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/sales'" 
            class="bg-gray-100 text-gray-600 px-4 py-2 rounded-lg font-medium hover:bg-gray-200 transition-colors">초기화</button>
    
    <!-- 필터 상태 유지를 위한 Hidden 필드들 -->
    <input type="hidden" name="status" id="hiddenStatus" value="${currentStatus}">
    <input type="hidden" name="viewType" id="hiddenViewType" value="${currentViewType}">
    <input type="hidden" name="salesSearch" value="${param.salesSearch}">
    <input type="hidden" name="paymentSearch" value="${param.paymentSearch}">
    <input type="hidden" name="salesPage" id="salesPage" value="${empty param.salesPage ? 1 : param.salesPage}">
    <input type="hidden" name="paymentPage" id="paymentPage" value="${empty param.paymentPage ? 1 : param.paymentPage}">
</form>

<!-- Summary Cards (정산 테이블 상단 디자인 적용) -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                <p class="text-sm font-medium text-gray-500">총 매출액</p>
                <p class="text-2xl font-bold text-gray-900 mt-2">
                    ₩<fmt:formatNumber value="${data.summary.totalSales}" pattern="#,###"/>
                </p>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                <p class="text-sm font-medium text-gray-500">정산금액</p>
                <p class="text-2xl font-bold text-red-500 mt-2">
                    ₩<fmt:formatNumber value="${data.summary.totalAmount}" pattern="#,###"/>
                </p>
            </div>
            <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
                <p class="text-sm font-medium text-gray-500">순수익(수수료)</p>
                <p class="text-2xl font-bold text-blue-600 mt-2">
                    ₩<fmt:formatNumber value="${data.summary.totalFee}" pattern="#,###"/>
                </p>
            </div>
        </div>

<!-- 매출 상세 내역 (데이터 테이블) -->
<div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden mb-8">
    <div class="px-6 py-5 border-b border-gray-50 flex justify-between items-center">
        <h3 class="text-lg font-bold text-gray-800">매출 내역</h3>
        <div class="flex items-center gap-3">
            <!-- 매출 전용 검색창 -->
            <div class="relative w-64">
                <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm">search</span>
                <input type="text" id="salesSearchInput" value="${param.salesSearch}" placeholder="지점명, 트레이너 검색..." 
                       onkeypress="if(event.keyCode==13){ updateSearch('sales'); return false; }"
                       class="w-full pl-9 pr-4 py-1.5 border-gray-200 rounded-lg text-xs focus:ring-primary">
            </div>
        <div id="salesFilterButtons" class="flex items-center gap-1 bg-gray-100 p-1 rounded-lg">
                    <%-- [변경 포인트 2] 선언된 변수(currentViewType)로 단순 비교 --%>
                    <button onclick="changeViewType('all')" class="px-4 py-1.5 text-xs font-bold ${currentViewType == 'all' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">전체 내역</button>
                    <button onclick="changeViewType('gym')" class="px-4 py-1.5 text-xs font-bold ${currentViewType == 'gym' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">헬스장별</button>
                    <button onclick="changeViewType('trainer')" class="px-4 py-1.5 text-xs font-bold ${currentViewType == 'trainer' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">트레이너별</button>
        </div>
    	</div>
    </div>
    <div class="overflow-x-auto">
        <table class="w-full text-sm text-left">
            <thead class="bg-gray-50 text-gray-500 uppercase text-[11px] font-bold">
                <tr>
                    <th class="px-6 py-4">고유번호</th>
                    <th class="px-6 py-4">날짜</th>
                    <th class="px-6 py-4">지점명</th>
                    <th class="px-6 py-4">트레이너</th>
                    <th class="px-6 py-4 text-right">매출액</th>
                    <th class="px-6 py-4 text-right">정산금</th>
                    <th class="px-6 py-4 text-right">수수료</th>
                </tr>
            </thead>
            <tbody id="salesTableBody" class="divide-y divide-gray-50">
                <c:if test="${not empty data.details}">
                    <c:forEach var="item" items="${data.details}">
                    <tr class="hover:bg-gray-50/50 transition-colors">
                        <!-- viewType이 'all'일 때만 ID와 날짜 출력, 나머지는 '-' 표시 -->
                        <td class="px-6 py-4 font-mono text-xs text-gray-400">${not empty item.paymentNum ? item.paymentNum : '-'}</td>
                        <td class="px-6 py-4 text-gray-600">${not empty item.paymentDate ? item.paymentDate : '-'}</td>
                        <td class="px-6 py-4 font-medium text-gray-900">${item.gymName}</td>
                        <td class="px-6 py-4 text-gray-700">${not empty item.trainerName ? item.trainerName : '전체'}</td>
                        <td class="px-6 py-4 text-right font-bold text-gray-900">₩<fmt:formatNumber value="${item.paymentPrice}" pattern="#,###"/></td>
                        <td class="px-6 py-4 text-right text-red-400">₩<fmt:formatNumber value="${item.paymentAmount}" pattern="#,###"/></td>
                        <td class="px-6 py-4 text-right font-semibold text-primary">₩<fmt:formatNumber value="${item.paymentFee}" pattern="#,###"/></td>
                    </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty data.details}">
                    <tr>
                        <td colspan="7" class="px-6 py-20 text-center text-gray-400">조회된 매출 내역이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
            <!-- 합계 영역: data.summary 객체와 연결 -->
            <tfoot id="salesTableFoot" class="bg-white border-t-2 border-gray-50">
                <tr class="font-bold text-gray-900">
                    <td colspan="4" class="px-6 py-8 text-right text-lg">합계</td>
                    <td class="px-6 py-8 text-right text-lg">₩ <fmt:formatNumber value="${data.summary.totalSales}" pattern="#,###"/></td>
                    <td class="px-6 py-8 text-right text-lg text-red-400">₩ <fmt:formatNumber value="${data.summary.totalAmount}" pattern="#,###"/></td>
                    <td class="px-6 py-8 text-right text-2xl text-primary">₩ <fmt:formatNumber value="${data.summary.totalFee}" pattern="#,###"/></td>
                </tr>
            </tfoot>
        </table>
    </div>
<!-- 매출 상세 내역 페이징 -->
<div id="salesPagination" class="px-8 py-8 border-t border-gray-50 flex justify-center">
    <div class="flex items-center gap-1">
        <c:set var="sp" value="${data.salesPager}" />
        
        <%-- 이전 화살표: 데이터가 없거나 첫 페이지 블록이면 비활성화 --%>
        <button type="button" 
                <c:choose>
                    <c:when test="${not empty sp && sp.startPage > 1}">onclick="movePage('sales', ${sp.startPage - 1})"</c:when>
                    <c:otherwise>disabled</c:otherwise>
                </c:choose>
                class="w-9 h-9 rounded-lg flex items-center justify-center transition-all ${not empty sp && sp.startPage > 1 ? 'text-gray-400 hover:bg-gray-100' : 'text-gray-200 cursor-not-allowed'}">
            <span class="material-symbols-outlined text-xl">chevron_left</span>
        </button>

        <%-- 숫자 버튼 영역 --%>
        <c:choose>
            <c:when test="${not empty sp && sp.allPage > 0}">
                <c:forEach var="num" begin="${sp.startPage}" end="${sp.endPage}">
                    <button type="button" onclick="movePage('sales', ${num})" 
                            class="w-9 h-9 rounded-lg flex items-center justify-center text-sm font-semibold transition-all
                                   ${sp.curPage == num ? 'bg-primary text-white shadow-md shadow-blue-200' : 'text-gray-500 hover:bg-gray-100'}">
                        ${num}
                    </button>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <button type="button" class="w-9 h-9 rounded-lg flex items-center justify-center text-sm font-semibold bg-primary text-white shadow-md shadow-blue-200">1</button>
            </c:otherwise>
        </c:choose>

        <%-- 다음 화살표: 데이터가 없거나 마지막 페이지 블록이면 비활성화 --%>
        <button type="button" 
                <c:choose>
                    <c:when test="${not empty sp && endPage < sp.allPage}">onclick="movePage('sales', ${sp.endPage + 1})"</c:when>
                    <c:otherwise>disabled</c:otherwise>
                </c:choose>
                class="w-9 h-9 rounded-lg flex items-center justify-center transition-all ${not empty sp && sp.endPage < sp.allPage ? 'text-gray-400 hover:bg-gray-100' : 'text-gray-200 cursor-not-allowed'}">
            <span class="material-symbols-outlined text-xl">chevron_right</span>
        </button>
    </div>
</div>
</div>


<!-- 결제 내역 -->
<div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
    <!-- 헤더: 제목 및 필터 버튼 -->
    <div class="px-6 py-5 border-b border-gray-50 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <h3 class="text-lg font-bold text-gray-800">결제 내역</h3>
        <div class="flex items-center gap-3">
            <!-- 결제 전용 검색창 -->
            <div class="relative w-64">
                <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-sm">search</span>
                <input type="text" id="paymentSearchInput" value="${param.paymentSearch}" placeholder="회원명 검색..." 
                       onkeypress="if(event.keyCode==13){ updateSearch('payment'); return false; }"
                       class="w-full pl-9 pr-4 py-1.5 border-gray-200 rounded-lg text-xs focus:ring-primary">
            </div>
        <div id="paymentFilterButtons" class="flex items-center gap-1 bg-gray-100 p-1 rounded-lg">
                    <%-- [변경 포인트 3] 선언된 변수(currentStatus)로 단순 비교 --%>
                    <button onclick="changeStatus('전체')" class="px-4 py-1.5 text-xs font-bold ${currentStatus == '전체' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">전체</button>
                    <button onclick="changeStatus('결제완료')" class="px-4 py-1.5 text-xs font-bold ${currentStatus == '결제완료' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">결제완료</button>
                    <button onclick="changeStatus('환불요청')" class="px-4 py-1.5 text-xs font-bold ${currentStatus == '환불요청' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">환불요청</button>
                    <button onclick="changeStatus('환불완료')" class="px-4 py-1.5 text-xs font-bold ${currentStatus == '환불완료' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">환불완료</button>
                    <button onclick="changeStatus('취소완료')" class="px-4 py-1.5 text-xs font-bold ${currentStatus == '취소완료' ? 'bg-white shadow-sm text-primary' : 'text-gray-500'} rounded-md transition-all">취소완료</button>
        </div>
    </div>
	</div>
  <!-- 테이블 영역 -->
    <div class="overflow-x-auto">
        <table class="w-full text-sm text-left border-collapse">
            <thead class="bg-gray-50/50 text-gray-400 uppercase text-[11px] font-bold">
                <tr>
                    <th class="px-8 py-4">고유번호</th>
                    <th class="px-6 py-4">회원명</th>
                    <th class="px-6 py-4 text-center">결제날짜</th>
                    <th class="px-6 py-4 text-right">결제금액</th>
                    <th class="px-8 py-4 text-center">상태</th>
                </tr>
            </thead>
            <tbody id="paymentTableBody" class="divide-y divide-gray-50">
                <c:if test="${not empty data.payments}">
                    <c:forEach var="pay" items="${data.payments}">
                    <tr class="hover:bg-gray-50/30 transition-colors">
                        <td class="px-8 py-5 font-mono text-[11px] text-gray-400">${pay.paymentNum}</td>
                        <td class="px-6 py-5">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 rounded-full bg-blue-50 border border-blue-100 flex items-center justify-center text-[11px] font-bold text-primary">
                                    ${not empty pay.userName ? pay.userName.substring(0,1) : '?'}
                                </div>
                                <span class="font-semibold text-gray-700">${pay.userName}</span>
                            </div>
                        </td>
                        <td class="px-6 py-5 text-center text-gray-600">${pay.paymentDate}</td>
                        <td class="px-6 py-5 text-right font-bold text-gray-900">
                            ₩ <fmt:formatNumber value="${pay.paymentPrice}" pattern="#,###"/>
                        </td>
                        <td class="px-8 py-5 text-center">
                            <!-- 상태별 색상 매핑 보정 -->
                            <c:choose>
                                <c:when test="${pay.paymentStatus == '결제완료'}">
                                    <span class="bg-blue-50 text-blue-600 px-3 py-1 rounded-full text-[11px] font-bold border border-blue-100">결제완료</span>
                                </c:when>
                                <c:when test="${pay.paymentStatus == '환불완료' || pay.paymentStatus == '환불요청'}">
                                    <span class="bg-red-50 text-red-600 px-3 py-1 rounded-full text-[11px] font-bold border border-red-100">${pay.paymentStatus}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="bg-gray-100 text-gray-500 px-3 py-1 rounded-full text-[11px] font-bold">${pay.paymentStatus}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty data.payments}">
                    <tr>
                        <td colspan="5" class="px-6 py-20 text-center text-gray-400">조회된 결제 내역이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
<!-- 결제 내역 페이징 -->
<div id="paymentPagination" class="px-8 py-8 border-t border-gray-50 flex justify-center">
    <div class="flex items-center gap-1">
        <c:set var="pp" value="${data.paymentPager}" />

        <%-- 이전 화살표 --%>
        <button type="button" 
                <c:choose>
                    <c:when test="${not empty pp && pp.startPage > 1}">onclick="movePage('payment', ${pp.startPage - 1})"</c:when>
                    <c:otherwise>disabled</c:otherwise>
                </c:choose>
                class="w-9 h-9 rounded-lg flex items-center justify-center transition-all ${not empty pp && pp.startPage > 1 ? 'text-gray-400 hover:bg-gray-100' : 'text-gray-200 cursor-not-allowed'}">
            <span class="material-symbols-outlined text-xl">chevron_left</span>
        </button>

        <%-- 숫자 버튼 영역 --%>
        <c:choose>
            <c:when test="${not empty pp && pp.allPage > 0}">
                <c:forEach var="num" begin="${pp.startPage}" end="${pp.endPage}">
                    <button type="button" onclick="movePage('payment', ${num})" 
                            class="w-9 h-9 rounded-lg flex items-center justify-center text-sm font-semibold transition-all
                                   ${pp.curPage == num ? 'bg-primary text-white shadow-md shadow-blue-200' : 'text-gray-500 hover:bg-gray-100'}">
                        ${num}
                    </button>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <button type="button" class="w-9 h-9 rounded-lg flex items-center justify-center text-sm font-semibold bg-primary text-white shadow-md shadow-blue-200">1</button>
            </c:otherwise>
        </c:choose>

        <%-- 다음 화살표 --%>
        <button type="button" 
                <c:choose>
                    <c:when test="${not empty pp && pp.endPage < pp.allPage}">onclick="movePage('payment', ${pp.endPage + 1})"</c:when>
                    <c:otherwise>disabled</c:otherwise>
                </c:choose>
                class="w-9 h-9 rounded-lg flex items-center justify-center transition-all ${not empty pp && pp.endPage < pp.allPage ? 'text-gray-400 hover:bg-gray-100' : 'text-gray-200 cursor-not-allowed'}">
            <span class="material-symbols-outlined text-xl">chevron_right</span>
        </button>
    </div>
</div>
</div>

</div>
</main>

<script>
const pageState = {
	    startDate: '${startDate}',
	    endDate: '${endDate}',
	    viewType: '${currentViewType}',
	    status: '${currentStatus}',
	    salesSearch: '${param.salesSearch}',
	    paymentSearch: '${param.paymentSearch}',
	    salesPage: ${empty param.salesPage ? 1 : param.salesPage},
	    paymentPage: ${empty param.paymentPage ? 1 : param.paymentPage}
	};
	
async function refreshData() {
    const params = new URLSearchParams();
    
    // state 객체에 있는 모든 값을 쿼리스트링으로 변환
    Object.keys(pageState).forEach(key => {
        if(pageState[key]) params.append(key, pageState[key]);
    });
    params.append('_t', new Date().getTime());

    console.log("==> 서버 전송 최종 상태:", pageState);

    try {
        const response = await fetch(`${pageContext.request.contextPath}/admin/sales?` + params.toString(), {
            method: 'GET',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        });

        if (!response.ok) throw new Error('데이터 로드 실패');

        const htmlText = await response.text();
        const doc = new DOMParser().parseFromString(htmlText, 'text/html');

        // 갈아끼울 영역 리스트
        const targetIds = [
            'salesTableBody', 'salesTableFoot', 'salesPagination', 
            'salesFilterButtons', 'paymentTableBody', 'paymentPagination', 
            'paymentFilterButtons'
        ];

        targetIds.forEach(id => {
            const newEl = doc.getElementById(id);
            const oldEl = document.getElementById(id);
            if (newEl && oldEl) oldEl.innerHTML = newEl.innerHTML;
        });
        
        if (document.getElementById('salesSearchInput')) {
            document.getElementById('salesSearchInput').value = pageState.salesSearch || '';
        }
        if (document.getElementById('paymentSearchInput')) {
            document.getElementById('paymentSearchInput').value = pageState.paymentSearch || '';
        }

        // 브라우저 주소창 업데이트 (뒤로가기 지원)
        history.pushState(null, '', '?' + params.toString());

    } catch (error) {
        console.error(error);
    }
}

// 매출 필터 변경
function changeViewType(type) {
    pageState.viewType = type;
    pageState.salesPage = 1;
    refreshData();
}

// 결제 상태 변경
function changeStatus(status) {
    pageState.status = status;
    pageState.paymentPage = 1;
    refreshData();
}

// 페이지 이동 함수
function movePage(type, pageNum) {
    if (type === 'sales') pageState.salesPage = pageNum;
    else pageState.paymentPage = pageNum;
    refreshData();
}

// 검색어 입력 시 호출 (엔터 키)
function updateSearch(type) {
	if (type === 'sales') {
        const val = document.getElementById('salesSearchInput').value;
        pageState.salesSearch = val;
        // 매출 검색 시 결제 검색어는 초기화 (간섭 방지)
        pageState.paymentSearch = ''; 
        document.querySelector('input[name="salesSearch"]').value = val;
        document.querySelector('input[name="paymentSearch"]').value = '';
        pageState.salesPage = 1;
    } else {
        const val = document.getElementById('paymentSearchInput').value;
        pageState.paymentSearch = val;
        // 결제 검색 시 매출 검색어는 초기화 (간섭 방지)
        pageState.salesSearch = ''; 
        document.querySelector('input[name="paymentSearch"]').value = val;
        document.querySelector('input[name="salesSearch"]').value = '';
        pageState.paymentPage = 1;
    }
    refreshData();
}

// 조회 폼 submit 기본 동작 막기
document.getElementById('searchForm').addEventListener('submit', function(e) {
    e.preventDefault();
    pageState.startDate = this.querySelector('input[name="startDate"]').value;
    pageState.endDate = this.querySelector('input[name="endDate"]').value;
    pageState.salesPage = 1;
    pageState.paymentPage = 1;
    refreshData();
});
</script>
</body></html>