<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>핏츠버그 - 트레이너 인증</title>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@700;800;900&family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'Noto Sans KR','Nunito',sans-serif;background:rgba(26,31,54,0.7);min-height:100vh;display:flex;align-items:center;justify-content:center;backdrop-filter:blur(10px);}
.fb-inp{width:100%;padding:13px 18px;border-radius:14px;border:2px solid #E8EDF5;background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;color:#1A1F36;outline:none;transition:all 0.2s;}
.fb-inp:focus{border-color:#FF6B35;box-shadow:0 0 0 3px rgba(255,107,53,0.12);background:white;}
.fb-inp::placeholder{color:#C4CEDE;}
.upload-box{width:100%;border:2.5px dashed #E8EDF5;border-radius:16px;padding:32px 20px;display:flex;flex-direction:column;align-items:center;justify-content:center;cursor:pointer;transition:all 0.2s;background:#F7F9FC;}
.upload-box:hover{border-color:#FF6B35;background:#FFF3EE;}
@keyframes fb_modal_in{from{opacity:0;transform:scale(0.9) translateY(20px);}to{opacity:1;transform:scale(1) translateY(0);}}
@keyframes slideDown{from{opacity:0;transform:translateY(-16px);}to{opacity:1;transform:translateY(0);}}
</style>
</head>
<body>

<!-- 상단 완료 토스트 -->
<div style="position:fixed;top:24px;left:50%;transform:translateX(-50%);z-index:200;animation:slideDown 0.5s ease;">
  <div style="background:white;border-radius:99px;padding:12px 20px;display:flex;align-items:center;gap:10px;box-shadow:0 8px 30px rgba(0,0,0,0.12);border:1.5px solid #E8EDF5;">
    <div style="width:26px;height:26px;border-radius:50%;background:#E8F8F6;display:flex;align-items:center;justify-content:center;">
      <span class="material-symbols-outlined" style="font-size:16px;color:#00897B;">check_circle</span>
    </div>
    <span style="font-size:14px;font-weight:700;color:#1A1F36;white-space:nowrap;">회원가입이 완료되었습니다. 관리자 승인 후 인증 마크가 부여됩니다.</span>
  </div>
</div>

<!-- 인증 모달 카드 -->
<div style="background:white;border-radius:28px;width:100%;max-width:460px;margin:80px 20px 20px;box-shadow:0 24px 80px rgba(0,0,0,0.2);overflow:hidden;animation:fb_modal_in 0.35s ease;">

  <!-- 헤더 -->
  <div style="background:linear-gradient(135deg,#FF6B35,#FF8C5A);padding:28px 32px;text-align:center;">
    <div style="font-size:40px;margin-bottom:10px;">🏅</div>
    <h2 style="font-size:22px;font-weight:900;color:white;margin-bottom:6px;">트레이너 인증 (선택)</h2>
    <p style="font-size:13px;color:rgba(255,255,255,0.85);">입력 시 인증된 트레이너로 표시됩니다<br>(관리자 승인 필요)</p>
  </div>

  <!-- 폼 -->
  <form action="trainerVerify" method="post" enctype="multipart/form-data" style="padding:28px 32px;display:flex;flex-direction:column;gap:18px;">

    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">운동 경력</label>
      <input name="experience" class="fb-inp" placeholder="예: 7년 (ACSM 자격증 보유)">
    </div>

    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">커리어 (근무 이력)</label>
      <textarea name="career" class="fb-inp" style="min-height:90px;resize:vertical;" placeholder="주요 근무 이력 · 수상 경력 등을 입력해주세요"></textarea>
    </div>

    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">보유 자격증</label>
      <input name="certificate" class="fb-inp" placeholder="예: 생활스포츠지도사 2급, ACSM-CPT">
    </div>

    <!-- 자격증 파일 업로드 -->
    <div>
      <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:7px;">자격증 사진 업로드</label>
      <label class="upload-box" id="uploadLabel">
        <span class="material-symbols-outlined" style="font-size:36px;color:#9DA8C0;margin-bottom:8px;">photo_camera</span>
        <div style="font-size:14px;font-weight:700;color:#5A6480;">자격증 사진 첨부</div>
        <div style="font-size:12px;color:#C4CEDE;margin-top:4px;">JPG, PNG 파일 지원</div>
        <input type="file" name="certFile" accept="image/*" style="display:none;" onchange="previewUpload(this)">
      </label>
      <div id="fileName" style="font-size:12px;color:#FF6B35;font-weight:700;margin-top:6px;min-height:18px;"></div>
    </div>

    <!-- 인증 혜택 안내 -->
    <div style="background:linear-gradient(135deg,#FFF3EE,#FFEEE5);border:1.5px solid rgba(255,107,53,0.15);border-radius:14px;padding:14px 16px;">
      <div style="font-size:12px;font-weight:700;color:#FF6B35;margin-bottom:6px;">✅ 인증 트레이너 혜택</div>
      <ul style="font-size:12px;color:#5A6480;line-height:1.8;padding-left:16px;">
        <li>인증 뱃지 표시로 신뢰도 UP</li>
        <li>검색 결과 상위 노출</li>
        <li>회원 매칭 우선권 부여</li>
      </ul>
    </div>

    <!-- 버튼 -->
    <div style="display:flex;gap:10px;margin-top:4px;">
      <button type="button" onclick="location.href='main'" style="flex:1;padding:13px;border-radius:99px;border:1.5px solid #E8EDF5;background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;" onmouseover="this.style.background='#F7F9FC'" onmouseout="this.style.background='white'">
        건너뛰기
      </button>
      <button type="submit" style="flex:2;padding:13px;border-radius:99px;border:none;cursor:pointer;background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;font-size:15px;font-weight:800;font-family:'Noto Sans KR',sans-serif;box-shadow:0 4px 16px rgba(255,107,53,0.3);transition:all 0.2s;" onmouseover="this.style.transform='translateY(-1px)'" onmouseout="this.style.transform='none'">
        🚀 제출하기
      </button>
    </div>

  </form>
</div>

<script>
function previewUpload(input){
  const label = document.getElementById('uploadLabel');
  const name  = document.getElementById('fileName');
  if(input.files && input.files[0]){
    name.innerText = '📎 ' + input.files[0].name;
    label.style.borderColor = '#FF6B35';
    label.style.background  = '#FFF3EE';
  }
}
</script>
</body>
</html>
