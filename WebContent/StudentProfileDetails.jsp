<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.bean.StudentProfile"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HELPS Booking System</title>
	<link rel="stylesheet" href="css/BookSpecificSession.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
		});
		function Back(){
			document.getElementById('loading').style.display = "block";
			window.location.href="OneToOneSessions.jsp";
		}
		
	</script>
</head>
<body>
	<div class="head"></div>
	<div class="loading" id="loading"  style="display:none;"></div>
	<div class="wrapper">
		<p class="header_name">Student Profile</p>
		<form action="MyInformationServlet" method="post" id="profile">
			<div class="instructions_box">
				<div class="box card" style="width:40%">
					<p>Student Name: <strong>${sessionScope.student.firstName} ${sessionScope.student.lastName}</strong></p>
					<p>Faculty: <strong>${sessionScope.student.faculty}</strong></p>
					<p>Course: <strong>${sessionScope.student.course}</strong></p>
					<p>Email: <strong>${sessionScope.student.email}</strong></p>
					<p>Mobile: ${sessionScope.student.mobile}</p>
					<p>DOB: ${sessionScope.student.dob}</p>
				</div>
				<div class="box card">
					<p>Preferred First Name: <input type="Text" name="preferred_name" value="${sessionScope.studentProfile.preferredFirstName}" maxlength="50"/></p>
					<p>Best contact no: <input type="Text" name="alternativecontact" value="${sessionScope.studentProfile.bestContactNum}" maxlength="15" /></p>
					
					<p>Gender:&nbsp;
					    &nbsp;<input type="Radio" name="rdoGender" value="M" <c:if test="${sessionScope.studentProfile.gender eq 'Male'}">checked</c:if> disabled>M (male)
					    &nbsp;&nbsp;<input type="Radio" name="rdoGender" value="F" <c:if test="${sessionScope.studentProfile.gender eq 'Female'}">checked</c:if> disabled>F (female)
					    &nbsp;&nbsp;<input type="Radio" name="rdoGender" value="X" <c:if test="${sessionScope.studentProfile.gender eq 'X'}">checked</c:if> disabled>X (indeterminate / unspecified / intersex)
					</p>
					<p>Degree*: 
						<input type="Radio" name="rdoDegree" value="UG" id="rdoDegree_UGdetails" <c:if test="${sessionScope.studentProfile.degree=='Undergraduate'}">checked</c:if> disabled>Undergraduate
						<input type="Radio" name="rdoDegree" value="PG" id="rdoDegree_PGdetails" <c:if test="${sessionScope.studentProfile.degree=='Postgraduate'}">checked</c:if> disabled>Postgraduate
					</p>
					
					<c:choose>
						<c:when test="${sessionScope.studentProfile.degree=='Undergraduate'}">
							<p>Year*: ${sessionScope.studentProfile.year}</p>
						</c:when>
						<c:otherwise>
							<p>Type*: 
								<input type="Radio" value="course work" <c:if test="${sessionScope.studentProfile.type=='course work'}">checked</c:if> disabled>Course work &nbsp;&nbsp;
								<input type="Radio" value="research" <c:if test="${sessionScope.studentProfile.type=='research'}">checked</c:if> disabled>Research &nbsp;&nbsp;
							</p>
						</c:otherwise>
					</c:choose>
					
					<p>Status*: 
						<input type="Radio" name="rdoStatus" value="Permanent" <c:if test="${sessionScope.studentProfile.status=='Permanent'}">checked</c:if> disabled>Permanent
						&nbsp;
						<input type="Radio" name="rdoStatus" value="International"  <c:if test="${sessionScope.studentProfile.status=='International'}">checked</c:if> disabled>International
					</p>
					<p>First Language*: ${sessionScope.studentProfile.firstLanguage}</p>
					<p>Country of Origin*: ${sessionScope.studentProfile.countryOfOrigin}</p>
				</div>
			</div>
		</form>
		<input id="Back" class="Back" onclick="Back()" type="button" value="Back to One To One Session Pages"><br>
	</div>
	
	
	<div class="footer" style="margin-top: 3em"></div>
</body>
</html>