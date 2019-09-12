<%@page 
import="java.sql.*" 
import="java.text.*"
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="com.bean.Admin"%>
<%@page import="com.bean.Session"%>
<%@page import="com.bean.Room"%>

<sql:setDataSource var="myDS" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://aagmqmvaq3h3zl.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false" user="root" password="rootroot"/>
     
<sql:query var="listRooms" dataSource="${myDS}"> SELECT * FROM room;</sql:query>
<sql:query var="listAdvisors" dataSource="${myDS}"> SELECT * FROM advisor;</sql:query>

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





<!-- <script type="text/javascript">
	$(function() {
		$('input[name="datePicker"]').daterangepicker({
			singleDatePicker: true,
			showDropdowns: true,
			minYear: 1901,
			
		});
	});
</script> -->
