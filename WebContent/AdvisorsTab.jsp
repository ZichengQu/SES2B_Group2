<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "com.bean.Advisor" %>
<%@page import="java.sql.*" %>
<%@ page import = "java.util.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>HELPS Booking System</title>
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
	
	<style>  
	
	.wrapper h2{
		margin-top: auto;
	}
	
	.wrapper .instructions_box, .wrapper .data_box {
		display: flex;
	}
	.wrapper .box {
		float: left;
	}
	.wrapper .box.card.s1 {
		width:100%;
		margin-bottom: 1%;
	}
	.wrapper .box.card.s2 {
		width:100%;
		margin-top: 1%;
	}
	.wrapper .box.card.s0 {
		width:100%;
		margin-bottom: 2%;
	}
	.wrapper .box.card {
		margin-right: 3%;
		border-radius: 15px;
		box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
		padding: 2%;
	}
	.wrapper .box.card:hover {
		box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
	}
	
	.wrapper input[type=submit] {
		align-items: flex-start;
	    text-align: center;
	    cursor: default;
	    margin-top: 2%;
	    margin-right:2%;
	    width: 15%;
	    font-size: 10pt; 
	    padding: 1%;
	    color: buttontext;
		border: 1px solid #ccc;
	    background-color: #ffffff;
	    box-sizing: border-box;
	}
	.wrapper input[type=submit]:hover {
		background-color: #33adff;
	}
	
	.wrapper input[type=text], .wrapper input[type=number] {
	    font-size: 13pt; 
	    width: 80%;
	}
	</style>  
</head>

<script type="text/javascript">
	$(function(){
		$('.head').load('admin_head.html');
		$('.footer').load('admin_footer.html');
	});
	$(document).ready(function() {
		$('#availableAD').DataTable();
		$('#inactiveAD').DataTable();
		$('#addAD').DataTable({
			"paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false
	    } );
	} );
</script> 
<!----------------------------------------------------------------------------------- START OF BODY ----------------------------------------------------------------------------------->
																						   <!-- <hr> -->
<!----------------------------------------------------------------------------------- START OF BODY ----------------------------------------------------------------------------------->

<body>
	<div class="head"></div>
	<!-- Create the table of Available Advisors -->
	<div class="wrapper" style="padding-left:40px; padding-right:40px">
	
		<!----------------------------------------------------------------- Delete, Update, Inactive Advisors Sections ----------------------------------------------------------------->
																		 						<!-- <hr> -->
		<!----------------------------------------------------------------- Delete, Update, Inactive Advisors Sections ----------------------------------------------------------------->		
		<div class="instructions_box">
			<div class="box card s0" style="margin-top: 2%">
				<h2>Available Advisors</h2>
				<form action="advisorServlet" method="post">
					<table class="display" id = "availableAD" style="border-bottom: 1px solid black">
						<thead>
							<tr align="left">  
								<th> <input type="checkbox" onClick="toggle(this)"/> <b>Staff Number</b></th> 
								<th><b>First Name</b></th> 
								<th><b>Last Name</b></th> 
								<th><b>Email</b></th>
							</tr>
						</thead>
						<tbody>
							<%
							  String id = request.getParameter("id");
							  String driver = "com.mysql.jdbc.Driver"; 
							  String connectionURL = "jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/"; 
							  String dtbName = "uts_help"; 
							  String dtbId =  "admin"; 
							  String dtbPass = "thisadmin";
							  
							  try{ 
								  Class.forName(driver); 
								}catch(ClassNotFoundException e) 
							  		{
							  			e.printStackTrace(); 
							 		}
							  
							  Connection connection = null; 
							  Statement statement = null; 
							  ResultSet resultSet =  null; 
							  %> 
							  <tr align="left"> 
							  <% 
							  try{ 
								connection = DriverManager.getConnection(connectionURL+dtbName, dtbId, dtbPass); 
							  	statement = connection.createStatement(); 
							  	String  dtb = "SELECT * FROM advisor"; 
							  	resultSet = statement.executeQuery(dtb); 
							  while  (resultSet.next()) {
								  if (resultSet.getString("isActive").equalsIgnoreCase("Active")){
							 %>
							
								<td><input type = "checkbox" name = "chk" value = <%=resultSet.getString("advisorId")%> /> 
	  	  							<input type="text" contenteditable = "true" name = "staffno_<%=resultSet.getString("advisorId")%>" value = <%=resultSet.getString("staffNumber")%> readonly/></td> 
								<td><input type="text" contenteditable = "true" name = "fname_<%=resultSet.getString("advisorId")%>" value = <%=resultSet.getString("firstName")%> /></td> 
								<td><input type="text" contenteditable = "true" name = "lname_<%=resultSet.getString("advisorId")%>" value = <%=resultSet.getString("lastName")%> /></td>
								<td><input type="text" contenteditable = "true" name = "staffemail_<%=resultSet.getString("advisorId")%>" value = <%=resultSet.getString("email") %> /></td>
							  </tr> 
							
							
							<%
								  }
							} 
							  connection.close();
							  }catch
							  (Exception e) { e.printStackTrace(); }
							  
							%>
						</tbody>
					</table>
					
					
					
					<!-- Note displayed in Advisors Tab -->
					<br>
					<b>Please note:</b>
					<ul>
						<li>If you delete an advisor, all sessions run by that advisor will also be deleted.</li>
						<li>Inactive advisors will not be able to log in, and their names will be removed from the drop down list.</li>
					</ul>
					<div class= 'buttonholder'> 
						<input type = "submit" name = "action" value = "Delete"/> 
						<input type = "submit" name = "action" value = "Update"/> 
						<input type = "submit" name = "action" value = "Inactive"/>
					</div>
				</form>
			</div>
		</div>
			
		
		<script>
		<!-- To select check all checkboxes -->
		function toggle(source) {
		  checkboxes = document.getElementsByName('chk');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
			    checkboxes[i].checked = source.checked;
			  }
		}
		</script>
		
		<!-------------------------------------------------------------------------- Add Advisors Sections -------------------------------------------------------------------------->
																		 				<!-- <hr> -->
		<!-------------------------------------------------------------------------- Add Advisors Sections -------------------------------------------------------------------------->		
		
		<!-- Note  -->
		<div class="instructions_box">
			<div class="box card s0" style="margin-top: 2%">
					<!-- Add Advisors Table -->
				<h2>Add Advisors</h2>
				<form action="advisorServlet" method="post">
					<table class="display" id = "addAD">  
						<thead>
							<tr align="left">
								<th><b>Staff Number*</b></th> 
								<th><b>First Name*</b></th> 
								<th><b>Last Name*</b></th> 
								<th><b>Email*</b></th>
							</tr>
						</thead>
						<tbody>
							<tr id = "add1" align="left">
								<td> 1  <input type = "number" name = "staffnumberadd1"></td> 
								<td><input type = "text" name = "firstnameadd1"></td>
								<td><input type = "text" name = "lastnameadd1"></td> 
								<td><input type = "text" name = "emailadd1"></td> 
							</tr>
					
							<tr id = "add2" align="left">
								<td> 2  <input type = "number" name = "staffnumberadd2"></td> 
								<td><input type = "text" name = "firstnameadd2"></td> 
								<td><input type = "text" name = "lastnameadd2"></td> 
								<td><input type = "text" name = "emailadd2"></td> 
							</tr>
							
							<tr id = "add3" align="left">
								<td> 3  <input type = "number" name = "staffnumberadd3"></td> 
								<td><input type = "text" name = "firstnameadd3"></td> 
								<td><input type = "text" name = "lastnameadd3"></td> 
								<td><input type = "text" name = "emailadd3"></td> 
							
							</tr>
						</tbody>
					</table>
					
					<!-- Create button and functions to add advisors  -->
					<div class= 'buttonholder'> 
						<input type="submit" name = "action" value="Add" /> 
					</div>
				</form>
				<br>
				To enter more advisors, please enter their details below and click "Add". <br>
				<b>Please note:</b> all the fields are compulsory, otherwise that advisors will not be added.<br>
				<%
					List list = (List) request.getAttribute("ErrorList");
					
					if(list != null)
					{
						for(Iterator iterator = list.iterator(); iterator.hasNext();)
						{
							String error = (String) iterator.next();
					%>
					
					<font color = "red">
					
					<li>
					<%=error %>
					</li>
					
					</font>
					
				<%
						}
					}
				%>
				
			</div>
		</div>
				
		
				
		
		
		<!----------------------------------------------------------------------- Inactive Advisors Sections ----------------------------------------------------------------------->
																		 				  <!-- <hr> -->
		<!----------------------------------------------------------------------- Inactive Advisors Sections ----------------------------------------------------------------------->		
		<div class="instructions_box">
			<div class="box card s0" style="margin-top: 2%">
				<!-- Inactive Advisor -->
				<h2>Inactive advisors</h2>
				<form action="advisorServlet" method="post">
					<table class="display" id = "inactiveAD">
						<thead>
							<tr align="left">
								<th> <input type="checkbox" onClick="toggle(this)"/> <b>Staff Number</b></th> 
								<th><b>First Name</b></th> 
								<th><b>Last Name</b></th> 
								<th><b>Email</b></th>
							</tr>
						</thead>
						<tbody>
							<% 
							try{ 
								  Class.forName(driver); 
								}catch(ClassNotFoundException e) 
							  		{
							  			e.printStackTrace(); 
							 		}
							  %> 
							  
							  <% 
							  try{ 
								connection = DriverManager.getConnection(connectionURL+dtbName, dtbId, dtbPass); 
							  	statement = connection.createStatement(); 
							  	String  dtb = "SELECT * FROM advisor"; 
							  	resultSet = statement.executeQuery(dtb); 
							  while  (resultSet.next()) {
								  if (resultSet.getString("isActive").equalsIgnoreCase("inactive")){
							 %>
							
							  <tr align="left">
								  <td><input type = "checkbox" name = "chk" value = <%=resultSet.getString("advisorId")%> /> 
								  	  <%=resultSet.getString("staffNumber")%></td> 
								  <td><%=resultSet.getString("firstName")%></td> 
								  <td><%=resultSet.getString("lastName")%></td>
								  <td><%=resultSet.getString("email") %></td>
							  </tr> 
							
							
							<%
								  }
							} 
							  connection.close();
							  }catch
							  (Exception e) { e.printStackTrace(); }
							  
							%>
						</tbody>
					</table>
		
				
				
				<!-- Buttons to Activate Advisors -->
					<div class= 'buttonholder'> 
						<input type = "submit" name = "action" value = "Active"/> 
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div class="footer" style="margin-top:3em"></div>
</body>
<!----------------------------------------------------------------------------------- END OF BODY ----------------------------------------------------------------------------------->
																						 <hr>
<!----------------------------------------------------------------------------------- END OF BODY ----------------------------------------------------------------------------------->
</html>

