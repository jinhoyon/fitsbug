<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*, dto.member.InquiryDTO"%>

<%
List<InquiryDTO> list = (List<InquiryDTO>) request.getAttribute("list");
if(list == null){
    list = new ArrayList<>();
}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">

<title>핏츠버그 - 고객센터</title>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
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
    display:flex;
    min-height:100vh;
}

.fb-inp{
    width:100%;
    padding:13px 18px;
    border-radius:14px;
    border:2px solid #E8EDF5;
    background:#F7F9FC;
    font-family:'Noto Sans KR',sans-serif;
    font-size:14px;
    color:#1A1F36;
    outline:none;
    transition:all 0.2s;
}

.fb-inp:focus{
    border-color:#FF6B35;
    box-shadow:0 0 0 3px rgba(255,107,53,0.12);
    background:white;
}

.fb-inp::placeholder{
    color:#C4CEDE;
}

.faq-item{
    border:1.5px solid #E8EDF5;
    border-radius:14px;
    overflow:hidden;
    margin-bottom:10px;
    transition:all 0.2s;
}

.faq-q{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:16px 20px;
    cursor:pointer;
    background:white;
    font-weight:700;
    font-size:14px;
    color:#1A1F36;
    transition:background 0.2s;
}

.faq-q:hover{
    background:#FFF3EE;
}

.faq-a{
    display:none;
    padding:14px 20px;
    background:#F7F9FC;
    font-size:14px;
    color:#5A6480;
    line-height:1.7;
    border-top:1.5px solid #E8EDF5;
}

.faq-item.open .faq-a{
    display:block;
}

.faq-item.open .faq-q{
    background:#FFF3EE;
    color:#FF6B35;
}

.faq-arrow{
    transition:transform 0.3s;
}

.faq-item.open .faq-arrow{
    transform:rotate(180deg);
}
</style>
</head>

<body>

<jsp:include page="sidebar.jsp"/>

<main style="flex:1;margin-left:260px;padding:32px 36px;display:flex;gap:28px;max-width:calc(100vw - 260px);">

<!-- 메인 -->
<div style="flex:1;min-width:0;display:flex;flex-direction:column;gap:24px;">

    <!-- 헤더 -->
    <div>
        <h2 style="font-size:26px;font-weight:900;color:#1A1F36;letter-spacing:-0.5px;">
            고객센터 🎧
        </h2>

        <p style="font-size:14px;color:#9DA8C0;margin-top:4px;">
            핏불 팀이 빠르게 도와드릴게요!
        </p>
    </div>

    <!-- 빠른 분류 -->
    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:14px;">

        <%
        String[][] quickCards = {
            {"💳","결제 문의","결제·환불 관련"},
            {"👤","계정 문의","로그인·비밀번호"},
            {"🔧","서비스 오류","버그·오작동 신고"},
            {"🚨","신고하기","부적절 게시물 신고"}
        };

        for(String[] c : quickCards){
        %>

        <div onclick="selectType('<%= c[0].equals("🚨") ? "신고" : "문의" %>')"
             style="background:white;border:1.5px solid #E8EDF5;border-radius:16px;padding:18px;text-align:center;cursor:pointer;transition:all 0.2s;"
             onmouseover="this.style.borderColor='#FF6B35';this.style.background='#FFF3EE';this.style.transform='translateY(-2px)'"
             onmouseout="this.style.borderColor='#E8EDF5';this.style.background='white';this.style.transform='none'">

            <div style="font-size:28px;margin-bottom:8px;"><%= c[0] %></div>

            <div style="font-size:13px;font-weight:800;color:#1A1F36;">
                <%= c[1] %>
            </div>

            <div style="font-size:11px;color:#9DA8C0;margin-top:3px;">
                <%= c[2] %>
            </div>
        </div>

        <% } %>

    </div>

    <!-- 문의 작성 -->
    <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:28px;">

        <div style="display:flex;align-items:center;gap:12px;margin-bottom:22px;">

            <div style="width:40px;height:40px;border-radius:12px;background:linear-gradient(135deg,#FF6B35,#FF8C5A);display:flex;align-items:center;justify-content:center;font-size:18px;">
                ✏️
            </div>

            <div>
                <h3 style="font-size:16px;font-weight:800;color:#1A1F36;">
                    문의 · 신고 작성
                </h3>

                <p style="font-size:12px;color:#9DA8C0;margin-top:2px;">
                    상세히 작성할수록 빠른 처리가 가능해요
                </p>
            </div>
        </div>

        <form action="support" method="post"
              style="display:flex;flex-direction:column;gap:14px;">

            <div>
                <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">
                    문의 유형
                </label>

                <select name="type" id="typeSelect" class="fb-inp">
                    <option value="결제">💳 결제 문의</option>
                    <option value="계정">👤 계정 문의</option>
                    <option value="오류">🔧 서비스 오류</option>
                    <option value="신고">🚨 신고하기</option>
                    <option value="기타">📝 기타 문의</option>
                </select>
            </div>

            <div>
                <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">
                    제목
                </label>

                <input name="title"
                       class="fb-inp"
                       placeholder="문의 제목을 입력하세요">
            </div>

            <div>
                <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">
                    내용
                </label>

                <textarea name="content"
                          class="fb-inp"
                          style="min-height:130px;resize:vertical;"
                          placeholder="문의 내용을 자세히 작성해주세요."></textarea>
            </div>

            <button type="submit"
                    style="align-self:flex-end;padding:12px 30px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;">
                🚀 제출하기
            </button>

        </form>
    </div>

    <!-- 문의 내역 -->
    <div style="background:white;border-radius:20px;border:1.5px solid #E8EDF5;box-shadow:0 2px 8px rgba(0,0,0,0.05);padding:28px;">

        <h3 style="font-size:16px;font-weight:800;color:#1A1F36;margin-bottom:18px;">
            📋 나의 문의 내역
        </h3>

        <%
        if(!list.isEmpty()){

            for(InquiryDTO s : list){

                boolean isComplete = "COMPLETE".equals(s.getStatus());

                String resultText =
                    s.getResult() != null
                    ? s.getResult().replace("\"", "&quot;").replace("'", "\\'")
                    : "";

                String titleText =
                    s.getTitle() != null
                    ? s.getTitle().replace("'", "\\'")
                    : "";

                String contentText =
                    s.getContent() != null
                    ? s.getContent().replace("'", "\\'")
                    : "";

                String regDateText =
                    s.getRegDate() != null
                    ? s.getRegDate().toString()
                    : "";
        %>

        <div style="display:flex;justify-content:space-between;align-items:center;padding:16px;border-radius:14px;border:1.5px solid #E8EDF5;margin-bottom:10px;transition:all 0.2s;cursor:<%= isComplete ? "pointer" : "default" %>;"
             onmouseover="this.style.background='#FFF9F7';this.style.borderColor='rgba(255,107,53,0.2)'"
             onmouseout="this.style.background='white';this.style.borderColor='#E8EDF5'"
             <%= isComplete
                    ? "onclick=\"openInquiryAnswer('"
                        + titleText
                        + "','"
                        + contentText
                        + "','"
                        + resultText
                        + "','"
                        + regDateText
                        + "')\""
                    : ""
             %>>

            <div>

                <div style="display:flex;align-items:center;gap:8px;margin-bottom:6px;">

                    <% if("기타".equals(s.getCategory()) || s.getCategory() == null){ %>

                    <span style="padding:3px 10px;border-radius:99px;background:linear-gradient(135deg,#FF4D4D,#FF6B35);color:white;font-size:11px;font-weight:800;">
                        🚨 신고
                    </span>

                    <% } else { %>

                    <span style="padding:3px 10px;border-radius:99px;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:11px;font-weight:800;">
                        💬 문의
                    </span>

                    <% } %>

                    <span style="font-size:12px;color:#9DA8C0;">
                        <%= s.getCategory() != null ? s.getCategory() : "" %>
                    </span>

                </div>

                <div style="font-weight:700;font-size:14px;color:#1A1F36;margin-bottom:3px;">
                    <%= s.getTitle() %>
                </div>

                <div style="font-size:12px;color:#9DA8C0;">
                    <%= regDateText %>
                </div>

            </div>

            <div style="display:flex;align-items:center;gap:8px;flex-shrink:0;">

                <span style="padding:6px 16px;border-radius:99px;font-size:12px;font-weight:700;
                    background:<%= isComplete ? "#E8F8F6" : "#F7F9FC" %>;
                    color:<%= isComplete ? "#00897B" : "#9DA8C0" %>;">
                    <%= isComplete ? "✔ 답변 완료" : "⏳ 처리 중" %>
                </span>

                <% if(isComplete){ %>
                <span style="font-size:11px;color:#FF6B35;font-weight:700;">
                    답변 보기 →
                </span>
                <% } %>

            </div>

        </div>

        <%
            }
        } else {
        %>

        <div style="text-align:center;padding:48px 20px;color:#9DA8C0;">

            <div style="font-size:48px;margin-bottom:12px;">
                📭
            </div>

            <div style="font-size:15px;font-weight:600;">
                아직 문의 내역이 없어요
            </div>

            <div style="font-size:13px;margin-top:6px;">
                궁금한 점이 있으면 언제든지 문의해주세요!
            </div>

        </div>

        <% } %>

    </div>

</div>

<!-- 모달 -->
<div id="inquiryAnswerModal"
     style="display:none;position:fixed;inset:0;background:rgba(26,31,54,0.5);z-index:2000;align-items:center;justify-content:center;">

    <div style="background:white;border-radius:24px;width:100%;max-width:520px;overflow:hidden;">

        <div style="background:linear-gradient(135deg,#00BFA5,#26D4BB);padding:22px 28px;display:flex;justify-content:space-between;align-items:center;">

            <div>
                <div style="font-size:13px;color:rgba(255,255,255,0.85);font-weight:600;">
                    ✔ 답변 완료
                </div>

                <h3 id="answerModalTitle"
                    style="font-size:17px;font-weight:900;color:white;margin-top:3px;">
                    문의 제목
                </h3>
            </div>

            <button onclick="closeInquiryAnswer()"
                    style="width:32px;height:32px;border-radius:50%;border:none;background:rgba(255,255,255,0.25);color:white;cursor:pointer;">
                ✕
            </button>

        </div>

        <div style="padding:24px 28px;display:flex;flex-direction:column;gap:18px;">

            <div>
                <div style="font-size:12px;font-weight:700;color:#9DA8C0;margin-bottom:8px;">
                    내 문의 내용
                </div>

                <div id="answerModalContent"
                     style="background:#F7F9FC;border-radius:12px;padding:14px 16px;font-size:14px;color:#5A6480;line-height:1.7;border:1.5px solid #E8EDF5;">
                </div>

                <div id="answerModalDate"
                     style="font-size:11px;color:#C4CEDE;margin-top:6px;text-align:right;">
                </div>
            </div>

            <div>
                <div style="font-size:12px;font-weight:700;color:#9DA8C0;margin-bottom:8px;">
                    핏불 팀 답변
                </div>

                <div id="answerModalResult"
                     style="background:linear-gradient(135deg,#E8F8F6,#F0FBF9);border-radius:12px;padding:14px 16px;font-size:14px;color:#1A1F36;line-height:1.7;border:1.5px solid rgba(0,191,165,0.2);white-space:pre-wrap;">
                </div>
            </div>

        </div>

    </div>

</div>

</main>

<script>
function toggleFaq(el){
    el.classList.toggle('open');
}

function selectType(val){
    const sel = document.getElementById('typeSelect');

    if(!sel) return;

    for(let i=0; i<sel.options.length; i++){
        if(sel.options[i].value === val){
            sel.selectedIndex = i;
            break;
        }
    }

    sel.scrollIntoView({
        behavior:'smooth',
        block:'center'
    });

    sel.focus();
}

function openInquiryAnswer(title, content, result, regDate){

    document.getElementById('answerModalTitle').innerText =
        title || '문의 제목';

    document.getElementById('answerModalContent').innerText =
        content || '';

    document.getElementById('answerModalResult').innerText =
        result || '(답변 내용 없음)';

    document.getElementById('answerModalDate').innerText =
        regDate ? '문의일: ' + regDate : '';

    document.getElementById('inquiryAnswerModal').style.display =
        'flex';
}

function closeInquiryAnswer(){

    document.getElementById('inquiryAnswerModal').style.display =
        'none';
}
</script>

</body>
</html>