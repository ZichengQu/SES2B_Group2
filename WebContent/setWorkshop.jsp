<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<sql:setDataSource var="myDS" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false" user="admin" password="thisadmin"/>
    
<sql:query var="skillSets" dataSource="${myDS}"> SELECT * FROM skillSet;</sql:query>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HELPS Booking System</title>
<link rel="stylesheet" href="css/setWorkshops.css" />
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>

<script type="text/javascript">
	$(function(){
		$('.head').load('admin_head.html');
		$('.footer').load('admin_footer.html');
	});
	$(document).ready(function() {
	    $('#tSkillSet').DataTable();
	} );
</script>
</head>
<div class="head"></div>
<body>
	

	<div class="wrapper">
		
		<div style="margin-top:2em"></div>
				
		<div class="instructions_box">
			<div class="box card s0">
				<form action="workshop" method="post">
					<div class="title">Add New Skill-Set:&nbsp;</div>
					<input type="hidden" name="action" value="insertSkillSet" required="required"> 
					<input id="skillsInput" name="name" type="text"> 
					<input class="buttonArea" type="submit" value="Add">
				</form>
			</div>
		</div>
		<div class="instructions_box">
			<div class="box card s0">
				<div class="title" style="margin-bottom: 1%">Available Skill-Set:&nbsp;</div>
				<table class="display" id="tSkillSet">
					<thead>
						<tr align="left">
							<th style="width: 5%;">No.</th>
							<th style="width: 5%;">
								<!-- <input type="checkbox"> -->select
							</th>
							<th style="width: 40%;">Skill-set</th>
							<th style="width: 40%;">Short Title</th>
							<th style="width: 10%;"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${skillSets.rows}" var="item" varStatus="status">
							<tr align="left">
								<td>
									<%-- <select class="skillSetId" data-index="${item.skillSetId }">
										<c:forEach var="s"  begin="1" end="${fn:length(skillSets)}" >
											<option   <c:if test="${status.index+1 == s }"> selected </c:if> >${s}</option>
										</c:forEach>
									</select> --%> ${status.index+1 }
								</td>
								<td><input type="radio" name="sel" class="sel"
									value="${item.skillSetId}"></td>
								<td>${item.name}</td>
								<td><input name="shortName"
									value="${item.shortName}"></td>
								<td><a
									href="workshop?action=showWorkShop&skillSetId=${item.skillSetId}">SetWorkshops</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<input class="buttonArea" type="submit"  value="Update"  id="update" />
				<input class="buttonArea" type="submit"  value="Archive"  id="archive" onclick="archive()"/>
			</div>
		</div>
	</div>
	<div class="footer"></div>
</body>
<script type="text/javascript">
	function  archive(){
		$.ajax({
			url:"workshop",
			data:{"action":'archive'},
			type:"post",
			async: false ,
		});
    }

 $(function(){
	
	$("#Update").click(function(){
		
		var skillSetId = $(".sel:checked").val();
		var shortName = $(".sel:checked").parent().next().next().children().val();
		
		$.ajax({
			url:"workshop",
			data:{"skillSetId":skillSetId,"shortName":shortName,"action":'updateSkillSet'},
			type:"post",
			async: false ,
			success:function(result){
				if(result=='success'){
					window.location.href="workshop?action=toSkillSet"
				}
			}
		});
		
		
	});
	
	
	/* $(".skillSetId").change(function(){
		
		var newv = $(this).val();
		var oldv=$(this).attr("data-index");
		
		$.ajax({
			url:"workshop",
			data:{"id1":newv,"id2":oldv,"action":'changeSkillSet'},
			type:"post",
			async: false ,
			success:function(result){
				if(result=='success'){
					window.location.href="workshop?action=toSkillSet"
				}
			}
		});
	}) */
	
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
			})
		})
	</script>
</html>
