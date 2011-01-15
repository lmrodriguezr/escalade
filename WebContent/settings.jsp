<%@ include file="inc/header.jsp" %>
<%@ include file="inc/requireUser.jsp" %>
<%
		Grimpeur g = (Grimpeur) userR;
		String login = g.getLogin()==null ? "" : g.getLogin();
		String email = g.getEmail()==null ? "" : g.getEmail();
		String prenom = g.getPrenom()==null ? "" : g.getPrenom();
		String nom = g.getNom()==null ? "" : g.getNom();
		String gender = g.getGender()==null ? "" : g.getGender();
		int age = g.getAge();
		int poids = g.getPoids();
		int taille = g.getTaille();
%>
<h1>Profile edition</h1>
<form method='post' action='AlterUserServlet'>
<h2>Basic user data</h2>
<label>User-name*<br />
<input readonly="readonly" type='text' name='login'
	value='<%=login%>' /></label><br />
<br />
<label>Password*<br />
<input type='password' name='password' /></label><br />
<br />
<label>Re-type the password*<br />
<input type='password' name='password2' /></label><br />
<br />
<label>Email<br />
<input type='text' name='email' value='<%=email%>' /></label><br />
<br />
<label>Forename<br />
<input type='text' name='prenom' value='<%=prenom%>' /></label><br />
<br />
<label>Surname<br />
<input type='text' name='nom' value='<%=nom%>' /></label><br />
<br />
<h2>Climber data</h2>
<label>Gender<br />
   <select name="gender">
   <option value=" ">  </option>
   <option value='<%=gender%>'>Male</option>
   </select></label><br />
 <br /> 
<label>Age<br />
<input type='text' name='age' value='<%=age%>' /></label><br />
<br />
<label>Weight<br />
<input type='text' name='poids' value='<%=poids%>' /></label><br />
<br />
<label>Height (cm)<br />
<input type='text' name='taille' value='<%=taille%>' /></label><br />
<p><input type='submit' name='submit' value='Modify data' /> or <input type='reset' value='restart' /></p>
</form>
<jsp:include page="inc/footer.jsp"/>