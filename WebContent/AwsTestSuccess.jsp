<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Welcome: <%=session.getAttribute("student") %></h1>
	<br/>
	<h1><%=session.getAttribute("description") %></h1>
</body>
</html>