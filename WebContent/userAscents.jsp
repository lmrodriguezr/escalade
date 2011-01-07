<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*" import="java.util.*"%>
<jsp:include page="inc/header.jsp"/>
<jsp:include page="inc/requireUser.jsp"/>

<%
	@SuppressWarnings("unchecked")
	List<Ascension> ascs = (List<Ascension>) request.getSession().getAttribute("requestedAscents");
	request.getSession().removeAttribute("requestedAscents");
	if(ascs==null) {
		%> <jsp:forward page="/UserAscentsServlet"/> <%
		return;
	}
	
	Grimpeur u = (Grimpeur) request.getSession().getAttribute("requestedUser");
	request.getSession().removeAttribute("requestedUser");
	Grimpeur user = (Grimpeur) ((Grimpeur)request.getSession().getAttribute("loggedUser"));
	if(u.getLogin().equals(user.getLogin())){
		%><h1>My Ascents</h1><a href='newAscent.jsp'>Add new</a><%
	}else{
		%><h1>Ascents</h1><%
	}
%><table class='selection'><tr>
	<th>Date</th><th>Path</th><th>Sector</th><th>Mountain</th><th>Country</th><th>Comments</th></tr><%
	
	for(Iterator<Ascension> it = ascs.iterator(); it.hasNext() ; ){
		Ascension asc = it.next();
		Secteur sec = asc.getVoie().getSecteur();
		Falaise fal = sec.getFalaise();
		%>
		<tr>
			<td><%= asc.getDate().toString() %></td>
			<td><%= asc.getVoie().getNom() %></td>
			<td><%= sec.getNom() %></td>
			<td><%= fal.getNom() %></td>
			<td><%= fal.getPays().getNom() %></td>
			<td><%= asc.getCommentaire() %></td>
		</tr>
		<%
	}
%>
</table>

<jsp:include page="inc/footer.jsp"/>