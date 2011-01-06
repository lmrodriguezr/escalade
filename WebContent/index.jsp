<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*"%>
<%
	Grimpeur user = (Grimpeur) request.getSession().getAttribute("loggedUser");
	RequestDispatcher dispatcher;
	if (user == null) {
		dispatcher = getServletContext().getRequestDispatcher("/peaks.jsp");
	}else{
		dispatcher = getServletContext().getRequestDispatcher("/userPage.jsp");
	}
	dispatcher.forward(request, response);
%>