<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.bean.Admin"%>
<%@page import="com.bean.Session"%>
<%@page import="com.bean.Room"%>

<sql:setDataSource var="myDS" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false" user="admin" password="thisadmin"/>

<%
String date = request.getParameter("datefilter");
String type = request.getParameter("typeDropbtn");
String room = request.getParameter("roomDropbtn");
String advisor = request.getParameter("advisorDropbtn");
boolean showAll = (type==null && room==null && advisor==null) || (type=="" && room=="" && advisor=="");
boolean filtered = (type!=null || room!=null || advisor!=null) && (type!="" || room!="" || advisor!="");
request.setAttribute("date", date);
request.setAttribute("type", type);
request.setAttribute("room", room);
request.setAttribute("advisor", advisor);
request.setAttribute("showAll", showAll);
request.setAttribute("filtered", filtered);

/* out.println("date: " + date + " | type: " + type + " | room " + room + " | advisor: " + advisor + "\n");
out.println("showAll? " + showAll + " | filtered? " + filtered); */
%>

<sql:query var="listRooms" dataSource="${myDS}"> SELECT * FROM room;</sql:query>
<sql:query var="listAdvisors" dataSource="${myDS}"> SELECT * FROM advisor WHERE isActive="Active";</sql:query>

<sql:query var="queryAllSessions" dataSource="${myDS}">
	SELECT * FROM session INNER JOIN room ON session.roomId=room.roomId LEFT JOIN student ON session.studentId=student.studentID LEFT JOIN advisor ON session.advisorId=advisor.advisorId WHERE isActive="Active" ORDER BY sessionId DESC;
</sql:query>
<sql:query var="queryFilterSessions" dataSource="${myDS}">
	SELECT * FROM session INNER JOIN room ON session.roomId=room.roomId LEFT JOIN student ON session.studentId=student.studentID WHERE type=? OR session.roomId=? OR advisorId=? ORDER BY sessionId DESC;
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
	
	<!-- Include jQuery, Monment.js and Date Range Picker's file -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	
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
			$('.addOneToOneSessions').load('AddOneToOneSessions.jsp');
		});
		$(document).ready(function() {
		    $('#tAdminSessionAvailable').DataTable();
		} );
		function delAvlbSess(){
			var message = "Date + Room\n";
			var sessionId = [];
			var date = [];
			var room = [];
			var session = [];
			$('.display input[type=checkbox]:checked').each(function (){
				var row = $(this).closest('tr')[0];
				date.push(row.cells[3].innerHTML);
				room.push(row.cells[6].innerHTML);
				sessionId.push(row.cells[2].innerHTML);
			})
			var txt = "";
			var alertText = "Are you sure you want to delete?\n\nSelected Details:\nDate + Room\n";
			var update = "";
	        
			if(sessionId.length == 0){
				alert("Please select sessions to delete.");
			} else{
				for(i=0; i<sessionId.length; i++){
					if (confirm(alertText + date[i] + room[i])) {
						session[i] = sessionId[i];
						// document.getElementById("tSessionAvailable").deleteRow(rowIndex[i]);
						document.getElementById("dltSessId").value = "" + session[i];
						document.getElementById("dltSubmitBt").style.display = "block";
						txt = "Please click RefreshPage to see your changes!";
					} else {
						sessionId = [];
					}
				}
			}
			document.getElementById("result").innerHTML = txt;
		};
	</script>
</head>
<body>
	<div class="head"></div>
	<div class="loading" id="loading"  style="display:none;"></div>
	<div class="wrapper">

		<!-- Tab: Book Session; Admin Session -->
		<h1>Admin One To One Session</h1>
		<div class="tab">
			<ul>
			  <li><a href="OneToOneSessions.jsp">Book Sessions</a></li>
			  <li><a class="active" href="OneToOneSessionsAdmin.jsp">Admin Sessions</a></li>
			</ul>
		</div>

		<div id="AdminSessionsContent" class="tabcontent">
			<div class="filter" id="filter" style="width:30%; float:left; margin-left: 10%; height:300px">
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
			<form method="GET" style="width:30%; float:right; margin-right: 10%; height:300px" class="filter_selected" id="filter_selected">
				<p class="header_name" style="width:95%; padding-top:10%">Your Selection:</p>
				<p>Date: <%=request.getParameter("startDate")%> - <%=request.getParameter("endDate")%></p>
				<p>Type: <%=request.getParameter("typeDropbtn")%></p>
				<p>Room: <%=request.getParameter("roomDropbtn")%></p>
				<p>Advisor: <%=request.getParameter("advisorDropbtn")%></p>
				<p><br></p>
			</form>
			<div class="layout">
				<p class="header_name" id="sessions_available_header" style="float:left; width:100%">Sessions Available</p>
				<table class="display" id="tAdminSessionAvailable">
					<thead>
						<tr class="header" align="left">
							<th style="width:2%;"></th>
							<th style="width:2%;">No. </th>
							<th style="display:none" >SessionId</th>
							<th style="width:9%;">Date</th>
							<th style="width:7%;">Start Time</th>
							<th style="width:7%;">End Time</th>
							<th style="width:10%;">Room</th>
							<th style="width:12%;">Advisor</th>
							<th style="width:20%;">Type</th>
							<th style="width:10%;">Booked by</th>
							<th style="width:5%;">A/NA</th>
							<th style="width:5%;">Waiting</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${showAll}">
							<c:forEach var="item" items="${queryAllSessions.rows }" varStatus="count">
								<tr class="filter_result">
									<td><input type="checkbox" name="chk"/></td>
									<td>${count.index+1}</td>
									<td style="display:none" >${item.sessionId}</td>
									<td><fmt:formatDate type="date" value="${item.date}"/>
									<td><fmt:formatDate pattern="HH:mm" value="${item.startTime}"/>
									<td><fmt:formatDate pattern="HH:mm" value="${item.endTime}"/>
									<td>${item.campus}.${item.level}.${item.roomNumber}</td>
									<td>${item.advisorName}</td>
									<td>${item.type}</td>
									<c:choose>
											<c:when test="${item.booked =='1'}">
												<td><form action="StudentBookingDetails.jsp" method="POST">
													<input type="hidden" name="get_sessionId" value = "${item.sessionId}">
													<input type="hidden" name="get_date" value = "${item.date}">
													<input type="hidden" name="get_startTime" value = "${item.startTime}">
													<input type="hidden" name="get_endTime" value = "${item.endTime}">
													<input type="hidden" name="get_room" value = "${item.campus}.${item.level}.${item.roomNumber}">
													<input type="hidden" name="get_type" value = "${item.type}">
													<input type="hidden" name="get_advisorId" value = "${item.advisorId}">
													<input type="hidden" name="get_advisorName" value = "${item.advisorName}">
													<input type="hidden" name="get_studentId" value = "${item.studentId}">
													<input type="hidden" name="get_studentFirstName" value = "${item.firstName}">
													<input type="hidden" name="get_studentLastName" value = "${item.lastName}">
													<input type="hidden" name="get_studentEmail" value = "${item.email}">
													<input type="hidden" name="get_subjectName" value = "${item.subjectName}">
													<input type="hidden" name="get_assignType" value = "${item.assignType}">
													<input type="hidden" name="get_isAssignment" value = "${item.isAssignment}">
													<input type="hidden" name="get_helpType" value = "${item.rule}">
													<input type="hidden" name="get_isSendToStudent" value = "${item.isSendToStudent}">
													<input type="hidden" name="get_isSendToLecture" value = "${item.isSendToLecture}">
													<input type="submit" value="${item.studentId}" id="bookedName"/>
													</form></td>
											</c:when>
											<c:otherwise>
												<td><form action="BookSpecificSession.jsp" method="POST">
													<input type="hidden" name="get_sessionId" value = "${item.sessionId}">
													<input type="hidden" name="get_date" value = "${item.date}">
													<input type="hidden" name="get_startTime" value = "${item.startTime}">
													<input type="hidden" name="get_endTime" value = "${item.endTime}">
													<input type="hidden" name="get_room" value = "${item.campus}.${item.level}.${item.roomNumber}">
													<input type="hidden" name="get_type" value = "${item.type}">
													<input type="hidden" name="get_advisorId" value = "${item.advisorId}">
													<input type="hidden" name="get_advisorName" value = "${item.advisorName}">
													<input type="submit" value="Student Name" id="bookedName"/>
												</form></td>
											</c:otherwise>
										</c:choose>
									<td><a href="AddToWaitingList.jsp">A/Na</a></td>
									<td><a href="AddToWaitingList.jsp">Add</a></td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${filtered}">
							<c:forEach var="item" items="${queryFilterSessions.rows }" varStatus="count">
								<tr class="filter_result">
									<td><input type="checkbox" name="chk"/></td>
									<td>${count.index+1}</td>
									<td style="display:none" >${item.sessionId}</td>
									<td><fmt:formatDate type="date" value="${item.date}"/>
									<td><fmt:formatDate pattern="HH:mm" value="${item.startTime}"/>
									<td><fmt:formatDate pattern="HH:mm" value="${item.endTime}"/>
									<td>${item.campus}.${item.level}.${item.roomNumber}</td>
									<td>${item.advisorName}</td>
									<td>${item.type}</td>
									<c:choose>
											<c:when test="${item.booked =='1'}">
												<td><form action="StudentBookingDetails.jsp" method="POST">
													<input type="hidden" name="get_sessionId" value = "${item.sessionId}">
													<input type="hidden" name="get_date" value = "${item.date}">
													<input type="hidden" name="get_startTime" value = "${item.startTime}">
													<input type="hidden" name="get_endTime" value = "${item.endTime}">
													<input type="hidden" name="get_room" value = "${item.campus}.${item.level}.${item.roomNumber}">
													<input type="hidden" name="get_type" value = "${item.type}">
													<input type="hidden" name="get_advisorId" value = "${item.advisorId}">
													<input type="hidden" name="get_advisorName" value = "${item.advisorName}">
													<input type="hidden" name="get_studentId" value = "${item.studentId}">
													<input type="hidden" name="get_studentFirstName" value = "${item.firstName}">
													<input type="hidden" name="get_studentLastName" value = "${item.lastName}">
													<input type="hidden" name="get_studentEmail" value = "${item.email}">
													<input type="hidden" name="get_subjectName" value = "${item.subjectName}">
													<input type="hidden" name="get_assignType" value = "${item.assignType}">
													<input type="hidden" name="get_isAssignment" value = "${item.isAssignment}">
													<input type="hidden" name="get_helpType" value = "${item.rule}">
													<input type="hidden" name="get_isSendToStudent" value = "${item.isSendToStudent}">
													<input type="hidden" name="get_isSendToLecture" value = "${item.isSendToLecture}">
													<input type="submit" value="${item.studentId}" id="bookedName"/>
													</form></td>
											</c:when>
											<c:otherwise>
												<td><form action="BookSpecificSession.jsp" method="POST">
													<input type="hidden" name="get_sessionId" value = "${item.sessionId}">
													<input type="hidden" name="get_date" value = "${item.date}">
													<input type="hidden" name="get_startTime" value = "${item.startTime}">
													<input type="hidden" name="get_endTime" value = "${item.endTime}">
													<input type="hidden" name="get_room" value = "${item.campus}.${item.level}.${item.roomNumber}">
													<input type="hidden" name="get_type" value = "${item.type}">
													<input type="hidden" name="get_advisorId" value = "${item.advisorId}">
													<input type="hidden" name="get_advisorName" value = "${item.advisorName}">
													<input type="submit" value="Student Name" id="bookedName"/>
												</form></td>
											</c:otherwise>
										</c:choose>
									<td><a href="AddToWaitingList.jsp">A/Na</a></td>
									<td><a href="AddToWaitingList.jsp">Add</a></td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<div align="center" style="margin-bottom: 1%">
					<button onclick="markAttendance()" id="markAttendance">Mark Attendance</button>
					<button onclick="delAvlbSess()" id="deleteAvlbSess">Delete Session(s)</button>
					<form action="DeleteSessions.jsp" method="POST">
						<input id="dltSessId" type="hidden" value="" name="get_dltSessId"/>
						<input id="dltSubmitBt" type="submit" value="RefreshPage" style="display: none"/>
					</form>
					<p id="result"></p>
				</div>
			</div>
			<div class="layout">
				<div class="addOneToOneSessions" style="width:100%; float:left">
					<form action="Add1To1Confirmation.jsp" method="POST">
						<p class="header_name" id="sessions_available_header" style="float:left; width:100%">Add a New Session</p>
						<p style="margin-left: 1%; margin-right:1%">To add sessions, please enter their details below and click "Add". If you do not wish to add a session that you selected date & time, please click "Clear" next to that session before adding.</p>
						<p style="margin-left: 1%; margin-right:1%">Please note: all the fields are compulsory, otherwise that session will not be added.</p>
						<table class="table table-hover" id="tAddSessions" style="padding-bottom:10px; margin-left: 1%; margin-right:1%; width:98%">
							<tr class="header" align="left" style="width:90%">
								<th style="width:10%;">Date</th>
								<th style="width:10%;">Start Time</th>
								<th style="width:10%;">End Time</th>
								<th style="width:15%;">Room</th>
								<th style="width:15%;">Advisor Name</th>
								<th style="width:15%;">Type</th>
								<th style="width:5%;"></th>
							</tr>
							
							<tr class="add_session_content">
								<td><input type="date" name="datePicker" style="width:100%" value="" /></td>
								<td><input type="time" name="startTimePicker" style="width:100%" value="" /></td>
								<td><input type="time" name="endTimePicker" style="width:100%" value="" /></td>
								<td>
									<select name="roomDropbtn" style="width:100%">
										<option value=""></option>
										<c:forEach var="item" items="${listRooms.rows}" >
											<option value="${item.roomId}"><c:out value="${item.campus}.${item.level}.${item.roomNumber}" /></option>
										</c:forEach>
									</select>
									
								</td>
								<td>
									<select name="ANADropbtn" style="width:100%">
										<option value=""></option>
										<c:forEach var="item" items="${listAdvisors.rows}" >
											<option value="${item.advisorId}"><c:out value="${item.firstName} ${item.lastName}"/></option>
										</c:forEach>
										
									</select>
								</td>
								<td>
									<select name="typeDropbtn" style="width:100%">
										<option value=""></option>
										<option value="UG/PG course work students">UG/PG course work students</option>
										<option value="UP/PG Others">UP/PG Others</option>
									</select>
								</td>
								<td><input type="reset" name="btnClearAddSessions" value="Clear" id="btnClearAddSessions"/></td>					
							</tr>
							
						</table>
						<div align="center">
							<input type="submit" name="btnAddSessions" value="Add" id="btnAddSessions" ></button>
							<p>To use the template, please select one week.</p>
						</div>
					</form>
				</div>
			</div>
			<div align="left" id="legendDesc" style="width:100%; float:left; margin-top:5%">
				<p style="font-weight:bold">Legend</p>
				<p>A: Attended</p>
				<p>NA: Not Attended</p>
			</div>
		</div>
	</div>
	
	<div class="footer" style="width:100%; float:left;"></div>

</body>
</html>