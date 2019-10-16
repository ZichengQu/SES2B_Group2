<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
		
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	
	<link rel="stylesheet" href="css/room_tab.css" />
	<!-- table viewer -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
	
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script>
		$(document).ready(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
		});
	</script>
		
	<title>HELPS Booking System</title>
</head>
<body>
	<div class="head"></div>
	<div class="wrapper">
		<div class="split left">
			<h1 style="padding-bottom:5%">Available Room</h1>
<!-- 			<div class="container"> -->
<!-- 				<p></p> -->
<!-- 				<div align="right" style="padding-right: 45px" > -->
<!-- 					<button onclick="sortFunction()">Sort</button> -->
<!-- 				</div> -->
<!-- 			 </div> -->
			<div class="tab">
				<button class="tablinks" onclick="openTab(event, 'AllCampus', 0)" id="defaultOpen">All Campus</button>
				<button class="tablinks" onclick="openTab(event, 'CityLibrary', 1)">City Library</button>
				<button class="tablinks" onclick="openTab(event, 'Building1', 2)">Building 1</button>
				<button onclick="sortFunction()">Sort</button>
			</div>
			
		
			<%
			String id = request.getParameter("userID");
			String driName = "com.mysql.jdbc.Driver";
			String connectionURL = "jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/";
			String dtbName = "uts_help";
			String dtbId = "admin";
			String dtbPass = "thisadmin";
			
			try {
				Class.forName(driName);	
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			Statement statement = null;
			Connection connection = null;
			ResultSet rSet = null;
			%>
		
			<form action = "roomServlet" method = "post">
				<%
				try{
					connection = DriverManager.getConnection(connectionURL + dtbName, dtbId, dtbPass);
					statement = connection.createStatement();
					String dtb = "SELECT * FROM room";
					rSet = statement.executeQuery (dtb); 
				%>
			
				<div id="AllCampus" class="tabcontent">
					 <table id = "table" class = "table">
							<tr>
								<th colspan="2">Room</th>
							</tr> 
						<%
						 while(rSet.next())
							{
						%>
							<tr>
								<td><input type = "checkbox" name = "roomId" value = "<%=rSet.getString("roomId")%>"></td>
								<td align = "center"><%=rSet.getString("campus")%>.<%=rSet.getString("level")%>.<%=rSet.getString("roomNumber")%></td>
							</tr>
						<%
							}
							
						}catch(Exception e)
						{
							e.printStackTrace();
						}
						%>
					</table>
					<input class="buttonArea" type = "submit" name="action" value = "Delete" style = "float: right">
				</div>
			</form>
			<p></p>
		
			<form action = "roomServlet" method = "post">
				<%
				try{
					connection = DriverManager.getConnection(connectionURL + dtbName, dtbId, dtbPass);
					statement = connection.createStatement();
					String dtb = "SELECT * FROM room";
					rSet = statement.executeQuery (dtb); 
				%>
				
				<div id="CityLibrary" class="tabcontent">
					<table id = "table" class = "table">
						<tr>
							<th colspan="2">Room</th>
						</tr>
						<%
						while(rSet.next()) { if(rSet.getString("campus").equalsIgnoreCase("Lib")){
						%>
						<tr>
							<td><input type = "checkbox" name = "roomId" value = "<%=rSet.getString("roomId")%>"></td>
							<td align = "center"><%=rSet.getString("campus")%>.<%=rSet.getString("level")%>.<%=rSet.getString("roomNumber")%></td>
						</tr>
						 <%
						 }
							}
							 connection.close();	
							}catch(Exception e)
							{
								e.printStackTrace();
							}
						%> 
					</table> 
					<input class="buttonArea" type = "submit" name="action" value = "Delete" style = "float: right">
				</div>
			</form>
		
			<form action = "roomServlet" method = "post">
				<%
				try{
					connection = DriverManager.getConnection(connectionURL + dtbName, dtbId, dtbPass);
					statement = connection.createStatement();
					String dtb = "SELECT * FROM room";
					rSet = statement.executeQuery (dtb); 
				%>
				
				<div id="Building1" class="tabcontent">
					<table id = "table" class="table">
						<tr>
							<th colspan="2">Room</th>
						</tr>
						<%
						 while(rSet.next()){	if(rSet.getString("campus").equalsIgnoreCase("CB01")){
						%>
						<tr>
					 		<td><input type = "checkbox" name = "roomId" value = "<%=rSet.getString("roomId")%>"></td>
							<td align = "center"><%=rSet.getString("campus")%>.<%=rSet.getString("level")%>.<%=rSet.getString("roomNumber")%></td>
						</tr>
					 	<%
							}
							}
							connection.close();
							
						}catch(Exception e)
						{
							e.printStackTrace();
						}
						%>
					</table>
					<input class="buttonArea" type = "submit" name="action" value = "Delete" style = "float: right">
				</div>	
			
			</form>
			
		</div>
		
		<div class="split right">
			<div class="addRoom" align="center">
				<h1 style="padding-bottom:5%">Add Room</h1>
				
				
				
				<form action = "roomServlet" method = "post">
					<p style="margin: 10% 0 0;">Campus</p>
					<select name = "selectedCampus">
						<option value = "default">Choose your Campus</option>
						<option value = "Lib">Lib</option>
						<option value = "CB01">CB01</option>
					</select>
				
					<p style="margin: 10% 0 0;">Level</p>
					<select name = "selectedLevel">
						<option value = "default">Choose your level</option>
						<option value = "01">01</option>
						<option value = "02">02</option>
						<option value = "03">03</option>
						<option value = "03">03</option>
					</select>
				
					<p style="margin: 10% 0 0;">Room</p>
					<select name = "selectedRoom">
						<option value = "default">Choose your room</option>
						<option value = "00">00</option>
						<option value = "01">01</option>
						<option value = "02">02</option>
						<option value = "03">03</option>
						<option value = "04">04</option>
					</select>	
				
					<p></p>
					<input class="buttonArea" type="submit" name = "action" value="Add" > 
				</form>
			</div>
		</div>
	</div>
	<div class="footer"></div>

<script>
var tableNumber;
function openTab(evt, campusName, number) {
	var i, tabContent, tabLinks;
	tableNumber = number;
	tabContent = document.getElementsByClassName("tabcontent");
	for (i = 0; i < tabContent.length; i++) {
		tabContent[i].style.display = "none";
	}
	tabLinks = document.getElementsByClassName("tablinks");
	for (i = 0; i < tabLinks.length; i++) {
		tabLinks[i].className = tabLinks[i].className.replace(" active", "");
	}
	document.getElementById(campusName).style.display = "block";
	evt.currentTarget.className += " active";
}

document.getElementById("defaultOpen").click();
</script>

<script>

function sortFunction()
{
	var table, rows, switching, i, x, y, shouldSwitch, direction, switchCount = 0;
	table = document.getElementsByClassName("table")[tableNumber];
	switching = true;
	direction = "asc";
	
	while(switching){
		switching = false;
		rows = table.rows;

		
		for(i= 1; i < (rows.length - 1); i++){
			shouldSwitch = false;
			
			x = rows[i].getElementsByTagName("td")[1];
			y = rows[i + 1].getElementsByTagName("td")[1];
			
			console.log(x);
			console.log(y);
			
			if(direction == "asc"){
				if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
								shouldSwitch= true;
								break;
			}
		} else if(direction == "desc"){
				 if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
								shouldSwitch = true;
								break;
						}
		}
	}
		
		if(shouldSwitch) {
			rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
				switching = true;
				switchCount ++;
		} else {
			if(switchCount == 0 && direction == "asc"){
				direction = "desc";
				switching = "true";
			}
		}
}
}

</script>
	 
	 
	 
	 <div >
		<%
	List list = (List) request.getAttribute("errorList");

	if(list != null)
	{
		for(Iterator it=list.iterator(); it.hasNext();)
		{
			String error = (String) it.next();
			%>

			<font color="red">
			<li> <%=error%> </li>
			
			</font>
<% 
			
		}
	}
	
%> 
	</div>
	

</body>
</html>
