<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 회원가입</title>

<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

<style>
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:#F7F9FC;display:flex;min-height:100vh;}
.form-side{width:52%;padding:60px;}
.brand-side{flex:1;background:linear-gradient(145deg,#FF6B35,#00BFA5);display:flex;align-items:center;justify-content:center;color:white;}
.fb-inp{width:100%;padding:12px;border-radius:10px;border:2px solid #E8EDF5;}
.btn{padding:10px 14px;border:none;border-radius:10px;cursor:pointer;}
.btn-main{background:#FF6B35;color:white;width:100%;padding:14px;font-weight:800;}
.btn-sm{background:#F7F9FC;border:1px solid #ddd;}
.role-btn{padding:10px;border-radius:999px;border:1px solid #ddd;cursor:pointer;}
.role-btn.active{background:#FF6B35;color:white;}
</style>
</head>

<body>

<!-- LEFT -->
<div class="form-side">

<h1>회원가입</h1>

<div style="margin:20px 0;">
  <button class="role-btn active" data-role="member">회원</button>
  <button class="role-btn" data-role="trainer" onclick="location.href='<%=request.getContextPath()%>/trainer/signup'">트레이너</button>
  <button class="role-btn" data-role="gym" onclick="location.href='<%=request.getContextPath()%>/member/gymJoin'">헬스장</button>
</div>

<form action="join" method="post">

<input type="hidden" name="role" id="role" value="member">
<input type="hidden" name="verified" id="verified" value="false">

<!-- 이메일 -->
<div>
<label>이메일</label>
<div style="display:flex;gap:10px;">
<input name="username" id="username" class="fb-inp">
<button type="button" onclick="checkEmail()" class="btn-sm">중복확인</button>
</div>
<div id="emailMsg"></div>
</div>

<!-- 인증 -->
<div>
<div style="display:flex;gap:10px;margin-top:10px;">
<input id="emailDisplay" readonly class="fb-inp">
<button type="button" id="verifyBtn" onclick="sendCode()" disabled class="btn-sm">인증</button>
</div>

<div id="codeBox" style="display:none;">
<input id="code" class="fb-inp" placeholder="코드 입력">
<button type="button" onclick="verifyCode()">확인</button>
<div id="codeMsg"></div>
<div id="timer"></div>
</div>
</div>

<!-- 기타 -->
<input name="password" placeholder="비밀번호" class="fb-inp">
<input name="nickname" placeholder="닉네임" class="fb-inp">
<input name="name" placeholder="이름" class="fb-inp">
<input name="phone" placeholder="전화번호" class="fb-inp">
<input name="age" type="number" placeholder="나이" class="fb-inp" min="1" max="120">
<div style="margin-top:10px;">
  <label>성별&nbsp;</label>
  <label><input type="radio" name="gender" value="MALE"> 남성</label>&nbsp;
  <label><input type="radio" name="gender" value="FEMALE"> 여성</label>
</div>

<button class="btn-main">가입하기</button>

</form>

</div>

<!-- RIGHT -->
<div class="brand-side">
<h2>핏츠버그</h2>
</div>

<script>

// 역할 선택
document.querySelectorAll(".role-btn").forEach(btn=>{
  btn.onclick=()=>{
    const role = btn.dataset.role;
    if(role==="trainer") location.href="<%=request.getContextPath()%>/trainer/signup";
    if(role==="gym") location.href="<%=request.getContextPath()%>/member/gymJoin";
    document.querySelectorAll(".role-btn").forEach(b=>b.classList.remove("active"));
    btn.classList.add("active");
    document.getElementById("role").value=role;
  }
});

// 이메일 체크
function checkEmail(){
  const email = document.getElementById("username").value;

  fetch("<%=request.getContextPath()%>/member/checkEmail?email="+email)
  .then(r=>r.json())
  .then(res=>{
    if(res.exists){
      msg("emailMsg","이미 사용중","red");
      verifyBtn.disabled=true;
    }else{
      msg("emailMsg","사용 가능","green");
      emailDisplay.value=email;
      verifyBtn.disabled=false;
    }
  });
}

// 인증 코드
function sendCode(){
  const email = username.value;

  fetch("<%=request.getContextPath()%>/member/sendEmailCode",{
    method:"POST",
    headers:{"Content-Type":"application/json"},
    body:JSON.stringify({email})
  });

  codeBox.style.display="block";
  startTimer();
}

// 타이머
let time=180, t;
function startTimer(){
  clearInterval(t);
  t=setInterval(()=>{
    timer.innerText="남은시간 "+time;
    time--;
    if(time<0){
      clearInterval(t);
      timer.innerText="시간초과";
    }
  },1000);
}

// 코드 검증
function verifyCode(){
  fetch("<%=request.getContextPath()%>/member/verifyCode",{
    method:"POST",
    headers:{"Content-Type":"application/json"},
    body:JSON.stringify({email:username.value, code:code.value})
  })
  .then(r=>r.text())
  .then(res=>{
    if(res==="success"){
      msg("codeMsg","인증 성공","green");
      verified.value="true";
    }else{
      msg("codeMsg","실패","red");
    }
  });
}

function msg(id,txt,color){
  const el=document.getElementById(id);
  el.innerText=txt;
  el.style.color=color;
}

</script>

</body>
</html>