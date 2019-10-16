<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.bean.Room"%>
<%@page import="com.bean.WorkShop"%>

<sql:setDataSource var="myDS" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false" user="admin" password="thisadmin"/>
     
<sql:query var="listRooms" dataSource="${myDS}"> SELECT * FROM room;</sql:query>
<sql:query var="listAdmins" dataSource="${myDS}"> SELECT * FROM admin;</sql:query>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HELPS Booking System</title>
	<link rel="stylesheet" href="css/createNewsession.css" />
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>	
	
    <script type="text/javascript">
		$(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
		});
		
	</script>
	
	<style type="text/css">
	.wrapper {
	    width: 90%;
	    margin: 0 auto;
	    height:1300px;
	    padding-left: 10px;
	    padding-right: 10px;
/* 	    border-left: 2px #95e0fd solid;
	    border-right: 2px #95e0fd solid; */
	}
	
	</style>
	
	
<script type="text/javascript">
	var skillSetId='${param.skillSetId}';
	$(function(){
		$("#all").click(function(){
			
			var ischeck = $(this).prop("checked");
			if(ischeck){
				$("[name=ck]").prop('checked',true);
			}else{
				$("[name=ck]").prop('checked',false);
			}
			
		})
		
		
		$("#delete").click(function(){
			var cks = '';
			$("[name=ck]:checked").each(function(index,item){
				cks += $(item).val()+",";
			});
			
			 $.ajax({
				url:"workshop",
				data:{"cks":cks,"action":'deleteworkshop'},
				type:"post",
				async: false ,
				success:function(result){
					if(result=='success'){
						window.location.href="workshop?action=showWorkShop&skillSetId="+skillSetId;
					}
				}
			});
			
		})
		
	})
	
	$(document).ready(function(){
		$('#studentListTable').DataTable({
			"paging":   false,
	    	"info":     false
	    } );
	    $('#waitingListTable').DataTable({
	    	"paging":   false,
	    	"info":     false
	    } );
		$('#workshopDetails').DataTable( {
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false
	    } );
	    
	});
</script>
</head>
<body>
   <div class="head"></div>
	<!-- UTS Logo -->
	<!-- <div id="global-utility-bar">
		<div id="uts-logo">
			<a href="http://www.uts.edu.au"><img src="https://web-common.uts.edu.au/images/utslogo.gif" alt="University of Technology, Sydney homepage" width="132" height="30" /></a>
		</div>
	</div> -->
	
	<div class="wrapper">
		<div class="instructions_box">
			<div class="box card s0" style="margin-top:2%">
				<p class="header_name" id="filter_sessions_header">Workshop Details</p>
				<br>
				<form action="workshop" method="post">
					<table class="display" id="workshopDetails">
						<thead></thead>
						<tbody align="left">
							<tr>
								<th style="width:15%">Topic</th>
								<td>
									<input type="hidden" name="action" value="update"  >
									<input type="hidden" style="width:60%" name="workShopId"  id="workshopid" value="${workShop.workShopId}">
									<%--<input type="text" style="width:60%" name="name"  value=" --%>${workShop.name}
								</td>
							</tr>
							<%-- <tr>
								<td>Target Group</td>
								<td><input type="text" name="targetGroup" value="${workShop.targetGroup}</td>
							</tr> --%>
							<tr>
								<th>Description</th>
								<td><textarea rows="6" cols="80" name="description">${workShop.description }</textarea></td>
							</tr>
							<tr>
								<th>Cut-off</th>
								<td><input type="text" name="placeAvailable" value="${workShop.placeAvailable}" id="placeAvailable"></td>
							</tr>
							<tr>
								<th>MaxiNum</th>
								<td><input type="text" name="maximumPlace" value="${workShop.maximumPlace}" id="maximumPlace"></td>
							</tr>
							<tr>
								<th>When</th>
								<td>${workShop.startDate}</td>
							</tr>
							<tr>
								<th>Room</th>
								<td>
									<select name="roomDropbtn" style="width:auto; font-size:14pt" >
										<option value=""></option>
										<%
											int temp = 1; 
											WorkShop workShop = (WorkShop)request.getSession().getAttribute("workShop");
											System.out.println(workShop);
											int index = workShop.getRoom().getRoomId();
										%>
									     <c:forEach var="item" items="${listRooms.rows}" >
									     		<%
									     			if(temp == index){
									     		%>
									     			<option value="${item.roomId}" selected="selected"><c:out value="${item.campus}.${item.level}.${item.roomNumber }" /></option>
									     		<% 		
									     			}
									     		%>
									     		
									     		<%
									     			if(temp != index){
									     		%>
									     			<option value="${item.roomId}"><c:out value="${item.campus}.${item.level}.${item.roomNumber }" /></option>
									     		<% 		
									     			}
									     		%>
											 	<%temp++; %>
									     </c:forEach>
								    </select> 
								    <input type="hidden" name=>
								</td>
							</tr>
						</tbody>
					</table>
					<input type="submit"  value="Update"  id="update" onclick="change()"/>
				</form>
			</div>
				
		</div>
		
		
		
		
		<div class="instructions_box">
			<div class="box card s0">
				<p class="header_name" id="filter_sessions_header">Student List</p>
				<br>
				<table class="display" id="studentListTable">
					<thead>
						<tr align="left">
							<th style="width: 5%;"></th>
							<th style="width: 10%;">Student ID</th>
							<th style="width: 20%;">Student Name</th>
							<th style="width: 5%;">Attendance</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${studentList}" var="stu">
							<tr align="left">
								<td><input type="checkbox" name="checkcheck" class="select" ${stu.isPresent=='yes'?'checked':''} value="${stu.studentListId}"/></td>
								<td>${stu.student.studentId }</td>
								<td>${stu.student.firstName } ${stu.student.lastName }</td>
								<td>${stu.isPresent=='yes'?'yes':'---'}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div>
					<input type="button"  value="Mark Attendance and Send Email to Student"  id="sendMail" onclick="chk()" style="margin-top:5%"/>
				</div>
			</div>
			<div class="box card s0">
				<p class="header_name" id="filter_sessions_header">Waiting List</p>
				<br>
				<c:if test="${fn:length(waiting)<=0}">
					<P>There is no student in the waiting list</P>
				</c:if>
				<table class="display" id="waitingListTable">
					<thead>
						<tr align="left">
							<th style="width: 40%;">Student ID</th>
							<th style="width: 60%;">Student Name</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${waiting}" var="ww">
							<tr align="left">
								<td>${ww.student.studentId }</td>
								<td>${ww.student.firstName } ${ww.student.lastName }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>	
	</div>
	
	<div class="footer"></div>
	
</body>
</html>

<!-- Date Range Picker -->

<script type="text/javascript">
	function chk1() {
	    if ($("input[name='select']").prop("checked")==true) {
	    	alert("111");
	        $("input[type='checkbox']").prop("checked",false);
	        $("input[type='checkbox']").prop("disabled",true);
	        $("#select").prop("checked",true);
	        $("#select").prop("disabled",false);
	    }else{
	        $("input[type='checkbox']").prop("disabled",false);
	    }
	}
	
	var workShopId='${param.workShopId}'
	var studentLists = document.getElementsByClassName("select");
	function chk() {
		for(var i=0; i<studentLists.length; i++){
			var checks = document.getElementsByName("checkcheck");
			for(var i=0;i<checks.length;i++){
				var tempCheckBox = checks[i];
				 if (tempCheckBox.checked) {
				    	var studentListId = studentLists[i].value;
						 $.ajax({
							url:"workshop",
							data:{"studentListId":studentListId, "isPresent":'yes', "action":'editAttendance'},
							type:"post",
							async: true,
							success:function(result){
								if(result=='success'){
									window.location.href="workshop?action=detail&workShopId="+workShopId;
								}
							}
						});
				    }else{
				    	var studentListId = document.getElementsByClassName("select")[i].value;
				    	
						 $.ajax({
							url:"workshop",
							data:{"studentListId":studentListId, "isPresent":'no', "action":'editAttendance'},
							type:"post",
							async: true,
							success:function(result){
								window.location.href="workshop?action=detail&workShopId="+workShopId;
							}
						});
				    }
			}
		   
	    }
	}
	</script>








