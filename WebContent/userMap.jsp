<%@ include file="inc/header.jsp" %>
<%@ include file="inc/requireUser.jsp" %>
<%
String u = request.getParameter("user");
if(u==null) u = userR.getLogin();
if(u!=null && u.equals(userR.getLogin())){
	%><h2>My registered mountains</h2><div class='subtext'>[<a href='userAscents.jsp'>View ascents in detail</a>]</div><%
}else{
	%><h2>Registered mountains by <a href='UserPageServlet?username=<%= u %>'><%= u %></a></h2><%
}
%>
<peak:map userLogin="<%= u %>"/>
<jsp:include page="inc/footer.jsp"></jsp:include>