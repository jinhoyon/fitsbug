<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
<script type="text/javascript">
	let currentSortColumn = 'trainerName';
	let currentSortOrder = 'ASC';
	
	function fn_search(){
		const keyword = $("#searchKeyword").val();

		$.ajax({
            url: "${pageContext.request.contextPath}/admin/memberTrainer",
            type: "POST",
            data: { 
            	trainerName: keyword,
                sortColumn: currentSortColumn,
                sortOrder: currentSortOrder
            	},
            dataType: "json",
            success: function(data) {
                let html = "";
                
                if(data.length === 0) {
                    html = `<tr><td colspan="5" class="px-6 py-10 text-center text-on-surface-variant">
                            등록된 트레이너 정보가 없습니다.</td></tr>`;
                } else {
                    $.each(data, function(index, item) {
                    	// 값이 없을 경우를 대비한 기본값 설정
                        const name = item.trainerName || '이름 없음';
                        const tel = item.trainerTel || '-';
                        const date = item.regDate || '-';
                        const count = item.trainerClientCount || 0;
                        // gymCal이 null이면 0으로 처리하고 숫자 포맷팅
                        const cal = Number(item.trainerCal || 0).toLocaleString();
                        const profile = item.profileImage ? item.profileImage : 'default.png';
                        
                        html += `
                            <tr class="hover:bg-surface-container-low transition-colors group">
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-4">
                                        <div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
                                            <img src="${contextPath}/trainer/profile-img/\${profile}" width="20px"/>
                                        </div>
                                        <div>
                                            <p class="text-sm font-bold text-on-surface">\${name}</p>
                                            <p class="text-xs text-on-surface-variant">\${tel}</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-sm text-on-surface-variant">\${date}</td>
                                <td class="px-6 py-4 text-sm font-medium text-on-surface">\${count}</td>
                                <td class="px-6 py-4 text-sm font-medium text-on-surface">₩\${cal}</td>
                                <td class="px-6 py-4 text-right">
                                    <button class="text-primary hover:bg-primary/10 p-2 rounded-full transition-colors">
                                        <span class="material-symbols-outlined">chevron_right</span>
                                    </button>
                                </td>
                            </tr>`;
                        });
                }
                // tbody에 결과 꽂아넣기
                $("#memberTableBody").html(html);
            },
            error: function(err) {
                console.log("검색 중 에러 발생:", err);
            }
        });
    }
	
	function fn_sort(column){
        if(currentSortColumn === column){
            currentSortOrder = (currentSortOrder === 'ASC') ? 'DESC' : 'ASC';
        } else {
            currentSortColumn = column;
            currentSortOrder = 'ASC';
        }
        fn_search();
    }
	
	$(document).ready(function() {
        // ID가 searchKeyword인 입력창에서 키보드가 눌렸을 때
        $("#searchKeyword").on("keydown", function(e) {
            // 눌린 키가 엔터(Enter, 코드 13)라면
            if (e.keyCode === 13) {
                e.preventDefault(); // 엔터 시 페이지 새로고침 방지 (보안용)
                fn_search();        // 위에서 만든 검색 함수 실행
            }
        });
    });
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
<!-- SideNavBar Shell -->
<div class="flex">
	<jsp:include page="sidebar.jsp"></jsp:include>
</div>
<!-- Main Content Area -->
<main class="ml-64 min-h-screen">
<!-- Page Canvas -->
<div class="pt-10 px-10 pb-10">
<!-- Header Section -->
<div class="flex justify-between items-end mb-8">
<div>
<h2 class="text-2xl font-semibold font-headline tracking-tight text-on-surface">회원리스트</h2>
<p class="text-on-surface-variant mt-1">서비스 전체 회원의 활동 내역과 승인 상태를 관리합니다.</p>
</div>
</div>
<!-- Main Tabs -->
<div class="flex gap-8 mb-4 border-b border-outline-variant/20">
<a href="${contextPath}/admin/memberAuth"
class="pb-4 text-sm font-medium text-on-surface-variant hover:text-primary transition-colors relative">자격승인</a>
<a href="${contextPath}/admin/memberGym"
class="pb-4 text-sm font-bold text-primary border-b-2 border-primary relative">회원리스트</a>
</div>

<!-- Summary Section Metrics -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-4 mt-1">
<!-- Card 1: Total Members -->
<div class="bg-surface-container-lowest px-6 py-3 rounded-xl shadow-sm border border-outline-variant/10">
<div class="flex items-center justify-between mb-2">
<div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined" data-icon="group">group</span>
</div>
</div>
<p class="text-xs font-label text-on-surface-variant uppercase mb-1">전체회원</p>
<h3 class="text-2xl font-bold text-on-surface">${totalCount }명</h3>
</div>
<!-- Card 2: Gyms -->
<div class="bg-surface-container-lowest px-6 py-3 rounded-xl shadow-sm border border-outline-variant/10">
<div class="flex items-center justify-between mb-2">
<div class="w-10 h-10 rounded-lg bg-orange-100 flex items-center justify-center text-orange-600">
<span class="material-symbols-outlined" data-icon="fitness_center">fitness_center</span>
</div>
</div>
<p class="text-xs font-label text-on-surface-variant uppercase mb-1">헬스장</p>
<h3 class="text-2xl font-bold text-on-surface">${gymCount }개</h3>
</div>
<!-- Card 3: Trainers -->
<div class="bg-surface-container-lowest px-6 py-3 rounded-xl shadow-sm border border-outline-variant/10">
<div class="flex items-center justify-between mb-2">
<div class="w-10 h-10 rounded-lg bg-green-100 flex items-center justify-center text-green-600">
<span class="material-symbols-outlined" data-icon="badge">badge</span>
</div>
</div>
<p class="text-xs font-label text-on-surface-variant uppercase mb-1">트레이너</p>
<h3 class="text-2xl font-bold text-on-surface">${trainerCount }명</h3>
</div>
<!-- Card 4: Members -->
<div class="bg-surface-container-lowest px-6 py-3 rounded-xl shadow-sm border border-outline-variant/10">
<div class="flex items-center justify-between mb-2">
<div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center text-blue-600">
<span class="material-symbols-outlined" data-icon="person">person</span>
</div>
</div>
<p class="text-xs font-label text-on-surface-variant uppercase mb-1">회원</p>
<h3 class="text-2xl font-bold text-on-surface">${clientCount }명</h3>
</div>
</div>

<!-- Bento Filter Section -->
<div class="grid grid-cols-12 gap-6 mb-4">
<div class="col-span-12 lg:col-span-4 bg-surface-container-lowest p-1 rounded-xl flex shadow-sm border border-outline-variant/10">
<a href="${contextPath}/admin/memberGym"
class="flex-1 py-2 text-sm font-semibold rounded-lg transition-all text-on-surface-variant hover:bg-surface-container flex items-center justify-center">
헬스장
</a>
<a href="${contextPath}/admin/memberTrainer"
class="flex-1 py-2 text-sm font-semibold rounded-lg transition-all bg-primary text-white shadow-md flex items-center justify-center">
트레이너
</a>
<a href="${contextPath}/admin/memberClient"
class="flex-1 py-2 text-sm font-semibold rounded-lg transition-all text-on-.surface-variant hover:bg-surface-container flex items-center justify-center">
회원
</a>
</div>
</div>
<!-- Table Section -->
<div class="bg-surface-container-lowest rounded-xl shadow-sm overflow-hidden border border-outline-variant/10">
<div class="px-6 py-4 border-b border-outline-variant/10">
<div class="flex items-center gap-3">
<div class="relative w-72">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant text-lg" data-icon="search">
search</span>
<input id="searchKeyword" class="w-full pl-10 pr-4 py-2 bg-surface-container-low border-none rounded-lg text-sm focus:ring-2 focus:ring-primary/20 outline-none transition-all" 
placeholder="트레이너 이름 검색" type="text"/>
</div>
<button id="searchBtn" type="button" onclick="fn_search()" class="px-4 py-2 bg-primary text-on-primary text-sm font-medium rounded-lg transition-all active:scale-95 active:bg-primary-dark shrink-0">
검색
</button>
</div>
</div>
<table class="w-full text-left border-collapse">
<thead>
            <tr class="bg-surface-container-low/50 text-on-surface-variant text-xs font-label uppercase tracking-wider">
                <th class="px-6 py-4 font-semibold cursor-pointer" onclick="fn_sort('trainerName')">트레이너정보 <span class="material-symbols-outlined text-xs">unfold_more</span></th>
                <th class="px-6 py-4 font-semibold cursor-pointer" onclick="fn_sort('regDate')">가입일자 <span class="material-symbols-outlined text-xs">unfold_more</span></th>
                <th class="px-6 py-4 font-semibold cursor-pointer" onclick="fn_sort('trainerClientCount')">담당회원 수 <span class="material-symbols-outlined text-xs">unfold_more</span></th>
                <th class="px-6 py-4 font-semibold cursor-pointer" onclick="fn_sort('trainerCal')">정산내역 <span class="material-symbols-outlined text-xs">unfold_more</span></th>
                <th class="px-6 py-4 font-semibold text-right">상세보기</th>
            </tr>
        </thead>
<tbody id="memberTableBody" class="divide-y divide-outline-variant/10">
<!-- Row  -->
<c:forEach var="item" items="${trainerList }">
<tr class="hover:bg-surface-container-low transition-colors group">
<td class="px-6 py-4">
<div class="flex items-center gap-4">
<img src="${contextPath}/trainer/profile-img/${not empty item.profileImage ? item.profileImage : 'default.png'}" class="rounded-full h-10 w-10 object-cover border border-outline-variant/10"/>
<div>
<p class="text-sm font-bold text-on-surface">${item.trainerName }</p>
<p class="text-xs text-on-surface-variant">${item.trainerTel }</p>
</div>
</div>
</td>
<td class="px-6 py-4 text-sm text-on-surface-variant">${item.regDate}</td>
<td class="px-6 py-4 text-sm font-medium text-on-surface">${item.trainerClientCount}</td>
<td class="px-6 py-4 text-sm font-medium text-on-surface">₩<fmt:formatNumber value="${item.trainerCal}" pattern="#,###"/></td>
<td class="px-6 py-4 text-right">
<form action="${contextPath }/member/trainerDetail">
<input type="hidden" name="trainerId" value="${item.trainerId }"/>
	<button class="text-primary hover:bg-primary/10 p-2 rounded-full transition-colors"><span class="material-symbols-outlined">chevron_right</span></button>
</form>
</td>
</tr>
</c:forEach>
<c:if test="${empty trainerList}">
 <tr><td colspan="5" class="px-6 py-10 text-center text-on-surface-variant">등록된 트레이너 정보가 없습니다.</td></tr>
</c:if>
</tbody>
</table>
<!-- Pagination -->
<div class="px-6 py-4 flex items-center justify-between bg-surface-container-low/30 border-t border-outline-variant/10">
<p class="text-xs text-on-surface-variant">
전체 ${pageInfo.allPage }페이지 중 ${pageInfo.curPage }페이지 표시 중</p>
<div class="flex items-center gap-1">
<c:choose>
<c:when test="${pageInfo.curPage>1 }">
<a href="memberTrainer?page=${pageInfo.curPage-1}"
class="w-8 h-8 flex items-center justify-center rounded hover:bg-surface-container transition-colors">
<span class="material-symbols-outlined text-lg" data-icon="chevron_left">chevron_left</span>
</a>
</c:when>
<c:otherwise>
<button class="w-8 h-8 flex items-center justify-center rounded opacity-30 cursor-not allowed">
<span class="material-symbols-outlined text-lg" data-icon="chevron_left">chevron_left</span>
</button>
</c:otherwise>
</c:choose>

<c:forEach begin="${pageInfo.startPage }" end="${pageInfo.endPage }" var="page">
<c:choose>
<c:when test="${pageInfo.curPage == page }">
<button class="w-8 h-8 flex items-center justify-center rounded bg-primary text-white font-bold text-xs shadow-sm">
${page }
</button>
</c:when>
<c:otherwise>
<a href="memberTrainer?page=${page }"
class="w-8 h-8 flex items-center justify-center rounded hover:bg-surface-container text-xs font-medium">
${page }
</a>
</c:otherwise>
</c:choose>
</c:forEach>

<c:choose>
<c:when test="${pageInfo.curPage < pageInfo.allPage}">
<a href="memberTrainer?page=${pageInfo.curPage + 1}"
class="w-8 h-8 flex items-center justify-center rounded hover:bg-surface-container transition-colors">
<span class="material-symbols-outlined text-lg" data-icon="chevron_right">chevron_right</span>
</a>
</c:when>
<c:otherwise>
<button class="w-8 h-8 flex items-center justify-center rounded opacity-30 cursor-not allowed">
<span class="material-symbols-outlined text-lg" data-icon="chevron_right">chevron_right</span>
</button>
</c:otherwise>
</c:choose>
</div>
</div>
</div>

</div>
</main>
</body></html>