<%--
  Created by IntelliJ IDEA.
  User: jinhoyon
  Date: 4/29/26
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<button onclick="cancelPayment('${payment.paymentKey}')">환불하기</button>

<script>
    async function cancelPayment(paymentKey) {
        const response = await fetch("${pageContext.request.contextPath}/payment/cancel", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                paymentKey: paymentKey,
                cancelReason: "고객 요청 환불"
            })
        });

        const json = await response.json();
        if (response.ok) {
            alert("환불이 완료됐습니다.");
        } else {
            alert("환불 실패: " + json.message);
        }
    }
</script>
</body>
</html>
