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
		<input type="submit" name="btnSubmitFilter" value="Submit" id="btnSubmitFilter" style="float:left; margin-left: 30%"/>
		<input type="reset" value="Reset" style="float:right; margin-right: 30%">
	</div>
	<p><br></p>

</form>
