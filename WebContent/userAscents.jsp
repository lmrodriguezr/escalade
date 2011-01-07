<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*" import="java.util.*"%>
<jsp:include page="inc/header.jsp"/>
<jsp:include page="inc/requireUser.jsp"/>

<%
	Grimpeur user = (Grimpeur) ((Grimpeur)request.getSession().getAttribute("loggedUser"));
	String reqUser = request.getParameter("user");
	if(reqUser==null) reqUser = user.getLogin();
	if(reqUser.equals(user.getLogin())){
		%><h1>My Ascends</h1><a href='newAscent.jsp'>Add new</a><%
	}else{
		%><h1>Ascents</h1><%
	}
	String req = "AscentsServlet?format=html-table&user=" + reqUser;
%>
<jsp:include page="<%= req %>"></jsp:include>
<jsp:include page="inc/footer.jsp"/>