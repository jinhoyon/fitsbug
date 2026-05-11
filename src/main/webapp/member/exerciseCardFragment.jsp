<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, dto.member.ExerciseGuideDTO" %>
<%
List<ExerciseGuideDTO> list = (List<ExerciseGuideDTO>) request.getAttribute("exerciseList");
if (list == null) list = new ArrayList<>();

for (ExerciseGuideDTO e : list) {
    // keyPoint → | 구분자 JSON 배열 생성
    String kp = e.getKeyPoint() != null ? e.getKeyPoint() : "";
    String[] kpArr = kp.split("\\|");
    StringBuilder kpJson = new StringBuilder("[");
    for (int ki = 0; ki < kpArr.length; ki++) {
        kpJson.append("\"")
              .append(kpArr[ki].trim()
                  .replace("\\","\\\\").replace("\"","\\\"").replace("'","\\'"))
              .append("\"");
        if (ki < kpArr.length - 1) kpJson.append(",");
    }
    kpJson.append("]");

    // ✅ DB 컬럼 기준 변수명
    String title    = e.getTitle()        != null ? e.getTitle()        : "";
    String muscle   = e.getTargetMuscle() != null ? e.getTargetMuscle() : "";  // targetMuscle
    String type     = e.getType()         != null ? e.getType()         : "";
    String diff     = e.getDifficulty()   != null ? e.getDifficulty()   : "";
    String desc     = e.getDescription()  != null
                      ? e.getDescription().replace("'","\\'").replace("\n","\\n") : "";
    String image    = e.getImage()        != null ? e.getImage()        : "";  // image (gif/thumb 통합)
    String video    = e.getVideo()        != null ? e.getVideo()        : "";  // video (youtube)
    String safeTitle = title.replace("'","\\'");
%>
<div class="ex-card"
     data-id="<%=e.getId()%>"
     data-muscle="<%=muscle%>"
     data-level="<%=diff%>"
     data-name="<%=safeTitle%>"
     onclick="showDetail(
       '<%=safeTitle%>',
       '<%=image%>',
       '<%=desc%>',
       '<%=video%>',
       '<%=muscle%>',
       '<%=type%>',
       '<%=diff%>',
       <%=kpJson%>,
       this
     )">

    <!-- 썸네일 (image 컬럼 = gif/이미지 통합) -->
    <div class="card-thumb">
        <img src="<%=image%>" alt="<%=title%>"
             onerror="this.parentElement.style.background='#e5e9f0'">
        <span class="gif-badge">GIF</span>
    </div>

    <div class="card-body">
        <div class="card-name"><%=title%></div>
        <div class="tag-row">
            <span class="tag <%=muscle%>"><%=muscle%></span>
            <span class="tag <%=type%>"><%=type%></span>
            <span class="tag <%=diff%>"><%=diff%></span>
        </div>
    </div>
</div>
<% } %>
