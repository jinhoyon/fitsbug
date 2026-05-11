<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ap" value="${activePage}"/>

<aside class="fixed left-0 top-0 h-full w-64 bg-slate-50 dark:bg-slate-900 transition-colors duration-200 z-20 flex-col p-6 hidden lg:flex">
    <a href="javascript:void(0)" class="flex items-center gap-3 mb-10">
        <div class="w-10 h-10 bg-[#007AFF] rounded-xl flex items-center justify-center shrink-0">
            <span class="material-symbols-outlined text-white text-2xl">exercise</span>
        </div>
        <h1 class="text-2xl font-bold tracking-tight text-on-surface">Fitsbug</h1>
    </a>
    <nav class="flex-1 space-y-1" id="main-nav">
        <!-- 대시보드 -->
        <a class="flex items-center gap-3 px-4 py-3 text-sm transition-colors duration-200 rounded-lg
                  ${ap == 'dashboard' ? 'font-semibold text-blue-700 border-r-4 border-blue-700 bg-slate-200/50' : 'font-medium text-slate-500 hover:bg-slate-200/50'}"
           href="${pageContext.request.contextPath}/trainer/dashboard">
            <span class="material-symbols-outlined">dashboard</span>대시보드
        </a>

        <!-- 회원관리 -->
        <a class="flex items-center gap-3 px-4 py-3 text-sm transition-colors duration-200 rounded-lg
                  ${ap == 'clients' ? 'font-semibold text-blue-700 border-r-4 border-blue-700 bg-slate-200/50' : 'font-medium text-slate-500 hover:bg-slate-200/50'}"
           href="${pageContext.request.contextPath}/trainer/clients">
            <span class="material-symbols-outlined">group</span>회원관리
        </a>

        <!-- 일정 -->
        <a class="flex items-center gap-3 px-4 py-3 text-sm transition-colors duration-200 rounded-lg
                  ${ap == 'calendar' ? 'font-semibold text-blue-700 border-r-4 border-blue-700 bg-slate-200/50' : 'font-medium text-slate-500 hover:bg-slate-200/50'}"
           href="${pageContext.request.contextPath}/trainer/calendar">
            <span class="material-symbols-outlined">calendar_today</span>일정
        </a>

        <!-- 메시지 -->
        <a class="flex items-center gap-3 px-4 py-3 text-sm transition-colors duration-200 rounded-lg
                  ${ap == 'messages' ? 'font-semibold text-blue-700 border-r-4 border-blue-700 bg-slate-200/50' : 'font-medium text-slate-500 hover:bg-slate-200/50'}"
           href="${pageContext.request.contextPath}/trainer/messages">
            <span class="material-symbols-outlined">chat</span>메시지
        </a>

        <!-- 수익 -->
        <a class="flex items-center gap-3 px-4 py-3 text-sm transition-colors duration-200 rounded-lg
                  ${ap == 'earnings' ? 'font-semibold text-blue-700 border-r-4 border-blue-700 bg-slate-200/50' : 'font-medium text-slate-500 hover:bg-slate-200/50'}"
           href="${pageContext.request.contextPath}/trainer/earnings">
            <span class="material-symbols-outlined">payments</span>수익
        </a>

        <div class="border-t border-slate-200 dark:border-slate-800 my-2"></div>

        <!-- 홈 -->
        <div class="relative">
            <button class="w-full flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-500 hover:bg-slate-200/50 transition-colors duration-200 rounded-lg cursor-pointer"
                    onclick="var d=this.parentElement.querySelector('.dropdown');var open=d.style.maxHeight&&d.style.maxHeight!='0px';d.style.maxHeight=open?'0px':d.scrollHeight+'px';this.querySelector('.chevron').style.transform=open?'':'rotate(180deg)';">
                <span class="material-symbols-outlined">home</span>
                홈
                <span class="material-symbols-outlined ml-auto transition-transform duration-200 chevron" style="font-size:18px">expand_more</span>
            </button>
            <div class="dropdown flex-col pl-4 overflow-hidden transition-all duration-300 ease-in-out" style="max-height:0px">
                <a class="flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-500 hover:bg-slate-200/50 transition-colors duration-200 rounded-lg"
                   href="${pageContext.request.contextPath}/member/guide">
                    <span class="material-symbols-outlined">info</span>운동가이드
                </a>
                <a class="flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-500 hover:bg-slate-200/50 transition-colors duration-200 rounded-lg"
                   href="${pageContext.request.contextPath}/member/gymList">
                    <span class="material-symbols-outlined">fitness_center</span>헬스장
                </a>
                <a class="flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-500 hover:bg-slate-200/50 transition-colors duration-200 rounded-lg"
                   href="${pageContext.request.contextPath}/member/trainerList">
                    <span class="material-symbols-outlined">badge</span>트레이너
                </a>
                <a class="flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-500 hover:bg-slate-200/50 transition-colors duration-200 rounded-lg"
                   href="${pageContext.request.contextPath}/member/community">
                    <span class="material-symbols-outlined">groups</span>커뮤니티
                </a>
            </div>
        </div>
    </nav>

    <!-- 설정, 고객 지원 -->
    <div class="mt-auto pt-6 border-slate-200 dark:border-slate-800 space-y-1">
        <a class="flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-500 hover:bg-slate-200/50 transition-colors duration-200 rounded-lg" 객
           href="${pageContext.request.contextPath}/member/support">
            <span class="material-symbols-outlined">help</span>고객 지원
        </a>
        <div class="border-t border-slate-200 dark:border-slate-800 my-2"></div>
    </div>

    <!-- 마이프로필 -->
    <a href="${pageContext.request.contextPath}/trainer/profile"
       class="flex items-center gap-3 px-4 py-3 text-sm font-medium text-slate-500 hover:bg-slate-200/50 transition-colors duration-200 rounded-lg
                  ${ap == 'profile' ? 'font-semibold text-blue-700 border-r-4 border-blue-700 bg-slate-200/50' : 'font-medium text-slate-500 hover:bg-slate-200/50'}">
        <img alt="profile" class="w-10 h-10 rounded-full object-cover shrink-0"
             src="${not empty sessionScope.loginUser.profileImg ? pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.loginUser.profileImg) : pageContext.request.contextPath.concat('/img/profile_img.jpg')}"/>
        <div class="overflow-hidden">
            <p class="text-sm font-bold text-on-surface truncate">${sessionScope.loginTrainer.name}</p>
            <p class="text-xs text-slate-500 truncate">마이프로필</p>
        </div>
    </a>

    <!-- 로그아웃 -->
    <form method="post" action="${pageContext.request.contextPath}/trainer/logout">
        <button type="submit"
                class="w-full flex items-center gap-3 px-4 py-3 text-sm font-medium text-red-500 hover:bg-red-50 transition-colors duration-200 rounded-lg">
            <span class="material-symbols-outlined">logout</span>
            로그아웃
        </button>
    </form>
</aside>
