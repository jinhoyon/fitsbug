<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Fitsbug - 트레이너 프로필</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; max-width: 640px; margin: 40px auto; padding: 0 20px 60px; color: #1a1c1f; }
        .brand { display: flex; align-items: center; gap: 10px; margin-bottom: 32px; }
        .brand-icon { width: 36px; height: 36px; background: #007AFF; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
        .brand-name { font-size: 20px; font-weight: 800; color: #1a1c1f; }
        .step-indicator { display: flex; gap: 6px; margin-bottom: 28px; }
        .step-indicator span { height: 4px; flex: 1; border-radius: 2px; background: #e2e2e7; }
        .step-indicator span.done { background: #0058bc; }
        h2 { font-size: 22px; font-weight: 700; margin: 0 0 4px; }
        .subtitle { color: #717786; font-size: 14px; margin: 0 0 28px; }
        .error { color: #ba1a1a; font-size: 14px; margin-bottom: 16px; background: #fff0f0; border: 1px solid #ffc5c5; padding: 10px 12px; border-radius: 8px; }
        .field { margin-bottom: 20px; }
        .field-label { display: block; font-size: 11px; font-weight: 700; color: #414755; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 8px; }
        textarea {
            width: 100%; padding: 10px 12px; border: 1px solid #c1c6d7; border-radius: 8px;
            font-size: 14px; color: #1a1c1f; outline: none; font-family: inherit;
            resize: vertical; min-height: 100px;
        }
        textarea:focus { border-color: #0058bc; box-shadow: 0 0 0 3px rgba(0,88,188,0.1); }
        textarea::placeholder { color: #a0a5b1; }

        /* Tag checkboxes */
        .tags { display: flex; flex-wrap: wrap; gap: 8px; }
        .tags input[type="checkbox"] { display: none; }
        .tags input[type="checkbox"] + label {
            display: inline-block; padding: 7px 14px; border: 1px solid #c1c6d7;
            border-radius: 20px; cursor: pointer; font-size: 13px; font-weight: 500;
            color: #414755; background: #fff; transition: all 0.15s;
            text-transform: none; letter-spacing: 0;
        }
        .tags input[type="checkbox"]:checked + label {
            background: #0058bc; color: #fff; border-color: #0058bc;
        }
        .tags input[type="checkbox"] + label:hover { border-color: #0058bc; color: #0058bc; background: #f0f5ff; }
        .tags input[type="checkbox"]:checked + label:hover { background: #004a9f; }

        /* Profile image upload */
        .avatar-upload { display: flex; align-items: center; gap: 16px; }
        .avatar-preview {
            width: 72px; height: 72px; border-radius: 50%; background: #e8e8ed;
            object-fit: cover; border: 2px solid #e2e2e7; flex-shrink: 0;
        }
        .file-label {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 9px 16px; border: 1px solid #c1c6d7; border-radius: 8px;
            font-size: 13px; font-weight: 600; color: #414755; cursor: pointer; background: #f9f9fe;
        }
        .file-label:hover { border-color: #0058bc; color: #0058bc; background: #f0f5ff; }
        .file-name { font-size: 12px; color: #717786; margin-top: 4px; }

        .section-divider { border: none; border-top: 1px solid #f0f0f5; margin: 24px 0; }
        .btn-primary {
            width: 100%; padding: 13px; background: #0058bc; color: #fff;
            border: none; border-radius: 10px; font-size: 15px; font-weight: 700;
            cursor: pointer; font-family: inherit; margin-top: 8px;
        }
        .btn-primary:hover { background: #004a9f; }
        .skip-note { text-align: center; margin-top: 14px; font-size: 13px; color: #a0a5b1; }
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

<a href="${pageContext.request.contextPath}/trainer/signup" class="btn-back">← 이전</a>

<div class="step-indicator">
    <span class="done"></span>
    <span class="done"></span>
    <span></span>
    <span></span>
    <span></span>
</div>

<h2>트레이너 프로필</h2>
<p class="subtitle">회원들에게 표시될 프로필 정보를 입력해 주세요. (2/5)</p>

<p class="error" style="${empty error ? 'display:none' : ''}">${error}</p>

<form action="${pageContext.request.contextPath}/trainer/signup/step2"
      method="post" enctype="multipart/form-data">

    <!-- Description -->
    <div class="field">
        <span class="field-label">자기소개</span>
        <textarea name="description" placeholder="간단한 자기소개를 작성해 주세요. 경력, 전문 분야, 코칭 철학 등을 포함하면 좋습니다.">${prefillTrainer.description}</textarea>
    </div>

    <hr class="section-divider"/>

    <!-- Specializations -->
    <div class="field">
        <span class="field-label">전문 분야</span>
        <div class="tags">
            <input type="checkbox" id="yoga" name="specializations" value="YOGA">
            <label for="yoga">Yoga</label>

            <input type="checkbox" id="weightloss" name="specializations" value="WEIGHT_LOSS">
            <label for="weightloss">체중 감량</label>

            <input type="checkbox" id="musclegain" name="specializations" value="MUSCLE_GAIN">
            <label for="musclegain">근비대</label>

            <input type="checkbox" id="body_recomposition" name="specializations" value="BODY_RECOMPOSITION">
            <label for="body_recomposition">체형 교정</label>

            <input type="checkbox" id="strength_training" name="specializations" value="STRENGTH_TRAINING">
            <label for="strength_training">스트렝스</label>

            <input type="checkbox" id="functional_training" name="specializations" value="FUNCTIONAL_TRAINING">
            <label for="functional_training">기능성 트레이닝</label>

            <input type="checkbox" id="posture_correction" name="specializations" value="POSTURE_CORRECTION">
            <label for="posture_correction">자세 교정</label>

            <input type="checkbox" id="pilates" name="specializations" value="PILATES">
            <label for="pilates">Pilates</label>

            <input type="checkbox" id="crossfit" name="specializations" value="CROSSFIT">
            <label for="crossfit">CrossFit</label>

            <input type="checkbox" id="rehab" name="specializations" value="REHABILITATION">
            <label for="rehab">재활</label>

            <input type="checkbox" id="athletic_performance" name="specializations" value="ATHLETIC_PERFORMANCE">
            <label for="athletic_performance">운동 퍼포먼스</label>
        </div>
    </div>

    <hr class="section-divider"/>

    <!-- Traits -->
    <div class="field">
        <span class="field-label">강점</span>
        <div class="tags">
            <input type="checkbox" id="kind" name="traits" value="KIND">
            <label for="kind">친절한</label>

            <input type="checkbox" id="beginner_friendly" name="traits" value="BEGINNER_FRIENDLY">
            <label for="beginner_friendly">입문자 친화적</label>

            <input type="checkbox" id="fun" name="traits" value="FUN">
            <label for="fun">즐거운</label>

            <input type="checkbox" id="motivational" name="traits" value="MOTIVATIONAL">
            <label for="motivational">동기부여</label>

            <input type="checkbox" id="detail_oriented" name="traits" value="DETAIL_ORIENTED">
            <label for="detail_oriented">꼼꼼한</label>

            <input type="checkbox" id="patient" name="traits" value="PATIENT">
            <label for="patient">인내심 있는</label>

            <input type="checkbox" id="result_focused" name="traits" value="RESULT_FOCUSED">
            <label for="result_focused">결과 중심</label>

            <input type="checkbox" id="flexible" name="traits" value="FLEXIBLE">
            <label for="flexible">유연한</label>

            <input type="checkbox" id="communicative" name="traits" value="COMMUNICATIVE">
            <label for="communicative">소통 잘 하는</label>
        </div>
    </div>

    <hr class="section-divider"/>

    <!-- Profile Image -->
    <div class="field">
        <span class="field-label">프로필 사진</span>
        <div class="avatar-upload">
            <img id="avatar-preview" class="avatar-preview"
                 src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='72' height='72' viewBox='0 0 24 24' fill='%23c1c6d7'%3E%3Cpath d='M12 12c2.7 0 4.8-2.1 4.8-4.8S14.7 2.4 12 2.4 7.2 4.5 7.2 7.2 9.3 12 12 12zm0 2.4c-3.2 0-9.6 1.6-9.6 4.8v2.4h19.2v-2.4c0-3.2-6.4-4.8-9.6-4.8z'/%3E%3C/svg%3E"
                 alt="프로필 미리보기"/>
            <div>
                <label class="file-label" for="profileImage">📷 사진 선택</label>
                <input type="file" id="profileImage" name="profileImage" accept="image/*"
                       style="display:none" onchange="previewAvatar(this)"/>
                <p class="file-name" id="avatar-name">JPG, PNG — 5MB 이하</p>
            </div>
        </div>
    </div>

    <button type="submit" class="btn-primary">다음</button>
    <p class="skip-note">모든 항목은 선택 사항입니다. 나중에 프로필에서 수정할 수 있습니다.</p>
</form>

<script>
    // Pre-check specializations and traits from previous submission
    (function() {
        const specs = new Set([<c:forEach items="${prefillSpecs}" var="s" varStatus="st">'${s}'<c:if test="${!st.last}">,</c:if></c:forEach>]);
        const traits = new Set([<c:forEach items="${prefillTraits}" var="t" varStatus="st">'${t}'<c:if test="${!st.last}">,</c:if></c:forEach>]);
        document.querySelectorAll('input[name="specializations"]').forEach(cb => { if (specs.has(cb.value)) cb.checked = true; });
        document.querySelectorAll('input[name="traits"]').forEach(cb => { if (traits.has(cb.value)) cb.checked = true; });
    })();

    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => document.getElementById('avatar-preview').src = e.target.result;
            reader.readAsDataURL(input.files[0]);
            document.getElementById('avatar-name').textContent = input.files[0].name;
        }
    }
</script>
</body>
</html>
