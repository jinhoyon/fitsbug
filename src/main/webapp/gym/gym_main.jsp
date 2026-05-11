<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피츠버그 엘리트 피트니스 - 관리자 모드</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
                        "primary-container": "#3B82F6",
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
                        "DEFAULT": "8px",
                        "lg": "8px",
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
        .custom-scrollbar::-webkit-scrollbar {
    		width: 4px;
		}
		.custom-scrollbar::-webkit-scrollbar-track {
    		background: transparent;
		}
		.custom-scrollbar::-webkit-scrollbar-thumb {
    		background: #e1e2e4;
    		border-radius: 10px;
		}
		.custom-scrollbar::-webkit-scrollbar-thumb:hover {
    		background: #c2c6d6;
		}
		.modal-backdrop {
    		background: rgba(0, 0, 0, 0.85);
    		backdrop-filter: blur(12px);
		}
</style>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body class="bg-background font-body text-on-surface">
<jsp:include page="common/sidebar.jsp"></jsp:include>

<!-- Main Content Area -->
<main class="ml-64 pt-16 min-h-screen bg-surface">
<div class="p-6 space-y-6">
<!-- Hero Section -->
<section>
<div class="relative h-[240px] rounded-xl overflow-hidden shadow-sm">

    <!-- 배경 이미지 -->
    <img alt="Gym background"
     class="w-full h-full object-cover cursor-pointer"
     onclick="openSingleImage(this.src)"
     src="${pageContext.request.contextPath}/trainer/profile-img/${gym.backgroundImg}"
     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default-bg.png'"/>

    <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent pointer-events-none"></div>

    <div class="absolute bottom-6 left-6 flex items-end space-x-4">

        <!-- 프로필 로고 -->
        <div class="w-20 h-20 bg-surface-container-lowest rounded-xl p-1 shadow-lg overflow-hidden">
            <img class="w-full h-full object-cover rounded-lg cursor-pointer"
     			 onclick="openSingleImage(this.src)"
     			 src="${pageContext.request.contextPath}/trainer/profile-img/${user.profileImage}"
     			 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/uploads/profile_img.jpg'">
        </div>

        <!-- 텍스트 -->
        <div class="text-white pb-1">

            <h2 class="text-3xl font-black tracking-tight">
                ${gym.name}
                <c:if test="${not empty gym.brFile}">
    <span class="material-symbols-outlined text-primary align-middle ml-2"
          style='font-variation-settings: "FILL" 1; font-size: 24px;'>
        check_circle
    </span>
</c:if>
            </h2>

            <div class="flex items-center space-x-4 text-[11px] font-medium text-white/90">

                <span class="flex items-center">
                    <span class="material-symbols-outlined text-xs mr-1">call</span>
                    ${gym.phoneNum}
                </span>

                <span class="flex items-center">
                    <span class="material-symbols-outlined text-xs mr-1 text-yellow-400"
                          style='font-variation-settings: "FILL" 1;'>star</span>
                    ${gym.rating}(${gym.reviewCount}개 후기)
                </span>

            </div>

            <p class="text-[11px] font-medium text-white/90 mt-1">
                ${gym.description}
            </p>

        </div>
    </div>
</div>
</section>
<div class="grid grid-cols-12 gap-6 items-start">
<!-- Left Column -->
<div class="col-span-8 space-y-6">
<div class="grid grid-cols-2 gap-6">
<!-- Gallery -->
<c:if test="${not empty gym.file }">
	<c:set var="images" value="${fn:split(gym.file, ',')}" /> 
	
	<section class="bg-surface-container-lowest p-5 rounded-xl shadow-sm border border-outline-variant/15">
		<h3 class="text-sm font-bold tracking-tight mb-3">센터 갤러리</h3>
		
		<div class="grid grid-cols-2 gap-2">
			<c:forEach var="img" items="${images}" varStatus="status">
    <c:set var="imgName" value="${fn:trim(img)}" />

    <div onclick="openLightbox(${status.index})" class="aspect-video rounded-lg overflow-hidden border border-outline-variant/10">
        <img alt="센터 갤러리 이미지"
             class="w-full h-full object-cover"
             src="${pageContext.request.contextPath}/trainer/profile-img/${imgName}"
             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/uploads/default-bg.png'"/>
    </div>
</c:forEach>
		</div>
	</section>
</c:if>
<!-- Notice -->
<section class="bg-surface-container-lowest p-5 rounded-xl shadow-sm border border-outline-variant/15">
	<div class="flex justify-between items-center mb-3">
		<h3 class="text-sm font-bold tracking-tight">공지사항</h3>
		<a href="${pageContext.request.contextPath}/gym/notice?gymId=${gym.id}" class="text-[10px] font-bold text-primary">전체보기</a>
	</div>
	<div class="space-y-1.5">
		<c:choose>
			<c:when test="${not empty noticeList}">
				<c:forEach var="notice" items="${noticeList}">
					<a href="${pageContext.request.contextPath}/gym/noticeDetail?noticeId=${notice.id}"
					   class="flex justify-between items-center p-2 rounded hover:bg-surface-container-low transition-colors group cursor-pointer border-b border-outline-variant/5 last:border-0">
							<div class="flex items-center space-x-2">
								<span class="w-1.5 h-1.5 rounded-full bg-primary"></span>
								<span class="text-xs font-medium text-on-surface truncate max-w-[150px]">${notice.title}</span>
							</div>
							<span class="text-[10px] text-outline">${notice.createdAt}</span>
					</a>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="text-xs text-outline p-2">
                    등록된 공지사항이 없습니다.
                </div>
			</c:otherwise>
		</c:choose>
	</div>
</section>
</div>

<!-- Reviews -->
<section id="reviewSection" class="bg-surface-container-lowest p-6 rounded-xl shadow-sm border border-outline-variant/15 flex flex-col min-h-[420px]">
	<div class="flex justify-between items-center mb-4 flex-shrink-0">
		<h3 class="text-sm font-bold tracking-tight">리뷰 및 평점</h3>
		<div class="flex items-center space-x-2">
			<span class="text-lg font-black text-primary">${gym.rating}</span>
			<div class="flex text-yellow-400 scale-75 origin-right">
				<c:forEach begin="1" end="5" var="i">
					<c:choose>
						<c:when test="${i <= gym.rating}">
							<span class="material-symbols-outlined" style='font-variation-settings: "FILL" 1;'>star</span>
						</c:when>
						<c:otherwise>
							<span class="material-symbols-outlined" style='font-variation-settings: "FILL" 0;'>star</span>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>
	<!-- 리뷰 작성 영역 (여기 추가) -->
	<c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'MEMBER'}">
    	<div class="mb-6 p-4 bg-surface-container-low rounded-lg border border-outline-variant/10">
        
        	<!-- 별점 -->
        	<div id="writeStarBox" class="flex items-center space-x-1 text-yellow-400">
    <c:forEach begin="1" end="5" var="i">
        <span onclick="setStar(${i})"
              class="material-symbols-outlined write-star cursor-pointer"
              style='font-variation-settings: "FILL" 0;'>
            star
        </span>
    </c:forEach>
    <span class="text-[10px] ml-2 text-on-surface-variant">평점을 선택해주세요</span>
</div>

        	<!-- 내용 -->
        	<textarea id="reviewContent"
                  	  class="w-full mt-2 p-3 bg-white border rounded"
                  	  placeholder="리뷰를 작성해주세요"
                  	  rows="3"></textarea>

        	<!-- 버튼 -->
        	<div class="flex justify-end mt-2">
    <button type="button"
            onclick="submitReviewAjax()"
            class="bg-primary text-white px-4 py-2 rounded text-xs font-bold">
        리뷰 등록
    </button>
</div>
    	</div>
    	<form id="reviewForm" method="post" action="${pageContext.request.contextPath}/gym/reviewWrite">
    		<input type="hidden" name="gymId" value="${gym.id}">
   	 		<input type="hidden" name="star" id="reviewStarInput">
    		<input type="hidden" name="comment" id="reviewCommentInput">
		</form>
	</c:if>
<div id="reviewList" class="grid grid-cols-1 gap-4">
    <c:choose>
        <c:when test="${not empty reviewList}">
            <c:forEach var="review" items="${reviewList}">
                <div class="bg-surface-container-low p-4 rounded-lg">
                    <div class="flex justify-between items-start mb-2">
                        <div class="flex items-center space-x-2">
                            <div>
                                <div class="text-[11px] font-bold">${review.clientName}</div>
                                <div class="text-[9px] text-outline">${review.createdAt}</div>
                            </div>
                        </div>

                        <div class="flex items-center">
                            <div class="flex text-yellow-400 scale-75 origin-right mr-1">

    <!-- 채워진 별 -->
    <c:forEach begin="1" end="${review.rating}">
        <span class="material-symbols-outlined" style='font-variation-settings: "FILL" 1;'>star</span>
    </c:forEach>

    <!-- 빈 별 (안전 처리) -->
    <c:if test="${review.rating < 5}">
        <c:forEach begin="${review.rating + 1}" end="5">
            <span class="material-symbols-outlined" style='font-variation-settings: "FILL" 0;'>star</span>
        </c:forEach>
    </c:if>

</div>

                            <!-- 신고 버튼 -->
                            <c:if test="${(not empty sessionScope.loginUser 
              and sessionScope.loginUser.id != review.clientId)
             or not empty sessionScope.loginGym}">
                                <button class="text-outline hover:text-error ml-2"
                                        onclick="reportReview('${review.reviewNum}')">
                                    <span class="material-symbols-outlined text-sm">report</span>
                                </button>
                            </c:if>

                            <!-- 본인 리뷰 -->
                        
                            
                            
                        </div>
                    </div>

                    <p class="text-[11px] text-on-surface-variant leading-relaxed">
                        ${review.comment}
                    </p>
                    
                    <c:if test="${not empty sessionScope.loginUser 
          and sessionScope.loginUser.id == review.clientId}">

    <form method="post"
      action="${pageContext.request.contextPath}/gym/reviewUpdate"
      class="flex items-center gap-2 mt-3">

    <input type="hidden" name="reviewNum" value="${review.reviewNum}">
    <input type="hidden" name="gymId" value="${gym.id}">

    <input type="number"
           name="star"
           min="1"
           max="5"
           value="${review.rating.intValue()}"
           class="w-16 border rounded px-1 text-xs">

    <input type="text"
           name="comment"
           value="${review.comment}"
           class="border rounded px-2 py-1 text-xs flex-1">

    <button type="submit" class="text-primary">
        <span class="material-symbols-outlined text-sm">save</span>
    </button>
</form>

    <form method="post"
      action="${pageContext.request.contextPath}/gym/reviewDelete"
      class="inline-block mt-2"
      onsubmit="return confirm('삭제하시겠습니까?');">

    <input type="hidden" name="reviewNum" value="${review.reviewNum}">
    <input type="hidden" name="gymId" value="${gym.id}">

    <button type="submit" class="text-error">
        <span class="material-symbols-outlined text-sm">delete</span>
    </button>
</form>

</c:if>
                </div>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <div class="col-span-2 text-xs text-outline p-4 text-center">
                등록된 리뷰가 없습니다.
            </div>
        </c:otherwise>
    </c:choose>
</div>	
<button id="reviewMoreBtn"
        onclick="toggleAllReviews()"
        class="w-full mt-4 py-1.5 text-[10px] font-bold text-primary hover:bg-primary/5 rounded">
    리뷰 ${gym.reviewCount}개 모두 보기
</button>
<div id="allReviewBox" class="hidden mt-4 max-h-[500px] overflow-y-auto space-y-3 custom-scrollbar">
    <c:choose>
        <c:when test="${not empty allReviewList}">
            <c:forEach var="review" items="${allReviewList}" begin="${fn:length(reviewList)}">
                <div class="bg-surface-container-low p-4 rounded-lg">
                    <div class="flex justify-between items-start mb-2">
                        <div>
                            <div class="text-[11px] font-bold">${review.clientName}</div>
                            <div class="text-[9px] text-outline">${review.createdAt}</div>
                        </div>
						<div class="flex items-center">
                        <div class="flex text-yellow-400 scale-75 origin-right mr-1">

    <!-- 채워진 별 -->
    <c:forEach begin="1" end="${review.rating}">
        <span class="material-symbols-outlined" style='font-variation-settings: "FILL" 1;'>star</span>
    </c:forEach>

    <!-- 빈 별 (안전 처리) -->
    <c:if test="${review.rating < 5}">
        <c:forEach begin="${review.rating + 1}" end="5">
            <span class="material-symbols-outlined" style='font-variation-settings: "FILL" 0;'>star</span>
        </c:forEach>
    </c:if>

</div>
<c:if test="${(not empty sessionScope.loginUser 
              and sessionScope.loginUser.id != review.clientId)
             or not empty sessionScope.loginGym}">
        <button class="text-outline hover:text-error ml-2"
                onclick="reportReview('${review.reviewNum}')">
            <span class="material-symbols-outlined text-sm">report</span>
        </button>
    </c:if>
</div>
                    </div>

                    <p class="text-[11px] text-on-surface-variant leading-relaxed">
                        ${review.comment}
                    </p>
                    
                    <c:if test="${not empty sessionScope.loginUser 
          and sessionScope.loginUser.id == review.clientId}">

    <form method="post"
          action="${pageContext.request.contextPath}/gym/reviewUpdate"
          class="flex items-center gap-2 mt-3">

        <input type="hidden" name="reviewNum" value="${review.reviewNum}">
        <input type="hidden" name="gymId" value="${gym.id}">

        <input type="number"
               name="star"
               min="1"
               max="5"
               value="${review.rating.intValue()}"
               class="w-16 border rounded px-1 text-xs">

        <input type="text"
               name="comment"
               value="${review.comment}"
               class="border rounded px-2 py-1 text-xs flex-1">

        <button type="submit" class="text-primary">
            <span class="material-symbols-outlined text-sm">save</span>
        </button>
    </form>

    <form method="post"
          action="${pageContext.request.contextPath}/gym/reviewDelete"
          class="inline-block mt-2"
          onsubmit="return confirm('삭제하시겠습니까?');">

        <input type="hidden" name="reviewNum" value="${review.reviewNum}">
        <input type="hidden" name="gymId" value="${gym.id}">

        <button type="submit" class="text-error">
            <span class="material-symbols-outlined text-sm">delete</span>
        </button>
    </form>

</c:if>
                    

                </div>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <div class="text-xs text-outline p-4 text-center">
                등록된 리뷰가 없습니다.
            </div>
        </c:otherwise>
    </c:choose>
</div>
</section>

<!-- Membership -->
<section class="bg-surface-container-lowest p-5 rounded-xl shadow-sm border border-outline-variant/15">
	<h3 class="text-sm font-bold tracking-tight mb-4">멤버십 요금</h3>

		<div class="grid grid-cols-5 gap-3">
			<c:choose>
				<c:when test="${not empty membershipList}">
					<c:forEach var="m" items="${membershipList}">

    <div onclick="openPaymentModal('${m.membershipNum}', '${m.type}', '${m.typeRep}', '${m.price}')"
         class="p-3 rounded-lg bg-surface-container-low border border-outline-variant/10 cursor-pointer">

        <p class="text-[9px] font-bold text-on-surface-variant mb-1 uppercase tracking-widest">
            <c:choose>
                <c:when test="${m.type eq 'day'}">${m.typeRep} Day</c:when>
                <c:when test="${m.type eq 'month' and m.typeRep == 12}">Annual</c:when>
                <c:when test="${m.type eq 'month'}">${m.typeRep} Months</c:when>
                <c:when test="${m.type eq 'pt'}">PT ${m.typeRep}회</c:when>
            </c:choose>
        </p>

        <p class="text-base font-black tracking-tighter mb-1">
            ₩<fmt:formatNumber value="${m.price}" pattern="#,###"/>
        </p>

        <p class="text-[9px] text-outline">
            <c:choose>
                <c:when test="${m.type eq 'day'}">1회 이용권</c:when>
                <c:when test="${m.type eq 'month'}">정기 이용권</c:when>
                <c:when test="${m.type eq 'pt'}">PT 이용권</c:when>
            </c:choose>
        </p>

    </div>

</c:forEach>			
				</c:when>
				<c:otherwise>
					<div class="col-span-5 text-xs text-outline p-4 text-center">
                    	등록된 멤버십 정보가 없습니다.
                	</div>
				</c:otherwise>
			</c:choose>
		</div>
</section>			
</div>
<!-- Right Column -->
<div class="col-span-4 space-y-6">
<!-- Facility & Hours -->
<div class="bg-surface-container-lowest p-5 rounded-xl shadow-sm border border-outline-variant/15">
<h4 class="text-[10px] font-bold text-on-surface-variant mb-4 uppercase tracking-widest">시설 정보</h4>
<div class="grid grid-cols-2 gap-2 mb-6">

    <c:if test="${fn:contains(gym.facility, '개인락커')}">
        <div class="flex items-center p-2 rounded bg-surface-container-low">
            <span class="material-symbols-outlined text-primary text-lg mr-2">lock</span>
            <span class="text-[10px] font-semibold">락커</span>
        </div>
    </c:if>

    <c:if test="${fn:contains(gym.facility, '샤워실')}">
        <div class="flex items-center p-2 rounded bg-surface-container-low">
            <span class="material-symbols-outlined text-primary text-lg mr-2">shower</span>
            <span class="text-[10px] font-semibold">샤워실</span>
        </div>
    </c:if>

    <c:if test="${fn:contains(gym.facility, '주차장')}">
        <div class="flex items-center p-2 rounded bg-surface-container-low">
            <span class="material-symbols-outlined text-primary text-lg mr-2">local_parking</span>
            <span class="text-[10px] font-semibold">주차</span>
        </div>
    </c:if>

    <c:if test="${fn:contains(gym.facility, '운동복')}">
        <div class="flex items-center p-2 rounded bg-surface-container-low">
            <span class="material-symbols-outlined text-primary text-lg mr-2">apparel</span>
            <span class="text-[10px] font-semibold">운동복</span>
        </div>
    </c:if>

</div>
<div class="pt-4 border-t border-outline-variant/10">
	<h4 class="text-[10px] font-bold text-on-surface-variant mb-3 uppercase tracking-widest">운영 시간</h4>
	<div class="space-y-2 text-[10px]">
		<div class="flex justify-between border-b border-outline-variant/5 pb-1">
			<span>평일 (월-금)</span>
			<span class="font-bold">${schedule.availableWeekdayStart} - ${schedule.availableWeekdayEnd}</span>
		</div>
		<div class="flex justify-between border-b border-outline-variant/5 pb-1">
			<span>토·일·공휴일</span>
			<span class="font-bold">${schedule.availableWeekendStart} - ${schedule.availableWeekendEnd}</span>
		</div>
	</div>
</div>
</div>

<!-- Trainer -->
<div class="bg-surface-container-lowest p-5 rounded-xl shadow-sm border border-outline-variant/15">
	<div class="flex justify-between items-center mb-4">
		<h4 class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest">트레이너</h4>
		<span class="bg-secondary-container text-on-secondary-container px-1.5 py-0.5 rounded text-[8px] font-bold">${trainerCount}명</span>
	</div>
	<div class="flex -space-x-2 mb-4">
		<c:choose>
			<c:when test="${not empty trainerList}">
				<c:forEach var="trainer" items="${trainerList}" begin="0" end="2">
					<img class="w-8 h-8 rounded-full border-2 border-white object-cover" 
						 src="${pageContext.request.contextPath}/gym/trainerProfileImgs/${trainer.profileImg}"
						 alt="${trainer.name}"/>
				</c:forEach>
				<c:if test="${trainerCount > 3}">
					<div class="w-8 h-8 rounded-full border-2 border-white bg-surface-container flex items-center justify-center text-[8px] font-bold text-on-surface-variant">
						+${trainerCount - 3}
					</div>
				</c:if>
			</c:when>
			<c:otherwise>
                <div class="text-[10px] text-outline">
                    등록된 트레이너가 없습니다.
                </div>
            </c:otherwise>
		</c:choose>
	</div>

<button onclick="openTrainerModal()" 
		class="w-full bg-surface-container-low text-on-surface py-2 rounded font-bold text-[10px] hover:bg-surface-container transition-colors">
			트레이너 보기
</button>
</div>

<!-- Map -->
<div class="bg-surface-container-lowest p-5 rounded-xl shadow-sm border border-outline-variant/15" >
<div class="flex items-center text-[10px] font-bold text-on-surface mb-2">
<span class="material-symbols-outlined text-primary mr-1 text-lg">location_on</span>
                        ${gym.address}
                    </div>
<div class="h-40 rounded-lg bg-surface-container-high overflow-hidden relative">
<div id="map" class="w-full h-full"></div>
<div class="absolute inset-0 flex items-center justify-center">
<span class="material-symbols-outlined text-primary text-2xl" style='font-variation-settings: "FILL" 1;'>location_on</span>
</div>
</div>
</div>

</div>
</div>
</div>

</main>
<div id="lightbox-modal" style="display:none;"
     class="fixed inset-0 z-[100] flex items-center justify-center p-4 modal-backdrop">

  <!-- 닫기 버튼 -->
  <button onclick="closeLightbox()"
          class="absolute top-6 right-6 text-white text-4xl">✕</button>
  
  <button id="prevBtn" onclick="prevImage()" class="absolute left-6 top-1/2 -translate-y-1/2 text-white text-4xl">❮</button>

  <!-- 이미지 -->
  <img id="lightbox-img" class="max-w-full max-h-[80vh] object-contain rounded-lg shadow-2xl">
  
  <button id="nextBtn" onclick="nextImage()" class="absolute top-1/2 right-6 -translate-y-1/2 text-white text-4xl">❯</button>
</div>

<c:if test="${not empty gym.file}">
<script>

const galleryImages =[
	<c:forEach var="img" items="${images}" varStatus="status">
	"${pageContext.request.contextPath}/trainer/profile-img/${img}"<c:if test="${!status.last}">,</c:if>
	</c:forEach>
];

let currentIndex = 0;

function openLightbox(index) {
	currentIndex = index;
    document.getElementById("lightbox-modal").style.display = "flex";
    document.getElementById("lightbox-img").src = galleryImages[currentIndex];
    document.getElementById("prevBtn").style.display = "block";
    document.getElementById("nextBtn").style.display = "block";
}

function closeLightbox() {
    document.getElementById("lightbox-modal").style.display = "none";
    document.getElementById("lightbox-img").src = "";
}

function nextImage(){
	currentIndex++;
	if(currentIndex >= galleryImages.length) currentIndex = 0;
	document.getElementById("lightbox-img").src = galleryImages[currentIndex];
}

function prevImage(){
	currentIndex--;
	if(currentIndex < 0) currentIndex = galleryImages.length - 1;
	document.getElementById("lightbox-img").src = galleryImages[currentIndex];
}
</script>
</c:if>


<!-- Modal Backdrop -->
<div id="trainerModal" style="display: none;" class="fixed inset-0 bg-[#191c1e]/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
	<!-- Modal Card - Reduced max-width and optimized padding -->
	<div class="bg-surface-container-lowest w-full max-w-md rounded-lg shadow-2xl overflow-hidden flex flex-col max-h-[80vh]">
		<!-- Modal Header - Reduced vertical padding -->
		<div class="flex items-center justify-between px-5 py-3 border-b border-outline-variant/15">
			<div class="flex items-center gap-2">
				<span class="material-symbols-outlined text-primary text-xl" data-icon="groups">groups</span>
				<h2 class="text-lg font-bold tracking-tight text-on-surface">트레이너 목록</h2>
			</div>
			<button onclick="closeTrainerModal()" class="p-1.5 hover:bg-surface-container-low rounded-full transition-colors group">
				<span class="material-symbols-outlined text-on-surface-variant group-hover:text-on-surface text-xl" data-icon="close">close</span>
			</button>
		</div>

		<!-- Modal Content (Scrollable List) -->
		<div class="flex-1 overflow-y-auto custom-scrollbar">
			<c:choose>
				<c:when test="${not empty trainerList}">
					<c:forEach var="trainer" items="${trainerList}" varStatus="status">
						<!-- Trainer Item 1 - Reduced padding, smaller image -->
						<div class="flex items-center gap-4 p-4 hover:bg-surface-container-low/50 transition-colors cursor-pointer group">
							<div class="relative shrink-0">
								<img class="w-12 h-12 rounded-full object-cover border-2 border-primary-container/20 group-hover:border-primary transition-colors" 
     								 alt="${trainer.name}" 
     								 src="${pageContext.request.contextPath}/gym/trainerProfileImgs/${trainer.profileImg}"
     								 onerror="this.src='${pageContext.request.contextPath}/uploads/profile_img.jpg'"/>
							</div>
							<div class="flex-1 min-w-0">
								<div class="flex justify-between items-baseline mb-0.5">
									<h3 class="font-bold text-base text-on-surface truncate">
    <a href="${pageContext.request.contextPath}/member/trainerDetail?trainerId=${trainer.trainerId}"
       class="text-primary group-hover:underline hover:text-primary-container transition-colors">
        ${trainer.name}
    </a>
</h3>
									<p class="text-[10px] font-semibold text-primary uppercase tracking-wider shrink-0">${trainer.mainSpecial}</p>
								</div>
								<div class="flex flex-wrap gap-1.5 mt-1">
									<c:forEach var="tag" items="${trainer.advList}">
										<span class="px-1.5 py-0.5 rounded text-[9px] font-medium bg-secondary-container/30 text-on-secondary-container">
											${tag}
										</span>
									</c:forEach>
								</div>
							</div>
						</div>
						<c:if test="${!status.last}">
							<div class="h-px bg-outline-variant/10 mx-4"></div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
    				<div class="p-4 text-sm text-outline text-center">
        				등록된 트레이너가 없습니다.
    				</div>
			</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<script>
function openTrainerModal() {
    document.getElementById("trainerModal").style.display = "flex";
}

function closeTrainerModal() {
    document.getElementById("trainerModal").style.display = "none";
}
</script>

<script>
function reportReview(reviewNum) {
    location.href =  '${pageContext.request.contextPath}/member/support?reviewNum=' + reviewNum;
}
</script>

<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c23c434dad386bee2955934ab6cb494d&libraries=services"></script>
<script>
    var gymName = "${gym.name}";
    var gymAddress = "${gym.address}";

    var mapContainer = document.getElementById('map');
    var mapOption = {
        center: new kakao.maps.LatLng(37.5665, 126.9780),
        level: 3
    };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch(gymAddress, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var x = result[0].x;
            var y = result[0].y;
            var coords = new kakao.maps.LatLng(y, x);

            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            map.setCenter(coords);
        }
    });
</script>

<script>
let selectedStar = 0;

function setStar(star) {
    selectedStar = star;

    const stars = document.querySelectorAll("#writeStarBox .write-star");

    stars.forEach((el, index) => {
        if (index < star) {
            el.style.fontVariationSettings = "'FILL' 1";
        } else {
            el.style.fontVariationSettings = "'FILL' 0";
        }
    });
}

function submitReviewAjax() {
    const content = document.getElementById("reviewContent").value.trim();
    const gymId = document.querySelector("#reviewForm input[name='gymId']").value;

    if (selectedStar === 0) {
        alert("별점을 선택하세요");
        return;
    }

    if (content === "") {
        alert("내용 입력하세요");
        return;
    }

    fetch("${pageContext.request.contextPath}/gym/reviewWrite", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        },
        body:
            "gymId=" + encodeURIComponent(gymId) +
            "&star=" + encodeURIComponent(selectedStar) +
            "&comment=" + encodeURIComponent(content) +
            "&ajax=true"
    })
    .then(res => res.text())
    .then(result => {
        if (result.trim() === "success") {
            location.reload();
        } else {
            alert(result);
        }
    })
    .catch(err => {
        console.error(err);
        alert("리뷰 등록 중 오류가 발생했습니다.");
    });
}

</script>

<!-- Payment Modal -->
<div id="paymentModal" style="display:none;"
     class="fixed inset-0 z-[200] flex items-center justify-center bg-black/20 backdrop-blur-sm p-4">

    <div class="flex flex-row max-w-5xl w-full h-[600px] shadow-2xl overflow-hidden rounded-lg">

        <!-- Side Navigation -->
        <aside class="hidden md:flex flex-col w-64 h-full py-8 px-4 bg-slate-50 border-r border-outline-variant/10">
            <div class="mb-10 px-4">
                <h2 class="text-xl font-black text-primary mb-1">멤버십 결제</h2>
            </div>

            <nav class="flex flex-col gap-2">
                <div id="stepNav1" class="flex items-center gap-3 px-4 py-3 rounded-lg text-primary border-r-2 border-primary bg-primary/5 font-medium">
                    <span class="material-symbols-outlined">assignment</span>
                    <span class="text-sm">멤버십</span>
                </div>

                <div id="stepNav2" class="flex items-center gap-3 px-4 py-3 rounded-lg text-slate-400">
                    <span class="material-symbols-outlined">calendar_today</span>
                    <span class="text-sm">시작일</span>
                </div>

                <div id="stepNav3" class="flex items-center gap-3 px-4 py-3 rounded-lg text-slate-400">
                    <span class="material-symbols-outlined">payments</span>
                    <span class="text-sm">결제</span>
                </div>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 flex flex-col bg-surface-container-lowest">

            <!-- Step 1: Membership -->
            <section id="paymentStep1" class="flex-1 flex flex-col">
                <header class="flex justify-between items-center px-8 py-6">
                    <div>
                        <p class="text-[0.6875rem] font-medium uppercase tracking-widest text-primary mb-1">1/3 단계</p>
                        <h2 class="text-xl font-bold">멤버십 플랜 확인</h2>
                    </div>
                    <button onclick="closePaymentModal()" class="p-2 hover:bg-surface-container-low rounded-full">
                        <span class="material-symbols-outlined text-on-surface-variant">close</span>
                    </button>
                </header>

                <div class="flex-1 px-8 overflow-y-auto">
                    <div class="p-6 rounded-xl bg-surface-container-low border border-outline-variant/15">
                        <p class="text-xs text-on-surface-variant mb-2">선택한 멤버십</p>
                        <h3 id="selectedMembershipName" class="text-xl font-black mb-2">-</h3>
                        <p id="selectedMembershipPrice" class="text-2xl font-black text-primary">-</p>
                    </div>
                </div>

                <footer class="p-8 flex items-center justify-between border-t border-outline-variant/5">
                    <button onclick="closePaymentModal()" class="text-sm font-medium text-on-surface-variant">
                        취소
                    </button>
                    <button onclick="goPaymentStep(2)" class="px-10 py-3.5 rounded-lg bg-primary text-white font-bold text-sm">
                        다음 단계로
                    </button>
                </footer>
            </section>

            <!-- Step 2: Start Date -->
            <section id="paymentStep2" class="hidden flex-1 flex-col">
                <header class="flex justify-between items-center px-8 py-6">
                    <div>
                        <p class="text-[0.6875rem] font-medium uppercase tracking-widest text-on-surface-variant mb-1">2/3 단계</p>
                        <h2 class="text-xl font-bold">이용 시작일 선택</h2>
                    </div>
                    <button onclick="closePaymentModal()" class="p-2 hover:bg-surface-container-low rounded-full">
                        <span class="material-symbols-outlined text-on-surface-variant">close</span>
                    </button>
                </header>

                <div class="flex-1 px-8 overflow-y-auto">
                    <div class="bg-primary/5 rounded-lg p-4 mb-6 flex gap-3 items-start border border-primary/10">
                        <span class="material-symbols-outlined text-primary text-xl">info</span>
                        <p class="text-sm text-on-surface-variant">
    						혼잡 시간대 안내:
    						<c:choose>
        						<c:when test="${not empty todayHotTime}">
            						<span class="font-semibold text-primary">
                						${todayHotTime.hour}:00 - ${todayHotTime.hour + 1}:00
            						</span>
            						사이가 가장 붐비는 시간입니다.
        						</c:when>
        						<c:otherwise>
            						<span class="font-semibold text-primary">혼잡 데이터가 없습니다.</span>
        						</c:otherwise>
    						</c:choose>
						</p>
                    </div>

                    <label class="block text-sm font-bold mb-2">시작일</label>
                    <input id="membershipStartDate"
                           type="date"
                           class="w-full rounded-lg border-outline-variant text-sm"
                           onchange="setStartDate(this.value)"/>

                    <div class="p-4 rounded-xl bg-surface-container-low mt-6">
                        <div class="flex justify-between items-center">
                            <span class="text-sm font-medium text-on-surface-variant">선택된 날짜</span>
                            <span id="selectedStartDateText" class="text-sm font-bold text-primary">선택 전</span>
                        </div>
                    </div>
                </div>

                <footer class="p-8 flex gap-3">
                    <button onclick="goPaymentStep(1)" class="flex-1 px-6 py-3.5 rounded-lg bg-surface-container-high text-on-surface-variant font-semibold">
                        이전
                    </button>
                    <button onclick="goPaymentStep(3)" class="flex-[2] px-6 py-3.5 rounded-lg bg-primary text-white font-semibold">
                        다음 단계로
                    </button>
                </footer>
            </section>

            <!-- Step 3: Payment -->
            <section id="paymentStep3" class="hidden flex-1 flex-col">
                <header class="flex justify-between items-center px-8 py-6">
                    <div>
                        <p class="text-[0.6875rem] font-medium uppercase tracking-widest text-on-surface-variant mb-1">3/3 단계</p>
                        <h2 class="text-xl font-bold">최종 확인 및 결제</h2>
                    </div>
                    <button onclick="closePaymentModal()" class="p-2 hover:bg-surface-container-low rounded-full">
                        <span class="material-symbols-outlined text-on-surface-variant">close</span>
                    </button>
                </header>

                <div class="flex-1 px-8 overflow-y-auto">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 pb-6">

                        <div class="space-y-4">
                            <div class="p-4 rounded-xl bg-surface-container-low">
                                <p class="text-xs text-on-surface-variant">선택한 멤버십</p>
                                <p id="finalMembershipName" class="text-sm font-bold">-</p>
                            </div>

                            <div class="p-4 rounded-xl bg-surface-container-low">
                                <p class="text-xs text-on-surface-variant">이용 시작일</p>
                                <p id="finalStartDate" class="text-sm font-bold">-</p>
                            </div>
                        </div>

                        <div class="p-6 rounded-xl bg-slate-900 text-white shadow-lg">
                            <p class="text-xs font-medium text-slate-400 mb-1">Billing Summary</p>

                            <div class="flex items-baseline gap-1 mt-4">
                                <span class="text-sm font-medium">₩</span>
                                <span id="finalPrice" class="text-3xl font-black tracking-tight">0</span>
                            </div>

                            <div class="mt-6 space-y-2 pt-4 border-t border-white/10">
                                <div class="flex justify-between text-xs text-slate-400">
                                    <span>상품 금액</span>
                                    <span id="basePrice">₩0</span>
                                </div>
                                <div class="flex justify-between text-base font-bold text-white mt-2 pt-2 border-t border-white/20">
                                    <span>최종 결제 금액</span>
                                    <span id="totalPrice" class="text-blue-400">₩0</span>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <footer class="p-8 flex gap-3">
                    <button onclick="goPaymentStep(2)" class="flex-1 px-6 py-3.5 rounded-lg bg-surface-container-high text-on-surface-variant font-semibold">
                        이전
                    </button>
                    <button type="button" onclick="submitPayment(event)" class="flex-[2] px-6 py-3.5 rounded-lg bg-primary text-white font-semibold flex items-center justify-center gap-2">
                        결제하기
                        <span class="material-symbols-outlined text-lg">contactless</span>
                    </button>
                </footer>
            </section>

        </main>
    </div>
</div>
<script>
let paymentName = "";
let selectedMembership = {
    id: null,
    type: null,
    typeRep: null,
    price: null,
    startDate: null
};

function openPaymentModal(id, type, typeRep, price) {
    selectedMembership.id = id;
    selectedMembership.type = type;
    selectedMembership.typeRep = typeRep;
    selectedMembership.price = price;

    

    if (selectedMembership.type === "month") {
        paymentName = selectedMembership.typeRep + "개월 이용권";
    } else if (selectedMembership.type === "day") {
        paymentName = selectedMembership.typeRep + "일 이용권";
    } else if (selectedMembership.type === "pt") {
        paymentName = "PT " + selectedMembership.typeRep + "회 이용권";
    }

    document.getElementById("selectedMembershipName").innerText = paymentName;
    document.getElementById("selectedMembershipPrice").innerText = "₩" + Number(price).toLocaleString();

    document.getElementById("finalMembershipName").innerText = paymentName;
    document.getElementById("finalPrice").innerText = Number(price).toLocaleString();
    document.getElementById("basePrice").innerText = "₩" + Number(price).toLocaleString();
    document.getElementById("totalPrice").innerText = "₩" + Number(price).toLocaleString();

    document.getElementById("paymentModal").style.display = "flex";
    goPaymentStep(1);
}

function closePaymentModal() {
    document.getElementById("paymentModal").style.display = "none";
}

function goPaymentStep(step) {
    document.getElementById("paymentStep1").classList.add("hidden");
    document.getElementById("paymentStep2").classList.add("hidden");
    document.getElementById("paymentStep3").classList.add("hidden");

    document.getElementById("paymentStep" + step).classList.remove("hidden");

    document.getElementById("stepNav1").className = "flex items-center gap-3 px-4 py-3 rounded-lg text-slate-400";
    document.getElementById("stepNav2").className = "flex items-center gap-3 px-4 py-3 rounded-lg text-slate-400";
    document.getElementById("stepNav3").className = "flex items-center gap-3 px-4 py-3 rounded-lg text-slate-400";

    document.getElementById("stepNav" + step).className =
        "flex items-center gap-3 px-4 py-3 rounded-lg text-primary border-r-2 border-primary bg-primary/5 font-medium";
}

function setStartDate(date) {
    selectedMembership.startDate = date;

    document.getElementById("selectedStartDateText").innerText = date;
    document.getElementById("finalStartDate").innerText = date;
}

function submitPayment(event) {
    if (event) {
        event.preventDefault();
        event.stopPropagation();
    }

    if (!selectedMembership.startDate) {
        alert("이용 시작일을 선택하세요.");
        goPaymentStep(2);
        return false;
    }

    const IMP = window.IMP;
    IMP.init("imp77425055");

    IMP.request_pay({
        channelKey: "channel-key-f10a8ff7-975c-4b31-8166-11d080e4eb4e",
        pay_method: "card",
        merchant_uid: "gym_" + new Date().getTime(),
        name: paymentName,
        amount: Number(selectedMembership.price),
        buyer_email: "test@test.com",
        buyer_name: "테스트회원",
        buyer_tel: "010-0000-0000"
    }, function (rsp) {
        if (rsp.success) {

        	fetch("${pageContext.request.contextPath}/gym/tossPayment", {
        	    method: "POST",
        	    headers: {
        	        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
        	    },
        	    body:
        	        "paymentKey=" + encodeURIComponent(rsp.imp_uid) +
        	        "&orderId=" + encodeURIComponent(rsp.merchant_uid) +
        	        "&amount=" + encodeURIComponent(parseInt(selectedMembership.price)) +
        	        "&status=" + encodeURIComponent("DONE") +
        	        "&membershipNum=" + encodeURIComponent(selectedMembership.id) +
        	        "&startDate=" + encodeURIComponent(selectedMembership.startDate)
        	})
        	.then(res => res.text())
        	.then(text => {
        	    console.log("서버 응답:", text);

        	    const data = JSON.parse(text);

        	    if (data.success) {
        	        alert("결제가 완료되었습니다.");
        	        closePaymentModal();
        	        location.reload();
        	    } else {
        	        alert(data.message);
        	    }
        	})
        	.catch(err => {
        	    console.error(err);
        	    alert("결제 저장 중 오류가 발생했습니다.");
        	});

        } else {
            alert("결제 실패: " + rsp.error_msg);
        }
    });

    return false;
}
</script>

<script>
function toggleAllReviews() {
    const box = document.getElementById("allReviewBox");
    const btn = document.getElementById("reviewMoreBtn");

    box.classList.toggle("hidden");

    if (box.classList.contains("hidden")) {
        btn.innerText = "리뷰 ${gym.reviewCount}개 모두 보기";
    } else {
        btn.innerText = "리뷰 접기";
    }
}

function openSingleImage(src) {

    document.getElementById("prevBtn").style.display = "none";
    document.getElementById("nextBtn").style.display = "none";

    document.getElementById("lightbox-modal").style.display = "flex";
    document.getElementById("lightbox-img").src = src;
}
</script>
</body>
</html>