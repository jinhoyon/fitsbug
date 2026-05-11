<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="postModal" style="
  display:none; position:fixed; inset:0; z-index:2000;
  background:rgba(26,31,54,0.55); align-items:center; justify-content:center;
  backdrop-filter:blur(6px);
">
  <div style="
    background:white; border-radius:28px; width:100%; max-width:600px;
    max-height:92vh; overflow-y:auto;
    box-shadow:0 16px 48px rgba(0,0,0,0.18);
    animation:fb_modal_in 0.3s ease;
    font-family:'Noto Sans KR','Nunito',sans-serif;
  ">

    <!-- 헤더 -->
    <div style="
      display:flex; justify-content:space-between; align-items:center;
      padding:24px 28px 20px;
      border-bottom:1.5px solid #E8EDF5;
    ">
      <div style="display:flex;align-items:center;gap:12px;">
        <!-- 핏불 미니 아이콘 -->
        <div style="width:38px;height:38px;border-radius:50%;background:linear-gradient(135deg,#FF6B35,#FFD166);display:flex;align-items:center;justify-content:center;font-size:18px;">🐾</div>
        <div>
          <h2 style="font-size:18px;font-weight:900;color:#1A1F36;">새 게시글 작성</h2>
          <p style="font-size:12px;color:#9DA8C0;margin-top:1px;">핏불 친구들과 공유해보세요!</p>
        </div>
      </div>
      <button onclick="closePostModal()" style="
        width:34px;height:34px;border-radius:50%;border:none;background:#F7F9FC;
        color:#5A6480;cursor:pointer;font-size:20px;display:flex;align-items:center;justify-content:center;
        transition:background 0.2s;
      " onmouseover="this.style.background='#FEE2E2';this.style.color='#EF4444'" onmouseout="this.style.background='#F7F9FC';this.style.color='#5A6480'">
        ✕
      </button>
    </div>

    <!-- 폼 -->
    <form action="post" method="post" enctype="multipart/form-data" style="padding:24px 28px;display:flex;flex-direction:column;gap:20px;">

      <!-- 카테고리 선택 -->
      <div>
        <p style="font-size:13px;font-weight:700;color:#5A6480;margin-bottom:10px;">카테고리 선택</p>
        <div style="display:flex;gap:10px;">
          <button type="button" id="owunBtn" onclick="selectCategory('owun')" style="
            padding:10px 22px;border-radius:99px;border:none;cursor:pointer;
            background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;
            font-size:14px;font-weight:700;font-family:'Noto Sans KR',sans-serif;
            box-shadow:0 4px 14px rgba(255,107,53,0.3);transition:all 0.2s;
          ">🏆 오운완</button>
          <button type="button" id="freeBtn" onclick="selectCategory('free')" style="
            padding:10px 22px;border-radius:99px;border:2px solid #E8EDF5;cursor:pointer;
            background:white;color:#5A6480;
            font-size:14px;font-weight:700;font-family:'Noto Sans KR',sans-serif;
            transition:all 0.2s;
          ">💬 자유게시판</button>
        </div>
        <input type="hidden" name="category" id="category" value="owun">
      </div>

      <!-- 제목 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:8px;">제목</label>
        <input name="title" placeholder="오늘의 운동 제목을 입력하세요 💪" style="
          width:100%;padding:13px 18px;border-radius:14px;border:2px solid #E8EDF5;
          background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;
          color:#1A1F36;outline:none;transition:border-color 0.2s,box-shadow 0.2s;box-sizing:border-box;
        " onfocus="this.style.borderColor='#FF6B35';this.style.boxShadow='0 0 0 3px rgba(255,107,53,0.12)';this.style.background='white'"
           onblur="this.style.borderColor='#E8EDF5';this.style.boxShadow='none';this.style.background='#F7F9FC'">
      </div>

      <!-- 이미지 업로드 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:8px;">🖼 인증샷 업로드</label>
        <label id="imageLabel" style="
          display:flex;flex-direction:column;align-items:center;justify-content:center;
          width:100%;border:2.5px dashed #E8EDF5;border-radius:18px;padding:36px 20px;
          cursor:pointer;background:#F7F9FC;transition:all 0.2s;
        " onmouseover="this.style.borderColor='#FF6B35';this.style.background='#FFF3EE'" onmouseout="this.style.borderColor='#E8EDF5';this.style.background='#F7F9FC'">
          <div style="width:56px;height:56px;border-radius:16px;background:white;border:1.5px solid #E8EDF5;display:flex;align-items:center;justify-content:center;margin-bottom:12px;font-size:28px;">📸</div>
          <span id="uploadText" style="font-size:14px;color:#9DA8C0;font-weight:600;">🏋️ 오늘 운동 인증샷을 공유해보세요!</span>
          <span style="font-size:12px;color:#C4CEDE;margin-top:4px;">JPG, PNG, GIF 업로드 가능</span>
          <input type="file" name="image" id="imageInput" class="hidden" accept="image/*" style="display:none;" onchange="previewImage(this)">
        </label>
        <!-- 이미지 미리보기 -->
        <img id="imagePreview" style="display:none;width:100%;max-height:220px;object-fit:cover;border-radius:14px;margin-top:10px;" alt="미리보기">
      </div>

      <!-- 내용 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:8px;">내용</label>
        <textarea name="body" placeholder="오늘 운동 어땠나요? 자유롭게 기록해보세요 🔥" style="
          width:100%;padding:14px 18px;border-radius:14px;border:2px solid #E8EDF5;
          background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;
          color:#1A1F36;outline:none;resize:none;min-height:110px;
          transition:border-color 0.2s,box-shadow 0.2s;box-sizing:border-box;
        " onfocus="this.style.borderColor='#FF6B35';this.style.boxShadow='0 0 0 3px rgba(255,107,53,0.12)';this.style.background='white'"
           onblur="this.style.borderColor='#E8EDF5';this.style.boxShadow='none';this.style.background='#F7F9FC'"></textarea>
      </div>

      <!-- 해시태그 -->
      <div>
        <label style="font-size:13px;font-weight:700;color:#5A6480;display:block;margin-bottom:8px;"># 해시태그</label>
        <input name="hashtags" id="hashtagInput" placeholder="#오운완 #운동 #헬스" style="
          width:100%;padding:13px 18px;border-radius:14px;border:2px solid #E8EDF5;
          background:#F7F9FC;font-family:'Noto Sans KR',sans-serif;font-size:14px;
          color:#00BFA5;font-weight:600;outline:none;transition:border-color 0.2s;box-sizing:border-box;
        " onfocus="this.style.borderColor='#00BFA5';this.style.background='white'" onblur="this.style.borderColor='#E8EDF5';this.style.background='#F7F9FC'">
      </div>

      <!-- 버튼 -->
      <div style="display:flex;gap:12px;justify-content:flex-end;margin-top:4px;">
        <button type="button" onclick="closePostModal()" style="
          padding:12px 24px;border-radius:99px;border:1.5px solid #E8EDF5;
          background:white;color:#5A6480;font-size:14px;font-weight:700;cursor:pointer;
          font-family:'Noto Sans KR',sans-serif;transition:all 0.2s;
        " onmouseover="this.style.background='#F7F9FC'" onmouseout="this.style.background='white'">취소</button>

        <button type="submit" style="
          padding:12px 30px;border-radius:99px;border:none;cursor:pointer;
          background:linear-gradient(135deg,#FF6B35,#FF8C5A);color:white;
          font-size:14px;font-weight:800;font-family:'Noto Sans KR',sans-serif;
          box-shadow:0 4px 16px rgba(255,107,53,0.3);transition:all 0.2s;
        " onmouseover="this.style.transform='translateY(-2px)';this.style.boxShadow='0 6px 22px rgba(255,107,53,0.4)'"
           onmouseout="this.style.transform='none';this.style.boxShadow='0 4px 16px rgba(255,107,53,0.3)'">
          🚀 등록하기
        </button>
      </div>

    </form>
  </div>
</div>

<script>
function previewImage(input) {
  const preview = document.getElementById('imagePreview');
  const label = document.getElementById('imageLabel');
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = e => {
      preview.src = e.target.result;
      preview.style.display = 'block';
      label.style.display = 'none';
    };
    reader.readAsDataURL(input.files[0]);
  }
}
</script>
