<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitsbug</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container-lowest": "#ffffff",
                        "background": "#f8f9fb",
                        "tertiary": "#924700",
                        "on-secondary-fixed": "#001a42",
                        "inverse-surface": "#2e3132",
                        "tertiary-container": "#b75b00",
                        "surface-variant": "#e1e2e4",
                        "on-primary-fixed-variant": "#004395",
                        "on-tertiary-fixed": "#311400",
                        "on-tertiary-fixed-variant": "#723600",
                        "surface": "#f8f9fb",
                        "on-secondary-container": "#405682",
                        "on-surface-variant": "#424754",
                        "surface-container-high": "#e7e8ea",
                        "on-surface": "#191c1e",
                        "error-container": "#ffdad6",
                        "primary-fixed": "#d8e2ff",
                        "on-background": "#191c1e",
                        "primary-container": "#2170e4",
                        "surface-bright": "#f8f9fb",
                        "on-error": "#ffffff",
                        "on-error-container": "#93000a",
                        "on-secondary": "#ffffff",
                        "on-primary-fixed": "#001a42",
                        "secondary-container": "#b6ccff",
                        "surface-container-highest": "#e1e2e4",
                        "secondary": "#495e8a",
                        "error": "#ba1a1a",
                        "inverse-primary": "#adc6ff",
                        "primary-fixed-dim": "#adc6ff",
                        "outline-variant": "#c2c6d6",
                        "on-primary": "#ffffff",
                        "tertiary-fixed-dim": "#ffb786",
                        "surface-container-low": "#f3f4f6",
                        "secondary-fixed-dim": "#b1c6f9",
                        "inverse-on-surface": "#f0f1f3",
                        "on-primary-container": "#fefcff",
                        "outline": "#727785",
                        "tertiary-fixed": "#ffdcc6",
                        "surface-dim": "#d9dadc",
                        "on-tertiary-container": "#fffbff",
                        "surface-container": "#edeef0",
                        "primary": "#3B82F6",
                        "surface-tint": "#3B82F6",
                        "on-tertiary": "#ffffff",
                        "secondary-fixed": "#d8e2ff",
                        "on-secondary-fixed-variant": "#304671"
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
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fb; color: #191c1e; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; vertical-align: middle; }
        .glass-nav { background: rgba(255, 255, 255, 0.8); backdrop-filter: blur(20px); }
    </style>
</head>
<body class="antialiased">
<jsp:include page="common/sidebar.jsp"></jsp:include>

<!-- Main Content Area -->
<div class="ml-64 min-h-screen flex flex-col">

<!-- Page Canvas -->
<main class="flex-1 p-10 pt-24 max-w-5xl mx-auto w-full">

<!-- Navigation Action Bar -->
<div class="flex justify-between items-center mb-10">
<a href="${pageContext.request.contextPath}/gym/notice" 
   class="flex items-center gap-2 text-on-surface-variant hover:text-on-surface transition-colors font-medium text-sm group">
	<span class="material-symbols-outlined text-[18px] group-hover:-translate-x-1 transition-transform">arrow_back</span>
                    목록으로 돌아가기
</a>
<div class="flex flex-col gap-2 items-end">
<button type="button"
		onclick="openEditModal()"
   		class="px-6 py-2.5 bg-primary text-white rounded-lg font-bold text-sm shadow-lg shadow-primary/20 hover:opacity-90 active:scale-95 transition-all w-full text-center">
        수정하기
    </button>

	<button type="button"
			onclick="openDeleteModal()"
		    class="px-6 py-2.5 bg-[#EF4444] text-white rounded-lg font-bold text-sm shadow-lg shadow-red-500/20 hover:opacity-90 active:scale-95 transition-all w-full text-center">
        	삭제하기
	</button>
   
</div>
</div>

<!-- Article Header -->
<div class="mb-8">
<h2 class="text-[2.75rem] font-extrabold text-on-surface leading-tight tracking-tight mb-6"><c:out value="${notice.title}"/></h2>
<div class="flex items-center gap-6 text-on-surface-variant">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-[18px]">calendar_today</span>
<span class="text-sm font-medium">
	<fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
</span>
</div>
<div class="w-px h-3 bg-outline-variant/30"></div>
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-[18px]">visibility</span>
<span class="text-sm font-medium">${notice.viewCount}</span>
</div>
</div>
</div>

<!-- Article Content -->
<article class="bg-surface-container-lowest rounded-xl p-8 shadow-sm border border-outline-variant/10">

	<!-- Text Content -->
	<div class="space-y-8 text-on-surface leading-relaxed">
		<p class="text-on-surface-variant whitespace-pre-line"><c:out value="${notice.content}"/></p>
	</div>
     
	<!-- Attached Images -->
	<c:if test="${not empty imageList}">
		<div class="mt-10 space-y-4">
            <h3 class="text-sm font-bold text-on-surface-variant">첨부 이미지</h3>

            <div class="grid grid-cols-1 gap-4">
                <c:forEach var="image" items="${imageList}">
                	<img src="${pageContext.request.contextPath}/trainer/profile-img/${image.imageUrl}"
     					 lt="${notice.title}"
     					 class="w-[250px] h-auto object-contain rounded-xl shadow-sm mx-auto"/>
                </c:forEach>
            </div>
        </div>
    </c:if>
</article>


</main>
</div>

<!-- Edit Notice Modal -->
<div id="editModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-on-surface/40 backdrop-blur-md p-4">
    <form action="${pageContext.request.contextPath}/gym/noticeUpdate"
          method="post"
          enctype="multipart/form-data"
          class="bg-surface-container-lowest w-full max-w-4xl max-h-[90vh] rounded-xl shadow-2xl flex flex-col overflow-hidden">

        <input type="hidden" name="noticeId" value="${notice.id}">
        <input type="hidden" name="gymId" value="${notice.gymId}">

        <!-- Modal Header -->
        <div class="px-8 py-6 flex justify-between items-center border-outline-variant/15 relative">
            <h2 class="text-2xl font-black tracking-tight text-on-surface w-full text-left">공지 수정</h2>

            <button type="button"
                    onclick="closeEditModal()"
                    class="absolute top-6 right-8 p-2 hover:bg-surface-container-low rounded-full transition-colors">
                <span class="material-symbols-outlined text-on-surface-variant">close</span>
            </button>
        </div>

        <!-- Modal Body -->
        <div class="flex-1 overflow-y-auto p-8 space-y-8">

            <!-- Image Attachment Section -->
            <div class="space-y-4">
                <label class="text-xs font-bold uppercase tracking-wider text-on-surface-variant">이미지 첨부</label>

                <div id="editNoticePreviewBox" 
                	 class="grid grid-cols-2 md:grid-cols-4 gap-4">

                    <!-- Existing Images -->
                    <c:forEach var="image" items="${imageList}">
    <div class="relative group aspect-video rounded-lg overflow-hidden border border-outline-variant/15">

        <input type="checkbox"
               id="deleteImage${image.imageId}"
               name="deleteImageIds"
               value="${image.imageId}"
               class="peer sr-only">

        <img src="${pageContext.request.contextPath}/trainer/profile-img/${image.imageUrl}"
             class="w-full h-full object-cover"
             alt="${notice.title}">

        <label for="deleteImage${image.imageId}"
               class="absolute top-2 right-2 bg-error text-white px-2 py-1 rounded text-[10px] font-bold cursor-pointer z-10">
            삭제
        </label>

        <div class="absolute inset-0 bg-black/60 hidden peer-checked:flex items-center justify-center text-white text-sm font-bold">
            삭제 예정
        </div>
    </div>
</c:forEach>

                    <!-- Add Image -->
                    <label class="aspect-video rounded-lg border-2 border-dashed border-outline-variant/30 hover:border-primary/50 hover:bg-primary/5 transition-all flex flex-col items-center justify-center gap-2 group cursor-pointer">
                        <span class="material-symbols-outlined text-on-surface-variant group-hover:text-primary transition-colors">add_photo_alternate</span>
                        <span class="text-xs font-medium text-on-surface-variant group-hover:text-primary transition-colors">이미지 추가</span>
                        <input type="file" id="editNoticeImageInput" name="noticeImages" multiple accept="image/*" class="hidden">
                    </label>
                </div>
            </div>

            <!-- Title -->
            <div class="space-y-2">
                <label class="text-xs font-bold uppercase tracking-wider text-on-surface-variant">제목</label>
                <input name="title"
                       class="w-full px-4 py-3 bg-surface-container-lowest border border-outline-variant/30 rounded-lg focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-lg"
                       type="text"
                       value="${fn:escapeXml(notice.title)}">
            </div>

            <!-- Content -->
            <div class="space-y-2">
                <label class="text-xs font-bold uppercase tracking-wider text-on-surface-variant">내용</label>
                <textarea name="content"
                          class="w-full min-h-[300px] p-6 bg-surface-container-lowest border border-outline-variant/30 rounded-lg focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none text-on-surface leading-relaxed"><c:out value="${notice.content}"/></textarea>
            </div>
        </div>

        <!-- Modal Footer -->
        <div class="px-8 py-6 border-outline-variant/15 flex justify-end items-center gap-3 relative">
            <button type="button"
                    onclick="closeEditModal()"
                    class="px-6 py-3 font-bold text-on-surface-variant hover:bg-surface-container-low rounded-lg transition-colors">
                취소
            </button>

            <button type="submit"
                    class="px-8 py-3 bg-primary text-white font-bold rounded-lg shadow-lg shadow-primary/20 active:scale-95 transition-all">
                수정 완료
            </button>
        </div>
    </form>
</div>

<script>
    function openEditModal() {
    	document.body.style.overflow="hidden";
        document.getElementById("editModal").classList.remove("hidden");
        document.getElementById("editModal").classList.add("flex");
    }

    function closeEditModal() {
    	document.body.style.overflow="auto";
        document.getElementById("editModal").classList.add("hidden");
        document.getElementById("editModal").classList.remove("flex");
    }
</script>

<!-- Delete Confirm Modal -->
<div id="deleteModal"
     class="fixed inset-0 z-[100] hidden items-center justify-center bg-on-surface/20 backdrop-blur-md p-6">

    <div class="bg-surface-container-lowest w-full max-w-[400px] rounded-lg shadow-2xl overflow-hidden border border-outline-variant/10">
        <div class="p-8 text-center md:text-left">
            <div class="flex items-center justify-center md:justify-start gap-3 mb-4 text-error">
                <span class="material-symbols-outlined text-3xl">warning</span>
                <h3 class="text-xl font-bold tracking-tight text-on-surface">게시글 삭제</h3>
            </div>

            <p class="text-on-surface-variant leading-relaxed mb-8">
                정말 삭제하시겠습니까? 삭제된 게시글은 복구할 수 없습니다.
            </p>

            <form action="${pageContext.request.contextPath}/gym/noticeDelete" method="post">
                <input type="hidden" name="noticeId" value="${notice.id}">
                <input type="hidden" name="gymId" value="${notice.gymId}">

                <div class="flex flex-col md:flex-row gap-3">
                    <button type="button"
                            onclick="closeDeleteModal()"
                            class="flex-1 py-3 px-6 rounded-lg text-on-surface-variant border border-outline-variant hover:bg-surface-container-low transition-colors font-semibold text-sm">
                        취소
                    </button>

                    <button type="submit"
                            class="flex-1 py-3 px-6 rounded-lg bg-[#e11d48] text-white hover:bg-error transition-all font-semibold shadow-md active:scale-95 text-sm">
                        삭제
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openDeleteModal() {
    	closeEditModal();
        document.getElementById("deleteModal").classList.remove("hidden");
        document.getElementById("deleteModal").classList.add("flex");
    }

    function closeDeleteModal() {
        document.getElementById("deleteModal").classList.add("hidden");
        document.getElementById("deleteModal").classList.remove("flex");
    }
    
    document.getElementById("editNoticeImageInput")
    .addEventListener("change", function(e) {

    const previewBox = document.getElementById("editNoticePreviewBox");

    const files = e.target.files;

    for (let file of files) {

        if (!file.type.startsWith("image/")) {
            continue;
        }

        const imageWrapper = document.createElement("div");
        imageWrapper.className =
            "relative w-32 h-32 rounded-xl overflow-hidden border border-outline-variant/10";

        const img = document.createElement("img");
        img.src = URL.createObjectURL(file);
        img.className = "w-full h-full object-cover";

        imageWrapper.appendChild(img);

        previewBox.appendChild(imageWrapper);
    }
});
</script> 
</body>
</html>