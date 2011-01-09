<%@ include file="inc/header.jsp" %>
<%@ include file="inc/requireUser.jsp" %>
<%
	String u = request.getParameter("user");
	if(u==null) u = userR.getLogin();
%>
<peak:user asUserLogin="<%= userR.getLogin() %>" userLogin="<%= u %>"/>