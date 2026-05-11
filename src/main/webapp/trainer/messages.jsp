<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Fitzberg - Messages</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <script id="tailwind-config">tailwind.config = {
        darkMode: "class", theme: {
            extend: {
                colors: {
                    "surface-container-lowest": "#ffffff",
                    "surface-container-low": "#f3f3f8",
                    "surface-container": "#ededf2",
                    "surface-container-high": "#e8e8ed",
                    "on-surface": "#1a1c1f",
                    "on-surface-variant": "#414755",
                    "outline": "#717786",
                    "outline-variant": "#c1c6d7",
                    "primary": "#0058bc",
                    "on-primary": "#ffffff",
                    "surface": "#f9f9fe",
                }
            }
        }
    };</script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .bubble-trainer { background: linear-gradient(135deg, #0058bc 0%, #0070eb 100%); }
    </style>
</head>
<body class="bg-surface text-on-surface antialiased">

<c:set var="activePage" value="messages" scope="request"/>
<jsp:include page="/trainer/sideNav.jsp"/>
<jsp:include page="/trainer/mobileBottomNav.jsp"/>
<jsp:include page="/trainer/mobileTopHeader.jsp"/>

<main class="lg:ml-64 h-screen pt-14 pb-20 lg:pt-0 lg:pb-0 flex flex-col bg-white">
    <div class="flex-1 flex overflow-hidden min-h-0">

        <!-- ── Left: Room List ── -->
        <section class="${not empty currentRoomId ? 'hidden lg:flex' : 'flex'} w-full lg:w-80 xl:w-96 flex-col bg-surface-container-low border-r border-outline-variant/20">
            <div class="p-6">
                <div class="flex items-center justify-between mb-6">
                    <h1 class="text-2xl font-bold tracking-tight">메세지</h1>
                    <c:if test="${unreadCount > 0}">
                        <span class="w-6 h-6 bg-primary text-white text-[11px] font-bold rounded-full flex items-center justify-center">${unreadCount}</span>
                    </c:if>
                </div>
                <div class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline text-[18px]">search</span>
                    <input class="w-full bg-surface-container-lowest border-none rounded-xl py-2.5 pl-10 pr-4 text-sm focus:ring-2 focus:ring-primary/20 placeholder:text-outline-variant"
                           placeholder="회원 검색" type="text" oninput="filterRooms(this.value)"/>
                </div>
            </div>

            <div class="flex-1 overflow-y-auto px-3 space-y-1" id="roomList">
                <c:choose>
                    <c:when test="${empty rooms}">
                        <p class="text-sm text-on-surface-variant text-center py-10">대화 내역이 없습니다.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="room" items="${rooms}">
                            <c:set var="isActive" value="${room.roomId == currentRoomId}"/>
                            <a href="${pageContext.request.contextPath}/trainer/messages?roomId=${room.roomId}"
                               class="room-item flex items-center gap-4 p-4 rounded-2xl cursor-pointer transition-colors
                                      ${isActive ? 'bg-surface-container-lowest shadow-sm' : 'hover:bg-surface-container-high'}">
                                <div class="shrink-0">
                                    <c:choose>
                                        <c:when test="${not empty room.partnerProfileImg}">
                                            <img alt="${room.partnerNickname}" class="w-12 h-12 rounded-full object-cover"
                                                 src="${pageContext.request.contextPath}/uploads/${room.partnerProfileImg}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                                                <span class="material-symbols-outlined text-primary">person</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <div class="flex items-center justify-between mb-0.5">
                                        <h3 class="text-sm font-semibold truncate room-name">${room.partnerNickname}</h3>
                                        <span class="text-[10px] ${isActive ? 'text-primary font-bold' : 'text-outline font-medium'}">${room.lastTime}</span>
                                    </div>
                                    <p class="text-xs text-on-surface-variant truncate">${room.lastMessage}</p>
                                </div>
                                <c:if test="${room.unreadCount > 0}">
                                    <span class="w-5 h-5 bg-primary text-white text-[10px] font-bold rounded-full flex items-center justify-center shrink-0">${room.unreadCount}</span>
                                </c:if>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- ── Right: Chat Window ── -->
        <section class="${empty currentRoomId ? 'hidden lg:flex' : 'flex'} flex-1 flex-col bg-surface-container-lowest min-w-0">
            <c:choose>
                <c:when test="${empty currentRoomId}">
                    <div class="flex-1 flex flex-col items-center justify-center text-on-surface-variant gap-3">
                        <span class="material-symbols-outlined text-5xl text-outline-variant">chat</span>
                        <p class="text-sm font-medium">대화를 선택하세요.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Chat Header -->
                    <header class="h-16 flex items-center justify-between px-4 lg:px-8 border-b border-surface-container-low shadow-sm shrink-0">
                        <div class="flex items-center gap-3">
                            <a href="${pageContext.request.contextPath}/trainer/messages"
                               class="lg:hidden p-1.5 rounded-lg hover:bg-surface-container-low text-on-surface-variant">
                                <span class="material-symbols-outlined text-[22px]">arrow_back</span>
                            </a>
                            <c:choose>
                                <c:when test="${not empty partnerProfileImg}">
                                    <img alt="${partnerNickname}" class="w-10 h-10 rounded-full object-cover"
                                         src="${pageContext.request.contextPath}/uploads/${partnerProfileImg}"/>
                                </c:when>
                                <c:otherwise>
                                    <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center">
                                        <span class="material-symbols-outlined text-primary text-[20px]">person</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <h2 class="text-base font-bold">${partnerNickname}</h2>
                        </div>
                    </header>

                    <!-- Message History -->
                    <div class="flex-1 overflow-y-auto p-4 lg:p-8 space-y-4 flex flex-col" id="messageHistory">
                        <c:choose>
                            <c:when test="${empty messages}">
                                <div class="flex-1 flex items-center justify-center">
                                    <p class="text-sm text-on-surface-variant">아직 메시지가 없습니다. 먼저 인사해보세요!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="msg" items="${messages}">
                                    <c:choose>
                                        <%-- My message (right) --%>
                                        <c:when test="${msg.senderId == sessionScope.loginUser.id}">
                                            <div class="flex items-end gap-3 flex-row-reverse max-w-[75%] self-end">
                                                <div class="space-y-1 text-right">
                                                    <div class="bubble-trainer px-4 py-3 rounded-2xl rounded-br-none text-sm leading-relaxed text-white">
                                                        <c:out value="${msg.message}"/>
                                                    </div>
                                                    <span class="text-[10px] text-outline-variant font-medium px-1">${msg.sendDate}</span>
                                                </div>
                                            </div>
                                        </c:when>
                                        <%-- Partner message (left) --%>
                                        <c:otherwise>
                                            <div class="flex items-end gap-3 max-w-[75%]">
                                                <c:choose>
                                                    <c:when test="${not empty msg.senderProfileImg}">
                                                        <img alt="${msg.senderNickname}" class="w-8 h-8 rounded-full object-cover mb-1 shrink-0"
                                                             src="${pageContext.request.contextPath}/uploads/${msg.senderProfileImg}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center mb-1 shrink-0">
                                                            <span class="material-symbols-outlined text-primary text-[16px]">person</span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="space-y-1">
                                                    <div class="bg-surface-container-low px-4 py-3 rounded-2xl rounded-bl-none text-sm leading-relaxed text-on-surface">
                                                        <c:out value="${msg.message}"/>
                                                    </div>
                                                    <span class="text-[10px] text-outline-variant font-medium px-1">${msg.sendDate}</span>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Message Input -->
                    <footer class="p-3 lg:p-6 border-t border-surface-container-low shrink-0">
                        <form method="post" action="${pageContext.request.contextPath}/trainer/messages"
                              class="flex items-end gap-3 bg-surface-container-low p-2 rounded-2xl border border-surface-container">
                            <input type="hidden" name="roomId"    value="${currentRoomId}"/>
                            <input type="hidden" name="partnerId" value="${partnerId}"/>
                            <textarea name="message" rows="1" id="msgInput"
                                      class="flex-1 bg-transparent border-none focus:ring-0 text-sm py-2.5 resize-none max-h-32 placeholder:text-outline"
                                      placeholder="Message ${partnerNickname}..."
                                      onkeydown="submitOnEnter(event)"></textarea>
                            <button type="submit"
                                    class="w-10 h-10 flex items-center justify-center bg-primary text-white rounded-xl shadow-lg shadow-primary/20 active:scale-90 transition-all">
                                <span class="material-symbols-outlined text-[20px]">send</span>
                            </button>
                        </form>
                    </footer>
                </c:otherwise>
            </c:choose>
        </section>
    </div>
</main>

<script>
    const history = document.getElementById('messageHistory');
    if (history) history.scrollTop = history.scrollHeight;

    function submitOnEnter(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            e.target.closest('form').submit();
        }
    }

    function filterRooms(query) {
        const q = query.toLowerCase();
        document.querySelectorAll('.room-item').forEach(item => {
            const name = item.querySelector('.room-name')?.textContent.toLowerCase() || '';
            item.style.display = name.includes(q) ? '' : 'none';
        });
    }
</script>
</body>
</html>
