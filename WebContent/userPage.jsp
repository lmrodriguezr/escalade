<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>
<jsp:include page="inc/header.jsp"/>
<jsp:include page="inc/requireUser.jsp"/>
<%
	Grimpeur u = (Grimpeur) request.getSession().getAttribute("requestedUser");
	request.getSession().removeAttribute("requestedUser");
	Grimpeur user = (Grimpeur) ((Grimpeur)request.getSession().getAttribute("loggedUser"));
	if(u==null) {
		//u = user;
		%> <jsp:forward page="/UserPageServlet"/> <%
		return;
	}
	if(u.getLogin().equals(user.getLogin())){
		%><h1>My Profile</h1><a href='settings.jsp'>Edit</a><%
	}else{
		%><h1>User Profile</h1><%
	}
%>
<table class='selection'>
	<tr>
		<td>Name</td>
		<td><%= u.getPrenom() %> <%= u.getNom() %></td>
	</tr>
	<tr>
		<td>E-mail</td>
		<td><%= u.getEmail() %></td>
	</tr>
	<tr>
		<td>Weight</td>
		<td><%= u.getPoids() %></td>
	</tr>
</table>
<jsp:include page="inc/footer.jsp"/>