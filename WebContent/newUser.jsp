<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="inc/libs.jsp"%>
<title>Peak | New User</title>
</head>
<body>
<%@ include file="inc/header.jsp"%>
<%
		Object login = request.getSession().getAttribute("login");
		Object email = request.getSession().getAttribute("email");
		Object prenom = request.getSession().getAttribute("prenom");
		Object nom = request.getSession().getAttribute("nom");
		Object age = request.getSession().getAttribute("age");
		Object poids = request.getSession().getAttribute("poids");
		Object taille = request.getSession().getAttribute("taille");
	%>
<form method='post' action='CreateUserServlet'>
<h2>Basic user data</h2>
<label>Username*<br />
<input type='text' name='login' value='<%= login==null?"":login %>' /></label><br />
<br />
<label>Password*<br />
<input type='password' name='password' /></label><br />
<br />
<label>Re-type the password*<br />
<input type='password' name='password2' /></label><br />
<br />
<label>Email<br />
<input type='text' name='email' value='<%= email==null?"":email %>' /></label><br />
<br />
<label>Forename<br />
<input type='text' name='prenom' value='<%= prenom==null?"":prenom %>' /></label><br />
<br />
<label>Surename<br />
<input type='text' name='nom' value='<%= nom==null?"":nom %>' /></label><br />
<br />
<h2>Climber data</h2>
<label>Age<br />
<input type='text' name='age'
	value='<%= age==null||(Integer)age==0?"":age %>' /></label><br />
<br />
<label>Poids<br />
<input type='text' name='poids'
	value='<%= poids==null||(Integer)age==0?"":poids %>' /></label><br />
<br />
<label>Taille (cm)<br />
<input type='text' name='taille'
	value='<%= taille==null||(Integer)taille==0?"":taille %>' /></label><br />
<p><input type='submit' name='submit' value='Create user' /> or <a
	href='login.jsp'>log in</a>.</p>
</form>
</body>
</html>