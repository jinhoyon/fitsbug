<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fitsbug - 스케줄 관리</title>

<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

<script>
tailwind.config = {
    darkMode: "class",
    theme: {
        extend: {
            colors: {
                primary: "#3B82F6",
                background: "#f8f9fb",
                surface: "#f8f9fb",
                "surface-container-lowest": "#ffffff",
                "surface-container-low": "#f3f4f6",
                "surface-variant": "#e1e2e4",
                "on-surface": "#191c1e",
                "on-surface-variant": "#424754",
                "outline-variant": "#c2c6d6"
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
body {
    font-family: 'Inter', sans-serif;
}

.material-symbols-outlined {
    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
    display: inline-block;
    line-height: 1;
    vertical-align: middle;
}

.no-scrollbar::-webkit-scrollbar {
    display: none;
}

.session-badge {
    background: #3B82F6;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    transition: all 0.2s ease;
}

.session-badge:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 6px rgba(59, 130, 246, 0.2);
}

.session-dimmed {
    background: #e1e2e4 !important;
    color: #424754 !important;
    box-shadow: none !important;
    opacity: 0.55;
}

.session-active {
    background: #3B82F6 !important;
    color: white !important;
    opacity: 1;
}
</style>
</head>

<body class="bg-background text-on-surface font-body antialiased">

<jsp:include page="common/sidebar.jsp"></jsp:include>

<main class="ml-64 min-h-screen flex flex-col bg-surface">

    <!-- Page Header -->
    <div class="p-8 pt-24 pb-0 max-w-[1440px] mx-auto w-full">
        <div class="flex justify-between items-end mb-8">
            <div>
                <h2 class="text-4xl font-black tracking-tight text-on-surface">스케줄 관리</h2>
            </div>
        </div>

        <!-- Control Bar -->
        <div class="bg-white rounded-xl px-6 py-4 flex items-center justify-between mb-6 shadow-sm border border-outline-variant/10">

            <!-- Trainer Dropdown -->
            <div class="flex items-center space-x-2 relative">
                <span class="text-xs font-bold text-on-surface-variant uppercase tracking-wider">Trainer</span>

                <button type="button" id="trainerDropdownBtn"
                    class="flex items-center space-x-1 cursor-pointer">
                    <span id="selectedTrainerName" class="text-sm font-bold text-primary">전체 트레이너</span>
                    <span class="material-symbols-outlined text-primary text-lg">expand_more</span>
                </button>

                <div id="trainerDropdown"
                    class="hidden absolute top-full left-0 mt-2 w-48 bg-white border border-outline-variant/20 rounded-lg shadow-xl py-1 z-[100]">

                    <div class="px-4 py-2 text-[10px] font-bold text-on-surface-variant/50 uppercase tracking-widest border-b border-outline-variant/10 mb-1">
                        Select Trainer
                    </div>

                    <button type="button"
                        class="trainer-option w-full text-left px-4 py-2.5 text-sm font-semibold text-primary bg-primary/5 hover:bg-primary/10"
                        data-trainer-id="">
                        전체 트레이너
                    </button>

                    <c:forEach var="trainer" items="${trainerList}">
                        <button type="button"
                            class="trainer-option w-full text-left px-4 py-2.5 text-sm font-medium text-on-surface hover:bg-surface-container-low"
                            data-trainer-id="${trainer.trainerId}">
                            ${trainer.trainerName}
                        </button>
                    </c:forEach>
                </div>
            </div>

            <!-- Week Control -->
            <div class="flex items-center space-x-6 text-sm font-medium text-on-surface-variant">
                <button onclick="moveWeek(-1)" class="material-symbols-outlined">chevron_left</button>
                <span class="text-on-surface font-bold min-w-[220px] text-center">
                    ${weekRangeText}
                </span>
                <button onclick="moveWeek(1)" class="material-symbols-outlined">chevron_right</button>
            </div>
        </div>
    </div>

    <!-- Calendar Area -->
    <div class="flex-grow px-8 pb-8 overflow-hidden flex flex-col max-w-[1440px] mx-auto w-full">
        <div class="bg-white rounded-2xl shadow-sm flex-grow flex flex-col overflow-hidden border border-outline-variant/20">

            <!-- Day Headers -->
            <div class="grid grid-cols-[80px_repeat(7,1fr)] border-b border-outline-variant/20 bg-white">
                <div class="p-4"></div>

                <c:forEach var="day" items="${dayList}">
                    <div class="p-4 text-center border-l border-outline-variant/20">
                        <p class="text-xs font-medium mb-1 ${day.value == 7 ? 'text-red-500' : day.value == 6 ? 'text-blue-500' : 'text-on-surface-variant'}">
                            ${day.name}
                        </p>
                        <p class="text-[11px] font-bold text-on-surface">
                            ${day.dateText}
                        </p>
                    </div>
                </c:forEach>
            </div>

            <!-- Time Grid -->
            <div class="flex-grow overflow-y-auto no-scrollbar">
                <div class="grid grid-cols-[80px_repeat(7,1fr)] auto-rows-[minmax(90px,auto)]">

                    <c:forEach var="hour" items="${hourList}">

                        <!-- Time Column -->
                        <div class="flex items-start justify-center pt-4 text-xs font-medium text-on-surface-variant border-b border-outline-variant/20">
                            ${hour}:00
                        </div>

                        <!-- Day Columns -->
                        <c:forEach var="day" items="${dayList}">
                            <div class="border-l border-b border-outline-variant/20 p-2 space-y-1">

							<c:if test="${not empty scheduleMap[hour][day.value]}">
                                <c:forEach var="session" items="${scheduleMap[hour][day.value]}">
                                    <div class="session-badge rounded flex flex-col justify-center text-white text-[10px] p-1.5 leading-tight"
                                         data-trainer-id="${session.trainerId}">
                                        <span class="font-bold">
                                            ${session.startTime} | ${session.trainerName} 
                                        </span>
                                        <span class="opacity-80">
                                            회원: ${session.clientName}
                                        </span>
                                    </div>
                                </c:forEach>
							</c:if>
                            </div>
                        </c:forEach>

                    </c:forEach>

                </div>
            </div>

        </div>
    </div>
</main>

<script>
const dropdownBtn = document.getElementById("trainerDropdownBtn");
const dropdown = document.getElementById("trainerDropdown");
const selectedTrainerName = document.getElementById("selectedTrainerName");

dropdownBtn.addEventListener("click", function () {
    dropdown.classList.toggle("hidden");
});

document.querySelectorAll(".trainer-option").forEach(option => {
    option.addEventListener("click", function () {
        const selectedTrainerId = this.dataset.trainerId;
        const selectedName = this.textContent.trim();

        selectedTrainerName.textContent = selectedName;
        dropdown.classList.add("hidden");

        document.querySelectorAll(".session-badge").forEach(badge => {
            const badgeTrainerId = badge.dataset.trainerId;

            badge.classList.remove("session-dimmed", "session-active");

            if (selectedTrainerId === "") {
                badge.classList.add("session-active");
            } else if (badgeTrainerId === selectedTrainerId) {
                badge.classList.add("session-active");
            } else {
                badge.classList.add("session-dimmed");
            }
        });
    });
});

document.addEventListener("click", function (e) {
    if (!dropdownBtn.contains(e.target) && !dropdown.contains(e.target)) {
        dropdown.classList.add("hidden");
    }
});

function moveWeek(offset) {
    const url = new URL(window.location.href);

    let weekOffset = url.searchParams.get("weekOffset");

    if (!weekOffset) weekOffset = 0;

    weekOffset = parseInt(weekOffset) + offset;

    url.searchParams.set("weekOffset", weekOffset);

    window.location.href = url.toString();
}

window.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".session-badge").forEach(badge => {
        badge.classList.add("session-active");
    });
});
</script>

</body>
</html>