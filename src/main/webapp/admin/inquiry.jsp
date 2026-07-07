<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script id="tailwind-config">
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              "primary": "#0058be",
              "surface": "#f8f9fb",
              "on-surface-variant": "#424754",
              "error": "#ba1a1a",
              "outline-variant": "#c2c6d6",
              "surface-container-low": "#f3f4f6",
              "surface-container-low-lowest": "#ffffff"
            }
          },
        },
      }
    </script>
    <style>
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }
        body { font-family: 'Inter', sans-serif; }
        .selected-card { background-color: #f0f4ff !important; border-color: #0058be !important; box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); }
        .overflow-y-auto::-webkit-scrollbar { width: 4px; }
        .overflow-y-auto::-webkit-scrollbar-thumb { background-color: #e5e7eb; border-radius: 10px; }
    </style>
</head>
<body class="bg-surface text-on-surface">
<div class="flex"><jsp:include page="sidebar.jsp"></jsp:include></div>

<main class="ml-64 min-h-screen">
    <div class="pt-10 px-10 pb-10 space-y-8">
        <section class="relative">
            <h2 class="text-2xl font-semibold mb-6">신고 및 문의내역 관리</h2>
<section class="grid grid-cols-4 gap-6 mb-8">
            <div class="bg-white py-3 px-6 rounded-xl shadow-sm border border-gray-100 flex flex-col justify-center">
                <p class="text-[11px] text-gray-400 mb-1 font-medium">전체 내역</p>
                <p class="text-xl font-bold">${totalCount }건 <span class="text-xs font-normal text-gray-300">건</span></p>
            </div>
            <div class="bg-white py-3 px-6 rounded-xl shadow-sm border-l-4 border-error border-y border-r border-gray-100 flex flex-col justify-center">
                <p class="text-[11px] text-gray-400 mb-1 font-medium">신고 내역</p>
                <p class="text-xl font-bold text-error">${reportCount }건 <span class="text-xs font-normal text-gray-300">건</span></p>
            </div>
            <div class="bg-white py-3 px-6 rounded-xl shadow-sm border-l-4 border-primary border-y border-r border-gray-100 flex flex-col justify-center">
                <p class="text-[11px] text-gray-400 mb-1 font-medium">문의 내역</p>
                <p class="text-xl font-bold text-primary">${inquiryCount }건 <span class="text-xs font-normal text-gray-300">건</span></p>
            </div>
            
</section>
            <div class="flex space-x-8 border-b border-outline-variant/10">
                <button onclick="location.href='${pageContext.request.contextPath}/admin/reportList'" class="pb-4 text-sm font-medium text-on-surface-variant hover:text-primary transition-colors">신고내역</button>
                <button onclick="location.href='${pageContext.request.contextPath}/admin/inquiryList'" class="pb-4 text-sm font-bold text-primary border-b-2 border-primary">문의내역</button>
            </div>
        </section>

        <div class="grid grid-cols-12 gap-8 items-start">
            
            <div class="col-span-5 bg-white rounded-xl shadow-sm flex flex-col h-[750px] overflow-hidden border border-gray-100">
                <div class="p-6 border-b border-gray-50">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-semibold">문의 목록</h3>
                        <div class="flex bg-gray-100 rounded-lg p-1">
                            <button onclick="filterStatus('WAIT')" class="px-4 py-1.5 text-xs font-semibold ${currentStatus == 'WAIT' ? 'bg-white shadow-sm rounded-md' : ''}">미처리</button>
                            <button onclick="filterStatus('COMPLETE')" class="px-4 py-1.5 text-xs font-semibold ${currentStatus == 'COMPLETE' ? 'bg-white shadow-sm rounded-md' : ''}">처리완료</button>
                        </div>
                    </div>
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">search</span>
                        <input id="searchInput" onkeyup="searchList(event)" class="w-full bg-gray-50 border-none rounded-lg py-2 pl-10 text-sm focus:ring-1 focus:ring-primary/20" 
                        placeholder="문의 제목 또는 작성자 검색" type="text" value="${param.keyword}"/>
                    </div>
                </div>
                <div class="flex-1 overflow-y-auto p-4 space-y-2 bg-[#fcfdfe]">
                    <c:forEach var="i" items="${inquiryList}">
                        <div onclick="loadDetail(${i.inquiryId}, this)" class="inquiry-item p-4 bg-white rounded-lg cursor-pointer hover:shadow-md transition-all border border-transparent">
                            <div class="flex justify-between mb-1">
                                <span class="text-xs font-bold text-primary"><c:out value="${i.category}"/></span>
                                <span class="text-xs text-gray-400"><fmt:formatDate value="${i.regDate}" pattern="MM.dd HH:mm"/></span>
                            </div>
                            <h4 class="text-sm font-semibold mb-1 truncate"><c:out value="${i.title}"/></h4>
                            <p class="text-[11px] text-gray-500 font-medium mt-2">
                                <span class="material-symbols-outlined text-[12px]">person</span>
                                <c:out value="${i.userName}"/> (<c:out value="${i.userId}"/>)
                            </p>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="col-span-7 h-[750px] sticky top-24">
                
                <div id="emptyDetail" class="w-full h-full bg-white rounded-xl border-2 border-dashed border-gray-200 flex flex-col items-center justify-center text-gray-400 space-y-4 shadow-sm">
                    <span class="material-symbols-outlined text-6xl">contact_support</span>
                    <p class="text-lg font-medium">문의 내역을 선택하면 상세 내용을 볼 수 있습니다.</p>
                </div>

                <div id="detailPanel" class="hidden w-full h-full bg-white rounded-xl p-8 shadow-md flex flex-col overflow-hidden border border-gray-100">
                    <div class="flex justify-between items-start mb-8 border-b border-gray-50 pb-6">
                        <div>
                            <div class="flex items-center space-x-3 mb-2">
                                <span id="detStatusBadge" class="px-2 py-1 rounded text-[10px] font-bold"></span>
                                <span id="detNo" class="text-xs text-gray-400 font-mono"></span>
                            </div>
                            <h3 id="detTitle" class="text-2xl font-bold text-gray-900 leading-tight"></h3>
                            <p id="detCategory" class="text-sm text-primary font-semibold mt-1"></p>
                        </div>
                    </div>

                    <div class="flex-1 overflow-y-auto space-y-8 pr-2">
                        <div class="grid grid-cols-2 gap-y-6 gap-x-12">
                            <div>
                                <p class="text-xs text-gray-400 mb-1">문의자 이름 (ID)</p>
                                <p id="detUser" class="font-bold text-gray-700"></p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 mb-1">문의 일시</p>
                                <p id="detDate" class="font-bold text-gray-700"></p>
                            </div>
                            <div id="detProcessArea" class="hidden">
        						<p class="text-xs text-green-600 mb-1 font-bold">처리 완료 일시</p>
        						<p id="detProcessDate" class="font-bold text-gray-700"></p>
    						</div>
                        </div>
                        
                        <div class="space-y-2">
                            <p class="text-xs text-gray-400 font-bold uppercase tracking-wider">문의 내용</p>
                            <div id="detContent" class="bg-gray-50 p-6 rounded-xl text-sm leading-relaxed text-gray-600 min-h-[150px]"></div>
                        </div>

						<div id="detFileArea" class="space-y-2 hidden">
    						<p class="text-xs text-gray-400 font-bold uppercase tracking-wider">첨부 파일 증빙</p>
    						<div class="flex gap-4">
        					<div class="relative group cursor-pointer overflow-hidden rounded-xl border border-gray-100 w-48 h-32 bg-gray-50">
            					<img id="detFileImg" onclick="zoomImage(this.src)" src="" alt="첨부이미지" class="w-full h-full object-cover transition-transform group-hover:scale-105">
        					</div>
    						</div>
						</div>

                        <div id="replyArea" class="space-y-4">
                            <p class="text-xs text-primary font-black uppercase tracking-wider">관리자 답변</p>
                            <div id="replyDisplay" class="hidden p-6 bg-blue-50 rounded-xl border border-blue-100 text-sm text-gray-700 leading-relaxed"></div>
                            
                            <div id="replyForm" class="hidden space-y-3">
                                <textarea id="replyText" 
                                    class="w-full border-gray-200 rounded-xl text-sm h-32 focus:ring-primary focus:border-primary p-4 outline-none transition-all" 
                                    placeholder="사용자에게 전달될 답변을 입력하세요..."></textarea>
                                <div class="flex justify-end">
                                    <button onclick="submitReply()" class="bg-primary text-white px-8 py-3 rounded-xl font-bold hover:opacity-90 transition-all shadow-sm">
                                        답변 등록
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
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
        function filterStatus(status) {
            location.href = '${pageContext.request.contextPath}/admin/inquiryList?status=' + status;
        }

        function searchList(e) {
            if(e.key === 'Enter') {
                location.href = '${pageContext.request.contextPath}/admin/inquiryList?status=${currentStatus}&keyword=' + e.target.value;
            }
        }

        function loadDetail(id, element) {
            document.querySelectorAll('.inquiry-item').forEach(el => el.classList.remove('selected-card'));
            element.classList.add('selected-card');

            fetch('${pageContext.request.contextPath}/admin/inquiryList?action=detail&id=' + id)
                .then(res => res.json())
                .then(data => {
                    document.getElementById('emptyDetail').classList.add('hidden');
                    document.getElementById('detailPanel').classList.remove('hidden');
                    
                    document.getElementById('detNo').innerText = 'INQ-' + data.inquiryId;
                    document.getElementById('detTitle').innerText = data.title;
                    document.getElementById('detCategory').innerText = '문의 유형 : ' + data.category;
                    document.getElementById('detUser').innerText = data.userName + ' (' + data.userId + ')';
                    document.getElementById('detContent').innerText = data.content;
                    document.getElementById('detDate').innerText = new Date(data.regDate.split('.')[0]).toLocaleString();

                 	// --- 첨부파일 영역 제어 ---
                    const fileArea = document.getElementById('detFileArea');
                    const fileImg = document.getElementById('detFileImg');
                    if(data.file && data.file.trim() !== "") {
                        fileArea.classList.remove('hidden');
                        // 서버의 실제 파일 저장 경로와 매핑 (예: /resources/upload/파일명)
                        fileImg.src = '${pageContext.request.contextPath}/resources/upload/' + data.file;
                    } else {
                        fileArea.classList.add('hidden');
                    }
                    
                 	// --- 상태별 처리 (처리완료/미처리) ---
                    const badge = document.getElementById('detStatusBadge');
                    const processArea = document.getElementById('detProcessArea'); // [추가] 처리완료일시 영역
                    
                    if(data.status === 'COMPLETE') {
                        badge.className = 'px-2 py-1 rounded text-[10px] font-bold bg-gray-200 text-gray-500';
                        badge.innerText = '처리완료';
                        
                        // 처리 완료 정보 노출
                        processArea.classList.remove('hidden');
                        if(data.processDate) {
                            document.getElementById('detProcessDate').innerText = new Date(data.processDate.split('.')[0]).toLocaleString();
                        }

                        document.getElementById('replyDisplay').classList.remove('hidden');
                        document.getElementById('replyDisplay').innerText = data.result;
                        document.getElementById('replyForm').classList.add('hidden');
                    } else {
                        badge.className = 'px-2 py-1 rounded text-[10px] font-bold bg-primary text-white';
                        badge.innerText = '미처리';
                        
                        // 처리 완료 정보 숨김
                        processArea.classList.add('hidden');

                        document.getElementById('replyDisplay').classList.add('hidden');
                        document.getElementById('replyForm').classList.remove('hidden');
                        document.getElementById('replyText').value = '';
                    }
                    
                    window.currentInquiryId = data.inquiryId;
                })
                .catch(err => {
                    console.error("상세 데이터 로드 실패:", err);
                    alert("데이터를 불러오는 중 오류가 발생했습니다.");
                });
        }

        function submitReply() {
            const result = document.getElementById('replyText').value;
            if(!result) { alert('답변 내용을 입력해주세요.'); return; }
            
            const params = new URLSearchParams();
            params.append('inquiryId', window.currentInquiryId);
            params.append('result', result);

            fetch('${pageContext.request.contextPath}/admin/inquiryList', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params
            })
            .then(res => res.json())
            .then(data => {
                if(data.success) {
                    alert('답변이 등록되었습니다.');
                    location.reload();
                } else {
                    alert('처리 중 오류가 발생했습니다.');
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
</body>
</html>