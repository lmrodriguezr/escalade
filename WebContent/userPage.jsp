<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="inc/libs.jsp"%>
<title>Escalade | New User</title>
</head>
<body>
<%@ include file="inc/header.jsp"%>
<%@ include file="inc/requireUser.jsp"%>
<%
		Grimpeur u = (Grimpeur) request.getSession().getAttribute("requestedUser");
		if(u==null) u=(Grimpeur)user;
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
</body>
</html>