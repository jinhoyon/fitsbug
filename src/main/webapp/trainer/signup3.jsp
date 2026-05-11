<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Fitsbug - 정산 정보</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; max-width: 560px; margin: 40px auto; padding: 0 20px 60px; color: #1a1c1f; }
        .brand { display: flex; align-items: center; gap: 10px; margin-bottom: 32px; }
        .brand-icon { width: 36px; height: 36px; background: #007AFF; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
        .brand-name { font-size: 20px; font-weight: 800; color: #1a1c1f; }
        .step-indicator { display: flex; gap: 6px; margin-bottom: 28px; }
        .step-indicator span { height: 4px; flex: 1; border-radius: 2px; background: #e2e2e7; }
        .step-indicator span.done { background: #0058bc; }
        h2 { font-size: 22px; font-weight: 700; margin: 0 0 4px; }
        .subtitle { color: #717786; font-size: 14px; margin: 0 0 28px; }
        .error { color: #ba1a1a; font-size: 14px; margin-bottom: 16px; background: #fff0f0; border: 1px solid #ffc5c5; padding: 10px 12px; border-radius: 8px; }

        /* Field */
        .field { margin-bottom: 18px; }
        .field-label { display: block; font-size: 11px; font-weight: 700; color: #414755; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 6px; }
        input[type="text"], input[type="number"], select {
            width: 100%; padding: 10px 12px; border: 1px solid #c1c6d7; border-radius: 8px;
            font-size: 14px; color: #1a1c1f; outline: none; font-family: inherit; background: #fff;
        }
        input:focus, select:focus { border-color: #0058bc; box-shadow: 0 0 0 3px rgba(0,88,188,0.1); }
        input::placeholder { color: #a0a5b1; }

        /* Type selection cards */
        .type-cards { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .type-card input[type="radio"] { display: none; }
        .type-card label {
            display: flex; flex-direction: column; gap: 4px;
            padding: 14px 16px; border: 1.5px solid #c1c6d7; border-radius: 10px;
            cursor: pointer; background: #fff; transition: all 0.15s;
            text-transform: none; letter-spacing: 0; font-size: 14px; font-weight: 600; color: #414755;
        }
        .type-card label small { font-size: 11px; font-weight: 400; color: #a0a5b1; }
        .type-card input[type="radio"]:checked + label {
            border-color: #0058bc; background: #f0f5ff; color: #0058bc;
        }
        .type-card input[type="radio"]:checked + label small { color: #4a80d4; }
        .type-card label:hover { border-color: #0058bc; }

        /* Sub-section */
        .sub-section {
            margin-top: 20px; padding: 16px; border-left: 3px solid #0058bc;
            background: #f8faff; border-radius: 0 8px 8px 0;
        }

        /* Info notice */
        .info-notice {
            display: flex; align-items: flex-start; gap: 10px;
            background: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px;
            padding: 12px 14px; color: #1e40af; font-size: 13px; margin-top: 14px;
        }
        .info-notice::before { content: 'ℹ️'; font-size: 16px; flex-shrink: 0; }

        /* Bank section divider */
        .section-divider { border: none; border-top: 1px solid #e2e2e7; margin: 24px 0; }
        .section-title { font-size: 15px; font-weight: 700; color: #1a1c1f; margin: 0 0 16px; }

        /* Buttons */
        .btn-primary {
            width: 100%; padding: 13px; background: #0058bc; color: #fff;
            border: none; border-radius: 10px; font-size: 15px; font-weight: 700;
            cursor: pointer; font-family: inherit;
        }
        .btn-primary:hover { background: #004a9f; }

        .hidden { display: none; }
        .btn-back {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 9px 16px; border: 1px solid #c1c6d7; border-radius: 8px;
            font-size: 13px; font-weight: 600; color: #414755; text-decoration: none;
            background: #f9f9fe; margin-bottom: 20px;
        }
        .btn-back:hover { border-color: #0058bc; color: #0058bc; background: #f0f5ff; }
    </style>
</head>
<body>

<div class="brand">
    <div class="brand-icon">💪</div>
    <span class="brand-name">Fitsbug</span>
</div>

<a href="${pageContext.request.contextPath}/trainer/signup/step2" class="btn-back">← 이전</a>

<div class="step-indicator">
    <span class="done"></span>
    <span class="done"></span>
    <span class="done"></span>
    <span></span>
    <span></span>
</div>

<h2>정산 정보</h2>
<p class="subtitle">수익 정산 방식을 설정해 주세요. (3/5)</p>

<p class="error" style="${empty error ? 'display:none' : ''}">${error}</p>

<form action="${pageContext.request.contextPath}/trainer/signup/step3" method="post">

    <!-- Base type -->
    <div class="field">
        <span class="field-label">트레이너 유형</span>
        <div class="type-cards">
            <div class="type-card">
                <input type="radio" id="baseFreelance" name="baseType" value="FREELANCE" onchange="onBaseTypeChange()" required/>
                <label for="baseFreelance">
                    개인 / 프리랜서
                    <small>독립적으로 활동하는 트레이너</small>
                </label>
            </div>
            <div class="type-card">
                <input type="radio" id="baseGym" name="baseType" value="GYM" onchange="onBaseTypeChange()"/>
                <label for="baseGym">
                    헬스장 소속
                    <small>특정 헬스장에 소속된 트레이너</small>
                </label>
            </div>
        </div>
    </div>

    <!-- ── FREELANCE sub-section ────────────────────────────── -->
    <div id="freelanceSection" class="hidden">
        <div class="sub-section">
            <div class="field">
                <span class="field-label">사업자 등록 여부</span>
                <div class="type-cards">
                    <div class="type-card">
                        <input type="radio" id="freelanceBusiness" name="freelanceType" value="FREELANCE_BUSINESS" onchange="onFreelanceTypeChange()"/>
                        <label for="freelanceBusiness">
                            사업자 있음
                            <small>사업자 등록 완료</small>
                        </label>
                    </div>
                    <div class="type-card">
                        <input type="radio" id="freelanceIndividual" name="freelanceType" value="FREELANCE_INDIVIDUAL" onchange="onFreelanceTypeChange()"/>
                        <label for="freelanceIndividual">
                            사업자 없음
                            <small>개인 원천징수 처리</small>
                        </label>
                    </div>
                </div>
            </div>

            <div id="businessNumSection" class="field hidden">
                <label class="field-label" for="businessRegistrationNum">사업자 등록번호</label>
                <input type="text" id="businessRegistrationNum" name="businessRegistrationNum" placeholder="000-00-00000"/>
            </div>

            <div id="residentNumSection" class="field hidden">
                <label class="field-label" for="residentRegistrationNum">주민등록번호 <span style="font-weight:400;color:#a0a5b1;">(원천징수 처리 목적)</span></label>
                <input type="text" id="residentRegistrationNum" name="residentRegistrationNum" placeholder="000000-0000000"/>
            </div>
        </div>
    </div>

    <!-- ── GYM sub-section ─────────────────────────────────── -->
    <div id="gymSection" class="hidden">
        <div class="sub-section">
            <div class="field">
                <span class="field-label">소속 형태</span>
                <div class="type-cards" style="grid-template-columns: 1fr 1fr 1fr;">
                    <div class="type-card">
                        <input type="radio" id="gymEmployee" name="gymType" value="GYM_EMPLOYEE" onchange="onGymTypeChange()"/>
                        <label for="gymEmployee">
                            직원
                            <small>급여 수령</small>
                        </label>
                    </div>
                    <div class="type-card">
                        <input type="radio" id="gymCommission" name="gymType" value="GYM_COMMISSION" onchange="onGymTypeChange()"/>
                        <label for="gymCommission">
                            위탁
                            <small>수수료 분배</small>
                        </label>
                    </div>
                    <div class="type-card">
                        <input type="radio" id="gymRental" name="gymType" value="GYM_RENTAL" onchange="onGymTypeChange()"/>
                        <label for="gymRental">
                            임대
                            <small>독립 운영</small>
                        </label>
                    </div>
                </div>
            </div>

            <div class="field">
                <label class="field-label" for="gymCode">헬스장 코드</label>
                <input type="text" id="gymCode" name="gymCode" placeholder="헬스장에서 받은 코드를 입력하세요"/>
            </div>

            <div id="commissionSection" class="field hidden">
                <label class="field-label" for="commissionRate">트레이너 수수료 비율 (%)</label>
                <input type="number" id="commissionRate" name="commissionRate" placeholder="예: 70" min="1" max="99"/>
                <p style="font-size:12px;color:#717786;margin:5px 0 0;">헬스장이 나머지 비율을 가져갑니다.</p>
            </div>

            <div id="gymPaymentNotice" class="info-notice hidden">
                정산 금액은 헬스장으로 입금됩니다. 헬스장이 급여 또는 수수료를 별도로 지급합니다.
            </div>
        </div>
    </div>

    <!-- ── Bank info ───────────────────────────────────────── -->
    <div id="bankSection" class="hidden">
        <hr class="section-divider"/>
        <p class="section-title">정산 계좌 정보</p>

        <div class="field">
            <label class="field-label" for="bankName">은행</label>
            <select id="bankName" name="bankName">
                <option value="">은행을 선택하세요</option>
                <option value="KB국민은행">KB국민은행</option>
                <option value="신한은행">신한은행</option>
                <option value="우리은행">우리은행</option>
                <option value="하나은행">하나은행</option>
                <option value="NH농협은행">NH농협은행</option>
                <option value="IBK기업은행">IBK기업은행</option>
                <option value="카카오뱅크">카카오뱅크</option>
                <option value="토스뱅크">토스뱅크</option>
                <option value="케이뱅크">케이뱅크</option>
                <option value="SC제일은행">SC제일은행</option>
                <option value="씨티은행">씨티은행</option>
                <option value="우체국">우체국</option>
            </select>
        </div>

        <div class="field">
            <label class="field-label" for="accountNumber">계좌번호</label>
            <input type="text" id="accountNumber" name="accountNumber" placeholder="계좌번호 (숫자만)"/>
        </div>
    </div>

    <!-- Submit -->
    <div id="submitSection" class="hidden" style="margin-top: 28px;">
        <button type="submit" class="btn-primary">다음</button>
    </div>

</form>

<script>
    function onBaseTypeChange() {
        var base = document.querySelector('input[name="baseType"]:checked').value;

        document.getElementById('freelanceSection').classList.add('hidden');
        document.getElementById('gymSection').classList.add('hidden');
        document.getElementById('bankSection').classList.add('hidden');
        document.getElementById('submitSection').classList.add('hidden');
        document.getElementById('businessNumSection').classList.add('hidden');
        document.getElementById('residentNumSection').classList.add('hidden');
        document.getElementById('commissionSection').classList.add('hidden');
        document.getElementById('gymPaymentNotice').classList.add('hidden');

        if (base === 'FREELANCE') {
            document.getElementById('freelanceSection').classList.remove('hidden');
        } else {
            document.getElementById('gymSection').classList.remove('hidden');
        }
    }

    function onFreelanceTypeChange() {
        var type = document.querySelector('input[name="freelanceType"]:checked').value;

        document.getElementById('businessNumSection').classList.add('hidden');
        document.getElementById('residentNumSection').classList.add('hidden');

        if (type === 'FREELANCE_BUSINESS') {
            document.getElementById('businessNumSection').classList.remove('hidden');
        } else {
            document.getElementById('residentNumSection').classList.remove('hidden');
        }

        document.getElementById('bankSection').classList.remove('hidden');
        document.getElementById('submitSection').classList.remove('hidden');
    }

    // Pre-fill from previous submission
    <c:if test="${not empty prefillPayout}">
    window.addEventListener('DOMContentLoaded', function() {
        var type = '${prefillPayout.trainerType}';
        if (!type) return;
        var isFreelance = type.startsWith('FREELANCE');
        var baseVal = isFreelance ? 'FREELANCE' : 'GYM';
        var baseRadio = document.querySelector('input[name="baseType"][value="' + baseVal + '"]');
        if (baseRadio) { baseRadio.checked = true; onBaseTypeChange(); }
        if (isFreelance) {
            var ftRadio = document.querySelector('input[name="freelanceType"][value="' + type + '"]');
            if (ftRadio) { ftRadio.checked = true; onFreelanceTypeChange(); }
            <c:if test="${not empty prefillPayout.businessRegistrationNum}">
            document.getElementById('businessRegistrationNum').value = '${prefillPayout.businessRegistrationNum}';
            </c:if>
            <c:if test="${not empty prefillPayout.residentRegistrationNum}">
            document.getElementById('residentRegistrationNum').value = '${prefillPayout.residentRegistrationNum}';
            </c:if>
        } else {
            var gtRadio = document.querySelector('input[name="gymType"][value="' + type + '"]');
            if (gtRadio) { gtRadio.checked = true; onGymTypeChange(); }
            <c:if test="${not empty prefillPayout.commissionRate}">
            document.getElementById('commissionRate').value = '${prefillPayout.commissionRate}';
            </c:if>
        }
        <c:if test="${not empty prefillPayout.bankName}">
        document.getElementById('bankName').value = '${prefillPayout.bankName}';
        </c:if>
        <c:if test="${not empty prefillPayout.accountNumber}">
        document.getElementById('accountNumber').value = '${prefillPayout.accountNumber}';
        </c:if>
    });
    </c:if>

    function onGymTypeChange() {
        var type = document.querySelector('input[name="gymType"]:checked').value;

        document.getElementById('commissionSection').classList.add('hidden');
        document.getElementById('bankSection').classList.add('hidden');
        document.getElementById('gymPaymentNotice').classList.add('hidden');

        if (type === 'GYM_COMMISSION') {
            document.getElementById('commissionSection').classList.remove('hidden');
        }

        if (type === 'GYM_RENTAL') {
            document.getElementById('bankSection').classList.remove('hidden');
        } else {
            document.getElementById('gymPaymentNotice').classList.remove('hidden');
        }

        document.getElementById('submitSection').classList.remove('hidden');
    }
</script>

</body>
</html>
