<%@ page import="java.util.*,dto.member.ExerciseGuideDTO" %>
<%

List<ExerciseGuideDTO> list = (List<ExerciseGuideDTO>) request.getAttribute("exerciseList");
for(ExerciseGuideDTO e : list) {
%>

<div class="bg-white p-3">
    <img src="<%=e.getThumbnail()%>" class="w-full h-40">
    <h3><%=e.getName()%></h3>
</div>

<% } %>