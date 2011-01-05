<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="inc/libs.jsp" %>
<title>Escalade | Login Page</title>
</head>
<body>
	<%@ include file="inc/header.jsp" %>
	<form method='post' action='LoginServlet' >
		<label>Username<br/><input type='text' name='login'/></label><br/><br/>
		<label>Password<br/><input type='password' name='password'/></label><br/><br/>
		<input type='submit' name='submit' value='login' />
	</form>
	<p>Or <a href='newUser.jsp'>create new user</a>.</p>
</body>
</html>