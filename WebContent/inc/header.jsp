<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>
<div id='header'>
	<h1><a href='./'>Peak</a></h1>
	<h2>The climbers website</h2>
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
<div id='user_box'>Logged in as <a
	href='UserPageServlet?username=<%=user.getLogin()%>'><%=user.getLogin()%></a><br />
	<a href='LogoutServlet'>Log out</a> |
	<a href='settings.jsp'>Settings</a> |
	<a href='ascents.jsp'>Ascents</a>
</div>
<%
	}else{
		%>
<div id='user_box'>[ <a href='login.jsp'>Log in</a> | <a
	href='newUser.jsp'>Create user</a> ]</div>
<%
	}
%>
<%=e%>