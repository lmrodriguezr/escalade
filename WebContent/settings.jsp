<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="inc/libs.jsp"%>
<title>Escalade | User settings</title>
</head>
<body>
<%@ include file="inc/header.jsp"%>
<%@ include file="inc/requireUser.jsp"%>
<%
		Grimpeur g = user;
		String login = g.getLogin();
		String email = g.getEmail();
		String prenom = g.getPrenom();
		String nom = g.getNom();
		int age = g.getAge();
		int poids = g.getPoids();
		int taille = g.getTaille();
	%>
<form method='post' action='AlterUserServlet'>
<h2>Basic user data</h2>
<label>Username*<br />
<input readonly="readonly" type='text' name='login'
	value='<%= login==null?"":login %>' /></label><br />
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
<input type='text' name='age' value='<%= age==0?"":age %>' /></label><br />
<br />
<label>Poids<br />
<input type='text' name='poids' value='<%= age==0?"":poids %>' /></label><br />
<br />
<label>Taille (cm)<br />
<input type='text' name='taille' value='<%= taille==0?"":taille %>' /></label><br />
<p><input type='submit' name='submit' value='Modify data' /> or <input
	type='reset' /></p>
</form>
</body>
</html>