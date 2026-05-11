<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trainer Signup - 자격증</title>
    <style>
        body { font-family: 'Inter', sans-serif; max-width: 640px; margin: 40px auto; padding: 0 20px; color: #1a1c1f; }
        h2 { font-size: 22px; font-weight: 700; margin-bottom: 4px; }
        .subtitle { color: #717786; font-size: 14px; margin-bottom: 28px; }
        .error { color: #ba1a1a; margin-bottom: 16px; font-size: 14px; }
        .cert-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            padding: 14px;
            border: 1px solid #e2e2e7;
            border-radius: 10px;
            margin-bottom: 10px;
            background: #fff;
            position: relative;
        }
        .cert-row .full { grid-column: 1 / -1; }
        label { display: block; font-size: 11px; font-weight: 700; color: #414755; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px; }
        input[type="text"], input[type="date"] {
            width: 100%; box-sizing: border-box;
            padding: 8px 10px; border: 1px solid #c1c6d7; border-radius: 6px;
            font-size: 14px; color: #1a1c1f; outline: none;
        }
        input:focus { border-color: #0058bc; box-shadow: 0 0 0 3px rgba(0,88,188,0.1); }
        .remove-btn {
            position: absolute; top: 10px; right: 10px;
            background: none; border: none; cursor: pointer; color: #717786; font-size: 18px; line-height: 1;
        }
        .remove-btn:hover { color: #ba1a1a; }
        .file-label {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 7px 12px; border: 1px solid #c1c6d7; border-radius: 6px;
            font-size: 13px; color: #414755; cursor: pointer; background: #f9f9fe;
        }
        .file-label:hover { border-color: #0058bc; color: #0058bc; background: #f0f5ff; }
        .file-name { font-size: 12px; color: #717786; margin-left: 4px; }
        .add-btn {
            width: 100%; padding: 10px; border: 2px dashed #c1c6d7; border-radius: 10px;
            background: none; cursor: pointer; font-size: 14px; font-weight: 600; color: #717786;
            margin-top: 4px; margin-bottom: 28px;
        }
        .add-btn:hover { border-color: #0058bc; color: #0058bc; background: #f0f5ff; }
        .btn-row { display: flex; gap: 12px; }
        .btn-primary {
            flex: 1; padding: 12px; background: #0058bc; color: #fff;
            border: none; border-radius: 10px; font-size: 15px; font-weight: 700; cursor: pointer;
        }
        .btn-primary:hover { background: #004a9f; }
        .btn-skip {
            padding: 12px 20px; background: #f3f3f8; color: #414755;
            border: none; border-radius: 10px; font-size: 15px; font-weight: 600; cursor: pointer;
        }
        .btn-skip:hover { background: #e2e2e7; }
        .brand { display: flex; align-items: center; gap: 10px; margin-bottom: 32px; }
        .brand-icon { width: 36px; height: 36px; background: #007AFF; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
        .brand-name { font-size: 20px; font-weight: 800; color: #1a1c1f; }
        .step-indicator { display: flex; gap: 6px; margin-bottom: 28px; }
        .step-indicator span {
            height: 4px; flex: 1; border-radius: 2px; background: #e2e2e7;
        }
        .step-indicator span.done { background: #0058bc; }
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

<a href="${pageContext.request.contextPath}/trainer/signup/step3" class="btn-back">← 이전</a>

<div class="step-indicator">
    <span class="done"></span>
    <span class="done"></span>
    <span class="done"></span>
    <span class="done"></span>
    <span></span>
</div>

<h2>자격증 등록</h2>
<p class="subtitle">보유하신 자격증이나 수료증을 추가해 주세요. (4/5)</p>

<p class="error">${error}</p>

<form action="${pageContext.request.contextPath}/trainer/signup/step4" method="post"
      enctype="multipart/form-data" id="certForm">

    <div id="cert-list"></div>

    <button type="button" class="add-btn" onclick="addRow()">+ 자격증 추가</button>

    <div class="btn-row">
        <button type="button" class="btn-skip" onclick="skipStep()">건너뛰기</button>
        <button type="submit" class="btn-primary">다음</button>
    </div>
</form>

<template id="cert-template">
    <div class="cert-row">
        <button type="button" class="remove-btn" onclick="removeRow(this)">×</button>
        <div class="full">
            <label>자격증 이름 *</label>
            <input type="text" name="certName" placeholder="예: 생활스포츠지도사 2급" required />
        </div>
        <div class="full">
            <label>발급 기관</label>
            <input type="text" name="issuingOrg" placeholder="예: 국민체육진흥공단" />
        </div>
        <div>
            <label>취득일</label>
            <input type="date" name="issueDate" />
        </div>
        <div>
            <label>만료일</label>
            <input type="date" name="expiryDate" />
        </div>
        <div class="full">
            <label>자격증 파일 첨부 <span style="color:#888;font-size:11px;">(이미지 또는 PDF)</span></label>
            <label class="file-label">
                <span>📎 파일 선택</span>
                <input type="file" name="certFile" accept="image/*,.pdf"
                       style="display:none" onchange="updateFileName(this)" />
            </label>
            <span class="file-name"></span>
        </div>
    </div>
</template>

<script>
    function addRow() {
        const tpl = document.getElementById('cert-template');
        const clone = tpl.content.cloneNode(true);
        document.getElementById('cert-list').appendChild(clone);
    }

    function removeRow(btn) {
        btn.closest('.cert-row').remove();
    }

    function skipStep() {
        // Submit with no cert rows — service will skip insert
        document.getElementById('cert-list').innerHTML = '';
        document.getElementById('certForm').submit();
    }

    function updateFileName(input) {
        const span = input.closest('label').nextElementSibling;
        span.textContent = input.files.length > 0 ? input.files[0].name : '';
    }

    // Start with one empty row
    addRow();
</script>
</body>
</html>
