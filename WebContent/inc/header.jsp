<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>

<%@ taglib uri="/WEB-INF/peak.tld" prefix="peak" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="libs.jsp"%>
<title>Peak</title>

</head>
<body>
<div id='header'>
	<h1><a href='peaks.jsp'>Peak</a></h1>
	<h2>The climbers web site</h2>
</div>

<div id='climber-top'>&nbsp;</div>
<%
	String contact = "<div id='contactFormContainer'>"+
	"<div id='contactForm'>"+
	"<div class='loader'></div>"+
	"<div class='bar'></div>"+
 	"<form action='ContactServlet' class='contactForm' name='cform' method='post'>"+
	"    <p>If you have any request, please fill out the form below</p>"+
	"    <div class='input_boxes'>"+
	"        <p><label for='name'>Name</label><span class='name-missing'>Please enter your name!</span><br />"+
	"        <input id='name' type='text' value='' name='name' /></p>"+
	"        <p><label for='e-mail'>E-mail</label><span class='email-missing'>Please enter a valid e-mail!</span><br />"+
	"        <input id='e-mail' type='text' value='' name='email' /></p>"+
	"        <p><label for='message'>Message</label><span class='message-missing'>Please enter a message!</span><br />"+
	"        <textarea id='message' rows='' cols='' name='message'></textarea></p>"+
	"     </div>"+
	"     <input class='submit' type='submit' name='submit' value='Submit Form' onfocus='this.blur()'  />"+
    "</form></div><div class='contact'></div>"+
	"</div>";
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
	<a href='userPage.jsp?user=<%= user.getLogin() %>'><%= user.getLogin() %></a><br />
	<a href='LogoutServlet'>Log out</a> |
	<a href='settings.jsp'>Settings</a>
</div>
<%=contact%>
<%=e%>
<%= "<table id='wrapper'><tr><td id='user_menu'>" %>

	<ul id='user_menu_list'>
		<li><a href='userPage.jsp'>View profile</a></li>
		<li><a href='userAscents.jsp'>List ascents</a></li>
		<li><a href='newAscent.jsp'>Register ascent</a></li>
		<li><a href='userMap.jsp'>Map of mountains</a></li>
		<li class='user_menu_separator'>&nbsp;</li>
		<li><a href='News.jsp'>News</a></li>
		<li><a href='Events.jsp'>Events</a></li>
		<li><a href='Members.jsp'>Members</a></li>
		<li><a href='weather.jsp'>Weather</a></li>
		<li><a href='Forum.jsp'>Forum</a></li>
	</ul>
	<script>
		$('#user_menu_list').scrollFollow();
	</script>
<%= "</td><td id='content'>" %>
<%
	}else{
%>
<div id='user_box'>[ <a href='login.jsp'>Log in</a> |
	<a href='newUser.jsp'>Create user</a> ]
</div>
<%=contact%>
<%=e%>
<%= "<table id='wrapper'><tr><td id='content'>" %>
<%
	}
%>
