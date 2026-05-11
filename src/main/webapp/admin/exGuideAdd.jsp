<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
      .hangul-lh { line-height: 1.7; }
      .preview-content{
      	width: 100%;
    	height: 100%;
   		object-fit: cover; /* 영역에 꽉 차게 */
    	border-radius: 0.75rem; /* rounded-xl */
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
<div class="flex justify-between items-center mb-8">
<div>
<h2 class="text-2xl font-semibold font-headline tracking-tight text-on-surface">운동가이드 관리</h2>
<p class="text-on-surface-variant mt-1">등록된 운동 가이드를 수정하거나 삭제할 수 있는 관리 대시보드입니다.</p>
</div>
<button onclick="location.href='<%= contextPath %>/admin/exGuideList'" 
class="bg-primary text-white px-6 py-2.5 rounded-lg text-sm font-semibold flex items-center gap-2 hover:bg-primary/90 transition-colors shadow-sm">
<span class="material-symbols-outlined text-lg">arrow_back</span>
목록으로 돌아가기
</button>
</div>
<!-- Registration Form Content -->
<div class="grid grid-cols-12 gap-8">
<!-- Registration Form -->
<div class="col-span-12 lg:col-span-8">
<section class="bg-surface-container-lowest p-8 rounded-xl shadow-sm border border-outline-variant/10">
<div class="flex items-center gap-3 mb-8">
<div class="w-10 h-10 bg-primary-fixed flex items-center justify-center rounded-lg text-primary">
<span class="material-symbols-outlined">add_circle</span>
</div>
<h3 class="text-xl font-bold tracking-tight">
    ${empty guide ? "신규 가이드 등록" : "가이드 수정"}
</h3>
</div>

<form action="<%= contextPath %>/admin/exGuideAdd" class="space-y-6" method="post" enctype="multipart/form-data">
<input type="hidden" name="egNum" value="${guide.egNum}">
<div class="space-y-2">
<label class="text-xs font-bold text-outline uppercase tracking-wider">가이드 제목</label>
<input name="title" value="${guide.title }" class="w-full bg-surface-container-low border-none border-b-2 border-outline-variant focus:border-primary focus:ring-0 text-base px-0 py-3 transition-all placeholder:text-outline-variant" placeholder="예: 초보자를 위한 하체 스쿼트의 정석" type="text"/>
</div>
<div class="grid grid-cols-2 gap-6">
<div class="space-y-2">
<label class="text-xs font-bold text-outline uppercase tracking-wider">운동 타입</label>
<select name="type" class="w-full bg-surface-container-low border-none border-b-2 border-outline-variant focus:border-primary focus:ring-0 text-sm py-3 transition-all">
	<option ${guide.type == '근력' ? 'selected' : ''}>근력</option>
    <option ${guide.type == '유산소' ? 'selected' : ''}>유산소</option>
</select>
</div>
<div class="space-y-2">
<label class="text-xs font-bold text-outline uppercase tracking-wider">난이도</label>
<div><span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all difficulty-item">
초급</span>
<span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all difficulty-item">
중급</span>
<span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all difficulty-item">
고급</span>
<input type="hidden" name="difficulty" id="difficultyInput" value="">
</div>
</div>
</div><div class="space-y-2 pt-4"><label class="text-xs font-bold text-outline uppercase tracking-wider">운동 부위</label><div class="flex flex-wrap gap-2 pt-2"><span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all muscle-item">
가슴</span>
<span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all muscle-item">
등</span>
<span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all muscle-item">
하체</span>
<span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all muscle-item">
팔</span>
<span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all muscle-item">
어깨</span>
<span class="px-4 py-1.5 rounded-full bg-surface-container-high text-on-surface-variant text-xs font-semibold cursor-pointer border border-transparent hover:border-primary transition-all muscle-item">
전신</span>
<input type="hidden" name="targetMuscle" id="muscleInput" value="">
</div></div>
<div class="space-y-2">
<label class="text-xs font-bold text-outline uppercase tracking-wider">상세 설명</label>
<textarea name="description" class="w-full bg-surface-container-low border-none border-b-2 border-outline-variant focus:border-primary focus:ring-0 text-sm px-4 py-3 rounded-lg transition-all hangul-lh min-h-[200px]" 
placeholder="운동 방법, 주의사항, 호흡법 등을 상세히 기록해 주세요." rows="6">${guide.description}</textarea>
</div>
<div class="space-y-2">
<label class="text-xs font-bold text-outline uppercase tracking-wider">핵심자세포인트</label>
<textarea name="keyPoint" class="w-full bg-surface-container-low border-none border-b-2 border-outline-variant focus:border-primary focus:ring-0 text-sm px-4 py-3 rounded-lg transition-all hangul-lh min-h-[200px]" 
placeholder="운동 시 반드시 지켜야 할 자세의 핵심 포인트를 입력해 주세요." rows="6">${guide.keyPoint}</textarea>
</div>
<div class="space-y-2 pt-4">
    <label class="text-xs font-bold text-outline uppercase tracking-wider">유튜브 영상 주소 (URL)</label>
    <div class="flex gap-2">
        <input name="video" id="videoUrlInput" value="${guide.video}" 
               class="w-full bg-surface-container-low border-none border-b-2 border-outline-variant focus:border-primary focus:ring-0 text-sm px-0 py-3 transition-all placeholder:text-outline-variant" 
               placeholder="https://www.youtube.com/watch?v=..." type="text"
               oninput="updateYoutubePreview(this.value)"/>
    </div>
    <p class="text-[11px] text-outline">유튜브 '공유' 버튼을 눌러 나오는 주소를 복사해서 붙여넣어 주세요.</p>
</div>

<div class="pt-4">
<button class="w-full bg-primary hover:bg-primary-container text-on-primary py-4 rounded-xl font-bold text-base transition-all scale-100 active:scale-[0.98] shadow-lg shadow-primary/20" 
type="submit"> ${empty guide ? "가이드 등록하기" : "수정 완료하기"}
</button>
</div>
 <input type="file" name="imageFile" id="imageFile" hidden onchange="previewMedia(this, 'imgPreview')"> 
</form>
</section>
</div>
<!-- Media Upload Column -->
<div class="col-span-12 lg:col-span-4 space-y-6">
<div class="space-y-4">
<label class="text-xs font-bold text-outline uppercase tracking-wider">미디어 업로드</label>
<div class="flex flex-col gap-4">
    <div class="relative group h-64">
        <div id="imgPreview" onclick="document.getElementById('imageFile').click()" 
             class="w-full h-full border-2 border-dashed border-outline-variant/50 rounded-xl p-10 flex flex-col items-center justify-center bg-surface-container-lowest hover:bg-surface-container-low transition-all cursor-pointer overflow-hidden">
            <span class="material-symbols-outlined text-outline group-hover:text-primary mb-3 text-4xl">image</span>
            <p class="text-sm font-medium text-on-surface-variant">이미지 업로드</p>
            <p class="text-xs text-outline mt-1">PNG, JPG (최대 10MB)</p>
        </div>
       
    </div>

    <div class="relative group h-64">
        <div id="videoPreview" 
                     class="w-full h-full border-2 border-dashed border-outline-variant/50 rounded-xl flex flex-col items-center justify-center bg-black transition-all overflow-hidden">
                    <div id="videoPlaceholder" class="flex flex-col items-center">
                        <span class="material-symbols-outlined text-outline mb-3 text-4xl">movie</span>
                        <p class="text-sm font-medium text-on-surface-variant">유튜브 미리보기</p>
                    </div>
                    <iframe id="ytPreviewIframe" class="w-full h-full hidden" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen>
					</iframe>
                </div>
    </div>
</div>
</div>
</div>
</div>
</div>

</main>
<!-- Floating Action Button -->
<button class="fixed bottom-8 right-8 w-14 h-14 bg-on-surface text-surface rounded-full flex items-center justify-center shadow-2xl hover:scale-110 active:scale-95 transition-all z-50">
<span class="material-symbols-outlined">help_outline</span>
</button>
<script>
// 1. 하이라이트 기능
function setupSelection(selector, inputId) {
    document.querySelectorAll(selector).forEach(item => {
        item.addEventListener('click', function() {
            // 초기화
            document.querySelectorAll(selector).forEach(i => {
                i.classList.remove('bg-primary', 'text-white');
                i.classList.add('bg-surface-container-high', 'text-on-surface-variant');
            });
            // 하이라이트
            this.classList.remove('bg-surface-container-high', 'text-on-surface-variant');
            this.classList.add('bg-primary', 'text-white');
            // 값 세팅
            document.getElementById(inputId).value = this.innerText;
        });
    });
}

// 2. 미디어 미리보기 기능
function previewMedia(input, previewId) {
	if (input.files && input.files[0]) {
        const reader = new FileReader();
        const container = document.getElementById(previewId);
        
        reader.onload = function(e) {
            container.innerHTML = ''; 
            const img = document.createElement('img');
            img.src = e.target.result;
            img.className = 'preview-content';
            container.appendChild(img);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
// 초기 실행
setupSelection('.difficulty-item', 'difficultyInput');
setupSelection('.muscle-item', 'muscleInput');
//페이지 로드 시 기존 값 세팅 (수정 모드일 때)
window.onload = function() {
    const existingDifficulty = "${guide.difficulty}";
    const existingMuscle = "${guide.targetMuscle}";

    if(existingDifficulty) {
        document.querySelectorAll('.difficulty-item').forEach(item => {
            if(item.innerText.trim() === existingDifficulty) item.click();
        });
    }
    if(existingMuscle) {
        document.querySelectorAll('.muscle-item').forEach(item => {
            if(item.innerText.trim() === existingMuscle) item.click();
        });
    }
    
    // 수정 시 이미지/비디오가 있다면 미리보기에 표시
    if("${guide.image}") {
        const imgCont = document.getElementById('imgPreview');
        imgCont.innerHTML = `<img src="<%=contextPath%>/uploads/${guide.image}" class="preview-content">`;
    }
    const existingVideo = "${guide.video}";
    if(existingVideo && existingVideo.trim() !== "") {
        updateYoutubePreview(existingVideo);
    }
};

//1. 유튜브 URL에서 ID 추출 및 미리보기 업데이트
function updateYoutubePreview(url) {
    const previewContainer = document.getElementById('videoPreview');
    const iframe = document.getElementById('ytPreviewIframe');
    const placeholder = document.getElementById('videoPlaceholder');

    if (!url || url.trim() === "") {
        iframe.classList.add('hidden');
        iframe.src = "";
        placeholder.style.display = 'flex';
        return;
    }

    // 보완된 유튜브 ID 추출 정규식 (shorts 및 다양한 URL 대응)
    const regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
    const match = url.match(regExp);
    const videoId = (match && match[7].length === 11) ? match[7] : null;

    if (videoId) {
        // 보안 및 정책 준수를 위한 주소 형식: https://www.youtube.com/embed/영상ID
        iframe.src = "https://www.youtube.com/embed/" + videoId;
        iframe.classList.remove('hidden');
        placeholder.style.display = 'none';
    } else {
        // 올바른 형식이 아닐 경우
        iframe.classList.add('hidden');
        iframe.src = "";
        placeholder.style.display = 'flex';
    }
    document.getElementById('videoUrlInput').setAttribute('value', url);
}
</script>
</body></html>