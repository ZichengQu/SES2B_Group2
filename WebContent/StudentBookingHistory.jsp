<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
String studentId = request.getParameter("get_studentId");
String studentFirstName = request.getParameter("get_studentFirstName");
String studentLastName = request.getParameter("get_studentLastName");
String studentEmail = request.getParameter("get_studentEmail");

request.setAttribute("studentId", studentId);
request.setAttribute("studentFirstName", studentFirstName);
request.setAttribute("studentLastName", studentLastName);
request.setAttribute("studentEmail", studentEmail);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HELPS Booking System</title>
	<link rel="stylesheet" href="css/BookSpecificSession.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
	
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<script type="text/javascript">
	$(function(){
		
		$("[id^='del_']").click(function(){
			var workshop_id = this.id.split("_")[1];
			if(confirm("confirm cancel?")){
				$.ajax({
					url:"MyBookingsServlet_delete",
					type:"post",
					data:"workshop_id="+workshop_id,
					dataType:"text",
					success:function(data){
						alert("Cancel Successfully!")
						window.location.reload(true);
					}
				});
			}
		});
		
		{
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
			
			var sessions1 = "${sessions }";
			var sessions2 = "${upcoming }";
			var sessions3 = "${past }";
			if(sessions1==""){
				$("#session1").show();
				$("#session2").hide();
			}else{
				$("#session1").hide();
				$("#session2").show();
			}
			if(sessions2==""){
				$("#session3").show();
				$("#session4").hide();
			}else{
				$("#session3").hide();
				$("#session4").show();
			}
			if(sessions3==""){
				$("#session5").show();
				$("#session6").hide();
			}else{
				$("#session5").hide();
				$("#session6").show();
			}
		}
		
	});
	function Back(){
		document.getElementById('loading').style.display = "block";
		window.location.href="OneToOneSessions.jsp";
	}
	$(document).ready(function() {
	    $('#tSessionAvailable1').DataTable();
	    $('#tSessionAvailable2').DataTable();
	    $('#tSessionAvailable3').DataTable();
	} );
	</script>
</head>
<body>
	<div class="head"></div>
	<div class="loading" id="loading"  style="display:none;"></div>
	<div class="wrapper">
		<form action="MyInformationServlet" method="post" id="profile">
			<h2><strong>Student History: </strong>${sessionScope.student.firstName} ${sessionScope.student.lastName} (Email: ${sessionScope.student.email})</h2>
		</form>
		<div class="instructions_box">
			<div class="box card s0">
				<h2 style="margin:auto">Sessions</h2>
				<div id="session1" style="display: none">
					<p>There are no sessions to display.</p>
				</div>
				<div id="session2">
					<!-- <h4>Past</h4> -->
					<table class="display" id="tSessionAvailable1">
						<thead>
							<tr align="left">
								<th>Date</th>
								<!-- <th>Days</th> -->
								<th>Time</th>
								<th>Room</th>
								<th>Advisor</th>
								<th>Type</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="thisSession" items="${sessions }">
							  	<tr align="left">
								  	<td><fmt:formatDate type="date" value="${thisSession.date }" /></td>
								  	<%-- <td>${thisSession.endTime } - ${thisSession.startTime }</td> --%>
								  	<td><fmt:formatDate pattern="HH:mm" value="${thisSession.startTime }" /></td>
								  	<td>${thisSession.room.campus}.${thisSession.room.level}.${thisSession.room.roomNumber}</td>
								  	<td>${thisSession.advisorName }</td>
								  	<td>${thisSession.type }</td>
							 	</tr>
						  </c:forEach>	
						</tbody>		
					</table>
				</div>
			</div>
		</div>
		<div class="instructions_box">
			<div class="box card s0">
				<h2 style="margin:auto">Workshop sessions</h2>
				<div id="session3" style="display: none">
					<h4>Upcoming</h4>
					<p>There are no workshop sessions to display.</p>
				</div>
				<div id="session4">
					<h4>Upcoming</h4>
					<table class="display" id="tSessionAvailable2">
						<thead>
							<tr align="left">
								<th style="width:30%;">Topic</th>
								<th style="width:15%;">Start date</th>
								<th style="width:15%;">End date</th>
								<th style="width:5%;">Days</th>
								<th style="width:5%;">Time</th>
								<th style="width:15%;">Room</th>
								<th style="width:5%;">No. Of Session</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="workShop" items="${upcoming }">
							  	<tr align="left">
								  	<td>${workShop.name }</td>
								  	<td><fmt:formatDate pattern="dd-MM-yyyy" value="${workShop.startDate }" /></td>
								  	<td><fmt:formatDate pattern="dd-MM-yyyy" value="${workShop.endDate }" /></td>
								  	<td>${workShop.days }</td>
								  	<td>${workShop.placeAvailable }</td>
								  	<td>${workShop.room.campus}.${workShop.room.level}.${workShop.room.roomNumber}</td>
								  	<td>${workShop.noOfSessions }</td>
							 	</tr>
						 	</c:forEach>
						</tbody>
					</table>
				</div>
				<hr>
				<div id="session5" style="display: none">
					<h4>Past</h4>
					<p>There are no workshop sessions to display.</p>
				</div>
				<div id="session6">
					<h4>Past</h4>
					<table class="display" id="tSessionAvailable3">
						<thead>
							<tr align="left">
								<th style="width:30%;">Topic</th>
								<th style="width:15%;">Start date</th>
								<th style="width:15%;">End date</th>
								<th style="width:5%;">Days</th>
								<th style="width:5%;">Time</th>
								<th style="width:15%;">Room</th>
								<th style="width:5%;">No. Of Session</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="workShop" items="${past }">
							  	<tr align="left">
								  	<td>${workShop.name }</td>
								  	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${workShop.startDate }" /></td>
								  	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${workShop.endDate }" /></td>
								  	<td>${workShop.days }</td>
								  	<td>${workShop.placeAvailable }</td>
								  	<td>${workShop.room.campus}.${workShop.room.level}.${workShop.room.roomNumber}</td>
								  	<td>${workShop.noOfSessions }</td>
							 	</tr>
						  	</c:forEach>	
						</tbody>	
					</table>
				</div>
			</div>
		</div>
			
		<input id="Back" class="Back" onclick="Back()" type="button" value="Back to One To One Session Pages"><br>
	</div>
	
	<div class="footer" style="margin-top: 3em"></div>

</body>
</html>