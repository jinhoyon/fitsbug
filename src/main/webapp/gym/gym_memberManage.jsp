<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&amp;display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
	rel="stylesheet">
<script id="tailwind-config">
	tailwind.config = {
		darkMode : "class",
		theme : {
			extend : {
				colors : {
					"primary" : "#3B82F6",
					"secondary" : "#495e8a",
					"tertiary-fixed-dim" : "#ffb786",
					"surface-tint" : "#3B82F6",
					"surface-dim" : "#d9dadc",
					"on-tertiary-fixed" : "#311400",
					"on-secondary-fixed-variant" : "#304671",
					"on-error-container" : "#93000a",
					"surface-container-low" : "#f3f4f6",
					"on-tertiary" : "#ffffff",
					"on-background" : "#191c1e",
					"on-secondary-fixed" : "#001a42",
					"tertiary-fixed" : "#ffdcc6",
					"on-error" : "#ffffff",
					"surface-variant" : "#e1e2e4",
					"tertiary" : "#924700",
					"outline" : "#727785",
					"on-surface" : "#191c1e",
					"surface-container-highest" : "#e1e2e4",
					"secondary-container" : "#E0E7FF",
					"on-tertiary-fixed-variant" : "#723600",
					"on-secondary" : "#ffffff",
					"primary-container" : "#DBEAFE",
					"inverse-on-surface" : "#f0f1f3",
					"surface-container-lowest" : "#ffffff",
					"on-primary" : "#ffffff",
					"inverse-primary" : "#adc6ff",
					"error-container" : "#ffdad6",
					"on-tertiary-container" : "#fffbff",
					"on-secondary-container" : "#405682",
					"secondary-fixed-dim" : "#b1c6f9",
					"secondary-fixed" : "#d8e2ff",
					"primary-fixed-dim" : "#adc6ff",
					"outline-variant" : "#c2c6d6",
					"background" : "#f8f9fb",
					"surface" : "#f8f9fb",
					"tertiary-container" : "#b75b00",
					"on-primary-fixed-variant" : "#004395",
					"on-primary-fixed" : "#001a42",
					"surface-container" : "#edeef0",
					"on-surface-variant" : "#424754",
					"surface-container-high" : "#e7e8ea",
					"surface-bright" : "#f8f9fb",
					"error" : "#ef4444",
					"inverse-surface" : "#2e3132",
					"primary-fixed" : "#d8e2ff",
					"on-primary-container" : "#1E40AF"
				},
				fontFamily : {
					"headline" : [ "Inter" ],
					"body" : [ "Inter" ],
					"label" : [ "Inter" ]
				},
				borderRadius : {
					"DEFAULT" : "0.5rem",
					"lg" : "0.5rem",
					"xl" : "1.5rem",
					"full" : "9999px"
				},
			},
		},
	}
</script>
<style>
body {
	font-family: 'Inter', sans-serif;
	-webkit-font-smoothing: antialiased;
}

.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 20;
	vertical-align: middle;
}

.no-scrollbar::-webkit-scrollbar {
	display: none;
}

.glass-nav {
	background: rgba(255, 255, 255, 0.85);
	backdrop-filter: blur(12px);
	border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}
</style>
</head>
<body class="bg-background">
	<jsp:include page="common/sidebar.jsp"></jsp:include>
	<!-- Main Canvas -->
	<main class="ml-64 min-h-screen">
		<!-- Content Area -->
		<div class="flex-1 p-5 pt-6 pb-8 bg-background space-y-2">
			<!-- Page Title -->
			<div class="flex items-center justify-between mb-2 px-1">
				<h3 class="text-xl font-bold text-on-surface tracking-tight"
					style="">회원 관리</h3>
			</div>
			<!-- Compact Bento Filter Section -->
			<div
				class="bg-surface-container-lowest p-5 rounded-lg shadow-[0_1px_3px_0_rgba(0,0,0,0.05)] border border-outline-variant/10">
				<div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-6">
					<div class="flex flex-col gap-2.5">
						<span
							class="text-[11px] font-bold text-on-surface-variant uppercase tracking-widest px-1"
							style="">이용권 타입</span>
						<div class="flex gap-1.5">
							<a
								href="${pageContext.request.contextPath}/gym/memberManage?status=${status}&keyword=${keyword}"
								class="px-3.5 py-1.5 ${empty type ? 'bg-primary text-white' : 'bg-surface-container text-on-surface-variant'} rounded-full text-[12px] font-bold hover:shadow-md transition-all">
								전체 </a> <a
								href="${pageContext.request.contextPath}/gym/memberManage?type=health&status=${status}&keyword=${keyword}"
								class="px-3.5 py-1.5 ${type == 'health' ? 'bg-primary text-white' : 'bg-surface-container text-on-surface-variant'} hover:bg-outline-variant/30 rounded-full text-[12px] font-semibold transition-all">
								헬스장 멤버십 </a> <a
								href="${pageContext.request.contextPath}/gym/memberManage?type=pt&status=${status}&keyword=${keyword}"
								class="px-3.5 py-1.5 ${type == 'pt' ? 'bg-primary text-white' : 'bg-surface-container text-on-surface-variant'} hover:bg-outline-variant/30 rounded-full text-[12px] font-semibold transition-all">
								PT 멤버십 </a>
						</div>
					</div>
					
				</div>
				<!-- Search and Stats Row -->
				<div
					class="flex flex-col md:flex-row md:items-center justify-between gap-4 pt-5 border-t border-outline-variant/10">
					<form action="${pageContext.request.contextPath}/gym/memberManage"
						method="get" class="relative flex-1 max-w-lg">
						<input type="hidden" name="type" value="${type}"> <input
							type="hidden" name="status" value="${status}"> <span
							class="absolute inset-y-0 left-3 flex items-center text-on-surface-variant/60">
							<span class="material-symbols-outlined text-[18px]" style="">search</span>
						</span> <input name="keyword" value="${keyword}"
							class="w-full pl-9 pr-4 py-2 bg-surface-container-low border border-transparent rounded-lg text-sm focus:ring-2 focus:ring-primary/10 focus:bg-white focus:border-primary/20 outline-none transition-all placeholder:text-on-surface-variant/40"
							placeholder="회원명 검색" type="text">
						<button type="submit"
							class="absolute right-2 top-1/2 -translate-y-1/2 px-3 py-1 text-xs bg-primary text-white rounded">
							검색</button>
					</form>
					<div class="flex items-center gap-6">
						<div
							class="flex flex-col items-end pr-6 border-r border-outline-variant/15">
							<span
								class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-0.5"
								style="">전체 회원</span> <span
								class="text-lg font-black text-on-surface leading-none" style="">${totalMemberCount}</span>
						</div>
						<div
							class="flex flex-col items-end px-4 py-1.5 bg-primary/5 rounded-lg border border-primary/10">
							<span
								class="text-[10px] font-bold text-primary uppercase tracking-widest mb-0.5"
								style="">이번 달 신규</span> <span
								class="text-lg font-black text-primary leading-none" style="">+${newMemberCount}</span>
						</div>
					</div>
				</div>
			</div>
			<!-- High-Density Member Table -->
			<div
				class="bg-surface-container-lowest rounded-lg shadow-[0_1px_3px_0_rgba(0,0,0,0.05)] border border-outline-variant/10 flex flex-col">
				<div>
					<table class="w-full text-left">
						<thead>
							<tr
								class="bg-surface-container-low/40 border-b border-outline-variant/10">
								<th class="px-6 py-3 w-[15%]">회원명</th>
								<th class="px-6 py-3 w-[15%]">이용권 타입</th>
								<th class="px-6 py-3 w-[20%]">이용권 종류</th>
								<th class="px-6 py-3 w-[15%]">헬스 이용 기간</th>
								<th class="px-6 py-3 w-[20%] text-center">남은 PT</th>
								<th class="px-6 py-3 w-[12%]">남은 기간</th>
							</tr>
						</thead>
						<tbody class="divide-y divide-outline-variant/5">
							<c:forEach var="member" items="${memberList}">
								<tr
									class="group hover:bg-surface-container-low/30 transition-colors">
									<td class="px-6 py-3">
    <div class="flex items-center gap-2">

        <a href="${pageContext.request.contextPath}/trainer/clientDetailCommon?clientId=${member.memberId}"
           class="text-sm font-bold text-on-surface hover:text-primary hover:underline">
            ${member.memberName}
        </a>

        <c:if test="${member.memberSource eq '예약회원'}">
            <span class="px-2 py-1 text-[10px] rounded bg-orange-100 text-orange-700 font-bold">
                예약회원
            </span>
        </c:if>

    </div>
</td>

									<td class="px-6 py-3" style=""><span
										class="px-2.5 py-0.5 bg-surface-container text-on-surface-variant rounded text-[11px] font-bold">
											<c:choose>
												<c:when test="${member.membershipType eq 'reservation'}">
    												예약 회원
												</c:when>
												<c:when test="${member.membershipType == 'pt'}"> PT 멤버십</c:when>
												<c:otherwise>헬스장 멤버십</c:otherwise>
											</c:choose>
									</span></td>

									<td class="px-6 py-3"><span
										class="text-[12px] font-semibold text-on-surface-variant bg-surface-container-high/50 px-2 py-0.5 rounded">
											<c:choose>
												<c:when test="${member.membershipType == 'pt'}">PT ${member.typeRep}회권</c:when>
												<c:when test="${member.membershipType == 'day'}">1일 이용권</c:when>
												<c:when test="${member.membershipType == 'month'}">${member.typeRep}개월 이용권</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
									</span></td>

									<td
										class="px-6 py-3 text-sm text-on-surface-variant/60 font-medium">
										<c:choose>
											<c:when test="${member.membershipType == 'pt'}">-</c:when>
											<c:otherwise>${member.startDate} ~ ${member.endDate}</c:otherwise>
										</c:choose>
									</td>

									<td class="px-6 py-3 text-center">
    <c:choose>

        <c:when test="${member.membershipType == 'pt' and member.status == 'expired'}">
    <span class="text-xs font-bold text-on-surface-variant/60">
        만료됨
    </span>
</c:when>

        <c:when test="${member.membershipType == 'pt' and member.status == 'before'}">
            <span class="text-xs font-bold text-on-surface-variant/60">
                시작 전
            </span>
        </c:when>

        <c:when test="${member.membershipType == 'pt'}">
            <span
                class="text-sm font-black ${member.remainPtCount <= 5 ? 'text-error' : 'text-on-surface'}">
                ${member.remainPtCount}회
            </span>
        </c:when>

        <c:otherwise>
            <span class="text-sm text-on-surface-variant/40">-</span>
        </c:otherwise>

    </c:choose>
</td>

									<td class="px-6 py-3">
    <c:choose>

    <c:when test="${member.membershipType != 'pt' and member.status == 'expired'}">
    <span class="text-xs font-bold text-on-surface-variant/60">
        만료됨
    </span>
</c:when>

    <c:when test="${member.status == 'before'}">
        <span class="text-xs font-bold text-blue-500">
            시작 전
        </span>
    </c:when>

    <c:when test="${member.remainDays == 0}">
        <span class="text-xs font-bold text-red-500">
            오늘 만료
        </span>
    </c:when>

    <c:otherwise>
        <span class="text-xs font-bold text-primary">
            ${member.remainDays}일 남음
        </span>
    </c:otherwise>

</c:choose>
</td>
								</tr>
							</c:forEach>
							<c:if test="${empty memberList}">
								<tr>
									<td colspan="6"
										class="px-6 py-10 text-center text-sm text-on-surface-variant">
										조회된 회원이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>

				<!-- Compact Pagination -->

				<div class="flex justify-center mt-6 mb-6 gap-1 text-sm">

					<c:if test="${page > 1}">
						<a
							href="${pageContext.request.contextPath}/gym/memberManage?page=${page-1}&type=${type}&status=${status}&keyword=${keyword}"
							class="px-3 py-1 rounded bg-surface-container hover:bg-outline-variant/30">
							이전 </a>
					</c:if>

					<c:forEach var="i" begin="1" end="${totalPage}">
						<a
							href="${pageContext.request.contextPath}/gym/memberManage?page=${i}&type=${type}&status=${status}&keyword=${keyword}"
							class="px-3 py-1 rounded ${i == page ? 'bg-primary text-white font-bold' : 'bg-surface-container hover:bg-outline-variant/30'}">
							${i} </a>
					</c:forEach>

					<c:if test="${page < totalPage}">
						<a
							href="${pageContext.request.contextPath}/gym/memberManage?page=${page+1}&type=${type}&status=${status}&keyword=${keyword}"
							class="px-3 py-1 rounded bg-surface-container hover:bg-outline-variant/30">
							다음 </a>
					</c:if>

				</div>

			</div>
		

		<!-- Refund Request Section -->
		<div
			class="bg-surface-container-lowest rounded-lg shadow-[0_1px_3px_0_rgba(0,0,0,0.05)] border border-outline-variant/10 overflow-hidden">

			<div
				class="flex items-center justify-between px-6 py-4 border-b border-outline-variant/10">
				<div>
					<h4 class="text-sm font-bold text-on-surface">환불 요청 처리</h4>
					<p class="text-xs text-on-surface-variant mt-1">회원의 환불 요청을 승인
						처리할 수 있습니다.</p>
				</div>

				<span id="pendingRefundCount"
					  class="text-[11px] font-bold text-error bg-error/10 px-3 py-1 rounded-full">
					  미처리 ${pendingRefundCount}건 </span>
			</div>

			<div class="overflow-x-auto">
				<table class="w-full text-left table-fixed">
					<thead>
						<tr class="bg-surface-container-low/40 border-b border-outline-variant/10">
							<th
								class="px-6 py-3 text-[11px] font-bold text-on-surface-variant uppercase tracking-widest">회원명</th>
							<th
								class="px-6 py-3 text-[11px] font-bold text-on-surface-variant uppercase tracking-widest">이용권</th>
							<th
								class="px-6 py-3 text-[11px] font-bold text-on-surface-variant uppercase tracking-widest">결제
								금액</th>
							<th
								class="px-6 py-3 text-[11px] font-bold text-on-surface-variant uppercase tracking-widest">환불
								사유</th>
							<th
								class="px-6 py-3 text-[11px] font-bold text-on-surface-variant uppercase tracking-widest">결제일</th>
							<th
								class="px-6 py-3 text-[11px] font-bold text-on-surface-variant uppercase tracking-widest text-center">처리</th>
						</tr>
					</thead>

					<tbody class="divide-y divide-outline-variant/5">
						<c:forEach var="payment" items="${paymentList}">
							<tr id="paymentRow-${payment.paymentNum}" class="hover:bg-surface-container-low/30 transition-colors">
								<td class="px-6 py-3 text-sm font-bold text-on-surface">
									${payment.memberName}</td>

								<td
									class="px-6 py-3 text-xs font-semibold text-on-surface-variant">
									${payment.membershipName}</td>

								<td class="px-6 py-3 text-sm font-bold text-on-surface">
									<fmt:formatNumber value="${payment.paymentPrice}" type="number"/>원</td>

								<td class="px-6 py-3 text-xs text-on-surface-variant">
									${payment.reason}</td>

								<td class="px-6 py-3 text-xs text-on-surface-variant">
									<fmt:formatDate value="${payment.paymentDate}" pattern="yyyy-MM-dd HH:mm"/></td>

								<td class="px-6 py-3">
									<div id="refundAction-${payment.paymentNum}" 
										 class="flex justify-center gap-2">
									<fmt:formatDate value="${payment.paymentDate}" pattern="yyyy-MM-dd HH:mm" var="formattedDate"/>
										<button type="button" onclick="openModal(this)"
											class="px-3 py-1 bg-error text-white rounded text-xs font-bold hover:opacity-90"
											data-name="${payment.memberName}"
											data-membership="${payment.membershipName}"
											data-price="${payment.paymentPrice}"
											data-payment-num="${payment.paymentNum}"
											data-date="${formattedDate}"
											data-reason="${payment.reason}">승인</button>
									</div>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty paymentList}">
							<tr>
								<td colspan="6"
									class="px-6 py-8 text-center text-sm text-on-surface-variant">
									환불 요청이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<div class="flex justify-center mt-3 mb-3 gap-1 text-sm">

					<c:if test="${refundPage > 1}">
						<a
							href="${pageContext.request.contextPath}/gym/memberManage?page=${page}&refundPage=${refundPage - 1}&type=${type}&status=${status}&keyword=${keyword}"
							class="px-3 py-1 rounded bg-surface-container hover:bg-outline-variant/30">
							이전 </a>
					</c:if>

					<c:forEach var="i" begin="1" end="${refundTotalPage}">
						<a
							href="${pageContext.request.contextPath}/gym/memberManage?page=${page}&refundPage=${i}&type=${type}&status=${status}&keyword=${keyword}"
							class="px-3 py-1 rounded ${i == refundPage ? 'bg-primary text-white font-bold' : 'bg-surface-container hover:bg-outline-variant/30'}">
							${i} </a>
					</c:forEach>

					<c:if test="${refundPage < refundTotalPage}">
						<a
							href="${pageContext.request.contextPath}/gym/memberManage?page=${page}&refundPage=${refundPage + 1}&type=${type}&status=${status}&keyword=${keyword}"
							class="px-3 py-1 rounded bg-surface-container hover:bg-outline-variant/30">
							다음 </a>
					</c:if>

				</div>
			</div>
		</div>
</div>
	</main>

	<!-- 🔥 환불 모달 -->
<div id="refundModal" class="fixed inset-0 z-[100] flex items-center justify-center hidden">

    <!-- 배경 -->
    <div class="absolute inset-0 bg-black/40 backdrop-blur-sm"></div>

    <!-- 모달 박스 -->
    <div class="relative bg-white w-full max-w-2xl rounded-xl shadow-2xl overflow-hidden">

        <!-- 헤더 -->
        <div class="px-6 py-5 flex justify-between items-start border-b border-outline-variant/10">
            <div>
                <h2 class="text-lg font-black text-on-surface">결제 내역 및 환불 처리</h2>
                <p class="text-xs text-on-surface-variant mt-1">
                    <span id="modalName"></span> 회원
                </p>
            </div>

            <button type="button" onclick="closeModal()"
                    class="text-on-surface-variant hover:text-on-surface text-xl">
                ×
            </button>
        </div>

        <!-- 내용 -->
        <div class="p-6 space-y-6">

            <!-- 결제 상세 -->
            <div>
                <h3 class="text-xs font-bold text-on-surface mb-3">결제 상세 내역</h3>

                <table class="w-full text-left rounded-lg overflow-hidden">
                    <thead>
                        <tr class="bg-surface-container-low border-b border-outline-variant/10">
                            <th class="px-4 py-3 text-[11px] font-bold text-on-surface-variant">상품명</th>
                            <th class="px-4 py-3 text-[11px] font-bold text-on-surface-variant text-center">결제일자</th>
                            <th class="px-4 py-3 text-[11px] font-bold text-on-surface-variant text-right">결제금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="border-b border-outline-variant/10">
                            <td class="px-4 py-4 text-sm font-bold text-on-surface">
                                <span id="modalMembership"></span>
                            </td>
                            <td class="px-4 py-4 text-sm text-on-surface-variant text-center">
    							<span id="modalDate"></span>
							</td>
                            <td class="px-4 py-4 text-sm font-black text-on-surface text-right">
                                <span id="modalPrice"></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 환불 사유 + 금액 -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">

                <!-- 환불 사유 -->
                <div>
                    <h3 class="text-xs font-bold text-on-surface mb-3">환불 사유</h3>

                    <div class="bg-surface-container-low p-4 rounded-lg min-h-[150px]">
                        <p id="modalReason" class="text-sm text-on-surface-variant leading-relaxed"></p>
                    </div>
                </div>

                <!-- 최종 환불 금액 -->
                <div class="bg-error/5 border border-error/20 rounded-lg p-6 flex flex-col justify-center items-center text-center min-h-[150px]">
                    <p class="text-[11px] font-bold text-error mb-3">최종 환불 금액</p>

                    <p class="text-3xl font-black text-error">
                        <span id="modalRefundPrice"></span>원
                    </p>

                    <p class="text-xs text-on-surface-variant mt-3">
                        승인 시 즉시 처리됩니다.
                    </p>
                </div>

            </div>
        </div>

        <!-- 푸터 -->
        <div class="px-6 py-5 flex justify-end gap-3 border-t border-outline-variant/10 bg-surface-container-lowest">

    <button type="button"
            onclick="closeModal()"
            class="px-5 py-2.5 bg-surface-container text-on-surface-variant rounded-lg text-sm font-bold">
        취소
    </button>

    

    <button type="button"
            onclick="approveRefund()"
            class="px-6 py-2.5 bg-error text-white rounded-lg text-sm font-bold shadow-md hover:opacity-90">
        환불 처리하기
    </button>

</div>
    </div>
</div>

<div id="successModal" class="fixed inset-0 z-[120] hidden flex items-center justify-center">
    <div class="absolute inset-0 bg-black/30"></div>

    <div class="relative bg-white rounded-xl shadow-xl px-8 py-6 text-center w-80">
        <h3 class="text-lg font-bold mb-3">환불 처리 완료</h3>
        <p class="text-sm text-on-surface-variant mb-5">
            환불 요청이 정상적으로 처리되었습니다.
        </p>

        <button type="button"
                onclick="closeSuccessModal()"
                class="px-5 py-2 bg-primary text-white rounded-lg text-sm font-bold">
            확인
        </button>
    </div>
    
</div>


<script>
let selectedPaymentNum = null;

function openModal(btn) {
    selectedPaymentNum = btn.dataset.paymentNum;
    
    const price = Number(btn.dataset.price);

    document.getElementById("modalName").innerText = btn.dataset.name;
    document.getElementById("modalMembership").innerText = btn.dataset.membership;
    document.getElementById("modalDate").innerText = btn.dataset.date;
    document.getElementById("modalPrice").innerText = price.toLocaleString('ko-KR') + "원";
    document.getElementById("modalReason").innerText = btn.dataset.reason;
    document.getElementById("modalRefundPrice").innerText = Math.floor(Number(price)).toLocaleString('ko-KR');

    document.getElementById("refundModal").classList.remove("hidden");
}

function closeModal() {
    document.getElementById("refundModal").classList.add("hidden");
}

function approveRefund() {
    fetch("${pageContext.request.contextPath}/gym/refundApprove", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        },
        body: "paymentNum=" + encodeURIComponent(selectedPaymentNum)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("환불 처리 실패");
        }

        closeModal();
        document.getElementById("successModal").classList.remove("hidden");
    })
    .catch(error => {
        alert("환불 처리 중 오류가 발생했습니다.");
        console.error(error);
    });
}

function closeSuccessModal() {
    document.getElementById("successModal").classList.add("hidden");

    const actionCell = document.getElementById(
    	    "refundAction-" + selectedPaymentNum
    	);	

    if (actionCell) {

        const now = new Date();

        const formatted =
            now.getFullYear() + "-" +
            String(now.getMonth() + 1).padStart(2, '0') + "-" +
            String(now.getDate()).padStart(2, '0');

        actionCell.innerHTML = 
            '<span class="text-[11px] font-bold text-slate-400">'
               + formatted + ' 환불완료'
               +'</span>';
        
    }
    
    const badge = document.getElementById("pendingRefundCount");
    if (badge) {
        const current = Number(badge.innerText.replace(/[^0-9]/g, ""));
        const next = Math.max(current - 1, 0);
        badge.innerText = "미처리 " + next + "건";
    }
}


</script>


</body>
</html>