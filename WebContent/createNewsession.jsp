<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.bean.Room"%>

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
	    padding-left: 10px;
	    padding-right: 10px;
	   /*  border: 2px #95e0fd solid; */
	}
	</style>
	
	<script type="text/javascript">
	 	
		
		var skillSetId='${param.skillSetId}';
		$(function(){
			$("#btnAddSessions").click(function(){
				var ss="";
				
				$(".add_session_content").each(function(index,item){
					
					var topic = $(item).find(".topic").val();
					
					var startDatePicker = $(item).find(".startDatePicker").val();
					var endDatePicker = $(item).find(".endDatePicker").val();
					var startTimePicker = $(item).find(".startTimePicker").val();
					var endTimePicker = $(item).find(".endTimePicker").val();
					
					var roomDropbtn = $(item).find("[name=roomDropbtn]").val();
					var Max = $(item).find("[name=Max]").val();
					var CO = $(item).find("[name=CO]").val();
					
					console.log(topic+" "+startDatePicker+" "+endDatePicker+" "+startTimePicker+" "+endTimePicker+" "
							+roomDropbtn+" "+Max+" "+CO+" "+skillSetId);
					
					var startDate=startDatePicker+" "+startTimePicker;
					var endDate = endDatePicker+" "+endTimePicker;
					
					ss=topic+","+startDate+","+endDate+","+Max+","+CO+","+roomDropbtn+","+skillSetId;
					
					
				});
				
				 $.ajax({
					url:"workshop",
					data:{"ss":ss,"action":'addworkshop'},
					type:"post",
					async: false,
					success:function(result){
						if(result=='success'){
							alert('Added successfully');
							window.location.href="workshop?action=showWorkShop&skillSetId="+skillSetId;
						}
					},
					error: function() {
			            alert('Error occured');
			        }
				}); 
				
			});
			
			
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
	<script type="text/javascript">
		$(document).ready(function(){
			$('select').change(function(){
				var value=$("select").find("option:selected").val();
				
				if(value!=" "){
					$(changeTemplate).removeClass('hide');
				}else{
					$(changeTemplate).addClass('hide');
				}
			});
			$('#sessionDetails').DataTable();
		    $('#createNewSession').DataTable( {
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
		<br><br>
		<div class="instructions_box">
			<div class="box card s0">
				<p class="header_name" id="filter_sessions_header">Session details</p>
				<table class="display" id="sessionDetails">
					<thead>
						<tr style="font-size:10pt" align="left">
						    <th style="width:5%; background:none">
						    	<input id="all" type="checkbox">
						    </th>
							<th style="width:20%;">Topic</th>
							<th style="width:10%;">Start Date</th>
							<th style="width:10%;">End Date</th>
							<th style="width:10%;">Start Time</th>
							<th style="width:10%;">End Time</th>
							<th style="width:10%;">Room</th>
							<th style="width:2%;">Max</th>
							<th style="width:2%;">C/O</th>
							<th style="width:2%;">No.of students</th>
							<th style="width:5%; background:none"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${workShops}" var="item">
							<tr style="font-size:12pt">
								<td><input name="ck" type="checkbox" value="${item.workShopId }"></td>
								<td>${item.name }</td>
								<td><fmt:formatDate value="${item.startDate}" type="date" /></td>
								<td><fmt:formatDate value="${item.endDate}" type="date" /></td>
								<td><fmt:formatDate value="${item.startDate}" pattern="HH:mm" /></td>
								<td><fmt:formatDate value="${item.endDate}" pattern="HH:mm" /></td>
								<td>${item.room.campus}.${item.room.level}.${item.room.roomNumber }</td>
								<td>${item.maximumPlace }</td>
								<td>${item.placeAvailable }</td>
								<td>${fn:length(students)}</td>
								<td><a href="workshop?action=detail&workShopId=${item.workShopId}">Detail</a>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div align="center">
					<input type="submit"  value="Delete" id="delete"/>
				</div>
			</div>
		</div>
		<div class="instructions_box">
			<div class="box card s0">
				<p class="header_name" id="filter_sessions_header">Create New Session(s)</p>
				<p>To add sessions, please enter their details below and click "Add". If you do not wish to add a session that you selected date & time, please click "Clear" next to that session before adding.</p>
				<p><b>Please note:</b> all the fields are compulsory, otherwise that session will not be added.</p>
				<table class="display" id="createNewSession">
					<thead>
						<tr style="font-size:10pt;" align="left">
							<th style="width:20%;">Topic</th>
							<th style="width:10%;">Start Date</th>
							<th style="width:10%;">End Date</th>
							<th style="width:10%;">Start Time</th>
							<th style="width:10%;">End Time</th>
							<th style="width:10%;">Room</th>
							<th style="width:2%;">Max</th>
							<th style="width:2%;">C/O</th>
							<th style="width:5%;"></th>
						</tr>
					</thead>
					<tbody>
						<tr class="add_session_content" style="font-size:14pt;">
							<td><input type="text" class="topic" name="topic" style="width:100%" value="" /></td>
							<td><input type="date" id="startData" class="startDatePicker" name="startDatePicker" style="width:100%" value="" /></td>
							<td><input type="date" id="endData" class="endDatePicker" name="endDatePicker" style="width:100%" value="" /></td>
							<td><input type="time" class="startTimePicker" name="startTimePicker" style="width:100%" value="" /></td>
							<td><input type="time" class="endTimePicker" name="endTimePicker" style="width:100%" value="" /></td>
							<td>
								<select name="roomDropbtn" style="width:100%">
									<option value=""></option>
								     <c:forEach var="item" items="${listRooms.rows}" >
								      	<option value="${item.roomId}"><c:out value="${item.campus}.${item.level}.${item.roomNumber }" /></option>
								     </c:forEach>
							    </select>
							</td>
							<td><input type="text" name="Max" style="width:100%" value="35" /></td>
							<td><input type="text" name="CO" style="width:100%" value="24" /></td>
							<td><input type="submit" name="btnClearAddSessions" value="Clear" id="btnClearAddSessions"/></td>					
						</tr>
					</tbody>
				</table>
				<div align="center">
					<input type="submit" name="btnAddSessions" value="Add" id="btnAddSessions"/>
					<p>To use the template, please select one week.</p>
				</div>
			</div>
		</div>
	</div>
	<div class="footer"></div>
	<!-- Switch to different tab content -->
	<script>
	function openSession(evt, sessionName) {
		// Declare all variables
		var i, tabcontent, tablinks;
		// Get all elements with class="tabcontent" and hide them
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		// Get all elements with class="tablinks" and remove the class "active"
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className.replace(" active", "");
		}
		
		// Show the current tab, and add an "active" class to the button that opened the tab
		document.getElementById(sessionName).style.display = "block";
		evt.currentTarget.className += " active";
	}
	
	// Get the element with id="defaultOpen" and click on it
	document.getElementById("defaultOpen").click();
	</script>
	
   
</body>
</html>

<!-- Date Range Picker -->









