<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>   
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//현재 상세 보기 중인 회원의 정보를 저장할 변수
let currentSelectedUser = {
    userId: '',
    authType: ''
};	

$(document).ready(function() {
	fn_loadPendingList(); // 페이지 열자마자 리스트 로딩
});

    // 1. 대기 리스트 로드
    function fn_loadPendingList() {
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/memberAuthList", 
            type: "GET",
            success: function(data) {
                $("#pendingCount").text(data.length);
                let html = "";
                if(data.length === 0) {
                    html = `<p class="text-center py-10 text-on-surface-variant">대기 중인 요청이 없습니다.</p>`;
                } else {
                    $.each(data, function(i, item) {
                        html += `
                            <div onclick="fn_loadDetail('\${item.userId}', '\${item.authType}')" class="group p-5 bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant/10 hover:border-primary transition-all cursor-pointer">
                                <div class="flex items-center gap-4">
                                    <div class="flex-1">
                                        <div class="flex justify-between items-start">
                                            <h4 class="font-bold text-on-surface text-base">\${item.userName}</h4>
                                            <span class="text-[11px] text-on-surface-variant">\${item.regDate}</span>
                                        </div>
                                        <p class="text-xs text-on-secondary-container mt-1">\${item.authType} 신청</p>
                                    </div>
                                </div>
                            </div>`;
                    });
                }
                $("#pendingList").html(html);
            }
        });
    }

    // 2. 상세 정보 로드
    function fn_loadDetail(uid, type) {
    	currentSelectedUser.userId = uid;
        currentSelectedUser.authType = type;
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/memberAuthDetail",
            data: { 
            	userId: uid,
            	authType: type
            },
            success: function(data) {
                $("#emptyView").addClass("hidden");
                $("#detailView").removeClass("hidden");
                //공통정보
                $("#detailName").text(data.name);
            	$("#detailEmail").text(data.email);
            	$("#detailTel").text(data.tel);
            	$("#detailProfileImg").attr("src",`${contextPath}/trainer/profile-img/`+data.profileImg);
            	$("#detailType").text(type === 'GYM' ? '헬스장' : '트레이너');
                //타입별 특화정보
                if(type === 'GYM') {
                    $("#detailAddr").text(data.address + " " + data.address_detail);
                    $("#detailAuthDoc").attr("src", "/uploads/gym/" + data.bizNum); // 예시
                } else {
                    $("#detailAddr").text(data.address || '프리랜서/지점소속');
                    $("#detailAuthDoc").attr("src", `${contextPath}/trainer/profile-img/` + data.certFile);
                }
            }
        });
    }
    
    function fn_approveUser() {
        const userName = $("#detailName").text();
        
        if (!confirm(`[\${userName}] 님의 자격을 승인하시겠습니까?`)) {
            return;
        }
        
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/memberAuthDetail",
            type: "POST",
            data: {
                userId: currentSelectedUser.userId,
                authType: currentSelectedUser.authType,
                statusAction: 'APPROVED' // 서버에서 'approved'로 처리하도록 고정값 전달
            },
            success: function(response) {
                if(response === "success") {
                    alert("정상적으로 승인되었습니다.");
                    // 화면 초기화 및 리스트 새로고침
                    $("#detailView").addClass("hidden");
                    $("#emptyView").removeClass("hidden");
                    fn_loadPendingList(); 
                } else {
                    alert("승인 처리 중 오류가 발생했습니다.");
                }
            },
            error: function() {
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
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
      .hide-scrollbar::-webkit-scrollbar { display: none; }
      .hide-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-surface font-body text-on-surface antialiased">

<div class="flex">
	<jsp:include page="sidebar.jsp"></jsp:include>
</div>
<!-- Main Content Area -->
<main class="ml-64 min-h-screen">
<!-- Page Canvas -->
<div class="pt-10 px-10 pb-10 max-w-7xl">
<!-- Header Section -->
<div class="flex justify-between items-end mb-8">
<div>
<h2 class="text-2xl font-semibold font-headline tracking-tight text-on-surface">회원 자격승인</h2>
<p class="text-on-surface-variant mt-1">신규 가입 회원의 정보를 검토하고 승인 프로세스를 진행합니다.</p>
</div>
</div>
<!-- Main Tabs -->
<div class="flex gap-8 mb-8 border-b border-outline-variant/20">
<a href="<%= request.getContextPath() %>/admin/memberAuth"
class="pb-4 text-sm font-bold text-primary border-b-2 border-primary relative">자격승인</a>
<a href="<%= request.getContextPath() %>/admin/memberGym"
class="pb-4 text-sm font-medium text-on-surface-variant hover:text-primary transition-colors relative">회원리스트</a>
</div>
<!-- Content Grid: Member List + Detail Profile -->
<div class="grid grid-cols-12 gap-8 items-start">
<!-- Left: Pending List (5 cols) -->
<section class="col-span-12 lg:col-span-5 flex flex-col gap-4">
<div class="flex items-center justify-between px-2">
<h3 class="font-bold text-lg flex items-center gap-2">
승인 대기 중인 회원
<span id="pendingCount" class="bg-primary/10 text-primary text-[11px] px-2 py-0.5 rounded-full font-bold">
0</span>
</h3>
</div>
<div id="pendingList" class="space-y-3 max-h-[700px] overflow-y-auto pr-2 hide-scrollbar">
</div>
</section>
<!-- Right: Detailed Profile Card (7 cols) -->
<section class="col-span-12 lg:col-span-7">
    <div id="emptyView" class="bg-surface-container-lowest rounded-2xl p-20 flex flex-col items-center justify-center border border-dashed border-outline-variant">
        <span class="material-symbols-outlined text-5xl text-outline-variant">person_search</span>
        <p class="text-on-surface-variant mt-4 font-medium">승인 대기 중인 회원을 선택해주세요.</p>
    </div>

    <div id="detailView" class="hidden bg-surface-container-lowest rounded-2xl shadow-sm overflow-hidden sticky top-24 border border-outline-variant/10">
        <div class="h-32 primary-gradient relative">
            <div class="absolute -bottom-12 left-8 p-1 bg-white rounded-full shadow-md">
                <img id="detailProfileImg" class="w-24 h-24 rounded-full object-cover" src=""/>
            </div>
        </div>
        
        <div class="pt-16 px-10 pb-10">
            <div class="flex justify-between items-start mb-8">
                <div>
                    <div class="flex items-center gap-2">
                        <h3 id="detailName" class="text-2xl font-bold text-on-surface">이름</h3>
                        <span id="detailInfo" class="text-sm text-on-surface-variant font-medium">(나이, 성별)</span>
                    </div>
                    <p id="detailEmail" class="text-primary font-semibold mt-1">이메일</p>
                </div>
                <div class="flex gap-2">
                    <button onclick="fn_approveUser()" class="px-8 py-2.5 rounded-xl primary-gradient text-white font-bold text-sm">
                    승인</button>
                </div>
            </div>

            <div class="grid grid-cols-2 gap-y-8 gap-x-12 mb-10">
                <div>
                    <h4 class="text-[11px] font-bold text-outline-variant uppercase mb-3">연락처</h4>
                    <p id="detailTel" class="text-sm font-medium">연락처 정보</p>
                </div>
                <div>
                    <h4 class="text-[11px] font-bold text-outline-variant uppercase mb-3">신청 유형</h4>
                    <p id="detailType" class="text-sm font-medium">헬스장 / 트레이너</p>
                </div>
                <div class="col-span-2">
                    <h4 class="text-[11px] font-bold text-outline-variant uppercase mb-3">활동/소재지 주소</h4>
                    <p id="detailAddr" class="text-sm font-medium">주소 정보</p>
                </div>
            </div>

            <div class="p-6 bg-surface-container-low rounded-xl">
                <h4 class="text-[11px] font-bold text-outline-variant uppercase mb-4 flex items-center gap-2">
                    <span class="material-symbols-outlined text-sm">verified_user</span>
                    증빙 서류 (자격증/사업자등록증)
                </h4>
                <div class="cursor-pointer overflow-hidden rounded-lg border border-outline-variant/20 bg-white">
                    <img id="detailAuthDoc" src="" class="w-full max-h-80 object-contain hover:scale-105 transition-transform" 
                         onclick="window.open(this.src)" title="클릭하여 크게 보기"/>
                </div>
            </div>
        </div>
    </div>
</section>
</div>
</div>
</main>
<!-- FAB for quick action -->
</body></html>