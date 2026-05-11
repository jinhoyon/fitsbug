<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ap" value="${activePage}"/>
<!-- Mobile Bottom Nav -->
<nav
        class="lg:hidden fixed bottom-0 left-0 right-0 z-30 bg-white border-t border-slate-200 px-2 py-2 flex items-center justify-around">
    <a href="#"
       class="flex flex-col items-center gap-1 px-3 py-1 text-slate-400 hover:text-primary transition-colors">
        <span class="material-symbols-outlined text-[22px]">home</span>
        <span class="text-[10px] font-medium">홈</span>
    </a>
    <a class="flex flex-col items-center gap-1 px-3 py-1
    ${ap == 'dashboard' ? 'text-blue-700 transition-colors' : 'text-slate-400 hover:text-primary transition-colors'}"
       href="${pageContext.request.contextPath}/trainer/dashboard">
        <span class="material-symbols-outlined text-[22px]"
              style='font-variation-settings: "FILL" 1;'>dashboard</span>
        <span class="text-[10px] font-medium">대시보드</span>
    </a>
    <a class="flex flex-col items-center gap-1 px-3 py-1
    ${ap == 'clients' ? 'text-blue-700 transition-colors' : 'text-slate-400 hover:text-primary transition-colors'}"
       href="${pageContext.request.contextPath}/trainer/clients"
       class="flex flex-col items-center gap-1 px-3 py-1 text-slate-400 hover:text-primary transition-colors">
        <span class="material-symbols-outlined text-[22px]">group</span>
        <span class="text-[10px] font-medium">회원관리</span>
    </a>
    <a class="flex flex-col items-center gap-1 px-3 py-1
    ${ap == 'calendar' ? 'text-blue-700 transition-colors' : 'text-slate-400 hover:text-primary transition-colors'}"
       href="${pageContext.request.contextPath}/trainer/calendar"
       class="flex flex-col items-center gap-1 px-3 py-1 text-slate-400 hover:text-primary transition-colors">
        <span class="material-symbols-outlined text-[22px]">calendar_today</span>
        <span class="text-[10px] font-medium">일정</span>
    </a>
    <a class="flex flex-col items-center gap-1 px-3 py-1
    ${ap == 'messages' ? 'text-blue-700 transition-colors' : 'text-slate-400 hover:text-primary transition-colors'}"
       href="${pageContext.request.contextPath}/trainer/messages"
       class="flex flex-col items-center gap-1 px-3 py-1 text-slate-400 hover:text-primary transition-colors">
        <span class="material-symbols-outlined text-[22px]">chat</span>
        <span class="text-[10px] font-medium">메시지</span>
    </a>
    <a class="flex flex-col items-center gap-1 px-3 py-1
    ${ap == 'earnings' ? 'text-blue-700 transition-colors' : 'text-slate-400 hover:text-primary transition-colors'}"
       href="${pageContext.request.contextPath}/trainer/earnings"
       class="flex flex-col items-center gap-1 px-3 py-1 text-slate-400 hover:text-primary transition-colors">
        <span class="material-symbols-outlined text-[22px]">payments</span>
        <span class="text-[10px] font-medium">수익</span>
    </a>
</nav>