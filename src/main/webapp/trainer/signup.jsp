<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Fitsbug - 트레이너 회원가입</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; max-width: 480px; margin: 40px auto; padding: 0 20px; color: #1a1c1f; }
        .brand { display: flex; align-items: center; gap: 10px; margin-bottom: 32px; }
        .brand-icon { width: 36px; height: 36px; background: #007AFF; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
        .brand-name { font-size: 20px; font-weight: 800; color: #1a1c1f; }
        .step-indicator { display: flex; gap: 6px; margin-bottom: 28px; }
        .step-indicator span { height: 4px; flex: 1; border-radius: 2px; background: #e2e2e7; }
        .step-indicator span.done { background: #0058bc; }
        h2 { font-size: 22px; font-weight: 700; margin: 0 0 4px; }
        .subtitle { color: #717786; font-size: 14px; margin: 0 0 28px; }
        .error { color: #ba1a1a; font-size: 14px; margin-bottom: 16px; background: #fff0f0; border: 1px solid #ffc5c5; padding: 10px 12px; border-radius: 8px; }
        .field { margin-bottom: 16px; }
        label.field-label { display: block; font-size: 11px; font-weight: 700; color: #414755; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 5px; }
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"] {
            width: 100%; padding: 10px 12px; border: 1px solid #c1c6d7; border-radius: 8px;
            font-size: 14px; color: #1a1c1f; outline: none; font-family: inherit;
        }
        input:focus { border-color: #0058bc; box-shadow: 0 0 0 3px rgba(0,88,188,0.1); }
        input::placeholder { color: #a0a5b1; }
        .btn-primary {
            width: 100%; padding: 13px; background: #0058bc; color: #fff;
            border: none; border-radius: 10px; font-size: 15px; font-weight: 700;
            cursor: pointer; font-family: inherit; margin-top: 8px;
        }
        .btn-primary:hover { background: #004a9f; }
        .login-link { text-align: center; margin-top: 20px; font-size: 13px; color: #717786; }
        .login-link a { color: #0058bc; font-weight: 600; text-decoration: none; }
        .login-link a:hover { text-decoration: underline; }
        .divider { border: none; border-top: 1px solid #e2e2e7; margin: 24px 0 20px; }
    </style>
</head>
<body>

<div class="brand">
    <div class="brand-icon">💪</div>
    <span class="brand-name">Fitsbug</span>
</div>

<div class="step-indicator">
    <span class="done"></span>
    <span></span>
    <span></span>
    <span></span>
    <span></span>
</div>

<h2>트레이너 회원가입</h2>
<p class="subtitle">기본 정보를 입력해 주세요. (1/5)</p>

<c:if test="${not empty error}">
    <p class="error">
        ${error}
        <c:if test="${isDuplicate}">
            <a href="${pageContext.request.contextPath}/trainer/login" style="color:#ba1a1a;font-weight:700;">로그인하기</a>
        </c:if>
    </p>
</c:if>

<form action="${pageContext.request.contextPath}/trainer/signup" method="post">
    <input type="hidden" name="role" value="TRAINER"/>

    <div class="field">
        <label class="field-label">이름</label>
        <input type="text" name="name" placeholder="홍길동" value="${prefill.name}" required/>
    </div>
    <div class="field">
        <label class="field-label">이메일</label>
        <input type="email" name="email" placeholder="example@email.com" value="${prefill.email}" required/>
    </div>
    <div class="field">
        <label class="field-label">비밀번호</label>
        <input type="password" name="password" placeholder="8자 이상 입력해 주세요" required/>
    </div>
    <div class="field">
        <label class="field-label">전화번호</label>
        <input type="tel" name="phone" placeholder="010-0000-0000" value="${prefill.phone}" required/>
    </div>
    <div class="field">
        <label class="field-label">닉네임</label>
        <input type="text" name="nickname" placeholder="활동명 또는 닉네임" value="${prefill.nickname}" required/>
    </div>
    <div class="field">
        <label class="field-label">나이</label>
        <input type="number" name="age" placeholder="25" min="1" max="100" value="${prefill.age}" required/>
    </div>
    <div class="field">
        <label class="field-label">성별</label>
        <label><input type="radio" name="gender" value="MALE" ${prefill.gender == 'MALE' ? 'checked' : ''}/> 남성</label>&nbsp;&nbsp;
        <label><input type="radio" name="gender" value="FEMALE" ${prefill.gender == 'FEMALE' ? 'checked' : ''}/> 여성</label>
    </div>

    <button type="submit" class="btn-primary">다음</button>
</form>

<hr class="divider"/>
<p class="login-link">이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/trainer/login">로그인하기</a></p>

</body>
</html>
