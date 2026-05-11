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
<h2 class="text-[1.5rem] font-semibold tracking-tight text-on-surface nowrap">정산 관리</h2>
<p class="text-on-surface-variant text-sm mt-1 nowrap">헬스장과 트레이너의 정산 내역을 한눈에 확인하고 처리하세요.</p>
</div>
</div>
<!-- Date Range Picker Section -->
<form id="searchForm" action="${pageContext.request.contextPath}/admin/salesSettlement" method="get" class="bg-white p-5 rounded-xl shadow-sm border border-gray-100 flex flex-wrap items-center gap-4 mb-8">
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
</form>

<!-- Summary Cards -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
    <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
        <p class="text-sm font-medium text-gray-500">총 매출액</p>
        <p class="text-2xl font-bold text-gray-900 mt-1">
            ₩<fmt:formatNumber value="${data.summary.totalSales}" pattern="#,###"/>
        </p>
    </div>
    <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
        <p class="text-sm font-medium text-gray-500">정산금액</p>
        <p class="text-2xl font-bold text-red-600 mt-1">
            ₩<fmt:formatNumber value="${data.summary.totalAmount}" pattern="#,###"/>
        </p>
    </div>
    <div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
        <p class="text-sm font-medium text-gray-500">순수익(수수료)</p>
        <p class="text-2xl font-bold text-blue-600 mt-1">
            ₩<fmt:formatNumber value="${data.summary.totalFee}" pattern="#,###"/>
        </p>
    </div>
</div>

<!-- Settlement Detail Table Section -->
<div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <form id="listForm" action="${pageContext.request.contextPath}/admin/salesSettlement" method="get">
            <!-- 폼 유지를 위한 히든 필드 -->
            <input type="hidden" name="startDate" value="${startDate}">
            <input type="hidden" name="endDate" value="${endDate}">
            <input type="hidden" name="status" id="currentStatus" value="${status}">
            <input type="hidden" name="offset" id="currentOffset" value="${param.offset != null ? param.offset : 0}">

            <!-- 테이블 헤더 및 필터 영역 -->
            <div class="p-4 border-b border-gray-100 flex flex-col md:flex-row justify-between items-center gap-4">
                <div class="flex gap-2">
                    <button type="button" onclick="changeStatus('정산대기')" class="px-4 py-2 rounded-lg text-sm font-medium ${status == '정산대기' ? 'bg-primary text-white' : 'bg-gray-100 text-gray-600'}">정산대기</button>
                    <button type="button" onclick="changeStatus('정산완료')" class="px-4 py-2 rounded-lg text-sm font-medium ${status == '정산완료' ? 'bg-primary text-white' : 'bg-gray-100 text-gray-600'}">정산완료</button>
                </div>
                
                <div class="flex items-center gap-3 w-full md:w-auto">
                    <!-- 정렬 필터 -->
                    <select name="orderBy" onchange="this.form.submit()" class="border rounded-lg px-3 py-2 text-sm bg-gray-50">
                        <option value="deadline" ${param.orderBy == 'deadline' ? 'selected' : ''}>기한 임박순</option>
                        <option value="amountDesc" ${param.orderBy == 'amountDesc' ? 'selected' : ''}>금액 큰 순</option>
                    </select>
                    <!-- 섹션 내 검색창 -->
                    <div class="relative flex-grow">
                        <input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="대상 ID 검색..." class="w-full border rounded-lg pl-4 pr-10 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20">
                        <button type="submit" class="absolute right-3 top-2.5 text-gray-400">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                        </button>
                    </div>
                </div>
            </div>
        </form>

        <div class="overflow-x-auto">
            <table class="w-full text-left">
                <thead class="bg-gray-50 border-b border-gray-100 text-xs uppercase text-gray-500 font-semibold">
                    <tr>
                        <th class="px-6 py-4">정산 번호</th>
                        <th class="px-6 py-4">대상(ID/유형)</th>
                        <th class="px-6 py-4">정산 기한</th>
                        <th class="px-6 py-4 text-right">총 매출</th>
                        <th class="px-6 py-4 text-right">정산 금액</th>
                        <th class="px-6 py-4 text-center">상태</th>
                        <th class="px-6 py-4 text-center">정산하기</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-50 text-sm">
                    <c:forEach var="item" items="${data.settlementList}">
                        <tr class="hover:bg-blue-50/30 transition-colors">
                            <td class="px-6 py-4">#${item.settlementNum}</td>
                            <td class="px-6 py-4">
                                <div class="font-medium text-gray-900">${item.targetNum}</div>
                                <div class="text-xs text-gray-400">${item.targetType}</div>
                            </td>
                            <td class="px-6 py-4 text-gray-600">${item.settlementDeadline}</td>
                            <td class="px-6 py-4 text-right font-medium">
                                <fmt:formatNumber value="${item.totalSales}" type="number"/>
                            </td>
                            <td class="px-6 py-4 text-right font-bold text-blue-600">
                                <fmt:formatNumber value="${item.totalAmount}" type="number"/>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <span class="inline-flex px-2 py-1 rounded-md text-xs font-semibold ${item.settlementStatus == '정산완료' ? 'bg-green-100 text-green-700' : 'bg-orange-100 text-orange-700'}">
                                    ${item.settlementStatus}
                                </span>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <c:if test="${item.settlementStatus == '정산대기'}">
                                	<button onclick="openSettlementModal(${item.settlementNum})" 
            						class="bg-gray-900 text-white px-3 py-1.5 rounded-lg text-xs hover:bg-black transition-colors">
        							상세보기
    								</button>      
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 페이징 영역 -->
        <div class="p-4 border-t border-gray-100 flex justify-center gap-2">
            <c:set var="limit" value="10"/>
            <c:set var="offset" value="${param.offset != null ? param.offset : 0}"/>
            <button onclick="movePage(${offset - limit})" class="p-2 border rounded-md hover:bg-gray-50 ${offset <= 0 ? 'invisible' : ''}">이전</button>
            <button onclick="movePage(${offset + limit})" class="p-2 border rounded-md hover:bg-gray-50">다음</button>
        </div>
    </div>
</div>

<!-- 정산 상세 모달 -->
<div id="settlementModal" class="fixed inset-0 z-50 hidden overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen px-4 pt-4 pb-20 text-center sm:block sm:p-0">
        <!-- 배경 레이어 -->
        <div class="fixed inset-0 transition-opacity bg-gray-500 bg-opacity-75" onclick="closeModal()"></div>
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen">&#8203;</span>
        
        <div class="inline-block overflow-hidden text-left align-bottom transition-all transform bg-white rounded-xl shadow-xl sm:my-8 sm:align-middle sm:max-w-2xl sm:w-full">
            <div class="px-6 py-4 border-b border-gray-100 flex justify-between items-center bg-gray-50">
                <h3 class="text-lg font-bold text-gray-900">정산 상세 내역</h3>
                <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>

					<div class="p-6">
						<div class="overflow-x-auto mb-6">
							<table class="w-full text-sm text-left">
								<thead
									class="bg-gray-50 text-gray-500 uppercase text-xs font-semibold">
									<tr>
										<th class="py-3 px-2">회원명</th>
										<th class="py-3 px-2">결제일자</th>
										<th class="py-3 px-2 text-right">결제금액</th>
									</tr>
								</thead>
								<tbody id="modalDetailBody" class="divide-y divide-gray-100">
								</tbody>
							</table>
						</div>

						<!-- 총 합계 영역 -->
						<div
							class="bg-blue-50 rounded-lg p-5 flex flex-col md:flex-row justify-between items-start md:items-center gap-4 border border-blue-100">
							<div>
								<p
									class="text-xs text-blue-600 font-bold mb-1 uppercase tracking-wider">입금
									계좌 정보</p>
								<div class="flex items-center gap-2">
									<span class="material-symbols-outlined text-blue-500">account_balance</span>
									<p id="modalBankInfo"
										class="text-sm text-gray-800 font-bold tracking-tight">정보를
										로드 중...</p>
								</div>
							</div>
							<div class="text-right space-y-1 min-w-[180px]">
								<div class="text-xs text-gray-500 flex justify-between gap-4">
									<span>총 매출:</span> <span id="modalTotalSales" class="font-medium text-gray-900">₩0</span>
								</div>
								<div class="text-xs text-red-500 flex justify-between gap-4">
									<span>수수료(10%):</span> 
									<span id="modalTotalFee" class="font-medium">₩0</span>
								</div>
								<div class="pt-2 mt-2 border-t border-blue-200">
									<p class="text-xs text-gray-500 font-medium">최종 입금액</p>
									<p id="modalTotalAmount" class="text-2xl font-black text-primary">₩0</p>
								</div>
							</div>
						</div>
					</div>

					<div class="px-6 py-4 bg-gray-50 border-t border-gray-100 flex justify-end gap-2">
                <button onclick="closeModal()" class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50">취소</button>
                <button id="modalConfirmBtn" class="px-4 py-2 text-sm font-medium text-white bg-primary rounded-lg hover:bg-primary-dark shadow-sm transition-all">정산 완료 처리</button>
            </div>
        </div>
    </div>
</div>

</main>
<script>

// 2. 상태 변경 및 페이징 함수
function changeStatus(status) {
    document.getElementById('currentStatus').value = status;
    document.getElementById('currentOffset').value = 0; // 탭 변경 시 첫 페이지로
    document.getElementById('listForm').submit();
}

function movePage(newOffset) {
    document.getElementById('currentOffset').value = newOffset;
    document.getElementById('listForm').submit();
}

//기존 정산 처리 함수 활용
function processSettlement(id) {
    if(!confirm("정산 완료 처리하시겠습니까? (이 작업은 되돌릴 수 없습니다)")) return;
    
    const params = new URLSearchParams();
    params.append('action', 'completeSettlement');
    params.append('id', id);

    fetch("${pageContext.request.contextPath}/admin/salesSettlement", {
        method: "POST",
        body: params
    })
    .then(res => res.text())
    .then(result => {
        if(result === "success") {
            alert("정산 처리가 완료되었습니다.");
            location.reload();
        } else {
            alert("오류 발생: " + result);
        }
    });
}

//모달 열기 함수
function openSettlementModal(settlementNum) {
	console.log("선택된 정산번호:", settlementNum);

    if (!settlementNum) {
        alert("정산 번호가 없습니다.");
        return;
    }

    // JSP 변수 충돌을 피하기 위해 경로를 미리 변수로 뺍니다.
    var ctx = "${pageContext.request.contextPath}";
    var url = ctx + "/admin/salesSettlement?action=getSettlementDetail&id=" + settlementNum;

    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) {
        	var html = "";
        	var sumPayAmount = 0; // 총 결제금액 합계
        	var sumFee = 0;       // 총 수수료 합계
        	var sumNetAmount = 0; // 총 정산금 합계
         
            
            if (!data.details || data.details.length === 0) {
                html = '<tr><td colspan="5" class="px-4 py-3 text-center">결제 내역이 없습니다.</td></tr>';
            } else {
            	data.details.forEach(detail => {
                    html += `<tr class="hover:bg-gray-50/50">
                        <td class="px-4 py-3 font-medium text-gray-900">\${detail.memberName}</td>
                        <td class="px-4 py-3 text-gray-500">\${detail.payDate}</td>
                        <td class="px-4 py-3 text-right text-gray-900">₩\${detail.payAmount.toLocaleString()}</td>
                    </tr>`;
                    sumPayAmount += detail.payAmount;
                    sumFee += detail.fee;
                    sumNetAmount += detail.netAmount;
                });
            	// 컨트롤러에서 보낸 계좌 정보 매핑
                const bank = data.bankName || "미등록";
                const acc = data.accountNum || "계좌정보없음";
                const owner = data.ownerName || "예금주미확인";
                document.getElementById('modalBankInfo').innerText = bank + " " + acc + " (" + owner + ")";
            }
            
            document.getElementById('modalDetailBody').innerHTML = html;
            document.getElementById('modalTotalSales').innerText = '₩' + sumPayAmount.toLocaleString();
            document.getElementById('modalTotalFee').innerText = '- ₩' + sumFee.toLocaleString();
            document.getElementById('modalTotalAmount').innerText = '₩' + sumNetAmount.toLocaleString();
            
            // 버튼 이벤트 및 모달 표시
            document.getElementById('modalConfirmBtn').onclick = function() { processSettlement(settlementNum); };
            document.getElementById('settlementModal').classList.remove('hidden');
        })
        .catch(function(err) {
            console.error(err);
            alert("데이터를 가져오는 중 오류가 발생했습니다.");
        });
}

// 모달 닫기
function closeModal() {
    document.getElementById('settlementModal').classList.add('hidden');
}

</script>
</body></html>