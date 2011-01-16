<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="me.thebio.escalade.*" import="java.io.*"%>
<%
	File hibernate_conf = new File(application.getRealPath("WEB-INF")
			+ "/classes/hibernate.mysql.cfg.xml");
	RequestDispatcher dispatcher;
	if (hibernate_conf.exists()) {
		Grimpeur user = (Grimpeur) request.getSession().getAttribute(
				"loggedUser");
		if (user == null) {
			dispatcher = getServletContext().getRequestDispatcher(
					"/peaks.jsp");
		} else {
			dispatcher = getServletContext().getRequestDispatcher(
					"/userPage.jsp");
		}
	} else {
		dispatcher = getServletContext().getRequestDispatcher(
				"/install.jsp");
	}
	dispatcher.forward(request, response);
%>