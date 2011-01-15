<%@ include file="inc/header.jsp" %>

<peak:map
	userLogin='<%= request.getParameter("user") %>'
	city='<%= request.getParameter("country") %>'
	country='<%= request.getParameter("city") %>'
	ascent='<%= request.getParameter("ascent") %>' />
	
<jsp:include page="inc/footer.jsp"></jsp:include>