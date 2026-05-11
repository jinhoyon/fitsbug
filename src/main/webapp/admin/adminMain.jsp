<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>핏츠버그 Admin Dashboard</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
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
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
    body { font-family: 'Inter', sans-serif; }
</style>
</head>
<body class="bg-surface font-body text-on-surface antialiased">
<div class="flex">
    <jsp:include page="sidebar.jsp"></jsp:include>

    <main class="flex-1 ml-64 min-h-screen">
        <div class="pt-10 px-10 pb-10">
            <div class="flex justify-between items-end mb-8">
                <div>
                    <h2 class="text-2xl font-semibold font-headline tracking-tight text-on-surface">대시보드</h2>
                    <p class="text-on-surface-variant mt-1">플랫폼 운영 현황 및 주요 지표를 실시간으로 확인합니다.</p>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div onclick="location.href='${pageContext.request.contextPath}/admin/memberGym'"
                     class="bg-surface-container-lowest p-8 rounded-xl shadow-sm border border-outline-variant/30 cursor-pointer hover:ring-2 hover:ring-primary/20 transition-all group">
                    <div class="flex justify-between items-start">
                        <span class="material-symbols-outlined text-primary bg-primary/10 p-3 rounded-lg group-hover:scale-110 transition-transform">group</span>
                    </div>
                    <h3 class="text-xs text-on-surface-variant mt-6 uppercase font-bold">총 회원 수</h3>
                    <p class="text-4xl font-bold text-on-surface mt-1">
                        <fmt:formatNumber value="${stats.totMember}" pattern="#,###"/>
                    </p>
                </div>

                <div onclick="location.href='${pageContext.request.contextPath}/admin/memberGym'"
                     class="bg-surface-container-lowest p-8 rounded-xl shadow-sm border border-outline-variant/30 cursor-pointer hover:ring-2 hover:ring-tertiary/20 transition-all group">
                    <div class="flex justify-between items-start">
                        <span class="material-symbols-outlined text-tertiary bg-tertiary/10 p-3 rounded-lg group-hover:scale-110 transition-transform">person_add</span>
                    </div>
                    <h3 class="text-xs text-on-surface-variant mt-6 uppercase font-bold">신규 가입(최근 1개월)</h3>
                    <p class="text-4xl font-bold text-on-surface mt-1">
                        <fmt:formatNumber value="${stats.newMember}" pattern="#,###"/>
                    </p>
                </div>

                <div onclick="location.href='${pageContext.request.contextPath}/admin/memberGym'"
                     class="bg-surface-container-lowest p-8 rounded-xl shadow-sm border border-outline-variant/30 cursor-pointer hover:ring-2 hover:ring-emerald-500/20 transition-all group">
                    <div class="flex justify-between items-start">
                        <span class="material-symbols-outlined text-emerald-600 bg-emerald-50 p-3 rounded-lg group-hover:scale-110 transition-transform">apartment</span>
                    </div>
                    <h3 class="text-xs text-on-surface-variant mt-6 uppercase font-bold">등록 지점 및 트레이너</h3>
                    <p class="text-4xl font-bold text-on-surface mt-1">
                        <fmt:formatNumber value="${stats.totPartners}" pattern="#,###"/>
                    </p>
                </div>
            </div>

            <div onclick="location.href='${pageContext.request.contextPath}/admin/sales'"
                 class="bg-surface-container-lowest p-8 rounded-xl shadow-sm border border-outline-variant/30 mb-8 cursor-pointer hover:bg-surface-container-low transition-colors group">
                <h4 class="text-sm font-bold mb-6 flex items-center gap-2 text-on-surface">
                    <span class="w-1 h-4 bg-primary rounded-full"></span>수익 현황 분석 (최근 30일)
                </h4>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
                    <div>
                        <p class="text-[11px] text-on-surface-variant uppercase font-bold mb-2">총 매출액</p>
                        <p class="text-3xl font-black text-on-surface">
                            ₩<fmt:formatNumber value="${stats.salesAmount}" pattern="#,###"/>
                        </p>
                    </div>
                    <div>
                        <p class="text-[11px] text-on-surface-variant uppercase font-bold mb-2">지점 정산금 (90%)</p>
                        <p class="text-3xl font-black text-error">
                            ₩<fmt:formatNumber value="${stats.salesAmount * 0.9}" pattern="#,###"/>
                        </p>
                    </div>
                    <div>
                        <p class="text-[11px] text-on-surface-variant uppercase font-bold mb-2">플랫폼 수익 (10%)</p>
                        <p class="text-3xl font-black text-primary">
                            ₩<fmt:formatNumber value="${stats.salesAmount * 0.1}" pattern="#,###"/>
                        </p>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="bg-surface-container-low p-6 rounded-xl border border-outline-variant/30">
                    <div class="flex justify-between items-center mb-6">
                        <h4 class="font-bold text-sm text-on-surface">회원 자격 승인</h4>
                        <span class="text-[10px] bg-primary/10 text-primary px-2 py-0.5 rounded-full font-bold">검토필요</span>
                    </div>
                    <div class="bg-surface-container-lowest p-6 rounded-lg text-center shadow-sm border border-outline-variant/10">
                        <p class="text-xs text-on-surface-variant mb-1">승인 대기 중</p>
                        <h3 class="text-4xl font-black text-primary">${stats.authWaitCount}건</h3>
                        <button onclick="location.href='${pageContext.request.contextPath}/admin/memberAuth'" class="mt-4 w-full py-2.5 bg-primary text-white text-xs font-bold rounded-lg hover:bg-primary/90 transition-colors">자격 검토하기</button>
                    </div>
                </div>

                <div class="bg-surface-container-low p-6 rounded-xl border border-outline-variant/30">
                    <div class="flex justify-between items-center mb-6">
                        <h4 class="font-bold text-sm text-on-surface">신고 및 문의</h4>
                        <span class="text-[10px] bg-error/10 text-error px-2 py-0.5 rounded-full font-bold">미처리</span>
                    </div>
                    <div class="bg-surface-container-lowest p-6 rounded-lg shadow-sm border border-outline-variant/10 space-y-4">
                        <div class="flex justify-between items-center">
                            <span class="text-xs text-on-surface-variant">신고 내역</span>
                            <span class="text-lg font-bold text-error">${stats.reportWaitCount}건</span>
                        </div>
                        <div class="flex justify-between items-center">
                            <span class="text-xs text-on-surface-variant">문의 사항</span>
                            <span class="text-lg font-bold text-on-surface">${stats.inquiryWaitCount}건</span>
                        </div>
                        <button onclick="location.href='${pageContext.request.contextPath}/admin/reportList'" class="w-full py-2.5 bg-inverse-surface text-inverse-on-surface text-xs font-bold rounded-lg hover:opacity-90 transition-opacity">상세 내역 확인</button>
                    </div>
                </div>

                <div class="bg-surface-container-low p-6 rounded-xl border border-outline-variant/30">
                    <div class="flex justify-between items-center mb-6">
                        <h4 class="font-bold text-sm text-on-surface">정산 관리</h4>
                        <span class="text-[10px] bg-emerald-100 text-emerald-700 px-2 py-0.5 rounded-full font-bold">입금대기</span>
                    </div>
                    <div class="bg-surface-container-lowest p-6 rounded-lg text-center shadow-sm border border-outline-variant/10">
                        <p class="text-xs text-on-surface-variant mb-1">이번 달 정산 대상</p>
                        <h3 class="text-4xl font-black text-emerald-600">${stats.settleWaitCount}건</h3>
                        <button onclick="location.href='${pageContext.request.contextPath}/admin/salesSettlement'" class="mt-4 w-full py-2.5 bg-emerald-600 text-white text-xs font-bold rounded-lg hover:bg-emerald-700 transition-colors">정산 처리하기</button>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>