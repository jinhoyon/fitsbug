<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Fitsbug - 요금 및 운영 시간</title>
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

        /* Section */
        .section { border: 1px solid #e2e2e7; border-radius: 12px; padding: 20px; margin-bottom: 24px; background: #fff; }
        .section-title { font-size: 14px; font-weight: 700; color: #1a1c1f; margin: 0 0 16px; display: flex; align-items: center; justify-content: space-between; }
        .section-add { font-size: 13px; font-weight: 600; color: #0058bc; background: none; border: none; cursor: pointer; padding: 0; }
        .section-add:hover { text-decoration: underline; }

        /* Pricing rows */
        .pricing-row { display: flex; align-items: flex-end; gap: 10px; padding: 12px; background: #f3f3f8; border-radius: 8px; margin-bottom: 8px; flex-wrap: wrap; }
        .pricing-row .field-group { display: flex; flex-direction: column; gap: 4px; }
        .pricing-row .field-group.flex1 { flex: 1; min-width: 120px; }
        .pricing-row .field-group.w80 { width: 80px; }
        .pricing-row .field-group.w110 { width: 110px; }
        label.field-label { display: block; font-size: 10px; font-weight: 700; color: #414755; text-transform: uppercase; letter-spacing: 0.05em; }
        input[type="text"], input[type="number"] {
            padding: 8px 10px; border: 1px solid #c1c6d7; border-radius: 6px;
            font-size: 14px; color: #1a1c1f; outline: none; width: 100%;
        }
        input:focus { border-color: #0058bc; box-shadow: 0 0 0 3px rgba(0,88,188,0.1); }
        .popular-label { display: flex; align-items: center; gap: 5px; font-size: 12px; color: #414755; cursor: pointer; white-space: nowrap; }
        .delete-btn { background: none; border: none; cursor: pointer; color: #717786; font-size: 18px; padding: 0 4px; line-height: 1; }
        .delete-btn:hover { color: #ba1a1a; }

        /* Availability rows */
        .avail-row { display: flex; align-items: center; gap: 12px; padding: 10px 12px; border-radius: 8px; border: 1px solid #e2e2e7; margin-bottom: 6px; transition: background .15s; }
        .avail-row.enabled { background: #eef4ff; border-color: #adc6ff; }
        .avail-row label.day-check { display: flex; align-items: center; gap: 7px; cursor: pointer; width: 56px; flex-shrink: 0; font-size: 14px; font-weight: 700; }
        .avail-row .times { display: flex; align-items: center; gap: 8px; flex: 1; }
        .avail-row .times input[type="time"] {
            padding: 7px 10px; border: 1px solid #c1c6d7; border-radius: 6px;
            font-size: 13px; color: #1a1c1f; outline: none; background: #fff;
        }
        .avail-row .times input[type="time"]:focus { border-color: #0058bc; box-shadow: 0 0 0 3px rgba(0,88,188,0.1); }
        .sep { color: #717786; font-size: 13px; }

        /* Buttons */
        .add-btn { width: 100%; padding: 10px; border: 2px dashed #c1c6d7; border-radius: 8px; background: none; cursor: pointer; font-size: 14px; font-weight: 600; color: #717786; }
        .add-btn:hover { border-color: #0058bc; color: #0058bc; background: #f0f5ff; }
        .btn-row { display: flex; gap: 12px; margin-top: 8px; }
        .btn-primary { flex: 1; padding: 13px; background: #0058bc; color: #fff; border: none; border-radius: 10px; font-size: 15px; font-weight: 700; cursor: pointer; }
        .btn-primary:hover { background: #004a9f; }
        .btn-skip { padding: 13px 20px; background: #f3f3f8; color: #414755; border: none; border-radius: 10px; font-size: 15px; font-weight: 600; cursor: pointer; }
        .btn-skip:hover { background: #e2e2e7; }
        .btn-back { display: inline-flex; align-items: center; gap: 6px; padding: 9px 16px; border: 1px solid #c1c6d7; border-radius: 8px; font-size: 13px; font-weight: 600; color: #414755; text-decoration: none; background: #f9f9fe; margin-bottom: 20px; }
        .btn-back:hover { border-color: #0058bc; color: #0058bc; background: #f0f5ff; }
    </style>
</head>
<body>

<div class="brand">
    <div class="brand-icon">💪</div>
    <span class="brand-name">Fitsbug</span>
</div>

<a href="${pageContext.request.contextPath}/trainer/signup/step4" class="btn-back">← 이전</a>

<div class="step-indicator">
    <span class="done"></span>
    <span class="done"></span>
    <span class="done"></span>
    <span class="done"></span>
    <span class="done"></span>
</div>

<h2>요금 및 운영 시간</h2>
<p class="subtitle">1:1 트레이닝 요금과 가능한 일정을 설정해 주세요. (5/5)</p>

<form action="${pageContext.request.contextPath}/trainer/signup/step5" method="post" id="step5Form">

    <!-- Pricing -->
    <div class="section">
        <div class="section-title">
            <span>1:1 트레이닝 요금</span>
            <button type="button" class="section-add" onclick="addPricingRow()">+ 요금 추가</button>
        </div>
        <div id="pricing-list"></div>
        <button type="button" class="add-btn" onclick="addPricingRow()" style="margin-top:4px;">+ 요금 패키지 추가</button>
    </div>

    <!-- Availability -->
    <div class="section">
        <div class="section-title">운영 시간</div>
        <div id="avail-list">
            <div class="avail-row" id="avail-MON">
                <label class="day-check"><input type="checkbox" name="availEnabled_MON" value="1" onchange="toggleDay('MON',this.checked)"/> 월</label>
                <div class="times" id="avail-times-MON" style="opacity:.4;pointer-events:none;">
                    <input type="time" name="startTime_MON" value="09:00" disabled/>
                    <span class="sep">~</span>
                    <input type="time" name="endTime_MON" value="18:00" disabled/>
                </div>
            </div>
            <div class="avail-row" id="avail-TUE">
                <label class="day-check"><input type="checkbox" name="availEnabled_TUE" value="1" onchange="toggleDay('TUE',this.checked)"/> 화</label>
                <div class="times" id="avail-times-TUE" style="opacity:.4;pointer-events:none;">
                    <input type="time" name="startTime_TUE" value="09:00" disabled/>
                    <span class="sep">~</span>
                    <input type="time" name="endTime_TUE" value="18:00" disabled/>
                </div>
            </div>
            <div class="avail-row" id="avail-WED">
                <label class="day-check"><input type="checkbox" name="availEnabled_WED" value="1" onchange="toggleDay('WED',this.checked)"/> 수</label>
                <div class="times" id="avail-times-WED" style="opacity:.4;pointer-events:none;">
                    <input type="time" name="startTime_WED" value="09:00" disabled/>
                    <span class="sep">~</span>
                    <input type="time" name="endTime_WED" value="18:00" disabled/>
                </div>
            </div>
            <div class="avail-row" id="avail-THU">
                <label class="day-check"><input type="checkbox" name="availEnabled_THU" value="1" onchange="toggleDay('THU',this.checked)"/> 목</label>
                <div class="times" id="avail-times-THU" style="opacity:.4;pointer-events:none;">
                    <input type="time" name="startTime_THU" value="09:00" disabled/>
                    <span class="sep">~</span>
                    <input type="time" name="endTime_THU" value="18:00" disabled/>
                </div>
            </div>
            <div class="avail-row" id="avail-FRI">
                <label class="day-check"><input type="checkbox" name="availEnabled_FRI" value="1" onchange="toggleDay('FRI',this.checked)"/> 금</label>
                <div class="times" id="avail-times-FRI" style="opacity:.4;pointer-events:none;">
                    <input type="time" name="startTime_FRI" value="09:00" disabled/>
                    <span class="sep">~</span>
                    <input type="time" name="endTime_FRI" value="18:00" disabled/>
                </div>
            </div>
            <div class="avail-row" id="avail-SAT">
                <label class="day-check"><input type="checkbox" name="availEnabled_SAT" value="1" onchange="toggleDay('SAT',this.checked)"/> 토</label>
                <div class="times" id="avail-times-SAT" style="opacity:.4;pointer-events:none;">
                    <input type="time" name="startTime_SAT" value="09:00" disabled/>
                    <span class="sep">~</span>
                    <input type="time" name="endTime_SAT" value="18:00" disabled/>
                </div>
            </div>
            <div class="avail-row" id="avail-SUN">
                <label class="day-check"><input type="checkbox" name="availEnabled_SUN" value="1" onchange="toggleDay('SUN',this.checked)"/> 일</label>
                <div class="times" id="avail-times-SUN" style="opacity:.4;pointer-events:none;">
                    <input type="time" name="startTime_SUN" value="09:00" disabled/>
                    <span class="sep">~</span>
                    <input type="time" name="endTime_SUN" value="18:00" disabled/>
                </div>
            </div>
        </div>
    </div>

    <div class="btn-row">
        <button type="button" class="btn-skip" onclick="document.getElementById('step5Form').submit()">건너뛰기</button>
        <button type="submit" class="btn-primary">완료 및 가입 마치기</button>
    </div>

</form>

<template id="pricing-row-tpl">
    <div class="pricing-row">
        <div class="field-group flex1">
            <label class="field-label">패키지 이름</label>
            <input type="text" name="pricingLabel" placeholder="예: 10회 패키지"/>
        </div>
        <div class="field-group w80">
            <label class="field-label">횟수</label>
            <input type="number" name="sessionCount" value="10" min="1"/>
        </div>
        <div class="field-group w110">
            <label class="field-label">가격 (원)</label>
            <input type="number" name="price" value="0" min="0" step="1000"/>
        </div>
        <label class="popular-label">
            <input type="checkbox" name="popularRow" value="__IDX__"/> 인기
        </label>
        <button type="button" class="delete-btn" onclick="this.closest('.pricing-row').remove(); reindexPopular()">×</button>
    </div>
</template>

<script>
    function addPricingRow() {
        const list = document.getElementById('pricing-list');
        const idx  = list.querySelectorAll('.pricing-row').length;
        const tpl  = document.getElementById('pricing-row-tpl');
        const html = tpl.innerHTML.replace('__IDX__', idx);
        const div  = document.createElement('div');
        div.innerHTML = html;
        list.appendChild(div.firstElementChild);
    }

    function reindexPopular() {
        document.querySelectorAll('#pricing-list .pricing-row').forEach((row, i) => {
            const cb = row.querySelector('input[name="popularRow"]');
            if (cb) cb.value = i;
        });
    }

    function toggleDay(day, enabled) {
        const row   = document.getElementById('avail-' + day);
        const times = document.getElementById('avail-times-' + day);
        times.querySelectorAll('input[type="time"]').forEach(i => i.disabled = !enabled);
        times.style.opacity = enabled ? '1' : '.4';
        times.style.pointerEvents = enabled ? '' : 'none';
        row.classList.toggle('enabled', enabled);
    }

    // Start with one pricing row
    addPricingRow();
</script>
</body>
</html>
