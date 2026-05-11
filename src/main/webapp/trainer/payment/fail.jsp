<%--
  Created by IntelliJ IDEA.
  User: jinhoyon
  Date: 4/29/26
  Time: 2:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2> 결제 실패 </h2>
    <p id="code"></p>
    <p id="message"></p>
</body>
</html>

<script>
    const urlParams = new URLSearchParams(window.location.search);

    const codeElement = document.getElementById("code");
    const messageElement = document.getElementById("message");

    codeElement.textContent = "에러코드: " + urlParams.get("code");
    messageElement.textContent = "실패 사유: " + urlParams.get("message");
</script>