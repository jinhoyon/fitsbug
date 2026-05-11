<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<title>핏츠버그 - 결제 완료</title>

<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<style>
*,*::before,*::after{
    box-sizing:border-box;
    margin:0;
    padding:0;
}

body{
    font-family:'Noto Sans KR','Nunito',sans-serif;
    background:#F7F9FC;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
}

@keyframes fb_pop{
    0%{
        opacity:0;
        transform:scale(0.7);
    }
    60%{
        transform:scale(1.08);
    }
    100%{
        opacity:1;
        transform:scale(1);
    }
}

@keyframes fb_float{
    0%,100%{
        transform:translateY(0);
    }
    50%{
        transform:translateY(-10px);
    }
}

@keyframes confetti_fall{
    0%{
        opacity:1;
        transform:translateY(-20px) rotate(0deg);
    }
    100%{
        opacity:0;
        transform:translateY(300px) rotate(720deg);
    }
}
</style>
</head>

<body>

<div style="background:white;border-radius:32px;padding:56px 48px;width:100%;max-width:460px;text-align:center;box-shadow:0 16px 60px rgba(0,0,0,0.12);position:relative;overflow:hidden;">

    <!-- 배경 원 -->
    <div style="position:absolute;width:300px;height:300px;border-radius:50%;background:rgba(0,191,165,0.06);top:-80px;right:-60px;"></div>
    <div style="position:absolute;width:200px;height:200px;border-radius:50%;background:rgba(255,107,53,0.06);bottom:-40px;left:-40px;"></div>

    <!-- 핏불 캐릭터 -->
    <div style="position:relative;z-index:1;animation:fb_float 3s ease-in-out infinite;margin-bottom:24px;">
        <svg width="130" height="130" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" style="filter:drop-shadow(0 8px 20px rgba(0,191,165,0.3));">
            <ellipse cx="100" cy="148" rx="52" ry="36" fill="#00BFA5"/>
            <ellipse cx="100" cy="155" rx="44" ry="30" fill="#26D4BB"/>

            <circle cx="100" cy="85" r="44" fill="#7A7EA8"/>

            <circle cx="76" cy="60" r="15" fill="#7A7EA8"/>
            <circle cx="124" cy="60" r="15" fill="#7A7EA8"/>

            <circle cx="76" cy="60" r="9" fill="#F4A0A0"/>
            <circle cx="124" cy="60" r="9" fill="#F4A0A0"/>

            <ellipse cx="100" cy="90" rx="28" ry="22" fill="#E8E8F0"/>

            <path d="M58 70 Q100 55 142 70"
                  stroke="#FFD166"
                  stroke-width="7"
                  fill="none"
                  stroke-linecap="round"/>

            <circle cx="87" cy="80" r="6" fill="#1A1F36"/>
            <circle cx="113" cy="80" r="6" fill="#1A1F36"/>

            <circle cx="88.5" cy="78.5" r="2" fill="white"/>
            <circle cx="114.5" cy="78.5" r="2" fill="white"/>

            <ellipse cx="100" cy="93" rx="7" ry="5" fill="#1A1F36"/>

            <path d="M87 103 Q100 115 113 103"
                  stroke="#FF6B35"
                  stroke-width="3.5"
                  fill="none"
                  stroke-linecap="round"/>

            <ellipse cx="80" cy="97" rx="8" ry="5" fill="#FFB4A2" opacity="0.8"/>
            <ellipse cx="120" cy="97" rx="8" ry="5" fill="#FFB4A2" opacity="0.8"/>

            <!-- 따봉 오른팔 -->
            <ellipse cx="155" cy="120"
                     rx="24"
                     ry="14"
                     fill="#7A7EA8"
                     transform="rotate(-25 155 120)"/>

            <rect x="144"
                  y="90"
                  width="28"
                  height="22"
                  rx="11"
                  fill="#7A7EA8"/>

            <ellipse cx="143"
                     cy="85"
                     rx="10"
                     ry="13"
                     fill="#7A7EA8"
                     transform="rotate(15 143 85)"/>
        </svg>
    </div>

    <!-- 체크 -->
    <div style="position:relative;z-index:1;width:64px;height:64px;border-radius:50%;background:linear-gradient(135deg,#00BFA5,#26D4BB);display:flex;align-items:center;justify-content:center;margin:0 auto 20px;animation:fb_pop 0.6s ease both;box-shadow:0 6px 20px rgba(0,191,165,0.35);">
        <svg width="30" height="30" viewBox="0 0 24 24" fill="none">
            <path d="M5 13l4 4L19 7"
                  stroke="white"
                  stroke-width="2.5"
                  stroke-linecap="round"
                  stroke-linejoin="round"/>
        </svg>
    </div>

    <h1 style="font-size:28px;font-weight:900;color:#1A1F36;margin-bottom:10px;position:relative;z-index:1;">
        결제 완료! 🎉
    </h1>

    <p style="font-size:15px;color:#9DA8C0;line-height:1.6;margin-bottom:32px;position:relative;z-index:1;">
        핏불이 응원해요! 트레이너와 함께<br>
        최고의 결과를 만들어봐요 💪
    </p>

    <!-- 오류 메시지 -->
    <c:if test="${not empty errorMsg}">
        <div style="background:#FFF0F0;border:1.5px solid #FFB4B4;border-radius:12px;padding:14px 18px;margin-bottom:20px;font-size:13px;color:#D32F2F;text-align:left;position:relative;z-index:1;">
            <strong>오류:</strong> ${errorMsg}
        </div>
    </c:if>

    <!-- 결제 요약 -->
    <div style="background:#F7F9FC;border-radius:16px;padding:20px;margin-bottom:28px;position:relative;z-index:1;">

        <div style="display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px solid #E8EDF5;">
            <span style="font-size:13px;color:#9DA8C0;font-weight:600;">
                트레이너
            </span>

            <span style="font-size:13px;font-weight:700;color:#1A1F36;">
                ${trainerName} 트레이너
            </span>
        </div>

        <div style="display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px solid #E8EDF5;">
            <span style="font-size:13px;color:#9DA8C0;font-weight:600;">
                수업 횟수
            </span>

            <span style="font-size:13px;font-weight:700;color:#1A1F36;">
                PT ${sessionCount}회권
            </span>
        </div>

        <div style="display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px solid #E8EDF5;">
            <span style="font-size:13px;color:#9DA8C0;font-weight:600;">
                결제 금액
            </span>

            <span style="font-size:15px;font-weight:900;color:#FF6B35;">
                <fmt:formatNumber value="${amount}" pattern="#,###"/>원
            </span>
        </div>

        <div style="display:flex;justify-content:space-between;align-items:center;padding:8px 0;">
            <span style="font-size:13px;color:#9DA8C0;font-weight:600;">
                결제 상태
            </span>

            <span style="font-size:13px;font-weight:700;color:#00897B;background:#E8F8F6;padding:4px 12px;border-radius:99px;">
                ✔ 결제 완료
            </span>
        </div>
    </div>

    <!-- 버튼 -->
    <div style="display:flex;flex-direction:column;gap:10px;position:relative;z-index:1;">

        <button
            onclick="location.href='${pageContext.request.contextPath}/member/mypage'"
            style="width:100%;padding:14px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:15px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 6px 20px rgba(255,107,53,0.3);transition:all 0.2s;"
            onmouseover="this.style.transform='translateY(-2px)'"
            onmouseout="this.style.transform='none'">

            마이페이지에서 확인하기 →
        </button>

        <button
            onclick="location.href='${pageContext.request.contextPath}/member/main'"
            style="width:100%;padding:12px;border-radius:99px;border:1.5px solid #E8EDF5;cursor:pointer;background:white;color:#5A6480;font-size:14px;font-weight:700;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;"
            onmouseover="this.style.background='#F7F9FC'"
            onmouseout="this.style.background='white'">

            홈으로 돌아가기
        </button>
    </div>
</div>

<script>

// ==============================
// 컨페티 효과
// ==============================

(function(){

    const colors = [
        '#FF6B35',
        '#FFD166',
        '#00BFA5',
        '#FF8C5A',
        '#26D4BB'
    ];

    for(let i=0;i<20;i++){

        const el = document.createElement('div');

        const size = 8 + Math.random() * 10;

        el.style.cssText =
            'position:fixed;' +
            'width:' + size + 'px;' +
            'height:' + size + 'px;' +
            'border-radius:' + (Math.random() > 0.5 ? '50%' : '3px') + ';' +
            'background:' + colors[Math.floor(Math.random() * colors.length)] + ';' +
            'left:' + (Math.random() * 100) + 'vw;' +
            'top:-20px;' +
            'animation:confetti_fall ' + (2 + Math.random() * 3) + 's ease ' + (Math.random() * 2) + 's forwards;' +
            'z-index:9999;' +
            'pointer-events:none;';

        document.body.appendChild(el);

        setTimeout(() => {
            el.remove();
        }, 5000);
    }

})();

</script>

</body>
</html>