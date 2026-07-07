<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            "colors": {
                    "surface": "#f8f9fb",
                    "on-tertiary": "#ffffff",
                    "secondary": "#585f6c",
                    "on-primary-container": "#fefcff",
                    "tertiary-container": "#b75b00",
                    "outline-variant": "#c2c6d6",
                    "background": "#f8f9fb",
                    "primary": "#0058be",
                    "inverse-on-surface": "#f0f1f3",
                    "on-surface-variant": "#424754",
                    "surface-dim": "#d9dadc",
                    "on-primary": "#ffffff",
                    "on-error": "#ffffff",
                    "tertiary-fixed-dim": "#ffb786",
                    "on-secondary-fixed": "#151c27",
                    "error": "#ba1a1a",
                    "surface-container": "#edeef0",
                    "surface-container-highest": "#e1e2e4",
                    "secondary-container": "#dce2f3",
                    "surface-container-lowest": "#ffffff",
                    "on-tertiary-container": "#fffbff",
                    "inverse-surface": "#2e3132",
                    "surface-container-low": "#f3f4f6",
                    "on-background": "#191c1e",
                    "on-tertiary-fixed-variant": "#723600",
                    "on-tertiary-fixed": "#311400",
                    "on-surface": "#191c1e",
                    "secondary-fixed": "#dce2f3",
                    "on-secondary-container": "#5e6572",
                    "inverse-primary": "#adc6ff",
                    "surface-variant": "#e1e2e4",
                    "tertiary-fixed": "#ffdcc6",
                    "on-primary-fixed": "#001a42",
                    "primary-container": "#2170e4",
                    "surface-container-high": "#e7e8ea",
                    "on-primary-fixed-variant": "#004395",
                    "secondary-fixed-dim": "#c0c7d6",
                    "on-secondary-fixed-variant": "#404754",
                    "tertiary": "#924700",
                    "surface-tint": "#005ac2",
                    "surface-bright": "#f8f9fb",
                    "primary-fixed-dim": "#adc6ff",
                    "outline": "#727785",
                    "on-secondary": "#ffffff",
                    "on-error-container": "#93000a",
                    "error-container": "#ffdad6",
                    "primary-fixed": "#d8e2ff"
            },
            "borderRadius": {
                    "DEFAULT": "0.5rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px"
            },
            "fontFamily": {
                    "headline": ["Inter"],
                    "body": ["Inter"],
                    "label": ["Inter"]
            }
          },
        },
      }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
        body { font-family: 'Inter', sans-serif; }
        
        .selected-card {
        background-color: #f0f4ff !important;
        border-color: #0058be !important;
        box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
    	}
    	/* 스크롤바 디자인 */
    	.overflow-y-auto::-webkit-scrollbar { width: 4px; }
    	.overflow-y-auto::-webkit-scrollbar-thumb { background-color: #e5e7eb; border-radius: 10px; }
</style>
</head>
<body class="bg-surface text-on-surface">
<!-- SideNavBar Shell -->
<div class="flex">
	<jsp:include page="sidebar.jsp"></jsp:include>
</div>
<!-- Main Canvas -->
<main class="ml-64 min-h-screen">
<!-- Content Area -->
<div class="pt-10 px-10 pb-10 space-y-8">
<!-- Header Section -->
<section class="relative">
<h2 class="text-2xl font-semibold mb-6">신고 및 문의내역 관리</h2>
<!-- Summary Indicators -->
<section class="grid grid-cols-4 gap-6 mb-8">
            <div class="bg-white py-3 px-6 rounded-xl shadow-sm border border-gray-100 flex flex-col justify-center">
                <p class="text-[11px] text-gray-400 mb-1 font-medium">전체 내역</p>
                <p class="text-xl font-bold">${totalCount }건 <span class="text-xs font-normal text-gray-300">건</span></p>
            </div>
            <div class="bg-white py-3 px-6 rounded-xl shadow-sm border-l-4 border-primary border-y border-r border-gray-100 flex flex-col justify-center">
                <p class="text-[11px] text-gray-400 mb-1 font-medium">신고 내역</p>
                <p class="text-xl font-bold text-error">${reportCount }건 <span class="text-xs font-normal text-gray-300">건</span></p>
            </div>
            <div class="bg-white py-3 px-6 rounded-xl shadow-sm border-l-4 border-error border-y border-r border-gray-100 flex flex-col justify-center">
                <p class="text-[11px] text-gray-400 mb-1 font-medium">문의 내역</p>
                <p class="text-xl font-bold text-primary">${inquiryCount }건 <span class="text-xs font-normal text-gray-300">건</span></p>
            </div>
            
</section>
<!-- Tab Navigation -->
<div class="flex space-x-8 border-b border-outline-variant/10">
<button onclick="location.href='${pageContext.request.contextPath}/admin/reportList'" class="pb-4 text-sm font-bold text-primary border-b-2 border-primary">
신고내역</button>
<button onclick="location.href='${pageContext.request.contextPath}/admin/inquiryList'" class="pb-4 text-sm font-medium text-on-surface-variant hover:text-primary transition-colors">
문의내역</button>
</div>
</section>
<!-- Main Workspace: Asymmetric Layout -->
<div class="grid grid-cols-12 gap-8 items-start">
    
    <div class="col-span-5 bg-white rounded-xl shadow-sm flex flex-col h-[750px] overflow-hidden border border-gray-100">
        <div class="p-6 border-b border-gray-50">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-lg font-semibold">신고 목록</h3>
                <div class="flex bg-gray-100 rounded-lg p-1">
                    <button onclick="filterStatus('WAIT')" class="px-4 py-1.5 text-xs font-semibold ${currentStatus == 'WAIT' ? 'bg-white shadow-sm rounded-md' : ''}">미처리</button>
                    <button onclick="filterStatus('DONE')" class="px-4 py-1.5 text-xs font-semibold ${currentStatus == 'DONE' ? 'bg-white shadow-sm rounded-md' : ''}">처리완료</button>
                </div>
            </div>
            <div class="relative">
                <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">search</span>
                <input id="searchInput" onkeyup="searchList(event)" class="w-full bg-gray-50 border-none rounded-lg py-2 pl-10 text-sm focus:ring-1 focus:ring-primary/20" 
                placeholder="목록 내 검색" type="text" value="${param.keyword}"/>
            </div>
        </div>

        <div class="flex-1 overflow-y-auto p-4 space-y-2 bg-surface-container-low">
    		<c:forEach var="r" items="${reportList}">
        	<div onclick="loadDetail(${r.reportId}, this)" class="report-item p-4 bg-white rounded-lg cursor-pointer hover:shadow-md transition-all border border-transparent">
            	<div class="flex justify-between mb-1">
                	<span class="text-xs font-bold text-error"><c:out value="${r.category}"/></span>
                	<span class="text-xs text-gray-400"><fmt:formatDate value="${r.regDate}" pattern="MM.dd HH:mm"/></span>
            	</div>
            	<h4 class="text-sm font-semibold mb-1 truncate"><c:out value="${r.title}"/></h4>
            	<p class="text-[11px] text-primary font-medium mt-2">
                	<span class="material-symbols-outlined text-[12px]">person</span>
                	신고자: <c:out value="${r.reporterName}"/> (<c:out value="${r.reporterId}"/>)
            	</p>
        	</div>
    		</c:forEach>
		</div>
    </div>

    <div class="col-span-7 h-[750px] sticky top-24">
        
        <div id="emptyDetail" class="w-full h-full bg-white rounded-xl border-2 border-dashed border-gray-200 flex flex-col items-center justify-center text-gray-400 space-y-4 shadow-sm">
            <span class="material-symbols-outlined text-6xl">Article</span>
            <p class="text-lg font-medium">신고 내역을 선택하면 상세 정보를 볼 수 있습니다.</p>
        </div>

        <div id="detailPanel" class="hidden w-full h-full bg-white rounded-xl p-8 shadow-md flex flex-col overflow-hidden border border-gray-100">
            <div class="flex justify-between items-start mb-8 border-b border-gray-50 pb-6">
                <div>
                    <div class="flex items-center space-x-3 mb-2">
                        <span id="detStatusBadge" class="px-2 py-1 rounded text-[10px] font-bold"></span>
                        <span id="detNo" class="text-xs text-gray-400 font-mono"></span>
                    </div>
                    <h3 id="detTitle" class="text-2xl font-bold text-gray-900 leading-tight"></h3>
                    <p id="detCategory" class="text-sm text-error font-semibold mt-1"></p>
                </div>
                <div id="actionButtons" class="flex space-x-2">
                    <button onclick="openProcessModal('REJECT')" class="px-5 py-2.5 text-sm font-bold border border-gray-200 rounded-lg hover:bg-gray-50 transition-all">반려</button>
                    <button onclick="openProcessModal('HIDE')" class="px-5 py-2.5 text-sm font-bold text-white bg-red-600 rounded-lg hover:bg-red-700 shadow-sm transition-all">숨김처리</button>
                </div>
            </div>

            <div class="flex-1 overflow-y-auto space-y-8 pr-2">
                <div class="grid grid-cols-2 gap-y-6 gap-x-12">
                    <div>
            			<p class="text-xs text-gray-400 mb-1">신고자 이름 (ID)</p>
            			<p id="detReporter" class="font-bold text-gray-700"></p>
        			</div>
        			<div>
            			<p class="text-xs text-gray-400 mb-1">신고 일시</p>
            			<p id="detDate" class="font-bold text-gray-700"></p>
        			</div>
        			<div>
            			<p class="text-xs text-gray-400 mb-1">피신고자 이름 (ID)</p>
            			<p id="detPostNum" class="font-bold text-gray-800"></p>
        			</div>
        			<div id="procDateArea">
            			<p class="text-xs text-gray-400 mb-1">처리 일시</p>
            			<p id="detProcDate" class="font-bold text-gray-700"></p>
        			</div>
                </div>
                
                <div class="space-y-2">
                    <p class="text-xs text-gray-400 font-bold uppercase tracking-wider">상세 신고내용</p>
                    <div id="detContent" class="bg-gray-50 p-6 rounded-xl text-sm leading-relaxed text-gray-600 min-h-[200px]"></div>
                </div>

				<div id="detFileArea" class="mt-6 space-y-2 hidden">
    				<p class="text-xs text-gray-400 font-bold uppercase tracking-wider">신고 증빙 자료</p>
    				<div class="flex gap-4">
        			<div class="relative group cursor-pointer overflow-hidden rounded-xl border border-gray-100 w-48 h-32 bg-gray-50">
            		<img id="detFileImg" onclick="zoomImage(this.src)" src="" alt="신고 증빙 사진" class="w-full h-full object-cover transition-transform group-hover:scale-105">
        			</div>
    				</div>
				</div>
	
                <div id="resultArea" class="hidden p-6 bg-blue-50 rounded-xl border border-blue-100">
                    <p class="text-xs text-primary font-black mb-2">관리자 처리결과</p>
                    <div id="detResult" class="text-sm text-gray-700 leading-relaxed"></div>
                </div>
            </div>

            <div class="mt-8 pt-6 border-t border-gray-100 flex justify-end">
                <button id="movePostBtn" class="flex items-center space-x-2 text-primary font-bold text-sm hover:scale-105 transition-transform">
                    <span>해당 게시물로 이동</span>
                    <span class="material-symbols-outlined text-sm">open_in_new</span>
                </button>
            </div>
        </div>
    </div>
</div>


<div id="processModal" class="fixed inset-0 bg-black/60 hidden z-50 flex items-center justify-center backdrop-blur-sm">
    <div class="bg-white rounded-2xl shadow-2xl w-[480px] overflow-hidden">
    
    	<input type="hidden" id="modalTargetId" value="">
		<input type="hidden" id="modalStatus" value="">
    
        <div class="p-6 border-b border-gray-100 flex justify-between items-center">
            <h3 id="modalTitle" class="text-xl font-bold text-gray-800">게시물 숨김 처리</h3>
            <button onclick="closeModal()" class="material-symbols-outlined text-gray-400 hover:text-gray-600">close</button>
        </div>
        <div class="p-8 space-y-6">
            <div class="bg-gray-50 p-4 rounded-xl space-y-2">
                <div class="flex justify-between text-sm">
                    <span class="text-gray-500">대상 작성자</span>
                    <span id="modalTargetUser" class="font-bold"> </span>
                </div>
                <div class="flex justify-between text-sm">
                    <span class="text-gray-500">신고 유형</span>
                    <span id="modalTargetCategory" class="text-error font-bold"> </span>
                </div>
            </div>
            
            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700">상세 처리 사유 입력</label>
                <textarea id="modalResultText" 
                    class="w-full border-gray-200 rounded-xl text-sm h-32 focus:ring-primary focus:border-primary p-4" 
                    placeholder="사용자에게 전달될 구체적인 사유를 입력하세요..."></textarea>
                <p class="text-[11px] text-gray-400">* 입력된 사유는 작성자에게 알림으로 전송됩니다.</p>
            </div>
        </div>
        <div class="p-6 bg-gray-50 flex space-x-3">
            <button onclick="closeModal()" class="flex-1 py-3 border border-gray-300 bg-white rounded-xl font-bold text-gray-600 hover:bg-gray-50">취소</button>
            <button onclick="submitProcess()" id="modalSubmitBtn" class="flex-1 py-3 bg-red-600 text-white rounded-xl font-bold hover:bg-red-700">처리</button>
        </div>
    </div>
</div>
<div id="imageModal" onclick="closeImageModal()" class="fixed inset-0 bg-black/80 hidden z-[60] flex items-center justify-center cursor-zoom-out backdrop-blur-sm">
    <div class="max-w-[90%] max-h-[90%] overflow-hidden rounded-lg shadow-2xl">
        <img id="modalFullImage" src="" class="w-full h-full object-contain" alt="확대 이미지">
    </div>
</div>

</div>
<script>
    // 상태 필터링
    function filterStatus(status) {
        location.href = '${pageContext.request.contextPath}/admin/reportList?status=' + status;
    }

    // 목록 검색 (엔터 키)
    function searchList(e) {
        if(e.key === 'Enter') {
            const keyword = e.target.value;
            location.href = '${pageContext.request.contextPath}/admin/reportList?status=${currentStatus}&keyword=' + keyword;
        }
    }

    // 상세 정보 AJAX 로드
    function loadDetail(id, element) {
    // UI 강조 로직
    document.querySelectorAll('.report-item').forEach(el => el.classList.remove('selected-card'));
    element.classList.add('selected-card');

    fetch('${pageContext.request.contextPath}/admin/reportList?action=detail&id=' + id)
        .then(res => res.json())
        .then(data => {
        	
        	console.log("받은 데이터:", data); // 크롬 콘솔에서 데이터가 오는지 확인용
            document.getElementById('emptyDetail').classList.add('hidden');
            document.getElementById('detailPanel').classList.remove('hidden');
            
            // [중요] DTO 필드명과 100% 일치시켜야 함 (카멜케이스 주의)
            document.getElementById('detNo').innerText = 'No. ' + data.reportId;
            document.getElementById('detTitle').innerText = data.title;
            document.getElementById('detCategory').innerText = '신고유형 : ' + data.category;
            document.getElementById('detReporter').innerText = data.reporterName + ' (' + data.reporterId + ')';
            document.getElementById('detPostNum').textContent = data.targetName + ' (' + data.targetId + ')';
            document.getElementById('detContent').innerText = data.content;

            // [핵심] 모달에 넘겨줄 데이터 미리 심어두기
            document.getElementById('modalTargetId').value = data.reportId; 
            document.getElementById('modalTargetUser').innerText = data.targetName + ' (' + data.targetId + ')';
            document.getElementById('modalTargetCategory').innerText = data.category;

            // 날짜 처리
            if (data.regDate && data.regDate !== "") {
    		// 문자열에 .0 (Timestamp 특유의 소수점)이 붙어올 경우 제거
    			let dateStr = data.regDate.split('.')[0]; 
   				let date = new Date(dateStr);
    			document.getElementById('detDate').innerText = isNaN(date) ? data.regDate : date.toLocaleString();
			}
         	// status가 DONE(숨김/반려 등)일 때만 처리일시 노출
            if (data.status !== 'WAIT') {
                document.getElementById('procDateArea').style.display = 'block';
                if (data.processDate && data.processDate !== "" && data.processDate !== "기록 없음") {
                    let pDateStr = data.processDate.split('.')[0]; // .0 제거
                    let pDate = new Date(pDateStr);
                    
                    // 날짜 변환 성공 시 toLocaleString() 적용, 실패 시 원본 표시
                    document.getElementById('detProcDate').innerText = isNaN(pDate) ? data.processDate : pDate.toLocaleString();
                } else {
                    document.getElementById('detProcDate').innerText = '기록 없음';
                }
            } else {
                document.getElementById('procDateArea').style.display = 'none';
            }

         	// --- 신고 증빙 파일 제어 로직 ---
            const fileArea = document.getElementById('detFileArea');
            const fileImg = document.getElementById('detFileImg');
            // data.file은 DB의 신고 테이블에 저장된 파일명입니다.
            if(data.file && data.file.trim() !== "") {
                fileArea.classList.remove('hidden');
                // 저장 경로는 문의내역과 동일하게 설정 (팀원간 합의된 경로)
                fileImg.src = '${pageContext.request.contextPath}/resources/upload/' + data.file;
            } else {
                fileArea.classList.add('hidden');
            }
         	
            // 상태 배지 처리
            const badge = document.getElementById('detStatusBadge');
            if(data.status !== 'WAIT') {
                document.getElementById('actionButtons').classList.add('hidden');
                document.getElementById('resultArea').classList.remove('hidden');
                document.getElementById('detResult').innerText = data.result;
                badge.className = 'px-2 py-1 rounded text-[10px] font-bold bg-gray-200 text-gray-500';
                badge.innerText = (data.status === 'REJECT' ? '반려됨' : '숨김처리됨');
            } else {
                document.getElementById('actionButtons').classList.remove('hidden');
                document.getElementById('resultArea').classList.add('hidden');
                badge.className = 'px-2 py-1 rounded text-[10px] font-bold bg-error text-white';
                badge.innerText = '미처리';
            }
            
            // 해당 게시물로 이동 처리
			const moveBtn = document.getElementById('movePostBtn');
            
            // 1. 게시글 번호가 있는지 확인 (image_5964dd.png 참고)
            if (data.postNum && data.postNum !== 0) {
                moveBtn.onclick = function() {
                    // 팀원분의 게시글 상세 페이지 URL 규칙에 맞게 아래 경로만 수정하세요.
                    // 예: /community/view?postNo=51
                    location.href = '${pageContext.request.contextPath}/member/community';
                };
                moveBtn.style.opacity = "1";
                moveBtn.style.cursor = "pointer";
            } else {
                // 게시글이 삭제되었거나 번호가 없는 경우 처리
                moveBtn.onclick = function() { alert('해당 게시물을 찾을 수 없습니다.'); };
                moveBtn.style.opacity = "0.3";
                moveBtn.style.cursor = "not-allowed";
            }
        });
    console.log(data);
	}
    

    // 모달 제어
    function openProcessModal(status) {
    	// 1. 상태값 저장 및 제목 변경 (기존 로직)
    	document.getElementById('modalStatus').value = status;
    	document.getElementById('modalTitle').innerText = (status === 'REJECT' ? '신고 반려 사유 입력' : '게시물 숨김 사유 입력');
    
    	// 2. [전술 추가] 버튼 객체 가져오기
    	const submitBtn = document.getElementById('modalSubmitBtn');
    
    	// 3. [전술 추가] 상태에 따른 버튼 텍스트 및 색상 변경
    	if (status === 'HIDE') {
        	submitBtn.innerText = '숨김 처리';
        	// 숨김은 경고 의미로 빨간색 유지
        	submitBtn.className = 'flex-1 py-3 bg-red-600 text-white rounded-xl font-bold hover:bg-red-700 transition-colors';
    	} else {
        	submitBtn.innerText = '반려 처리';
        	// 반려(취소)는 조금 더 차분한 어두운 회색이나 파란색 계열 추천
        	submitBtn.className = 'flex-1 py-3 bg-gray-700 text-white rounded-xl font-bold hover:bg-gray-800 transition-colors';
    	}    
    	// 4. 사유 입력창 초기화 (이전 입력값이 남아있지 않게)
    	document.getElementById('modalResultText').value = '';
    
    	// 5. 모달 표시
    	document.getElementById('processModal').classList.remove('hidden');
	}

    function closeModal() {
        document.getElementById('processModal').classList.add('hidden');
    }

    // 최종 처리 제출 (POST AJAX)
    function submitProcess() {
    	const reportId = document.getElementById('modalTargetId').value; // 이 값이 비어있는지 확인!
    	const status = document.getElementById('modalStatus').value;
    	const result = document.getElementById('modalResultText').value;

    	if(!result) { alert('사유를 입력해주세요.'); return; }

    	const params = new URLSearchParams();
    	params.append('reportId', reportId); // 서블릿의 request.getParameter("reportId")와 맞춰야 함
    	params.append('status', status);
    	params.append('result', result);

    fetch('${pageContext.request.contextPath}/admin/reportList', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    })
    .then(res => res.json())
    .then(data => {
        if(data.success) { // 서버에서 { "success": true } 라고 줘야 함
            alert('처리가 완료되었습니다.');
            location.reload();
        } else {
            alert('처리 중 오류가 발생했습니다: ' + (data.message || ''));
        }
    });
    }
 	// 이미지 확대 함수
    function zoomImage(imgSrc) {
        if(!imgSrc || imgSrc.includes('undefined')) return;
        
        const modal = document.getElementById('imageModal');
        const modalImg = document.getElementById('modalFullImage');
        
        modalImg.src = imgSrc;
        modal.classList.remove('hidden');
        // 스크롤 방지 (필요 시)
        document.body.style.overflow = 'hidden';
    }

    // 이미지 모달 닫기 함수
    function closeImageModal() {
        const modal = document.getElementById('imageModal');
        modal.classList.add('hidden');
        // 스크롤 복구
        document.body.style.overflow = 'auto';
    }
</script>
</main>
</body></html>