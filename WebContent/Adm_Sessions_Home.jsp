<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.bean.Admin"%>
<%@page import="com.bean.Session"%>
<%@page import="com.bean.Room"%>

<sql:setDataSource var="myDS" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://aagmqmvaq3h3zl.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false" user="root" password="rootroot"/>

<%
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String type = request.getParameter("typeDropbtn");
String room = request.getParameter("roomDropbtn");
String advisor = request.getParameter("advisorDropbtn");
boolean showAll = (type==null && room==null && advisor==null) || (type=="" && room=="" && advisor=="");
boolean filtered = (type!=null || room!=null || advisor!=null) && (type!="" || room!="" || advisor!="");
request.setAttribute("startDate", startDate);
request.setAttribute("endDate", endDate);
request.setAttribute("type", type);
request.setAttribute("room", room);
request.setAttribute("advisor", advisor);
request.setAttribute("showAll", showAll);
request.setAttribute("filtered", filtered);

/* out.println("date: " + date + " | type: " + type + " | room " + room + " | advisor: " + advisor + "\n");
out.println("showAll? " + showAll + " | filtered? " + filtered); */
%>
<sql:query var="queryAllSessions" dataSource="${myDS}">
	SELECT * FROM session INNER JOIN room ON session.roomId=room.roomId LEFT JOIN student ON session.studentId=student.studentID;
</sql:query>
<sql:query var="queryFilterSessions" dataSource="${myDS}">
	SELECT * FROM session INNER JOIN room ON session.roomId=room.roomId LEFT JOIN student ON session.studentId=student.studentID WHERE type=? OR session.roomId=? OR adminId=?;
	<sql:param value="${type}" />
	<sql:param value="${room}" />
	<sql:param value="${advisor}" />
</sql:query>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
	<title>HELPS Booking System</title>
	<link rel="stylesheet" href="css/Adm_Sessions.css" />
	
	<!-- table viewer -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
    
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
	<script type="text/javascript">
		$(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
			$('.filter').load('FilterComponent.jsp');
		});
	</script>

	
</head>
<body>
	<div class="head"></div>
	
	<div class="wrapper">
		<!-- Tab: Book Session; Admin Session -->
		<div class="tab">
			<ul>
			  <li><a class="active" href="Adm_Sessions_Home.jsp">Book Sessions</a></li>
			  <li><a href="OneToOneSessionsAdmin.jsp">Admin Sessions</a></li>
			</ul>
		</div>
		
		<div id="BookSessionsContent" class="tabcontent">
			<div class="filter" style="width:30%; float:left; margin-left: 10%"></div>
		</div>
	</div>
	<div class="footer" style="width:100%; float:left; margin-top:5%"></div>
	
</body>
</html>