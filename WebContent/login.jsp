<%@ include file="inc/header.jsp" %>

<form method='post' action='LoginServlet'><label>Username<br />
<input type='text' name='login' /></label><br />
<br />
<label>Password<br />
<input type='password' name='password' /></label><br />
<br />
<input type='submit' name='submit' value='login' /></form>
<p>Or <a href='newUser.jsp'>create new user</a>.</p>
<jsp:include page="inc/footer.jsp"/>