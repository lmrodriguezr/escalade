<%@ include file="inc/header.jsp" %>
<%@ include file="inc/requireUser.jsp" %>
<%
String u = request.getParameter("user");
if(u==null) u = userR.getLogin();
if(u!=null && u.equals(userR.getLogin())){
	%><h2>My registered ascents</h2><div class='subtext'>[<a href='newAscent.jsp'>Register new ascent</a>]</div><%
}else{
	%><h2>Registered ascents by <a href='UserPageServlet?username=<%= u %>'><%= u %></a></h2><%
}
%>
<peak:ascents userLogin="<%= u %>"/>
<jsp:include page="inc/footer.jsp"></jsp:include>