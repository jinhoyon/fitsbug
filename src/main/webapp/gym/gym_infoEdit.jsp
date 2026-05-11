<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보수정 | Fitsbug ADMIN</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
tailwind.config = {
	    darkMode: "class",
	    theme: {
	        extend: {
	            colors: {
	                "background": "#f8f9fb",
	                "surface-container-lowest": "#ffffff",
	                "surface-container-low": "#f3f4f6",
	                "surface-container": "#edeef0",
	                "outline-variant": "#c2c6d6",
	                "on-surface": "#191c1e",
	                "on-surface-variant": "#424754",
	                "primary": "#3B82F6",
	                "primary-fixed": "#d8e2ff",
	                "secondary-container": "#b6ccff",
	                "on-secondary-container": "#405682",
	                "error": "#ba1a1a"
	            },
	            borderRadius: {
	                DEFAULT: "0.5rem",
	                lg: "0.5rem",
	                xl: "1.5rem",
	                full: "9999px"
	            },
	            fontFamily: {
	                body: ["Inter"]
	            }
	        }
	    }
	}
	</script>

	<style>
	.material-symbols-outlined {
	    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
	    vertical-align: middle;
	}
	.glass-nav {
	    background: rgba(255,255,255,0.8);
	    backdrop-filter: blur(20px);
	}
	.tonal-depth {
	    box-shadow: 0 2px 12px -2px rgba(0,0,0,0.05);
	}
	.toggle-checkbox:checked + .toggle-label {
	    background-color: #3B82F6;
	}
	.toggle-checkbox:checked + .toggle-label::after {
	    transform: translateX(100%);
	}
	.toggle-label::after {
	    content: '';
	    position: absolute;
	    top: 0.125rem;
	    left: 0.125rem;
	    background: white;
	    width: 0.625rem;
	    height: 0.625rem;
	    border-radius: 9999px;
	    transition: transform 0.2s;
	}
	</style>
</head>
<body class="bg-background font-body text-on-surface antialiased">
<jsp:include page="common/sidebar.jsp"></jsp:include>

<form id="mypageForm"
      action="${pageContext.request.contextPath}/gym/infoUpdate"
      method="post"
      enctype="multipart/form-data">

<input type="hidden" id="gymId" name="gymId" value="${gym.id}">
<input type="hidden" id="postcode" name="postcode" value="${gym.postcode}">
<input type="hidden" id="latitude" name="latitude" value="${gym.latitude}">
<input type="hidden" id="longitude" name="longitude" value="${gym.longitude}">
<input type="hidden" id="deleteGallery" name="deleteGallery" value="">

<main class="ml-64 pt-20 pb-8 px-6 min-h-screen">
    <header class="mb-5 flex justify-between items-end">
        <div>
            <h2 class="text-2xl font-extrabold tracking-tight">정보수정</h2>
        </div>

        <button type="submit" class="flex items-center gap-2 px-5 py-2 bg-primary text-white text-xs font-bold rounded-lg shadow">
            <span class="material-symbols-outlined text-base">save</span>
            설정 저장
        </button>
    </header>

    <div class="grid grid-cols-12 gap-4">

        <div class="col-span-12 lg:col-span-8 grid grid-cols-1 md:grid-cols-2 gap-4 h-fit">

            <!-- 계정 설정 -->
            <section class="bg-surface-container-lowest p-5 rounded-lg tonal-depth">
                <div class="flex items-center gap-2 mb-4">
                    <div class="p-1.5 rounded bg-primary/10 text-primary">
                        <span class="material-symbols-outlined text-lg">manage_accounts</span>
                    </div>
                    <h3 class="text-base font-bold">계정 설정</h3>
                </div>

                <div class="space-y-3">
                    <div>
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">로그인 ID</label>
                        <div class="flex gap-1.5">
                            <input id="emailId"
                                   name="emailId"
                                   class="flex-1 bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                                   type="email"
                                   value="${user.email}"
                                   placeholder="example@email.com"/>

                            <button type="button"
                                    onclick="checkEmailDuplicate()"
                                    class="px-2.5 py-1.5 bg-primary text-white text-[10px] font-bold rounded-lg">
                                확인
                            </button>
                        </div>
                        <p id="emailCheckMsg" class="text-[10px] mt-1"></p>
                    </div>

                    <div>
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">비밀번호</label>
                        <div class="flex gap-1.5">
                            <input id="newPassword"
                                   name="newPassword"
                                   class="flex-1 bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                                   type="password"
                                   placeholder="새 비밀번호 입력"/>

                            <button type="button"
                                    onclick="changePassword()"
                                    class="px-2.5 py-1.5 bg-secondary-container text-on-secondary-container text-[10px] font-bold rounded-lg">
                                변경
                            </button>
                        </div>
                        <p id="passwordMsg" class="hidden text-[10px] text-primary mt-1">비밀번호가 변경되었습니다.</p>
                    </div>

                    <div>
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">대표자 이름</label>
                        <input name="userName"
                               class="w-full bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                               type="text"
                               value="${user.name}"/>
                    </div>

                    <div>
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">대표자 전화번호</label>
                        <input name="tel"
                               class="w-full bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                               type="tel"
                               value="${user.phone}"
                               placeholder="010-0000-0000"/>
                    </div>
                </div>
            </section>

            <!-- 센터 갤러리 -->
            <section class="bg-surface-container-lowest p-5 rounded-lg tonal-depth">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center gap-2">
                        <div class="p-1.5 rounded bg-primary/10 text-primary">
                            <span class="material-symbols-outlined text-lg">branding_watermark</span>
                        </div>
                        <h3 class="text-base font-bold">센터 갤러리</h3>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-3 mb-4">
                    <div class="flex flex-col items-center gap-1.5">
                        <div class="relative">
                            <div class="w-14 h-14 rounded-full overflow-hidden ring-2 ring-primary-fixed border-2 border-white shadow-sm">
                                <img id="profileMainPreview"
                                	 class="w-full h-full object-cover"
                                     src="${pageContext.request.contextPath}/trainer/profile-img/${user.profileImage}"
 									 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/profile_img.jpg'">
                            </div>
                            <button type="button" onclick="openModal('profileModal')"
        							class="absolute -bottom-0.5 -right-0.5 p-1 bg-primary text-white rounded-full shadow cursor-pointer">
    							<span class="material-symbols-outlined text-[10px]">photo_camera</span>
							</button>
                        </div>
                        <span class="text-[9px] font-bold text-on-surface-variant">프로필 로고</span>
                    </div>

                    <div class="flex flex-col items-center gap-1.5">
                        <div class="relative">
                            <div class="w-20 h-14 rounded overflow-hidden ring-2 ring-primary-fixed border-2 border-white shadow-sm bg-slate-200">
                                <img id="backgroundMainPreview"
                                	 class="w-full h-full object-cover"
     								 src="${pageContext.request.contextPath}/trainer/profile-img/${gym.backgroundImg}"
 									 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default-bg.png'">
                            </div>
                            <button type="button" onclick="openModal('backgroundModal')"
        							class="absolute -bottom-0.5 -right-0.5 p-1 bg-primary text-white rounded-full shadow cursor-pointer">
    							<span class="material-symbols-outlined text-[10px]">photo_camera</span>
							</button>
                        </div>
                        <span class="text-[9px] font-bold text-on-surface-variant">배경 사진</span>
                    </div>
                </div>

<button type="button"
        onclick="openModal('galleryModal')"
        class="mt-2 inline-flex items-center gap-1 px-2 py-1 bg-primary text-white rounded-full shadow text-[10px] font-bold">
    <span class="material-symbols-outlined text-[12px]">photo_camera</span>
    갤러리 수정
</button>	 
				
                <div id="galleryMainPreview" class="grid grid-cols-4 gap-2">
                    <c:set var="images" value="${fn:split(gym.file, ',')}" />
<c:forEach var="img" items="${images}">
    <c:if test="${not empty img}">
        <div class="aspect-square rounded overflow-hidden bg-slate-100 relative" data-file="${img}">
            <img id="galleryMainPreview"
            	 class="w-full h-full object-cover"
                 src="${pageContext.request.contextPath}/trainer/profile-img/${img}"
                 onerror="this.parentElement.remove();">
        </div>
    </c:if>
</c:forEach>

                </div>
            </section>

            <!-- 센터 정보 -->
            <section class="md:col-span-2 bg-surface-container-lowest p-5 rounded-lg tonal-depth">
                <div class="flex items-center gap-2 mb-4">
                    <div class="p-1.5 rounded bg-primary/10 text-primary">
                        <span class="material-symbols-outlined text-lg">home_work</span>
                    </div>
                    <h3 class="text-base font-bold">센터 정보 설정</h3>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-x-4 gap-y-3">
                    <div>
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">센터 명칭</label>
                        <input name="gymName"
                               class="w-full bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                               type="text"
                               value="${gym.name}"/>
                    </div>

                    <div>
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">대표 연락처</label>
                        <input name="phoneNum"
                               class="w-full bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                               type="text"
                               value="${gym.phoneNum}"/>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">센터 한줄 소개</label>
                        <input name="description"
                               class="w-full bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                               type="text"
                               value="${gym.description}"/>
                    </div>

                    <div class="md:col-span-2">
                        <label class="block text-[10px] font-bold text-on-surface-variant uppercase mb-1">위치 정보</label>
                        <div class="flex gap-1.5 mb-1.5">
                            <input id="address"
                                   name="address"
                                   class="flex-1 bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                                   type="text"
                                   value="${gym.address}"
                                   readonly/>

                            <button type="button"
                                    onclick="openKakaoAddress()"
                                    class="px-3 py-1.5 bg-secondary-container text-on-secondary-container text-[10px] font-bold rounded-lg flex items-center gap-1">
                                <span class="material-symbols-outlined text-xs">search</span>
                                주소 검색
                            </button>
                        </div>

                        <input name="addressDetail"
                               class="w-full bg-surface-container-low border-0 rounded-lg px-3 py-1.5 text-sm"
                               placeholder="상세 주소 입력"
                               type="text"
                               value="${gym.addressDetail}"/>
                    </div>
                </div>
            </section>

            <!-- 사업자 등록증 -->
            <section class="md:col-span-2 bg-surface-container-lowest p-5 rounded-lg tonal-depth">
                <div class="flex items-center gap-2 mb-4">
                    <div class="p-1.5 rounded bg-primary/10 text-primary">
                        <span class="material-symbols-outlined text-lg">description</span>
                    </div>
                    <h3 class="text-base font-bold">사업자 등록증 관리</h3>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <button type="button" onclick="openModal('businessModal')"
        					class="border border-dashed border-outline-variant rounded-lg p-3 flex flex-col items-center justify-center bg-surface-container-low/30 hover:bg-surface-container-low cursor-pointer">
    					<span class="material-symbols-outlined text-xl text-outline-variant mb-1">cloud_upload</span>
    					<p class="text-[9px] font-medium text-on-surface-variant text-center">
        					사업자등록증 업로드
    					</p>
					</button>

<div class="w-full">
    <img id="brMainImagePreview"
         src="${pageContext.request.contextPath}/trainer/profile-img/${gym.brFile}"
         class="w-full max-h-48 object-contain rounded-lg"
         onerror="this.style.display='none'">

    <span id="brFilePreview"
          class="hidden text-[10px] font-medium truncate flex-1">
        ${gym.brFile}
    </span>
</div>
                </div>
         	</section>
         	
         	
        </div>
        
        

        <!-- 오른쪽 영역 -->
<div class="col-span-12 lg:col-span-4 space-y-4">

    <!-- 편의시설 -->
     <section class="bg-surface-container-lowest p-5 rounded-lg tonal-depth">
    <div class="flex items-center gap-2 mb-3">
        <div class="p-1.5 rounded bg-primary/10 text-primary">
            <span class="material-symbols-outlined text-lg">room_service</span>
        </div>
        <h3 class="text-base font-bold">편의 시설</h3>
    </div>

    <div class="space-y-1.5">

        <!-- 개인 락커 -->
        <div class="flex items-center justify-between px-2.5 py-1.5 rounded bg-surface-container-low">
            <div class="flex items-center gap-2">
                <span class="material-symbols-outlined text-base text-on-surface-variant">lock</span>
                <span class="text-[11px] font-bold">개인 락커</span>
            </div>
            <div class="relative inline-block w-7 h-3.5">
                <input type="checkbox" name="facility" value="개인락커" id="f-locker"
                       class="toggle-checkbox hidden"
                       ${fn:contains(gym.facility, '개인락커') ? 'checked' : ''}/>
                <label class="toggle-label block w-full h-full bg-outline-variant rounded-full cursor-pointer relative" for="f-locker"></label>
            </div>
        </div>

        <!-- 샤워실 -->
        <div class="flex items-center justify-between px-2.5 py-1.5 rounded bg-surface-container-low">
            <div class="flex items-center gap-2">
                <span class="material-symbols-outlined text-base text-on-surface-variant">shower</span>
                <span class="text-[11px] font-bold">샤워실</span>
            </div>
            <div class="relative inline-block w-7 h-3.5">
                <input type="checkbox" name="facility" value="샤워실" id="f-shower"
                       class="toggle-checkbox hidden"
                       ${fn:contains(gym.facility, '샤워실') ? 'checked' : ''}/>
                <label class="toggle-label block w-full h-full bg-outline-variant rounded-full cursor-pointer relative" for="f-shower"></label>
            </div>
        </div>

        <!-- 주차 -->
        <div class="flex items-center justify-between px-2.5 py-1.5 rounded bg-surface-container-low">
            <div class="flex items-center gap-2">
                <span class="material-symbols-outlined text-base text-on-surface-variant">local_parking</span>
                <span class="text-[11px] font-bold">무료 주차</span>
            </div>
            <div class="relative inline-block w-7 h-3.5">
                <input type="checkbox" name="facility" value="주차장" id="f-parking"
                       class="toggle-checkbox hidden"
                       ${fn:contains(gym.facility, '주차장') ? 'checked' : ''}/>
                <label class="toggle-label block w-full h-full bg-outline-variant rounded-full cursor-pointer relative" for="f-parking"></label>
            </div>
        </div>

        <!-- 운동복 -->
        <div class="flex items-center justify-between px-2.5 py-1.5 rounded bg-surface-container-low">
            <div class="flex items-center gap-2">
                <span class="material-symbols-outlined text-base text-on-surface-variant">checkroom</span>
                <span class="text-[11px] font-bold">운동복</span>
            </div>
            <div class="relative inline-block w-7 h-3.5">
                <input type="checkbox" name="facility" value="운동복" id="f-clothes"
                       class="toggle-checkbox hidden"
                       ${fn:contains(gym.facility, '운동복') ? 'checked' : ''}/>
                <label class="toggle-label block w-full h-full bg-outline-variant rounded-full cursor-pointer relative" for="f-clothes"></label>
            </div>
        </div>

    </div>
</section>

    <!-- 운영 시간 -->
    <section class="bg-surface-container-lowest p-5 rounded-lg tonal-depth">
        <div class="flex items-center justify-between mb-3">
            <div class="flex items-center gap-2">
                <div class="p-1.5 rounded bg-primary/10 text-primary">
                    <span class="material-symbols-outlined text-lg">schedule</span>
                </div>
                <h3 class="text-base font-bold">운영 시간</h3>
            </div>
            <button type="button" onclick="toggleHourEdit()" class="p-1 text-primary hover:bg-primary/5 rounded">
                <span class="material-symbols-outlined text-xs">edit</span>
            </button>
        </div>

        <div id="hourText" class="space-y-1.5">
            <div class="flex justify-between text-[11px]">
                <span class="text-on-surface-variant">평일 월-금</span>
                <span class="font-bold">${schedule.availableWeekdayStart} - ${schedule.availableWeekdayEnd}</span>
            </div>
            <div class="flex justify-between text-[11px]">
                <span class="text-on-surface-variant">토·일·공휴일</span>
                <span class="font-bold">${schedule.availableWeekendStart} - ${schedule.availableWeekendEnd}</span>
            </div>
        </div>

        <div id="hourEdit" class="hidden space-y-2">
            <p class="text-[10px] font-bold text-on-surface-variant">평일</p>
            <div class="grid grid-cols-2 gap-2">
                <input type="time" name="weekdayStart" value="${schedule.availableWeekdayStart}" class="bg-surface-container-low rounded-lg text-xs border-0">
                <input type="time" name="weekdayEnd" value="${schedule.availableWeekdayEnd}" class="bg-surface-container-low rounded-lg text-xs border-0">
            </div>

            <p class="text-[10px] font-bold text-on-surface-variant">주말/공휴일</p>
            <div class="grid grid-cols-2 gap-2">
                <input type="time" name="weekendStart" value="${schedule.availableWeekendStart}" class="bg-surface-container-low rounded-lg text-xs border-0">
                <input type="time" name="weekendEnd" value="${schedule.availableWeekendEnd}" class="bg-surface-container-low rounded-lg text-xs border-0">
            </div>
        </div>
    </section>

    <!-- 이용권 관리 -->
    <section class="bg-surface-container-lowest p-5 rounded-lg tonal-depth min-h-[430px]">
        <div class="flex items-center justify-between mb-3">
            <div class="flex items-center gap-2">
                <div class="p-1.5 rounded bg-primary/10 text-primary">
                    <span class="material-symbols-outlined text-lg">sell</span>
                </div>
                <h3 class="text-base font-bold">이용권 관리</h3>
            </div>
            <button type="button" onclick="openModal('membershipModal')" class="p-1 text-primary hover:bg-primary/5 rounded">
                <span class="material-symbols-outlined text-xs">edit</span>
            </button>
        </div>

        <div id="membershipPreview" class="space-y-2">
            <c:forEach var="m" items="${membershipList}">
                <div class="px-3 py-2 rounded bg-surface-container-low flex justify-between items-center">
                    <span class="text-[11px] font-bold">
                        <c:choose>
                            <c:when test="${m.type == 'day'}">${m.typeRep}일 이용권</c:when>
                            <c:when test="${m.type == 'month'}">${m.typeRep}개월 회원권</c:when>
                            <c:otherwise>PT ${m.typeRep}회</c:otherwise>
                        </c:choose>
                    </span>
                    <p class="text-[11px] font-black">
                        ₩<fmt:formatNumber value="${m.price}" pattern="#,###"/>
                    </p>
                </div>
            </c:forEach>
        </div>
    </section>

</div>
    </div>
</main>


<!-- 프로필 로고 모달 -->
<div id="profileModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
    <div class="bg-white w-full max-w-md rounded-lg shadow-2xl overflow-hidden">
        <div class="px-6 py-5 flex items-center justify-between border-b">
            <h3 class="text-lg font-bold">프로필 로고 관리</h3>
            <button type="button" onclick="closeModal('profileModal')">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>

        <div class="p-6 space-y-6">
            <div class="flex flex-col items-center">
                <div class="w-32 h-32 rounded-full overflow-hidden bg-surface-container shadow">
                    <img id="profilePreview"
     					 class="w-full h-full object-cover"
     					 src="${pageContext.request.contextPath}/trainer/profile-img/${user.profileImage}">
                </div>
                <p class="mt-3 text-sm text-on-surface-variant">현재 등록된 로고</p>
            </div>

            <label class="border-2 border-dashed border-outline-variant/40 rounded-lg p-8 flex flex-col items-center justify-center gap-3 cursor-pointer">
                <span class="material-symbols-outlined text-primary text-3xl">cloud_upload</span>
                <p class="text-sm font-bold">새 로고 업로드</p>
                <p class="text-xs text-on-surface-variant">PNG, JPG 최대 2MB</p>
                <input id="profileImgInput"
       				   type="file"
       				   name="profileImg"
       				   accept="image/*"
       				   class="hidden">
            </label>
        </div>

        <div class="bg-surface-container-low px-6 py-4 flex justify-end gap-3">
            <button type="button" onclick="closeModal('profileModal')" class="px-4 py-2 text-sm rounded-lg">취소</button>
            <button type="button" onclick="applyProfilePreview()" class="px-5 py-2 bg-primary text-white text-sm rounded-lg">적용</button>
        </div>
    </div>
</div>

<!-- 배경 사진 모달 -->
<div id="backgroundModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
    <div class="bg-white w-full max-w-lg rounded-lg shadow-2xl overflow-hidden">
        <div class="px-6 py-5 flex items-center justify-between border-b">
            <h3 class="text-lg font-bold">배경 사진 관리</h3>
            <button type="button" onclick="closeModal('backgroundModal')">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>

        <div class="p-6 space-y-6">
            <div>
                <p class="text-xs font-bold mb-2">현재 배경 사진</p>
                <div class="aspect-[21/9] rounded-lg overflow-hidden">
                    <img id="backgroundPreview"
     					 class="w-full h-full object-cover"
     					 src="${pageContext.request.contextPath}/trainer/profile-img/${gym.backgroundImg}">
                </div>
            </div>

            <label class="border-2 border-dashed border-outline-variant/40 rounded-lg p-8 flex flex-col items-center justify-center gap-3 cursor-pointer">
                <span class="material-symbols-outlined text-primary text-3xl">cloud_upload</span>
                <p class="text-sm font-bold">새 배경 사진 업로드</p>
                <p class="text-xs text-on-surface-variant">PNG, JPG 권장 1920x600</p>
                <input id="backgroundImgInput"
       				   type="file"
       				   name="backgroundImg"
       				   accept="image/*"
       				   class="hidden">
            </label>
        </div>

        <div class="bg-surface-container-low px-6 py-4 flex justify-end gap-3">
            <button type="button" onclick="closeModal('backgroundModal')" class="px-4 py-2 text-sm rounded-lg">취소</button>
            <button type="button" onclick="applyBackgroundPreview()" class="px-5 py-2 bg-primary text-white text-sm rounded-lg">적용</button>
        </div>
    </div>
</div>

<!-- 센터 갤러리 모달 -->
<div id="galleryModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
    <div class="bg-white w-full max-w-4xl rounded-xl shadow-2xl overflow-hidden">
        <div class="px-8 py-6 flex items-center justify-between border-b">
            <h3 class="text-xl font-bold">센터 갤러리</h3>
            <button type="button" onclick="closeModal('galleryModal')">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>

        <div class="p-8">
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <c:set var="images" value="${fn:split(gym.file, ',')}" />
                <c:forEach var="img" items="${images}">
                    <c:if test="${not empty img}">
                        <div class="relative aspect-square rounded-lg overflow-hidden bg-surface-container-low"  data-file="${img}">
                            <img class="w-full h-full object-cover"
                                 src="${pageContext.request.contextPath}/trainer/profile-img/${img}">
                            <button type="button"
        							onclick="removeGallery(this, '${img}')"
        							class="absolute top-2 right-2 bg-white rounded shadow px-1">
    							<span class="material-symbols-outlined text-sm text-error">close</span>
							</button>
                        </div>
                    </c:if>
                </c:forEach>

                <label id="galleryUploadBox"
       class="aspect-square rounded-lg border-2 border-dashed border-outline-variant flex items-center justify-center cursor-pointer overflow-hidden relative">
    <span id="galleryAddIcon"
          class="material-symbols-outlined text-primary text-3xl">add</span>

    <img id="galleryUploadPreview"
         class="hidden absolute inset-0 w-full h-full object-cover">

    <input id="galleryImgsInput"
           type="file"
           name="galleryImgs"
           multiple
           accept="image/*"
           class="hidden">
</label>
            </div>
        </div>

        <div class="bg-surface-container-low px-6 py-4 flex justify-end gap-3">
            <button type="button" onclick="closeModal('galleryModal')" class="px-4 py-2 text-sm rounded-lg">취소</button>
            <button type="button" onclick="applyGalleryPreview()" class="px-5 py-2 bg-primary text-white text-sm rounded-lg">적용</button>
        </div>
    </div>
</div>

<!-- 사업자 등록증 모달 -->
<div id="businessModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
    <div class="bg-white w-full max-w-xl rounded-xl shadow-2xl overflow-hidden">
        <div class="px-6 py-5 flex items-center justify-between">
            <h3 class="text-lg font-bold">사업자 등록증 첨부</h3>
            <button type="button" onclick="closeModal('businessModal')">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>

        <label for="brFileInput"
       class="border-2 border-dashed border-outline-variant rounded-xl p-12 flex flex-col items-center justify-center space-y-4 cursor-pointer">
    <span class="material-symbols-outlined text-primary text-4xl">cloud_upload</span>
    <p class="font-semibold">파일을 클릭하여 선택하세요</p>
    <p class="text-sm text-on-surface-variant">PDF, JPG, PNG 최대 5MB</p>
</label>

<input id="brFileInput"
       type="file"
       name="brFile"
       accept=".pdf,image/*"
       class="sr-only">
       
       <p id="brFileName" class="mt-2 text-xs text-primary"></p>
       
       <img id="brImagePreview"
     		class="hidden mt-4 max-h-64 w-full object-contain rounded-lg border">

<div id="currentBrFile"
     class="mt-4 text-xs text-on-surface-variant">
    현재 파일: ${gym.brFile}
</div>

        <div class="bg-surface-container-low px-6 py-4 flex justify-end gap-3">
            <button type="button" onclick="closeModal('businessModal')" class="px-4 py-2 text-sm rounded-lg">취소</button>
            <button type="button" onclick="applyBusinessPreview()" class="px-5 py-2 bg-primary text-white text-sm rounded-lg">적용</button>
        </div>
    </div>
</div>

<!-- 이용권 관리 모달 -->
<div id="membershipModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center bg-black/40 backdrop-blur-sm p-4">
    <div class="bg-white w-full max-w-6xl rounded-xl shadow-2xl overflow-hidden">
        <div class="px-8 py-6 flex justify-between items-center border-b">
            <div>
                <h3 class="text-xl font-bold">이용권 정보 수정</h3>
                <p class="text-sm text-on-surface-variant mt-1">회원들에게 노출될 이용권 금액을 수정합니다.</p>
            </div>
            <button type="button" onclick="closeModal('membershipModal')">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>

        <div id="membershipArea" class="p-8 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 bg-surface-container-low">
            <c:forEach var="m" items="${membershipList}">
                <div class="membership-card bg-white p-5 rounded-lg border flex flex-col gap-4">
                    <input type="hidden" name="membershipId" value="${m.membershipNum}">

                    <div class="grid grid-cols-2 gap-2">
                        <select name="membershipType" class="text-sm rounded-lg">
                            <option value="day" ${m.type == 'day' ? 'selected' : ''}>일권</option>
                            <option value="month" ${m.type == 'month' ? 'selected' : ''}>개월권</option>
                            <option value="pt" ${m.type == 'pt' ? 'selected' : ''}>PT</option>
                        </select>

                        <input type="number" name="membershipTypeRep" value="${m.typeRep}"
                               class="text-sm rounded-lg" placeholder="기간/횟수">
                    </div>

                    <div class="relative">
                        <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm">₩</span>
                        <input type="number" name="membershipPrice" value="${m.price.intValue()}" step="100" min="100"
                               class="w-full pl-7 py-2 text-sm rounded-lg" placeholder="가격">
                    </div>

                    <button type="button" onclick="this.parentElement.remove()"
                            class="text-xs text-error text-right">삭제</button>
                </div>
            </c:forEach>

            <button type="button" onclick="addMembershipCard()"
                    class="min-h-[160px] rounded-lg border-2 border-dashed border-outline-variant flex items-center justify-center text-primary font-bold">
                + 이용권 추가
            </button>
        </div>

        <div class="bg-surface-container-low px-6 py-4 flex justify-end gap-3">
            <button type="button" onclick="closeModal('membershipModal')" class="px-4 py-2 text-sm rounded-lg">취소</button>
            <button type="button" onclick="applyMembershipPreview()" class="px-5 py-2 bg-primary text-white text-sm rounded-lg">적용</button>
        </div>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
function checkEmailDuplicate() {
    const email = document.getElementById("emailId").value.trim();
    const msg = document.getElementById("emailCheckMsg");

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
        msg.textContent = "이메일 형식으로 입력해주세요.";
        msg.className = "text-[10px] mt-1 text-error";
        return;
    }

    fetch("${pageContext.request.contextPath}/gym/checkEmail?emailId=" + encodeURIComponent(email))
        .then(res => res.text())
        .then(result => {
            if (result === "available") {
                msg.textContent = "사용 가능한 이메일입니다.";
                msg.className = "text-[10px] mt-1 text-primary";
            } else {
                msg.textContent = "이미 사용 중인 이메일입니다.";
                msg.className = "text-[10px] mt-1 text-error";
            }
        });
}

function changePassword() {
    const password = document.getElementById("newPassword").value.trim();
    const msg = document.getElementById("passwordMsg");

    if (password.length < 4) {
        msg.textContent = "비밀번호를 4자 이상 입력해주세요.";
        msg.className = "text-[10px] text-error mt-1";
        msg.classList.remove("hidden");
        return;
    }

    fetch("${pageContext.request.contextPath}/gym/changePassword", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "password=" + encodeURIComponent(password)
    })
    .then(res => res.text())
    .then(result => {
        if (result === "success") {
            msg.textContent = "비밀번호가 변경되었습니다.";
            msg.className = "text-[10px] text-primary mt-1";
            msg.classList.remove("hidden");
        }
    });
}

function toggleHourEdit() {
    document.getElementById("hourText").classList.toggle("hidden");
    document.getElementById("hourEdit").classList.toggle("hidden");
}



function openKakaoAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("address").value = data.address;
            document.getElementById("postcode").value = data.zonecode;
        }
    }).open();
}

function openModal(id) {
    document.getElementById(id).classList.remove("hidden");
}

function closeModal(id) {
    document.getElementById(id).classList.add("hidden");
}

function addMembershipCard() {
    const area = document.getElementById("membershipArea");
    const addBtn = area.lastElementChild;

    const div = document.createElement("div");
    div.className = "membership-card bg-white p-5 rounded-lg border flex flex-col gap-4";

    div.innerHTML = `
        <input type="hidden" name="membershipId" value="new">

        <div class="grid grid-cols-2 gap-2">
            <select name="membershipType" class="text-sm rounded-lg">
                <option value="day">일권</option>
                <option value="month">개월권</option>
                <option value="pt">PT</option>
            </select>

            <input type="number" name="membershipTypeRep"
                   class="text-sm rounded-lg" placeholder="기간/횟수">
        </div>

        <div class="relative">
            <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm">₩</span>
            <input type="number" name="membershipPrice" step="100" min="100"
                   class="w-full pl-7 py-2 text-sm rounded-lg" placeholder="가격">
        </div>

        <button type="button" onclick="this.parentElement.remove()"
                class="text-xs text-error text-right">삭제</button>
    `;

    area.insertBefore(div, addBtn);
}

function removeGallery(btn, fileName) {
    btn.closest(".relative").remove();

    const input = document.getElementById("deleteGallery");

    if (input.value === "") {
        input.value = fileName;
    } else {
        input.value += "," + fileName;
    }
}

function applyMembershipPreview() {
    const preview = document.getElementById("membershipPreview");
    const cards = document.querySelectorAll("#membershipArea .membership-card");

    preview.innerHTML = "";

    cards.forEach(card => {
        const typeEl = card.querySelector('select[name="membershipType"]');
        const repEl = card.querySelector('input[name="membershipTypeRep"]');
        const priceEl = card.querySelector('input[name="membershipPrice"]');

        if (!typeEl || !repEl || !priceEl) return;

        const type = typeEl.value;
        const rep = repEl.value.trim();
        const price = priceEl.value.trim();

        if (!rep || !price) return;

        let title = "";

        if (type === "day") {
            title = rep + "일 이용권";
        } else if (type === "month") {
            title = rep + "개월 회원권";
        } else {
            title = "PT " + rep + "회";
        }

        const formattedPrice = Number(price).toLocaleString();

        preview.innerHTML +=
            '<div class="px-3 py-2 rounded bg-surface-container-low flex justify-between items-center">' +
                '<span class="text-[11px] font-bold">' + title + '</span>' +
                '<p class="text-[11px] font-black">₩' + formattedPrice + '</p>' +
            '</div>';
    });

    closeModal("membershipModal");
}

document.getElementById("brFileInput").addEventListener("change", function () {
    const file = this.files.length > 0 ? this.files[0] : null;
    const fileNameEl = document.getElementById("brFileName");
    const previewImg = document.getElementById("brImagePreview");

    if (!file) {
        fileNameEl.textContent = "";
        previewImg.classList.add("hidden");
        previewImg.src = "";
        return;
    }

    fileNameEl.textContent = file.name;

    if (file.type.startsWith("image/")) {
        previewImg.src = URL.createObjectURL(file);
        previewImg.classList.remove("hidden");
    } else {
        previewImg.classList.add("hidden");
        previewImg.src = "";
    }
});

function applyBusinessPreview() {
    const input = document.getElementById("brFileInput");
    const current = document.getElementById("currentBrFile");
    const preview = document.getElementById("brFilePreview");
    const mainImg = document.getElementById("brMainImagePreview");

    if (input.files.length > 0) {
        const file = input.files[0];
        const fileName = file.name;

        if (current) {
            current.textContent = "현재 파일: " + fileName;
        }

        if (preview) {
            preview.textContent = fileName;
        }

        if (mainImg) {
            if (file.type.startsWith("image/")) {
                mainImg.src = URL.createObjectURL(file);
                mainImg.classList.remove("hidden");
            } else {
                mainImg.src = "";
                mainImg.classList.add("hidden");
            }
        }
    }

    closeModal("businessModal");
}

document.getElementById("profileImgInput")?.addEventListener("change", function () {
    const file = this.files[0];
    if (!file) return;

    document.getElementById("profilePreview").src = URL.createObjectURL(file);
});

document.getElementById("backgroundImgInput")?.addEventListener("change", function () {
    const file = this.files[0];
    if (!file) return;

    document.getElementById("backgroundPreview").src = URL.createObjectURL(file);
});

document.getElementById("galleryImgsInput")?.addEventListener("change", function () {
    const file = this.files[0];
    const previewImg = document.getElementById("galleryUploadPreview");
    const addIcon = document.getElementById("galleryAddIcon");

    if (!file || !file.type.startsWith("image/")) {
        previewImg.classList.add("hidden");
        previewImg.src = "";
        addIcon.classList.remove("hidden");
        return;
    }

    previewImg.src = URL.createObjectURL(file);
    previewImg.classList.remove("hidden");
    addIcon.classList.add("hidden");
});

function applyProfilePreview() {
    const input = document.getElementById("profileImgInput");
    const mainImg = document.getElementById("profileMainPreview");

    if (input && input.files.length > 0) {
        mainImg.src = URL.createObjectURL(input.files[0]);
    }

    closeModal("profileModal");
}

function applyBackgroundPreview() {
    const input = document.getElementById("backgroundImgInput");
    const mainImg = document.getElementById("backgroundMainPreview");

    if (input && input.files.length > 0) {
        mainImg.src = URL.createObjectURL(input.files[0]);
    }

    closeModal("backgroundModal");
}

function applyGalleryPreview() {
    const mainArea = document.getElementById("galleryMainPreview");
    const input = document.getElementById("galleryImgsInput");
    const deleteInput = document.getElementById("deleteGallery");

    // 삭제된 기존 이미지 페이지에서도 제거
    if (deleteInput.value.trim() !== "") {
        const deleteFiles = deleteInput.value.split(",");

        deleteFiles.forEach(fileName => {
            const target = mainArea.querySelector('[data-file="' + fileName + '"]');
            if (target) {
                target.remove();
            }
        });
    }

    // 새로 추가한 이미지 페이지에 미리보기 추가
    if (input && input.files.length > 0) {
        Array.from(input.files).forEach(file => {
            if (!file.type.startsWith("image/")) return;

            const box = document.createElement("div");
            box.className = "aspect-square rounded overflow-hidden bg-slate-100 relative";

            const img = document.createElement("img");
            img.className = "w-full h-full object-cover";
            img.src = URL.createObjectURL(file);

            box.appendChild(img);
            mainArea.appendChild(box);
        });
    }

    closeModal("galleryModal");
}
</script>
</form>
</body>
</html>