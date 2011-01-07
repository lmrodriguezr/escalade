<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="inc/header.jsp"/>

<h2>Recent users</h2>
<jsp:include page="UsersServlet?format=html-table&limit=10"></jsp:include>

<h2>Recent ascents</h2>
<jsp:include page="AscentsServlet?format=html-table&limit=10"></jsp:include>

<jsp:include page="inc/footer.jsp"/>