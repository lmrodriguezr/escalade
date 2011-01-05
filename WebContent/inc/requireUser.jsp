<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>

<%
	Utilisateur userR = (Utilisateur) request.getSession().getAttribute("loggedUser");
	if (userR == null) {
		request.getSession().setAttribute("error", "You must log in to access this page.");
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);
	}
%>