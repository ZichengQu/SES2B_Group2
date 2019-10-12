<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.bean.Admin"%>
<%@page import="com.bean.Session"%>
<%@page import="com.bean.Room"%>
<%@page import="com.dao.MessageDatabase"%>

<sql:setDataSource var="myDS" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false" user="admin" password="thisadmin"/>

<sql:query var="listRooms" dataSource="${myDS}"> SELECT * FROM room;</sql:query>
<sql:query var="listAdvisors" dataSource="${myDS}"> SELECT * FROM advisor;</sql:query>

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
			var mess = "<%=MessageDatabase.getCurrentMessage(12).getMessageTempDetailed()%>";
			$("#message_edit").html(mess);
		});

	</script>

	
</head>
<body>
	<div class="head"></div>
	
	<div class="wrapper">
		<!-- Tab: Book Session; Admin Session -->
		<h1>One To One Session</h1>
		<div id="message_edit"></div>
		<div class="tab">
			<ul>
			  <li><a class="active" href="OneToOneSessions.jsp">Book Sessions</a></li>
			  <li><a href="OneToOneSessionsAdmin.jsp">Admin Sessions</a></li>
			</ul>
		</div>
		<div class="filter" style="width:30%; float:left; margin-left: 10%">
			<p class="header_name" id="filter_sessions_header" style="width:90%; padding-top: 3%;" >Filter Sessions</p>
			<form class="filter_sessions" action="OneToOneSessions.jsp" method="POST">
				<p id="date_filter">1. Date:&nbsp;&nbsp;
					<input type="date" name="startDate" style="width:50%"> to <input type="date" name="endDate" style="width:50%">
				</p>
				<p id="type_filter">2. Type:&nbsp;&nbsp;
					<select name="typeDropbtn">
						<option value=""></option>
						<option value="UG/PG course work students">UG/PG course work students</option>
						<option value="UP/PG Others">UP/PG Others</option>
					</select>
				</p>
				<p id="room_filter">3. Room:&nbsp;&nbsp;
					<select name="roomDropbtn">
						<option value=""></option>
						<c:forEach var="item" items="${listRooms.rows}" >
							<option value="${item.roomId}"><c:out value="${item.campus}.${item.level}.${item.roomNumber}" /></option>
						</c:forEach>
					</select>
				</p>
				<p id="advisor_filter">4. Advisor:&nbsp;&nbsp;
					<select name="advisorDropbtn">
						<option value=""></option>
						<c:forEach var="item" items="${listAdvisors.rows}" >
							<option value="${item.advisorId}"><c:out value="${item.firstName} ${item.lastName}"/></option>
						</c:forEach>
					</select>
				</p>
				<div class="submitFilter" style="padding-bottom:1%; padding-top:5%">
					<input type="submit" name="btnSubmitFilter" value="Show This Year" id="btnShowAllFilter" style="float:left; margin-left: 10%"/>
					<input type="submit" name="btnSubmitFilter" value="Submit" id="btnSubmitFilter" style="float:left; margin-left: 10%"/>
					<input type="reset" value="Reset" style="float:left; margin-left: 10%">
				</div>
				<p><br></p>
			
			</form>
		</div>
	</div>
	<div class="footer"></div>
	
</body>
</html>