<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fisbug Admin - 트레이너 관리</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "on-primary-fixed": "#001a42",
                        "primary-container": "#2170e4",
                        "on-tertiary-fixed": "#311400",
                        "on-surface-variant": "#424754",
                        "on-secondary-fixed-variant": "#304671",
                        "tertiary-fixed-dim": "#ffb786",
                        "background": "#f8f9fb",
                        "tertiary-container": "#b75b00",
                        "surface-container-high": "#e7e8ea",
                        "on-primary-container": "#fefcff",
                        "surface-container": "#edeef0",
                        "on-primary-fixed-variant": "#004395",
                        "on-secondary": "#ffffff",
                        "on-secondary-container": "#405682",
                        "on-secondary-fixed": "#001a42",
                        "tertiary": "#924700",
                        "surface-variant": "#e1e2e4",
                        "primary": "#0058be",
                        "inverse-surface": "#2e3132",
                        "on-tertiary-fixed-variant": "#723600",
                        "surface-container-lowest": "#ffffff",
                        "secondary-fixed": "#d8e2ff",
                        "error-container": "#ffdad6",
                        "surface-tint": "#005ac2",
                        "primary-fixed-dim": "#adc6ff",
                        "secondary-fixed-dim": "#b1c6f9",
                        "on-error-container": "#93000a",
                        "surface-container-low": "#f3f4f6",
                        "outline-variant": "#c2c6d6",
                        "on-primary": "#ffffff",
                        "surface": "#f8f9fb",
                        "secondary": "#495e8a",
                        "on-surface": "#191c1e",
                        "on-error": "#ffffff",
                        "error": "#ba1a1a",
                        "surface-bright": "#f8f9fb",
                        "surface-dim": "#d9dadc",
                        "inverse-primary": "#adc6ff",
                        "inverse-on-surface": "#f0f1f3",
                        "outline": "#727785",
                        "surface-container-highest": "#e1e2e4",
                        "primary-fixed": "#d8e2ff",
                        "on-tertiary": "#ffffff",
                        "on-tertiary-container": "#fffbff",
                        "on-background": "#191c1e",
                        "secondary-container": "#b6ccff",
                        "tertiary-fixed": "#ffdcc6"
                    },
                    fontFamily: {
                        "headline": ["Inter"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.5rem",
                        "lg": "0.5rem",
                        "xl": "1.5rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
<style>
        body { font-family: 'Inter', sans-serif; -webkit-font-smoothing: antialiased; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }
        .glass-nav { background: rgba(255, 255, 255, 0.8); backdrop-filter: blur(20px); }
        .tab-active { color: #0058be; border-bottom: 2px solid #0058be; }
        .tab-inactive { color: #424754; border-bottom: 2px solid transparent; }
    </style>
</head>
<body class="bg-background text-on-surface">
<jsp:include page="common/sidebar.jsp"></jsp:include>

<!-- Main Content Area -->
<main class="ml-64 pt-16 h-screen flex flex-col bg-surface">
<div class="p-8 max-w-[1400px] w-full mx-auto flex flex-col flex-1 space-y-6 overflow-hidden">

<!-- Filter Section -->
<section class="flex flex-wrap items-center gap-4 shrink-0 pt-4 px-0 pb-2"><h2 class="text-3xl font-black text-on-surface tracking-tight">트레이너 관리</h2></section>
<div class="flex-1 flex flex-col gap-6 min-h-0 overflow-hidden">

<!-- Unified Trainer List Section -->
<section class="bg-surface-container-lowest rounded-xl shadow-sm overflow-hidden flex flex-col min-h-0">
    <div class="px-6 py-4 bg-surface-container-low/30 border-b border-surface-container">
		<form action="${pageContext.request.contextPath}/gym/trainer" method="get" class="relative max-w-md">
			<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant">search</span>
			<input class="w-full pl-10 pr-4 py-2 bg-surface-container-lowest border-none rounded-lg text-sm focus:ring-2 focus:ring-primary shadow-sm" 
		   		   placeholder="이름 또는 사번으로 검색하세요" 
		   		   type="text"
		   		   name="keyword"
		   		   value="${keyword}"/>
		</form>
	</div>

	<div class="px-6 py-4 border-b border-surface-container shrink-0">
		<h3 class="font-headline font-bold text-lg text-on-surface">트레이너 목록</h3>
	</div>
		
	<div class="flex-1 overflow-auto" id="content-unified">
		<table class="w-full text-left border-collapse">
			<thead class="sticky top-0 bg-surface-container-lowest z-10">
				<tr class="bg-surface-container-low/50">
					<th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">프로필</th>
					<th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">사번/식별ID</th>
					<th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">이름</th>
					<th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">연락처</th>
					<th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">담당 회원 수</th>
				</tr>
			</thead>

			<tbody class="divide-y divide-surface-container">
				<c:forEach var="trainer" items="${trainerList}">
					<tr class="hover:bg-surface-container-low transition-colors cursor-pointer group">
						<td class="px-6 py-4">
							<c:choose>
								<c:when test="${not empty trainer.profileImg}">
									<img alt="트레이너" class="w-10 h-10 rounded-full object-cover border-2 border-surface shadow-sm" 
					 					 src="${pageContext.request.contextPath}/trainer/profile-img/${trainer.profileImg}"/>
								</c:when>
								<c:otherwise>
									<div class="w-10 h-10 rounded-full bg-surface-container-high flex items-center justify-center">
                    					<span class="material-symbols-outlined text-on-surface-variant">person</span>
                					</div>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="px-6 py-4 text-sm font-medium text-on-surface">TR-${trainer.trainerId}</td>
						<td class="px-6 py-4 text-sm font-bold">
    						<a href="${pageContext.request.contextPath}/member/trainerDetail?trainerId=${trainer.trainerId}"
       						   class="text-primary group-hover:underline hover:text-primary-container transition-colors">
        							${trainer.name}
    						</a>
						</td>
						<td class="px-6 py-4 text-sm text-on-surface-variant">${trainer.phoneNum}</td>
						<td class="px-6 py-4 text-sm font-medium text-primary">
							<button onclick="openMemberModal(${trainer.trainerId}, '${trainer.name}', '${trainer.profileImg}')"
        							class="hover:underline font-bold">
        							${trainer.memberCount}명
        					</button>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty trainerList}">
					<tr>
    					<td colspan="5" class="px-6 py-10 text-center text-sm text-on-surface-variant">
        					등록된 트레이너가 없습니다.
    					</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</section>


</div>
</div>
</main>

<!-- 담당 회원 모달 -->
<div id="memberModal" class="fixed inset-0 z-50 hidden items-center justify-center p-4">
    
    <!-- 배경 -->
    <div class="absolute inset-0 bg-black/40" onclick="closeMemberModal()"></div>

    <!-- 모달 -->
    <div class="relative w-full max-w-2xl bg-white rounded-xl shadow-2xl overflow-hidden flex flex-col max-h-[80vh]">
        
        <!-- 헤더 -->
        <div class="px-6 py-4 border-b flex justify-between items-center">
            <div class="flex items-center gap-3">
                <img id="modalProfileImg" class="w-10 h-10 rounded-full"/>
                <div>
                    <h3 id="modalTrainerName" class="font-bold"></h3>
                    <p class="text-sm text-gray-500">담당 회원 목록</p>
                </div>
            </div>
            <button onclick="closeMemberModal()">✕</button>
        </div>
        
        <div class="px-6 pt-4 flex gap-6 border-b">
    		<button id="currentTabBtn"
            	onclick="loadTrainerMembers('current')"
            	class="pb-3 text-sm font-bold text-primary border-b-2 border-primary">
        		현재 수강 회원
    		</button>

    		<button id="pastTabBtn"
            	onclick="loadTrainerMembers('past')"
            	class="pb-3 text-sm font-semibold text-on-surface-variant border-b-2 border-transparent">
        		이전 수강 회원
    		</button>
		</div>

        <!-- 내용 -->
        <div class="p-6 overflow-auto">
    <table class="w-full text-sm table-fixed">
        <thead>
            <tr class="border-b">
                <th class="w-1/4 px-4 py-3 text-left font-bold">회원명</th>
                <th class="w-1/4 px-4 py-3 text-left font-bold">이용권</th>
                <th class="w-1/4 px-4 py-3 text-left font-bold">잔여</th>
                <th class="w-1/4 px-4 py-3 text-left font-bold">시작일</th>
            </tr>
        </thead>
        <tbody id="memberListBody">
        </tbody>
    </table>
</div>

        <!-- footer -->
        <div class="p-4 text-right">
            <button onclick="closeMemberModal()">닫기</button>
        </div>
    </div>
</div>
<script>
let selectedTrainerId = 0;

function openMemberModal(trainerId, trainerName, profileImg) {
    selectedTrainerId = trainerId;

    document.getElementById("memberModal").classList.remove("hidden");
    document.getElementById("memberModal").classList.add("flex");

    document.getElementById("modalTrainerName").innerText = trainerName;

    const modalImg = document.getElementById("modalProfileImg");

    if (profileImg) {
        modalImg.src = '${pageContext.request.contextPath}/trainer/profile-img/' + profileImg;
    } else {
        modalImg.src = '${pageContext.request.contextPath}/img/profile_img.jpg';
    }

    loadTrainerMembers("current");
}

function closeMemberModal() {
    document.getElementById("memberModal").classList.add("hidden");
    document.getElementById("memberModal").classList.remove("flex");
}

function setActiveTab(type) {
    const currentTabBtn = document.getElementById("currentTabBtn");
    const pastTabBtn = document.getElementById("pastTabBtn");

    currentTabBtn.className =
        "pb-3 text-sm border-b-2 " +
        (type === "current"
            ? "font-bold text-primary border-primary"
            : "font-semibold text-on-surface-variant border-transparent");

    pastTabBtn.className =
        "pb-3 text-sm border-b-2 " +
        (type === "past"
            ? "font-bold text-primary border-primary"
            : "font-semibold text-on-surface-variant border-transparent");
}

function loadTrainerMembers(type) {
    setActiveTab(type);

    fetch('${pageContext.request.contextPath}/gym/trainerMembers?trainerId='
        + selectedTrainerId + '&type=' + type)
    .then(response => response.json())
    .then(data => {
        let html = "";

        if (data.length === 0) {
            html = `
                <tr>
                    <td colspan="4" class="px-4 py-8 text-center text-sm text-gray-500">
                        회원이 없습니다.
                    </td>
                </tr>
            `;
        } else {
            data.forEach(member => {
                html += `
                    <tr class="border-b last:border-b-0">
                		<td class="w-1/4 px-4 py-4 text-left">
                    		<a href="${pageContext.request.contextPath}/trainer/clientDetailCommon?clientId=\${member.memberId}"
                    		   onclick="console.log('memberId=', \${member.memberId});"
                       		   class="font-bold text-on-surface hover:text-primary hover:underline">
                        		\${member.memberName}
                    		</a>
                		</td>
                        <td class="w-1/4 px-4 py-4 text-left">\${member.membershipName}</td>
                        <td class="w-1/4 px-4 py-4 text-left">\${member.remainingSession}회</td>
                        <td class="w-1/4 px-4 py-4 text-left">\${member.startDate}</td>
                    </tr>
                `;
            });
        }

        document.getElementById("memberListBody").innerHTML = html;
    })
    .catch(error => {
        console.log(error);
    });
}
</script>
</body>
</html>