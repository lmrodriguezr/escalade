<%@ include file="inc/header.jsp" %>
<%
		String login = (String) request.getSession().getAttribute("login");
		if(login==null) login = "";
		String email = (String) request.getSession().getAttribute("email");
		if(email==null) email = "";
		String prenom = (String) request.getSession().getAttribute("prenom");
		if(prenom==null) prenom = "";
		String nom = (String) request.getSession().getAttribute("nom");
		if(nom==null) nom = "";
		Integer age = (Integer) request.getSession().getAttribute("age");
		if(age==null) age = 0;
		Integer poids = (Integer) request.getSession().getAttribute("poids");
		if(poids==null) poids = 0;
		Integer taille = (Integer) request.getSession().getAttribute("taille");
		if(taille==null) taille = 0;
%>
<form method='post' action='CreateUserServlet'>
<h2>Basic user data</h2>
<label>Username*<br />
<input type='text' name='login' value='<%= login %>' /></label><br />
<br />
<label>Password*<br />
<input type='password' name='password' /></label><br />
<br />
<label>Re-type the password*<br />
<input type='password' name='password2' /></label><br />
<br />
<label>Email<br />
<input type='text' name='email' value='<%= email %>' /></label><br />
<br />
<label>Forename<br />
<input type='text' name='prenom' value='<%= prenom %>' /></label><br />
<br />
<label>Surename<br />
<input type='text' name='nom' value='<%= nom %>' /></label><br />
<br />
<h2>Climber data</h2>
<label>Age<br />
<input type='text' name='age'
	value='<%= age %>' /></label><br />
<br />
<label>Poids<br />
<input type='text' name='poids'
	value='<%= poids %>' /></label><br />
<br />
<label>Taille (cm)<br />
<input type='text' name='taille'
	value='<%= taille %>' /></label><br />
<p><input type='submit' name='submit' value='Create user' /> or <a
	href='login.jsp'>log in</a>.</p>
</form>
<jsp:include page="inc/footer.jsp"/>