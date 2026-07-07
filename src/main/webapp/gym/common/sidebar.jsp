<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.common.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 	
<%  
	UserDTO loginUser = (UserDTO) session.getAttribute("loginUser"); 
	String contextPath = request.getContextPath();
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!-- 🔹 사이드바 -->
<aside
	class="h-full w-64 fixed left-0 top-0 bg-slate-50 dark:bg-slate-950 flex flex-col p-5 z-50 border-r border-surface-container-highest">

	<!-- 🔹 상단 영역 -->
	<div class="flex flex-col">

		<!-- 로고 -->
		<div
			class="text-2xl font-black text-blue-600 dark:text-blue-500 italic mb-4 flex items-center gap-2">
			
			<span>FITSBUG</span>
		</div>

		<!-- 프로필 -->
		<a href="${pageContext.request.contextPath}/member/gymDetail?gymId=${sessionScope.gymId}">
   		   
			<div
				class="flex items-center gap-3 p-3 bg-white rounded-xl shadow-sm border mb-6">
				<div class="w-10 h-10 rounded-full bg-gray-300">
					<img class="w-full h-full object-cover rounded-full"
                 	 	 src="${pageContext.request.contextPath}/trainer/profile-img/${loginUser.profileImage}"
                 	 	 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/profile_img.jpg'">
				</div>
				<div class="flex flex-col">
					<span class="text-sm font-semibold">${loginUser.nickname}</span> <span
					class="text-xs text-gray-500">${loginUser.email}</span>
				</div>
			</div>
		</a>

		<!-- 메뉴 -->
		<nav class="flex flex-col gap-2"> 

			<div class="flex flex-col">
					<a href="${contextPath}/gym/dashboard"
   					   class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
						<span class="material-symbols-outlined">home</span>
    					<span class="text-sm">홈</span>
					</a>
					<a href="${contextPath}/gym/schedule"
   					   class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
						<span class="material-symbols-outlined">calendar_today</span>
    					<span class="text-sm">스케줄</span>
					</a> 
					
					<a href="${contextPath}/gym/memberManage"
   					   class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
						<span class="material-symbols-outlined">group</span>
    					<span class="text-sm">회원</span>

					</a>

					<a href="${contextPath}/gym/trainer"
   					   class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
						<span class="material-symbols-outlined">fitness_center</span>
    					<span class="text-sm">트레이너</span>

					</a>
					<div class="flex flex-col">

						

					<a href="${contextPath}/gym/sales"
   					   class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
						<span class="material-symbols-outlined">bar_chart</span>
    					<span class="text-sm">매출</span>

					</a> 
					
					<a href="${contextPath}/gym/notice"
   					   class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
						<span class="material-symbols-outlined">campaign</span>
    					<span class="text-sm">공지사항</span>

					</a>
					 
					 <a href="${contextPath}/gym/infoEdit"
   					    class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
						<span class="material-symbols-outlined">edit_square</span>
    					<span class="text-sm">정보수정</span>
					</a>

				<div class="my-3 border-t-2 border-outline-variant/40 mx-2"></div>

			    <a href="${contextPath}/member/guide" class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
			    	<span class="material-symbols-outlined">fitness_center</span>
			    	<span>운동 가이드</span>
    			</a>
    			
			    <a href="${contextPath}/member/trainerList" class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
      				<span class="material-symbols-outlined">badge</span>
      				<span>트레이너</span>
    			</a>
    			
   				<a href="${contextPath}/member/gymList" class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
      				<span class="material-symbols-outlined">store</span>
      				<span>헬스장</span>
    			</a>
    			
    			<a href="${contextPath}/member/community" 
    			    class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
      				<span class="material-symbols-outlined">groups</span>
      				<span>커뮤니티</span>
    			</a>


			</div>

		</nav>
	</div>

	<!-- 🔹 하단 영역 -->
	<div class="mt-auto flex flex-col gap-2 pt-4 border-t border-slate-200">

		<!-- 고객센터 (하단 고정) -->
		<a href="${contextPath}/member/support"
			class="flex items-center gap-3 px-4 py-2 rounded-xl text-slate-500 hover:bg-blue-50">
			<span class="material-symbols-outlined">support_agent</span> <span
			class="text-sm">고객센터</span>
		</a>

		<!-- 로그아웃 -->
		<form action="${contextPath}/member/logout" method="post">

    		<button type="submit"
        			class="bg-blue-600 text-white py-2 rounded-xl text-sm font-bold w-full">
        			로그아웃
    		</button>

		</form>

	</div>

</aside>



<script>
	function toggleMenu() {
		const menu = document.getElementById("menu");
		const arrow = document.getElementById("arrow");

		menu.classList.toggle("hidden");
		arrow.classList.toggle("rotate-180");
	}

	function toggleTrainerMenu() {
		const trainerMenu = document.getElementById("trainerMenu");
		const trainerArrow = document.getElementById("trainerArrow");

		trainerMenu.classList.toggle("hidden");
		trainerArrow.classList.toggle("rotate-180");
	}
</script>