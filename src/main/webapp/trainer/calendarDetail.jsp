<%--
  Created by IntelliJ IDEA.
  User: jinhoyon
  Date: 4/28/26
  Time: 1:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Fitzberg - Calendar Details</title>
    <!-- Inter Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&amp;display=swap"
          rel="stylesheet" />
    <!-- Material Symbols -->
    <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
    <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-secondary-container": "#2d4c83",
                        "on-primary-fixed-variant": "#004493",
                        "surface-variant": "#e2e2e7",
                        "primary-container": "#0070eb",
                        "on-primary": "#ffffff",
                        "background": "#f9f9fe",
                        "on-tertiary-fixed": "#351000",
                        "inverse-surface": "#2e3034",
                        "tertiary": "#9e3d00",
                        "on-surface": "#1a1c1f",
                        "on-error-container": "#93000a",
                        "outline": "#717786",
                        "on-tertiary-fixed-variant": "#7c2e00",
                        "surface-dim": "#d9dade",
                        "primary": "#0058bc",
                        "surface-bright": "#f9f9fe",
                        "on-tertiary-container": "#fffbff",
                        "outline-variant": "#c1c6d7",
                        "on-primary-fixed": "#001a41",
                        "inverse-primary": "#adc6ff",
                        "on-tertiary": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "surface-container-high": "#e8e8ed",
                        "inverse-on-surface": "#f0f0f5",
                        "secondary": "#405e96",
                        "surface-tint": "#005bc1",
                        "on-error": "#ffffff",
                        "error": "#ba1a1a",
                        "primary-fixed-dim": "#adc6ff",
                        "surface-container-low": "#f3f3f8",
                        "on-secondary-fixed-variant": "#26467d",
                        "surface": "#f9f9fe",
                        "on-background": "#1a1c1f",
                        "surface-container-highest": "#e2e2e7",
                        "on-primary-container": "#fefcff",
                        "on-surface-variant": "#414755",
                        "secondary-fixed-dim": "#adc6ff",
                        "primary-fixed": "#d8e2ff",
                        "secondary-fixed": "#d8e2ff",
                        "tertiary-container": "#c64f00",
                        "tertiary-fixed-dim": "#ffb595",
                        "error-container": "#ffdad6",
                        "secondary-container": "#a1befd",
                        "tertiary-fixed": "#ffdbcc",
                        "on-secondary": "#ffffff",
                        "on-secondary-fixed": "#001a41",
                        "surface-container": "#ededf2"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.125rem",
                        "lg": "0.25rem",
                        "xl": "0.5rem",
                        "full": "0.75rem"
                    },
                    "fontFamily": {
                        "headline": ["Inter"],
                        "body": ["Inter"],
                        "label": ["Inter"]
                    }
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-background text-on-background antialiased overflow-hidden">
<!-- Background Layer: Mock Weekly Calendar (Blurred) -->
<div class="fixed inset-0 flex backdrop-blur-md bg-on-background/40">

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
                     src="${not empty sessionScope.loginUser.profileImg ? pageContext.request.contextPath.concat('/uploads/').concat(sessionScope.loginUser.profileImg) : pageContext.request.contextPath.concat('/img/profile_img.jpg')}" />
            </a>
        </div>
    </header>

    <!-- SideNavBar -->
    <c:set var="activePage" value="calendar" scope="request"/>
    <jsp:include page="/trainer/sideNav.jsp"/>
    <jsp:include page="/trainer/mobileBottomNav.jsp"/>


    <!-- Calendar Main View (Blurred) -->
    <main class="flex-1 flex flex-col">
        <!-- HEADER -->

        <!-- GRID -->
        <div class="p-6 grid grid-cols-7 gap-4 flex-1">
            <!-- Mock calendar grid -->
            <div class="space-y-4">
                <div class="text-xs font-bold text-slate-400">MON 23</div>
                <div class="h-24 bg-primary/10 rounded-lg border-l-4 border-primary p-2"></div>
            </div>
            <div class="space-y-4">
                <div class="text-xs font-bold text-slate-400">TUE 24</div>
                <div class="h-32 bg-secondary/10 rounded-lg border-l-4 border-secondary p-2"></div>
            </div>
            <div class="space-y-4">
                <div class="text-xs font-bold text-primary">WED 25</div>
                <div class="h-20 bg-primary rounded-lg p-2 text-white shadow-lg">10:00 AM Session</div>
            </div>
            <div class="space-y-4">
                <div class="text-xs font-bold text-slate-400">THU 26</div>
            </div>
            <div class="space-y-4">
                <div class="text-xs font-bold text-slate-400">FRI 27</div>
                <div class="h-40 bg-tertiary/10 rounded-lg border-l-4 border-tertiary p-2"></div>
            </div>
            <div class="space-y-4">
                <div class="text-xs font-bold text-slate-400">SAT 28</div>
            </div>
            <div class="space-y-4">
                <div class="text-xs font-bold text-slate-400">SUN 29</div>
            </div>
        </div>
    </main>
</div>

<!-- Modal Overlay -->
<div class="fixed inset-0 lg:left-64 z-50 flex items-center justify-center p-4">
    <!-- Modal Card -->
    <div
            class="bg-white w-full max-w-lg rounded-[1.5rem] shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-300">
        <!-- Header Section -->
        <div class="relative px-8 pt-8 pb-6 flex items-start justify-between">
            <div class="flex items-center gap-4">
                <img alt="Marcus Thorne" class="w-16 h-16 rounded-full object-cover border-2 border-primary/10"
                     data-alt="close-up portrait of Marcus Thorne, a middle-aged man with a friendly smile, athletic build, in a bright modern gym setting"
                     src="https://lh3.googleusercontent.com/aida-public/AB6AXuAgxZKTWgIlDrZS-XEqRTcfxQU55R5ANyRrr5Z3G2xzKj-rjEvJF8e_MwWEpSRylvdoB_eWzmq2z20omLRLndux6b-4JiiQ1pD6UqUKnDXJ1uT1iXDR9CXo96f7ClRwBWiofwr3F7rGq6p4DxGeMR0AWFKNoBjACKTvaVA00wZvsZqhOtMjf7F2PBVv3_CazKqRun60J4sm8ifrDG4dgY1ASaBf4enZl58pL50htGJilyWwOHjJE2x2r0Whxql2VWtSt89X4TG8Xk9W" />
                <div>
                    <h2 class="text-2xl font-bold text-on-surface tracking-tight">Marcus Thorne</h2>
                    <span
                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-primary-container/10 text-primary uppercase tracking-wider">
                            Advanced Strength
                        </span>
                </div>
            </div>
            <button class="p-2 hover:bg-surface-container rounded-full transition-colors">
                <span class="material-symbols-outlined text-outline">close</span>
            </button>
        </div>
        <!-- Body Section -->
        <div class="px-8 space-y-6 pb-8">
            <!-- Detail Row: Time -->
            <div class="flex items-start gap-4">
                <div
                        class="w-10 h-10 rounded-xl bg-surface-container flex items-center justify-center flex-shrink-0">
                    <span class="material-symbols-outlined text-primary">calendar_today</span>
                </div>
                <div>
                    <p class="text-xs font-semibold text-outline uppercase tracking-wider mb-0.5">Date &amp; Time
                    </p>
                    <p class="text-on-surface font-medium">Wednesday, Oct 25 • 10:00 AM - 11:00 AM</p>
                </div>
            </div>
            <!-- Detail Row: Location -->
            <div class="flex items-start gap-4">
                <div
                        class="w-10 h-10 rounded-xl bg-surface-container flex items-center justify-center flex-shrink-0">
                    <span class="material-symbols-outlined text-primary">location_on</span>
                </div>
                <div>
                    <p class="text-xs font-semibold text-outline uppercase tracking-wider mb-0.5">Location</p>
                    <p class="text-on-surface font-medium">Fitzberg Elite Center - Studio B</p>
                </div>
            </div>
            <!-- Detail Row: Goals -->
            <div class="flex items-start gap-4">
                <div
                        class="w-10 h-10 rounded-xl bg-surface-container flex items-center justify-center flex-shrink-0">
                    <span class="material-symbols-outlined text-primary">target</span>
                </div>
                <div>
                    <p class="text-xs font-semibold text-outline uppercase tracking-wider mb-0.5">Client Goals</p>
                    <p class="text-on-surface-variant leading-relaxed">Hypertrophy Phase 2, focus on squat form.</p>
                </div>
            </div>
            <!-- Detail Row: Notes -->
            <div class="flex items-start gap-4 bg-surface-container-low p-4 rounded-xl">
                <div class="w-8 h-8 rounded-lg bg-white shadow-sm flex items-center justify-center flex-shrink-0">
                    <span class="material-symbols-outlined text-tertiary text-sm">sticky_note_2</span>
                </div>
                <div>
                    <p class="text-xs font-semibold text-on-surface-variant uppercase tracking-wider mb-1">Session
                        Notes</p>
                    <p class="text-sm text-on-surface-variant italic leading-relaxed">
                        "Client mentioned slight knee tightness last session. Warm up thoroughly."
                    </p>
                </div>
            </div>
        </div>
        <!-- Action Footer -->
        <div
                class="bg-surface-container-lowest px-8 py-6 border-t border-surface-variant flex flex-col sm:flex-row gap-3">
            <button
                    class="flex-1 bg-primary text-white font-bold py-3.5 rounded-xl hover:bg-primary-container transition-all active:scale-[0.98] flex items-center justify-center gap-2">
                    <span class="material-symbols-outlined text-lg"
                          style="font-variation-settings: 'FILL' 1;">chat</span>
                Message Marcus
            </button>
            <div class="flex gap-3">
                <button
                        class="flex-1 sm:flex-none px-6 py-3.5 bg-surface-container text-on-surface-variant font-semibold rounded-xl hover:bg-surface-variant transition-all active:scale-[0.98]">
                    View Profile
                </button>
                <button
                        class="flex-1 sm:flex-none px-6 py-3.5 bg-surface-container text-on-surface-variant font-semibold rounded-xl hover:bg-surface-variant transition-all active:scale-[0.98]">
                    Edit Session
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Background Decoration -->
<div class="fixed top-0 right-0 w-96 h-96 bg-primary/5 rounded-full blur-3xl -z-10 -mr-48 -mt-48"></div>
<div class="fixed bottom-0 left-0 w-96 h-96 bg-secondary/5 rounded-full blur-3xl -z-10 -ml-48 -mb-48"></div>
</body>
</html>
