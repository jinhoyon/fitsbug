<%--
  Created by IntelliJ IDEA.
  User: jinhoyon
  Date: 4/28/26
  Time: 1:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
    <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet"/>
    <script
            id="tailwind-config">tailwind.config = {
        darkMode: "class", theme: {
            extend: {
                colors: {
                    "surface-container-lowest": "#ffffff",
                    "on-primary": "#ffffff",
                    "secondary-fixed": "#d8e2ff",
                    "tertiary-container": "#c64f00",
                    "on-secondary": "#ffffff",
                    "on-tertiary": "#ffffff",
                    background: "#f9f9fe",
                    secondary: "#405e96",
                    "on-background": "#1a1c1f",
                    "surface-dim": "#d9dade",
                    "secondary-container": "#a1befd",
                    "primary-fixed": "#d8e2ff",
                    tertiary: "#9e3d00",
                    "on-tertiary-container": "#fffbff",
                    "primary-fixed-dim": "#adc6ff",
                    "surface-container-high": "#e8e8ed",
                    "on-secondary-fixed-variant": "#26467d",
                    "surface-container-low": "#f3f3f8",
                    "on-surface-variant": "#414755",
                    "secondary-fixed-dim": "#adc6ff",
                    "tertiary-fixed-dim": "#ffb595",
                    "on-primary-container": "#fefcff",
                    "error-container": "#ffdad6",
                    "inverse-on-surface": "#f0f0f5",
                    "on-secondary-container": "#2d4c83",
                    "surface-container-highest": "#e2e2e7",
                    "surface-bright": "#f9f9fe",
                    surface: "#f9f9fe",
                    "on-surface": "#1a1c1f",
                    primary: "#0058bc",
                    "on-tertiary-fixed-variant": "#7c2e00",
                    "outline-variant": "#c1c6d7",
                    "primary-container": "#0070eb",
                    outline: "#717786",
                    "on-error-container": "#93000a",
                    "inverse-surface": "#2e3034",
                    "surface-tint": "#005bc1",
                    "on-primary-fixed-variant": "#004493",
                    "surface-container": "#ededf2",
                    "on-error": "#ffffff",
                    "inverse-primary": "#adc6ff",
                    error: "#ba1a1a",
                    "on-tertiary-fixed": "#351000",
                    "surface-variant": "#e2e2e7",
                    "tertiary-fixed": "#ffdbcc",
                    "on-secondary-fixed": "#001a41",
                    "on-primary-fixed": "#001a41"
                },
                fontFamily: {headline: ["Inter"], body: ["Inter"], label: ["Inter"], display: "Inter"},
                borderRadius: {DEFAULT: "0.125rem", lg: "0.25rem", xl: "0.5rem", full: "0.75rem"}
            }
        }
    };</script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }

        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        body {
            min-height: 100vh;
        }

        .metric-selected {
            @apply ring-2;
        }

        .ring-weight {
            --tw-ring-color: #0058bc;
        }

        .ring-muscle {
            --tw-ring-color: #22c55e;
        }

        .ring-bodyFat {
            --tw-ring-color: #f97316;
        }

    </style>
</head>
<body class="bg-background text-on-background font-body antialiased" data-mode="connect">

<!-- Mobile Top Bar -->
<header
        class="lg:hidden fixed top-0 left-0 right-0 z-30 bg-slate-50 border-b border-slate-200 px-4 py-3 flex items-center justify-between">
    <div class="flex items-center gap-2">
        <div class="w-8 h-8 bg-[#007AFF] rounded-lg flex items-center justify-center">
            <span class="material-symbols-outlined text-white text-lg">exercise</span>
        </div>
        <h1 class="text-lg font-bold text-on-surface">Fitsbug</h1>
    </div>
    <div class="flex items-center gap-1">
        <button class="p-2 rounded-lg hover:bg-slate-200">
            <span class="material-symbols-outlined">notifications</span>
        </button>
        <a href="${pageContext.request.contextPath}/trainer/profile" class="p-1 rounded-full hover:ring-2 hover:ring-primary/30 transition-all">
            <img alt="연진호" class="w-8 h-8 rounded-full object-cover"
                 src="${not empty client.profileImage ? pageContext.request.contextPath.concat('/uploads/').concat(client.profileImage) : pageContext.request.contextPath.concat('/img/profile_img.jpg')}"/>
        </a>
    </div>
</header>

<!-- SideNavBar -->
<c:set var="activePage" value="clients" scope="request"/>

<div class="lg:ml-64 min-h-screen flex flex-col pt-14 pb-20 lg:pt-0 lg:pb-0">
    <main class="flex-1 p-4 md:p-6 lg:p-8 max-w-6xl mx-auto w-full space-y-6 lg:space-y-8">
        <!-- Client Overview Section -->
        <section
                class="bg-surface-container-lowest p-4 md:p-8 rounded-2xl md:rounded-3xl shadow-sm border border-outline-variant/10">
            <div class="flex flex-col md:flex-row items-start md:items-center gap-4 md:gap-8">
                <div class="relative">
                    <img alt="Profile of Kim Min-su"
                         class="w-20 h-20 md:w-32 md:h-32 rounded-3xl object-cover shadow-lg"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuDRaM7aJPJccG2VqzuEQFnWzaty4vFhjpL-5fNEreSZkXZaMJ5w2gbFP2X82eqKZUp0SOMGtYAZojFrVr0Fign3C2EZQ-Ec48g_8roHzucGiFw1AckjjTTYJNp5qK9bmHgBJwxzMFtj-LYouo4jaW5KBk-O7YS7IA72oZGHvXpT1GY54kq_npmXyHJ9h_eHtm0lcLdvDeE_9iVYH5EgNO1uECszkkpo6Xp2mWrdBHkpWNljrH0kMSPmRZM5Ztg3yD7t-YfJnvIWXQw5"/>
                </div>
                <div class="flex-1 space-y-2">
                    <h2 class="text-4xl font-bold tracking-tighter text-on-surface">${client.name}</h2>
                    <p class="text-on-surface-variant text-lg font-medium">
                        Age ${client.age} • ${client.height}cm / ${client.weight}kg
                    </p>
                    <div class="flex flex-wrap gap-3 mt-4">
                        <div class="inline-flex items-center gap-2 px-4 py-1.5 bg-surface-container-low rounded-full border border-outline-variant/20">
                            <span class="material-symbols-outlined text-[16px] text-tertiary">track_changes</span>
                            <span class="text-xs font-semibold text-on-surface-variant">${client.goals}</span>
                        </div>
                    </div>
                </div>
                <div class="flex gap-4 w-full md:w-auto">
                    <div class="bg-surface-container-low px-4 py-3 md:px-6 md:py-4 rounded-2xl flex-1 md:flex-initial text-center border border-outline-variant/10">
                        <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">
                            Current Weight</p>
                        <div class="flex items-baseline justify-center gap-1">
                            <span class="text-3xl font-bold text-primary">${client.weight}</span>
                            <span class="text-sm font-medium text-on-surface-variant">kg</span>
                        </div>
                    </div>
                    <div class="bg-surface-container-low px-4 py-3 md:px-6 md:py-4 rounded-2xl flex-1 md:flex-initial text-center border border-outline-variant/10">
                        <p class="text-[10px] font-bold text-on-surface-variant uppercase tracking-widest mb-1">
                            남은 수업</p>
                        <div class="flex items-baseline justify-center gap-1">
                            <span class="text-3xl font-bold text-on-surface">${client.lessonCount}</span>
                            <span class="text-sm font-medium text-on-surface-variant">회</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Main Layout Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <!-- Left Column: Overview & Stats -->
            <div class="lg:col-span-8 space-y-8">
                <!-- Segmented Control -->
                <nav class="flex gap-1 p-1.5 bg-surface-container-low rounded-2xl w-max max-w-full overflow-x-auto no-scrollbar">
                    <button
                            class="px-8 py-2.5 text-sm font-semibold text-primary bg-surface-container-lowest rounded-xl shadow-sm transition-all">
                        Overview
                    </button>
                    <a href="${pageContext.request.contextPath}/trainer/meals?clientId=${client.clientId}" class="btn-primary px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors">
                        Meals
                    </a>
                    <button
                            class="px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors">
                        Workouts
                    </button>
                    <a href="${pageContext.request.contextPath}/trainer/clientInbodyLog?clientId=${client.clientId}"
                       class="px-8 py-2.5 text-sm font-medium text-on-surface-variant hover:text-on-surface transition-colors">
                        InBody
                    </a>
                </nav>
                <!-- Body Composition Trends -->
                <section class="space-y-4">
                    <div class="flex justify-between items-end">
                        <div class="space-y-1">
                            <h3 class="text-2xl font-bold tracking-tight">Body Composition Trends</h3>
                            <p class="text-sm text-on-surface-variant font-medium">Track weight, muscle mass, and
                                body fat over time</p>
                        </div>
                    </div>
                    <div
                            class="bg-surface-container-lowest p-8 rounded-3xl border border-outline-variant/10 space-y-8">
                        <!-- Summary Stats Cards -->
                        <c:choose>
                            <c:when test="${latestInbody != null}">
                                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3 md:gap-4">
                                    <div data-metric="weight" onclick="showMetric('weight', this)"
                                         class="metric-card ring-2 ring-primary p-4 rounded-2xl bg-primary/5 border border-primary/10">
                                        <p class="text-[10px] font-bold text-primary uppercase tracking-widest mb-1">Weight</p>
                                        <div class="flex items-baseline gap-2">
                                            <span class="text-2xl font-bold text-on-surface">${latestInbody.weight}</span>
                                            <span class="text-xs font-medium text-on-surface-variant">kg</span>
                                        </div>
                                    </div>
                                    <div data-metric="muscle" onclick="showMetric('muscle', this)"
                                         class="metric-card p-4 rounded-2xl bg-green-50 border border-green-100">
                                        <p class="text-[10px] font-bold text-green-700 uppercase tracking-widest mb-1">Muscle Mass</p>
                                        <div class="flex items-baseline gap-2">
                                            <span class="text-2xl font-bold text-on-surface">${latestInbody.muscleMass}</span>
                                            <span class="text-xs font-medium text-on-surface-variant">kg</span>
                                        </div>
                                    </div>
                                    <div data-metric="bodyFat" onclick="showMetric('bodyFat', this)"
                                         class="metric-card p-4 rounded-2xl bg-orange-50 border border-orange-100">
                                        <p class="text-[10px] font-bold text-tertiary uppercase tracking-widest mb-1">Body Fat</p>
                                        <div class="flex items-baseline gap-2">
                                            <span class="text-2xl font-bold text-on-surface">${latestInbody.bodyFat}</span>
                                            <span class="text-xs font-medium text-on-surface-variant">kg</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Multi-Line Graph Area -->
                                <div>
                                    <canvas id="myChart"></canvas>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="flex flex-col items-center justify-center py-12 text-center text-on-surface-variant gap-2">
                                    <span class="material-symbols-outlined text-4xl">monitor_weight</span>
                                    <p class="font-semibold">인바디 기록이 없습니다</p>
                                    <p class="text-sm">회원이 인바디를 등록하면 여기에 표시됩니다.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>
                <!-- Recent Meal -->
                <section class="space-y-4">
                    <div class="flex justify-between items-end">
                        <h3 class="text-2xl font-bold tracking-tight">Recent Meal</h3>
                        <span class="text-on-surface-variant text-sm font-medium">Today 12:30 PM</span>
                    </div>
                    <div
                            class="bg-surface-container-lowest p-6 rounded-3xl border border-outline-variant/10 space-y-6">
                        <div class="flex gap-6 items-center">
                            <img alt="Healthy meal bowl" class="w-24 h-24 rounded-2xl object-cover shadow-sm"
                                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuDtRTiOLbN7PHNXM5m46FGSACydTKXN7WG79apaHKenSPf-udoC2aL1sO9ZC74iyl4sRBwwJNqKKYap4fRLJQ7j2p745sHXcEd55MdUBqB7dbdB-QtVpntZNDqK18rchXW7pq4j9qumUI3R1svaIy9D8Ofg7PwkJneIYKx-CkB_KbSNqvQjyVqHnXYMw4AKJV5We-xGPU88_MQpu4REWdyGynLoTh797ltu_1kXZd1SE8hFbJQdEepCuNz9d-9c-xGnZDh1zdsVbO0y"/>
                            <div class="flex-1">
                                <p class="text-xl font-bold text-on-surface">Chicken Salad &amp; Avocado</p>
                                <p class="text-on-surface-variant font-medium">High Protein • 420 kcal</p>
                                <div class="mt-2 flex gap-2">
                                        <span
                                                class="px-2 py-0.5 bg-green-50 text-green-700 text-[10px] font-bold rounded uppercase">Breakfast</span>
                                    <span
                                            class="px-2 py-0.5 bg-blue-50 text-blue-700 text-[10px] font-bold rounded uppercase">Healthy</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Recent Workout Section -->
                <section class="space-y-4 mt-8">
                    <div class="flex justify-between items-end">
                        <h3 class="text-2xl font-bold tracking-tight">Recent Workout</h3>
                        <span class="text-on-surface-variant text-sm font-medium">Today 10:00 AM</span>
                    </div>
                    <div
                            class="bg-surface-container-lowest p-6 rounded-3xl border border-outline-variant/10 space-y-6">
                        <div class="space-y-4">
                            <div
                                    class="flex items-center gap-4 p-3 hover:bg-surface-container-low rounded-2xl transition-colors">
                                <div
                                        class="w-10 h-10 rounded-xl bg-primary/10 flex items-center justify-center text-primary">
                                    <span class="material-symbols-outlined text-[20px]">fitness_center</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-on-surface">Bench Press (Barbell)</p>
                                    <p class="text-xs text-on-surface-variant font-medium">4 Sets × 10 Reps • 60kg
                                    </p>
                                </div>
                            </div>
                            <div
                                    class="flex items-center gap-4 p-3 hover:bg-surface-container-low rounded-2xl transition-colors">
                                <div
                                        class="w-10 h-10 rounded-xl bg-primary/10 flex items-center justify-center text-primary">
                                    <span class="material-symbols-outlined text-[20px]">fitness_center</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-on-surface">Incline DB Press</p>
                                    <p class="text-xs text-on-surface-variant font-medium">3 Sets × 12 Reps • 20kg
                                    </p>
                                </div>
                            </div>
                            <div
                                    class="flex items-center gap-4 p-3 hover:bg-surface-container-low rounded-2xl transition-colors">
                                <div
                                        class="w-10 h-10 rounded-xl bg-primary/10 flex items-center justify-center text-primary">
                                    <span class="material-symbols-outlined text-[20px]">reorder</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-on-surface">Tricep Pushdown (Cables)</p>
                                    <p class="text-xs text-on-surface-variant font-medium">3 Sets × 15 Reps • 25kg
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns"></script>
<script>

    const chartData = {
        weight:  ${weightJson},
        bodyFat: ${bodyFatJson},
        muscle:  ${muscleJson}
    };

    const myChartEl = document.getElementById('myChart');
    if (!myChartEl) { /* no inbody data — chart canvas not rendered */ }
    const myChart = myChartEl ? new Chart(myChartEl, {
        type: 'line',
        data: {
            datasets: [{
                label: 'Weight (kg)',
                data: chartData.weight,
                borderColor: '#0058bc',
                backgroundColor: '#0058bc',
            }]
        },
        options: {
            scales: {
                x: {
                    type: 'time',
                    time: {unit: 'day'}
                }
            }
        }
    }) : null;

    function setActiveCard(type, element) {
        document.querySelectorAll('.metric-card').forEach(card => {
            card.classList.remove('ring-2', 'ring-weight', 'ring-muscle', 'ring-bodyFat');
        });

        element.classList.add('ring-2');

        if (type === 'weight') element.classList.add('ring-weight');
        if (type === 'muscle') element.classList.add('ring-muscle');
        if (type === 'bodyFat') element.classList.add('ring-bodyFat');
    }

    function showMetric(type, element) {

        let dataset;

        if (type === 'weight') {
            dataset = {
                label: 'Weight (kg)',
                data: chartData.weight,
                borderColor: '#0058bc',
                backgroundColor: '#0058bc',
            };
        }

        if (type === 'bodyFat') {
            dataset = {
                label: 'Body Fat (%)',
                data: chartData.bodyFat,
                borderColor: '#f97316',
                backgroundColor: '#f97316',

            };
        }

        if (type === 'muscle') {
            dataset = {
                label: 'Muscle Mass (kg)',
                data: chartData.muscle,
                borderColor: '#22c55e',
                backgroundColor: '#22c55e',
            };
        }

        if (myChart) {
            myChart.data.datasets = [dataset];
            myChart.update();
        }

        setActiveCard(type, element);

        window.addEventListener('DOMContentLoaded', () => {
            const defaultCard = document.querySelector('[data-metric="weight"]');
            if (defaultCard) {
                showMetric('weight', defaultCard);
            }
        });
    }
</script>
</body>
</html>
