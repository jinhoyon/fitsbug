<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitsbug - 공지사항</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "outline-variant": "#c2c6d6",
                        "on-secondary-fixed-variant": "#304671",
                        "inverse-on-surface": "#f0f1f3",
                        "tertiary-container": "#b75b00",
                        "background": "#f8f9fb",
                        "on-error-container": "#93000a",
                        "primary-container": "#2170e4",
                        "on-tertiary-fixed-variant": "#723600",
                        "on-surface": "#191c1e",
                        "on-primary-fixed": "#001a42",
                        "surface-container-high": "#e7e8ea",
                        "outline": "#727785",
                        "on-tertiary-fixed": "#311400",
                        "surface-container-lowest": "#ffffff",
                        "surface-container-highest": "#e1e2e4",
                        "on-primary-fixed-variant": "#004395",
                        "tertiary": "#924700",
                        "secondary-fixed-dim": "#b1c6f9",
                        "error": "#ba1a1a",
                        "surface-dim": "#d9dadc",
                        "on-secondary-container": "#405682",
                        "surface-container": "#edeef0",
                        "tertiary-fixed-dim": "#ffb786",
                        "primary": "#3B82F6",
                        "on-secondary": "#ffffff",
                        "on-tertiary": "#ffffff",
                        "on-primary": "#ffffff",
                        "inverse-primary": "#adc6ff",
                        "surface-container-low": "#f3f4f6",
                        "on-tertiary-container": "#fffbff",
                        "surface-tint": "#3B82F6",
                        "secondary": "#495e8a",
                        "primary-fixed": "#d8e2ff",
                        "on-primary-container": "#fefcff",
                        "on-error": "#ffffff",
                        "inverse-surface": "#2e3132",
                        "secondary-fixed": "#d8e2ff",
                        "error-container": "#ffdad6",
                        "surface": "#f8f9fb",
                        "on-surface-variant": "#424754",
                        "surface-bright": "#f8f9fb",
                        "primary-fixed-dim": "#adc6ff",
                        "tertiary-fixed": "#ffdcc6",
                        "secondary-container": "#b6ccff",
                        "on-background": "#191c1e",
                        "surface-variant": "#e1e2e4",
                        "on-secondary-fixed": "#001a42"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.5rem",
                        "lg": "0.5rem",
                        "xl": "1.5rem",
                        "full": "9999px"
                    },
                    "fontFamily": {
                        "headline": ["Inter"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            }
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
        .glass-nav {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
        }
    </style>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
</head>
<body class="bg-background font-body text-on-surface">
	<jsp:include page="common/sidebar.jsp"></jsp:include>

	<!-- Main Content Area -->
	<main class="ml-64 pt-16 min-h-screen bg-surface">
		<div class="p-8 max-w-5xl mx-auto">
		
		<!-- Header Section -->
		<div class="flex items-end justify-between mb-12">
			<div>
				<span class="text-[11px] font-bold text-primary tracking-widest uppercase mb-1 block" style=""><br></span>
				<h2 class="text-4xl font-black tracking-tight text-on-surface" style="">공지사항</h2>
			</div>
			<button class="bg-primary text-white px-5 py-2.5 rounded-lg text-sm font-bold flex items-center gap-2 hover:shadow-lg hover:shadow-primary/20 transition-all active:scale-95"
					onclick="openNoticeWriteModal()"
					type="button">
					<span class="material-symbols-outlined text-lg" style="">add</span>
                		새 공지 작성
            </button>
		</div>
		
		<!-- Sorting UI -->
		<div class="flex items-center justify-between mb-6">
			<div class="flex items-center gap-4">
				<a href="${pageContext.request.contextPath}/gym/notice?sort=latest&page=1"
   		   		   class="${empty sort || sort eq 'latest' ? 'text-sm font-bold text-primary border-b-2 border-primary pb-1' : 'text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors pb-1 border-b-2 border-transparent'}">
   					최신순
				</a>
				<a href="${pageContext.request.contextPath}/gym/notice?sort=view&page=1"
   		   		   class="${sort eq 'view' ? 'text-sm font-bold text-primary border-b-2 border-primary pb-1' : 'text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors pb-1 border-b-2 border-transparent'}">
   					조회수순
				</a>
			</div>
			<div class="text-[11px] font-medium text-on-surface-variant">
				총 <span class="font-bold text-on-surface" style="">${noticeCount}</span>건의 공지사항
   			</div>
		</div>
		
		<!-- Notice List -->
		<div class="space-y-4">
			<c:forEach var="notice" items="${noticeList}">
				<a href="${pageContext.request.contextPath}/gym/noticeDetail?noticeId=${notice.id}"
			   	   class="block bg-white hover:bg-surface-container-low p-6 rounded-lg transition-all duration-200 flex items-start gap-6 group cursor-pointer border border-outline-variant/10">
			
				<div class="flex-shrink-0 text-center w-16">
					<p class="text-[10px] font-black text-on-surface-variant tracking-tighter uppercase mb-1">
						<c:if test="${not empty notice.createdAt}">
							${notice.createdAt.toString().substring(0,7)}
						</c:if>
					</p>
					<p class="text-2xl font-black text-on-surface">
						<c:if test="${not empty notice.createdAt}">
							${notice.createdAt.toString().substring(8,10)}
						</c:if>
					</p>	
				</div>	
			
				<div class="flex-1">
					<div class="flex items-center gap-2 mb-2">
						<span class="text-[11px] text-on-surface-variant font-medium">조회수 ${notice.viewCount}</span>
					</div>	
				
					<h4 class="text-lg font-bold text-on-surface group-hover:text-primary transition-colors mb-1">${notice.title}</h4>
					<p class="text-sm text-on-surface-variant line-clamp-1 leading-relaxed">${notice.content}</p>
				</div>	
			
				<div class="flex-shrink-0 self-center">
					<span class="material-symbols-outlined text-outline-variant group-hover:text-primary transition-colors">chevron_right</span>
				</div>
				</a>
			</c:forEach>
	
			<c:if test="${empty noticeList}">
				<div class="text-center text-gray-400 p-10 bg-white rounded-lg border border-outline-variant/10">
            		공지사항이 없습니다.
        		</div>
			</c:if>
		</div>
	

	<!-- Pagination -->
	<div class="mt-12 flex justify-center items-center gap-2">
		<c:if test="${page > 1}">
			<a href="${pageContext.request.contextPath}/gym/notice?page=${page-1}&sort=${sort}"
			   class="w-10 h-10 flex items-center justify-center rounded-lg border border-transparent hover:bg-white transition-colors text-outline-variant">
				<span class="material-symbols-outlined" style="">chevron_left</span>
			</a>
		</c:if>
		
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="${pageContext.request.contextPath}/gym/notice?page=${i}&sort=${sort}"
			   class="${i == page ? 'w-10 h-10 flex items-center justify-center rounded-lg bg-primary text-white font-bold text-sm' : 'w-10 h-10 flex items-center justify-center rounded-lg hover:bg-white transition-colors text-sm font-medium text-on-surface-variant'}">
				${i}
			</a>
		</c:forEach>
		<c:if test="${page < totalPage}">
			<a href="${pageContext.request.contextPath}/gym/notice?page=${page+1}&sort=${sort}"
			   class="w-10 h-10 flex items-center justify-center rounded-lg border border-transparent hover:bg-white transition-colors text-outline-variant">
				<span class="material-symbols-outlined" style="">chevron_right</span>
			</a>
		</c:if>
	</div>
</div>
</main>

<!-- 모달 -->
<!-- 공지 작성 모달 -->
<div id="noticeModal"
     class="fixed inset-0 z-50 hidden items-center justify-center bg-black/40 backdrop-blur-sm p-4">

    <div class="w-full max-w-2xl bg-white rounded-xl shadow-2xl overflow-hidden">
        
        <!-- 모달 헤더 -->
        <div class="px-8 py-6 flex justify-between items-center border-b border-gray-200">
            <h2 class="text-2xl font-black tracking-tight text-on-surface">새 공지 작성</h2>
            <button type="button"
                    onclick="closeNoticeWriteModal()"
                    class="p-2 hover:bg-gray-100 rounded-full transition-colors">
                <span class="material-symbols-outlined text-on-surface-variant">close</span>
            </button>
        </div>

        <!-- 모달 내용 -->
        <form action="${pageContext.request.contextPath}/gym/noticeWrite"
              method="post"
              onsubmit="return submitNoticeForm();"
              enctype="multipart/form-data"
              class="px-8 pb-8 pt-6 space-y-6">

            <!-- 제목 -->
            <div class="space-y-2">
                <label for="noticeTitle"
                       class="text-xs font-bold uppercase tracking-wider text-on-surface-variant">
                    제목
                </label>
                <input type="text"
                       id="noticeTitle"
                       name="title"
                       class="w-full px-4 py-3 border border-outline-variant/30 rounded-lg outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"
                       placeholder="공지사항 제목을 입력하세요" />
            </div>

            <!-- 내용 -->
            <div class="space-y-2">
                <label class="text-xs font-bold uppercase tracking-wider text-on-surface-variant">
                    내용
                </label>

                <!-- Toast UI Editor 들어갈 자리 -->
                <div id="editor">
                </div>
                

                <!-- 실제 서버로 보낼 hidden input -->
                <input type="hidden" name="content" id="noticeContent" />
                
                <input type="file"
           			   name="noticeImages"
           			   multiple
           			   class="w-full text-sm border border-outline-variant/30 rounded-lg p-2">
            </div>

            <!-- 버튼 -->
            <div class="flex items-center justify-end gap-3 pt-4">
                <button type="button"
                        onclick="closeNoticeWriteModal()"
                        class="px-6 py-3 font-bold text-on-surface-variant hover:bg-gray-100 rounded-lg transition-colors">
                    취소
                </button>

                <button type="submit"
                        class="px-8 py-3 bg-primary text-white font-bold rounded-lg shadow-lg shadow-primary/20 active:scale-95 transition-all">
                    게시하기
                </button>
            </div>
        </form>
    </div>
</div>
<script>
let noticeEditor = null;

function openNoticeWriteModal() {
    const modal = document.getElementById("noticeModal");
    modal.classList.remove("hidden");
    modal.classList.add("flex");

    if (!noticeEditor) {
        noticeEditor = new toastui.Editor({
            el: document.querySelector("#editor"),
            height: "300px",
            initialEditType: "wysiwyg",
            previewStyle: "vertical",
            placeholder: "회원들에게 알릴 상세 내용을 작성하세요..."
        });
    }
}

function closeNoticeWriteModal() {
    const modal = document.getElementById("noticeModal");
    modal.classList.add("hidden");
    modal.classList.remove("flex");
}

function submitNoticeForm() {
    const title = document.getElementById("noticeTitle").value.trim();
    let content = noticeEditor.getHTML().trim();

    content = content.replace(/<img[^>]*src=["']data:image\/[^>]*>/gi, "");
    content = content.replace(/<p>\s*<\/p>/gi, "");
    content = content.trim();
    
    if (title === "") {
        alert("제목을 입력하세요.");
        document.getElementById("noticeTitle").focus();
        return false;
    }

    if (content === "" || content === "<p><br></p>") {
        alert("내용을 입력하세요.");
        return false;
    }

    document.getElementById("noticeContent").value = content;
    return true;
}
</script>  
</body>
</html>