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
	<link rel="stylesheet" href="css/emailTemplate.css" />
    <link rel="stylesheet" href="css/adminMenu.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	
    <script type="text/javascript">
		$(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
		});
		
	</script>
	<!-- Include jQuery, Monment.js and Date Range Picker's file -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

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
	
	.left{
		width:50%;
		float: left;
	}
	.right{
		width:50%;
		float: left;
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
	<p class="header_name" id="filter_sessions_header">Work Shop Detail</p>
	<div>
		<form action="workshop" method="post">
			<table style="padding-bottom:10px;width: 70%; border: 1px solid #c1c1c15c; margin-bottom:20px;" >
				<tr>
					<td>Topic</td>
					<td>
					<input type="hidden" name="action" value="update"  >
					<input type="hidden" style="width:60%" name="workShopId"  id="workshopid" value="${workShop.workShopId}">
					<%--<input type="text" style="width:60%" name="name"  value=" --%>${workShop.name}
					</td>
				</tr>
				<tr>
					<td>Target Group</td>
					<td><%--<input type="text" name="targetGroup" value=" --%>${workShop.targetGroup}</td>
				</tr>
				<tr>
					<td>Description</td>
					<td><textarea rows="6" cols="80" name="description">${workShop.description }</textarea></td>
				</tr>
				<tr>
					<td>Cut-off</td>
					<td><input type="text" name="placeAvailable" value="${workShop.placeAvailable}"></td>
				</tr>
				<tr>
					<td>MaxiNum</td>
					<td><input type="text" name="maximumPlace" value="${workShop.maximumPlace}"></td>
				</tr>
				<tr>
					<td>When</td>
					<td>${workShop.startDate}</td>
				</tr>
				<tr>
					<td>Room</td>
					<td>
						<select name="roomDropbtn" style="width:100%" class="sel" >
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
				<tr>
					<td colspan="2">
					<input type="submit"  value="update"  id="update" onclick="change()"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	
	
	
	<div class="left">
	<p class="header_name" id="filter_sessions_header">Student List</p>
		<table>
			<tbody>
				<tr>
					<th>select</th>
					<th>StudentId</th>
					<th>Attendance</th>
				</tr>
				<c:forEach items="${studentList}" var="stu">
					<tr>
						<th><input type="checkbox" name="checkcheck" class="select" ${stu.isPresent=='yes'?'checked':''} onclick="chk()" value="${stu.studentListId}"></th>
						<th style="width: 1%;">${stu.student.studentId }</th>
						<th>${stu.isPresent=='yes'?'yes':'---'}</th>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	<div class="right">
	<p class="header_name" id="filter_sessions_header">Waiting List</p>
		<c:if test="${fn:length(waiting)<=0}">
		<P>There is no student in the waiting list</P>
		</c:if>
		<table>
		<c:forEach items="${waiting}" var="ww">
			<tr>
				<td>${ww.student.studentId }</td>
			</tr>
		</c:forEach>
		</table>
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








