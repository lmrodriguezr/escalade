<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="libs.jsp"%>
<title>Peak</title>
</head>
<body>
<div id='header'>
	<h1><a href='./'>Peak</a></h1>
	<h2>The climbers web site</h2>
</div>
<div id='climber-top'>&nbsp;</div>
<%
	String e = "";
	Object err = request.getSession().getAttribute("error");
	if (err != null) {
		e = "<script>\n"
				+ "setTimeout(function () { $('#ErrId').fadeOut('slow'); }, 1000*12);\n"
				+ "</script><div class='error' id='ErrId'><h1>Error</h1>"
				+ err + "</div>";
		request.getSession().removeAttribute("error");
	}
	Grimpeur user = (Grimpeur) request.getSession().getAttribute("loggedUser");
	if (user != null) {
		%>
<div id='user_box'>Logged in as
	<a href='UserPageServlet?username=<%= user.getLogin() %>'><%= user.getLogin() %></a><br />
	<a href='LogoutServlet'>Log out</a> |
	<a href='settings.jsp'>Settings</a>
</div>
<%=e%>
<table id='wrapper'><tr><td id='user_menu'>
	<ul id='user_menu_list'>
		<li><a href='userPage.jsp'>Profile</a></li>
		<li><a href='ascents.jsp'>Ascents</a></li>
		<li><a>Map</a></li>
		<li><a>Stats</a></li>
	</ul>
	<script>
		$('#user_menu_list').scrollFollow();
	</script>
</td><td id='content'>
<%
	}else{
%>
<div id='user_box'>[ <a href='login.jsp'>Log in</a> |
	<a href='newUser.jsp'>Create user</a> ]
</div>
<%=e%>
<table id='wrapper'><tr><td id='content'>
<%
	}
%>