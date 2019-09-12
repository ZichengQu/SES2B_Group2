<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.text.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.bean.Admin"%>
<%@page import="com.bean.Session"%>
<%@page import="com.bean.Room"%>

<sql:setDataSource var="myDS" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://aagmqmvaq3h3zl.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false" user="root" password="rootroot"/>

<%
String sessionId = request.getParameter("get_sessionId");
String dateStr = request.getParameter("get_date");
String startTimeStr = request.getParameter("get_startTime");
String endTimeStr = request.getParameter("get_endTime");
String room = request.getParameter("get_room");
String type = request.getParameter("get_type");
String advisorName = request.getParameter("get_advisorName");
String advisorId = request.getParameter("get_advisorId");
String studentId = request.getParameter("get_studentId");
String studentFirstName = request.getParameter("get_studentFirstName");
String studentLastName = request.getParameter("get_studentLastName");
String studentEmail = request.getParameter("get_studentEmail");
String subjectName = request.getParameter("get_subjectName");
String assignType = request.getParameter("get_assignType");
String helpType = request.getParameter("get_helpType");
String assignmentStr = request.getParameter("get_isAssignment");
String sendToStudentStr = request.getParameter("get_isSendToStudent");
String sendToLectureStr = request.getParameter("get_isSendToLecture");


SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

java.util.Date util_a = dateFormat.parse(dateStr);
java.util.Date util_b = timeFormat.parse(startTimeStr);
java.util.Date util_c = timeFormat.parse(endTimeStr);
java.sql.Date date = new java.sql.Date(util_a.getTime());
java.sql.Timestamp startTime = new java.sql.Timestamp(util_b.getTime());
java.sql.Timestamp endTime = new java.sql.Timestamp(util_c.getTime());

request.setAttribute("sessionId", sessionId);
request.setAttribute("date", date);
request.setAttribute("startTime", startTime);
request.setAttribute("endTime", endTime);
request.setAttribute("room", room);
request.setAttribute("type", type);
request.setAttribute("advisorName", advisorName);
request.setAttribute("adminId", advisorId);
request.setAttribute("studentId", studentId);
request.setAttribute("studentFirstName", studentFirstName);
request.setAttribute("studentLastName", studentLastName);
request.setAttribute("studentEmail", studentEmail);
request.setAttribute("subjectName", subjectName);
request.setAttribute("assignType", assignType);
request.setAttribute("assignmentStr", assignmentStr);
request.setAttribute("sendToStudentStr", sendToStudentStr);
request.setAttribute("sendToLectureStr", sendToLectureStr);
request.setAttribute("helpType", helpType);
%>


<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;" charset="UTF-8">
	<title>HELPS Booking System</title>
	<link rel="stylesheet" href="css/BookSpecificSession.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript">
	  	/* help others box */
		$(function(){
	  		$('[name="helpType"][value="Others"]').change(function(){
	  			if ($(this).is(':checked')) {
	  				document.getElementById('otherHelpTypeRichText').style.display = "block";
				}else{
					document.getElementById('otherHelpTypeRichText').style.display = "none";
				}
			});
		});
	  	/* check detailed rules */
	  	$(function(){
	  		$('[name="additionalBook"][value="checkRule"]').change(function(){
	  			if ($(this).is(':checked')) {
	  				document.getElementById('checkRuleDetails').style.display = "block";
				}else{
					document.getElementById('checkRuleDetails').style.display = "none";
				}
			});
	  		
	  		$("#OneToOneProfile").click(function(){
	  			var student_id = ${requestScope.studentId};
	  			$.ajax({
					url:"OneToOneProfileServlet",
					type:"post",
					data:"student_id="+student_id,
					dataType:"text",
					success:function(data){
						window.location.href="StudentProfileDetails.jsp";
					}
				});
	  		});
	  		
	  		$("#StudentBookingHistory").click(function(){
	  			var student_id = ${requestScope.studentId};
	  			$.ajax({
					url:"StudentBookingHistoryS",
					type:"post",
					data:"student_id="+student_id,
					dataType:"text",
					success:function(data){
						window.location.href="StudentBookingHistory.jsp";
					}
				});
	  		});
	  		$(document).ready(function() {
	   			var heightRight = $(".form_right").height() + $(".checkRuleDetails").height()
		        var height = Math.max($(".form_left").height(), heightRight);
		        $(".form_left").height(height);
		        $(".form_right").height(height);
		    });
	  		
		});
	</script>
	
	<script type="text/javascript">
		$(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
		});
	</script>
</head>
<body>
	<div class="head"></div>
	<div class="wrapper">
		<p class="header_name" id="student_booking_header" style="text-align:center; margin:2% 0">Student booking Details</p>
	
		<div class="form_left">
			<p><br></p>
			<p>Date: <strong><fmt:formatDate type="date" value="${date}" /></strong></p>
			<p>Time: <strong><fmt:formatDate pattern="HH:mm" value="${startTime}"/> - <fmt:formatDate pattern="HH:mm" value="${endTime}"/></strong></p>
			<p>Advisor: <strong><c:out value="${advisorName}"/></strong></p>
			<p>Campus: <strong><c:out value="${room}"/></strong></p>
			<p>Type: <strong><c:out value="${type}"/></strong></p>
			<p><br><br></p>
			<h3><strong>Currently booked by student: </strong></h3>
			<p>Name: <strong><c:out value="${studentFirstName} ${studentLastName}"/></strong></p>
			<p>Email: <c:out value="${studentEmail}"/></p>
			
			<!-- <a id="OneToOneProfile" >View this student's profile</a><br> --><!-- href="/SES2A/OneToOneProfileServlet" -->
			<input id="OneToOneProfile" type="button" value="View this student's profile"><br>
			<input id="StudentBookingHistory" type="button" value="View student's history"><br>
		</div>
		
		<div class="form_right">
			<p><br></p>
			<p>Subject Name* <input type="Text" style="font-size:12pt" value="${subjectName}" readonly/></p>
			<p>Assignment Type* <input type="Text" style="font-size:12pt" value="${assignType}" readonly style="width: 40%"/></p>
			<p>Is this a group assignment?
				<input type="Radio" name="rdoGroupAssignment" value="Yes" <c:if test="${assignmentStr=='true'}">checked</c:if> disabled>Yes
				<input type="Radio" name="rdoGroupAssignment" value="No" <c:if test="${assignmentStr=='false'}">checked</c:if> disabled>No
			</p>
			<p>I need help with ... </p>
			<input type="checkbox" name="helpType" value="Answer question" <c:if test="${helpType.contains('Answer question')}">checked</c:if> disabled>Answering the assignment question (please provide the question to your advisor)<br>
			<input type="checkbox" name="helpType" value="Marking criteria" <c:if test="${helpType.contains('Marking criteria')}">checked</c:if> disabled>Addressing the marking criteria (please provide the criteria to your advisor)<br>
			<input type="checkbox" name="helpType" value="Structure" <c:if test="${helpType.contains('Structure')}">checked</c:if> disabled>Structure<br>
			<input type="checkbox" name="helpType" value="Paragraph Development" <c:if test="${helpType.contains('Paragraph Development')}">checked</c:if> disabled>Paragraph development<br>
			<input type="checkbox" name="helpType" value="Referencing" <c:if test="${helpType.contains('Referencing')}">checked</c:if> disabled>Referencing<br>
			<input type="checkbox" name="helpType" value="Grammar" <c:if test="${helpType.contains('Grammar')}">checked</c:if> disabled>Grammar<br>
			<input type="checkbox" name="helpType" value="Others" <c:if test="${helpType.contains('Others')}">checked</c:if> disabled>Other, please specify below<br>
			<textarea rows="4" cols="70" id="otherHelpTypeRichText" ></textarea>
			<p><br><br></p>
			<p>Did student attend this session? (select on option and press button "Mark Attendance")</p>
				<input type="radio" name="rdoAttendance" value="Yes" id="rdoAttendance_Yes"/>Yes
				<input type="radio" name="rdoAttendance" value="No" id="rdoAttendance_No"/>No
			<div align="center" style="margin-top:3em">
				<input type="submit" name="btnCancelBooking" value="Cancel this booking" id="btnCancelBooking">
				<input type="submit" name="btnMarkAttendance" value="Mark Attendance" id="btnMarkAttendance"/><br>
				<input type="checkbox" name="additionalBook" value="sendToStudent"<c:if test="${sendToStudentStr=='true'}">checked</c:if> disabled>Send email to student<br>
				<input type="checkbox" name="additionalBook" value="sendToLecture"<c:if test="${sendToLectureStr=='true'}">checked</c:if> disabled>Send email to lecturer (by default, no email is sent to lecturer)<br>
				<input type="checkbox" name="additionalBook" value="checkRule">Check rule<br>
			</div>
			<div id="checkRuleDetails" style="display:none" class="checkRuleDetails">
				<p>Rule:</p>
				<p>- A session must be booked / cancelled / put into the waiting list at least 24 hour before appointment.</p>
				<p>- Student can only be put into the waiting list for the max 3 sessions for the week</p>
				<p>- Student cannot make appointments for 1 year after 2nd no-show</p>
				<p>- Student can book for up to 1 session per week</p>
				<p>- Student can book for up to 3 sessions in advance</p>
			</div>
		</div>
		
	<form method="GET">
		<div class="layout" style="width:100%; float:left; margin-bottom:3em; margin-top:3em">
			<p class="header_name" id="comment_header" style="margin-top:2em; ">Advisor's comment</p>
			<div style="width: 85%; float:left">
				<div style="width:100%">
					<p>Comment:</p>
					<textarea rows="4" cols="50" id="commentRichText" style="width:90%"></textarea>
				</div>
				<div style="width:100%; margin-bottom:2%">
					<input type="checkbox" name="commentType" value="Requirement">Understanding assignment requirements<br>
					<input type="checkbox" name="commentType" value="Purpose_focus_argument">Purpose / focus / argument<br>
					<input type="checkbox" name="commentType" value="Genre_register">Genre / register<br>
					<input type="checkbox" name="commentType" value="Cohesion">Cohesion<br>
					<input type="checkbox" name="commentType" value="Paragraph_structure">Paragraph structure<br>
					<input type="checkbox" name="commentType" value="Using_sources_approriately">Using sources approriately<br>
					<input type="checkbox" name="commentType" value="Sentence_grammar">Sentence grammar<br>
					<input type="checkbox" name="commentType" value="Speaking_presentation">Speaking presentation<br>
					<input type="checkbox" name="commentType" value="Other">Other<br>
				</div>
				
			</div>
			<div style="width: 10%; float:left;">
				<input type="submit" name="btnSaveComment" value="Save" id="btnSaveComment"><br>
			</div>
			
		</div>
	</form>
	<div class="layout" style="width:100%; float:left; margin-bottom:3em">
		<p class="header_name" id="upload_header" style="margin-top:1em; width:100%">Upload your documents</p>
		<button onclick="chooseFile()" style="display:inline; font-size:12pt">Choose File</button>
		<p style="display:inline">No file chosen</p><br>
		<input type="submit" name="btnUpload" value="Upload" id="btnUpload" style="font-size:12pt; margin-bottom:2%; margin-top:1%">
	</div>
</div>
<div class="footer" style="width:100%; float:left; margin-top:5%"></div>
</body>
</html>