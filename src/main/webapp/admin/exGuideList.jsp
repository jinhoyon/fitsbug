<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String contextPath = request.getContextPath();
%>     
<!DOCTYPE html>

<html lang="ko"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            colors: {
              "surface-dim": "#d9dadc",
              "secondary": "#585f6c",
              "on-surface": "#191c1e",
              "tertiary": "#924700",
              "background": "#f8f9fb",
              "primary-fixed": "#d8e2ff",
              "surface-bright": "#f8f9fb",
              "on-secondary-container": "#5e6572",
              "tertiary-fixed": "#ffdcc6",
              "primary": "#3B82F6",
              "on-tertiary-fixed": "#311400",
              "secondary-fixed": "#dce2f3",
              "surface-tint": "#3B82F6",
              "on-primary-fixed": "#001a42",
              "on-tertiary-fixed-variant": "#723600",
              "primary-fixed-dim": "#adc6ff",
              "primary-container": "#2170e4",
              "on-secondary-fixed": "#151c27",
              "surface-container": "#edeef0",
              "surface-container-highest": "#e1e2e4",
              "on-error": "#ffffff",
              "on-primary": "#ffffff",
              "error-container": "#ffdad6",
              "on-surface-variant": "#424754",
              "tertiary-fixed-dim": "#ffb786",
              "surface-variant": "#e1e2e4",
              "inverse-primary": "#adc6ff",
              "surface": "#f8f9fb",
              "surface-container-low": "#f3f4f6",
              "surface-container-low-80": "rgba(243, 244, 246, 0.8)",
              "surface-container-lowest": "#ffffff",
              "surface-container-high": "#e7e8ea",
              "error": "#ba1a1a",
              "on-secondary": "#ffffff",
              "on-primary-fixed-variant": "#004395",
              "on-tertiary": "#ffffff",
              "outline": "#727785",
              "secondary-fixed-dim": "#c0c7d6",
              "on-primary-container": "#fefcff",
              "on-tertiary-container": "#fffbff",
              "outline-variant": "#c2c6d6",
              "secondary-container": "#dce2f3",
              "inverse-on-surface": "#f0f1f3",
              "on-background": "#191c1e",
              "tertiary-container": "#b75b00",
              "inverse-surface": "#2e3132",
              "on-error-container": "#93000a",
              "on-secondary-fixed-variant": "#404754"
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
<script>
function filterMuscle(muscle) {
	// 필터 변경 시에는 1페이지로 이동하며 검색어는 유지
    const keyword = "${param.searchKeyword}";
    let url = "<%= contextPath %>/admin/exGuideList?page=1";
    if(muscle) url += "&targetMuscle=" + encodeURIComponent(muscle);
    if(keyword) url += "&searchKeyword=" + encodeURIComponent(keyword);
    location.href = url;
}
function deleteGuide(egNum) {
    if (confirm("정말 이 가이드를 삭제하시겠습니까?")) {
        location.href = "<%= contextPath %>/admin/exGuideDelete?egNum=" + egNum;
    }
}
function searchGuide(keyword) {
	// 검색 시에는 1페이지로 이동하며 필터는 유지
    const muscle = "${param.targetMuscle}";
    let url = "<%= contextPath %>/admin/exGuideList?page=1";
    if(muscle) url += "&targetMuscle=" + encodeURIComponent(muscle);
    if(keyword) url += "&searchKeyword=" + encodeURIComponent(keyword);
    location.href = url;
}
function goSearch(page) {
    const muscle = "${param.targetMuscle}";
    const keyword = document.getElementById("searchInput").value; // 검색창 ID 부여 필요
    
    let url = "<%= contextPath %>/admin/exGuideList?page=" + page;
    if(muscle) url += "&targetMuscle=" + encodeURIComponent(muscle);
    if(keyword) url += "&searchKeyword=" + encodeURIComponent(keyword);
    
    location.href = url;
}
</script>
<style>
      .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
      }
      .glass-header {
        backdrop-filter: blur(24px);
        background-color: rgba(255, 255, 255, 0.8);
      }
      .primary-gradient {
        background: linear-gradient(135deg, #3B82F6 0%, #2563EB 100%);
      }
</style>
</head>
<body class="bg-surface font-body text-on-surface antialiased">

<div class="flex">
    <jsp:include page="sidebar.jsp"></jsp:include>

    <main class="flex-1 ml-64 min-h-screen">
			<div class="pt-10 px-10 pb-10">

				<div class="flex justify-between items-center mb-8">
					<div>
						<h2
							class="text-2xl font-semibold font-headline tracking-tight text-on-surface">운동가이드
							관리</h2>
						<p class="text-on-surface-variant mt-1">등록된 운동 가이드를 수정하거나 삭제할
							수 있는 관리 대시보드입니다.</p>
					</div>
					<button
						onclick="location.href='<%= contextPath %>/admin/exGuideAdd'"
						class="bg-primary text-white px-6 py-2.5 rounded-lg text-sm font-semibold flex items-center gap-2 hover:bg-primary/90 transition-colors shadow-sm">
						<span class="material-symbols-outlined text-lg">add</span>등록
					</button>
				</div>

				<div
					class="bg-surface-container-lowest p-4 rounded-xl shadow-sm border border-outline-variant/30 mb-8 flex items-center justify-between">
					<div class="relative w-72 flex items-center">
						<span
							class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-lg">search</span>
						<input id="searchInput"
							onkeyup="if(window.event.keyCode==13){searchGuide(this.value)}"
							value="${param.searchKeyword}"
							class="w-full pl-10 pr-4 py-2 bg-surface-container-low border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/20 outline-none transition-all"
							placeholder="운동 가이드 검색..." type="text" />
					</div>
					<div class="flex items-center gap-2 flex-wrap">
						<span class="text-xs font-medium text-on-surface-variant mr-2">분류:</span>
						<div class="flex gap-1.5">
							<button onclick="filterMuscle('')"
								class="px-3 py-1.5 text-xs font-medium rounded-full ${empty param.targetMuscle ? 'bg-primary text-white' : 'bg-surface-container-low text-on-surface-variant hover:bg-gray-200'}">전체</button>
							<c:forEach var="muscle"
								items="${fn:split('가슴,등,하체,팔,어깨,전신', ',')}">
								<button onclick="filterMuscle('${muscle}')"
									class="px-3 py-1.5 text-xs font-medium rounded-full ${param.targetMuscle eq muscle ? 'bg-primary text-white' : 'bg-surface-container-low text-on-surface-variant hover:bg-gray-200'}">
									${muscle}</button>
							</c:forEach>
						</div>
					</div>
				</div>
				<div
					class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/30 p-8">
					<div
						class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
						<c:forEach var="guide" items="${guideList}">
							<div
								class="bg-white rounded-lg border border-outline-variant/20 overflow-hidden flex flex-col hover:shadow-md transition-shadow">
								<div class="relative aspect-video">
									<c:choose>
										<c:when test="${not empty guide.image}">
											<img src="<%= contextPath %>/uploads/${guide.image}"
												class="w-full h-full object-cover" alt="${guide.title}" />
										</c:when>
										<c:otherwise>
											<img
												src="<%= contextPath %>/uploads/default_exercise.png"
												class="w-full h-full object-cover" alt="기본이미지" />
										</c:otherwise>
									</c:choose>
									<div
										class="absolute top-2 left-2 bg-primary/90 text-white text-[10px] font-bold px-2 py-0.5 rounded uppercase">${guide.targetMuscle}</div>
								</div>

								<div class="p-4 flex-grow flex flex-col">
									<h3 class="font-bold text-sm mb-2 text-on-surface">${guide.title}</h3>
									<div
										class="flex items-center gap-3 text-on-surface-variant text-[11px] mb-4">
										<span class="flex items-center gap-1"><span
											class="material-symbols-outlined text-sm">fitness_center</span>
											${guide.type}</span> <span class="flex items-center gap-1"><span
											class="material-symbols-outlined text-sm">calendar_today</span>
											<fmt:formatDate value="${guide.regDate}" pattern="yyyy.MM.dd" /></span>
									</div>
									<div class="flex gap-2 mt-auto">
										<button
											onclick="location.href='<%= contextPath %>/admin/exGuideAdd?egNum=${guide.egNum}'"
											class="flex-1 py-1.5 border border-primary text-primary text-xs font-semibold rounded hover:bg-primary/5 transition-colors">수정</button>
										<button onclick="deleteGuide(${guide.egNum})"
											class="flex-1 py-1.5 border border-error text-error text-xs font-semibold rounded hover:bg-error/5 transition-colors">삭제</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

					<c:if test="${empty guideList}">
						<div class="text-center py-20 text-on-surface-variant">등록된
							운동 가이드가 없습니다.</div>
					</c:if>

					<div
						class="mt-8 flex items-center justify-between border-t border-outline-variant/10 pt-6">
						<p class="text-xs text-on-surface-variant">전체 ${totalCount}개 중
							현재 ${pageInfo.curPage}페이지</p>
						<div class="flex items-center gap-1">
							<c:if test="${pageInfo.curPage > 1}">
								<button onclick="goSearch(${pageInfo.curPage - 1})"
									class="w-8 h-8 flex items-center justify-center rounded hover:bg-gray-100">
									<span class="material-symbols-outlined text-lg">chevron_left</span>
								</button>
							</c:if>

							<c:forEach var="i" begin="${pageInfo.startPage}"
								end="${pageInfo.endPage}">
								<button onclick="goSearch(${i})"
									class="w-8 h-8 flex items-center justify-center rounded ${i == pageInfo.curPage ? 'bg-primary text-white font-bold' : 'hover:bg-gray-100'} text-xs">
									${i}</button>
							</c:forEach>

							<c:if test="${pageInfo.curPage < pageInfo.allPage}">
								<button onclick="goSearch(${pageInfo.curPage + 1})"
									class="w-8 h-8 flex items-center justify-center rounded hover:bg-gray-100">
									<span class="material-symbols-outlined text-lg">chevron_right</span>
								</button>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</main>
</div>

</body>
</html>