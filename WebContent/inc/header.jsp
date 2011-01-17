<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>
<%@ taglib uri="/WEB-INF/peak.tld" prefix="peak" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="libs.jsp"%>
<title>Peak</title>

<link href="jimgMenu.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function () {

  // Chercher les elements a etirer
  $('div.jimgMenu ul li a').hover(function() {
    
    // Si l'element est anime
    if ($(this).is(':animated')) {
      $(this).stop().animate({width: "310px"}, {duration: 450, easing:"easeOutQuad"});
    } else {
      // l'etirer vite
      $(this).stop().animate({width: "310px"}, {duration: 400, easing:"easeOutQuad"});
    }
  }, function () {
    // le ramener
    if ($(this).is(':animated')) {
      $(this).stop().animate({width: "78px"}, {duration: 400, easing:"easeInOutQuad"})
    } else {
      // le ramener doucement
      $(this).stop('animated:').animate({width: "78px"}, {duration: 450, easing:"easeInOutQuad"});
    }
  });
});
</script>

</head>
<body>
<div id='header'>
	<h1><a href='peaks.jsp'>Peak</a></h1>
	<h2>The climbers web site</h2>
</div>

<div class="jimgMenu">
  <ul>
    <li class="home"><a href="peaks.jsp">Home</a></li>
    <li class="news"><a href="News.html">News</a></li>
    <li class="events"><a href="Events.html">Events Calendar</a></li>
    <li class="members"><a href="Members.jsp">Members</a></li>
    <li class="photo"><a href="Photo.html">Photo Gallery</a></li>
    <li class="video"><a href="Videos.html">Video Gallery</a></li>
    <li class="weather"><a href="Weather.html">Weather</a></li>
    <li class="forum"><a href="Forum.html">Forum</a></li>
    <li class="guestbook"><a href="Guestbook.html">Guestbook</a></li>
    <li class="contact"><a href="Contact.html">Contact us</a></li>
  </ul>
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
	<a href='userPage.jsp?user=<%= user.getLogin() %>'><%= user.getLogin() %></a><br />
	<a href='LogoutServlet'>Log out</a> |
	<a href='settings.jsp'>Settings</a>
</div>
<%=e%>
<table id='wrapper'><tr><td id='user_menu'>

	<ul id='user_menu_list'>
		<li><a href='userPage.jsp'>View profile</a></li>
		<li><a href='userAscents.jsp'>List ascents</a></li>
		<li><a href='newAscent.jsp'>Register ascent</a></li>
		<li><a href='userMap.jsp'>Map of mountains</a></li>
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