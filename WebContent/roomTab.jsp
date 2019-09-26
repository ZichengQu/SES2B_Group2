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


<style>

.split {
  height: 100%;
  width: 50%;
  position: fixed;
  z-index: 1;
  top: 20;
  overflow-x: hidden;
  padding-top: 20px;
  margin-left: 50px;
  
}

.left {
  left: 0;
}

.right {
  right: 0;
}

.centered {
  position: absolute;
  top: 50;
  left: 50;
  transform: translate(-50%, -50%);
  text-align: center;
}

.dropbtn {
  padding: 16px;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropbtn:hover, .dropbtn:focus {
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  overflow: auto;
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown a:hover {background-color: #ddd;}

.show {display: block;}

.button {
	position: relative;
	left: 200px;
	top: 200px:
	
}

#mainDiv
{
	position: fixed;
	top: 0;
	bottom: 0;
	right:0;
	left:0;
}


table{
	width: 100%;
	border-collapse: collapse;
	
} 

table tr:nth-child(even) {
	  background-color: #f2f2f2;;
	}
	
table tr:nth-child(odd) {
	 background: #fff;
	}
	
table {
		border: 1px solid black;
		}
		
th, td {
		padding: 10px;
		border: 1px solid #ddd;
	}
	
th {
		padding-top: 12px;
  		padding-bottom: 12px;
 		text-align: center;
	}
	

/* Style the tab */
.tab {
  float: left;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  width: 43%
}

/* Style the buttons inside the tab */
.tab button {
  
  
  background-color: inherit;
  padding: 18px 12px;
  width: 100%;
  border: none;
  outline: none;
  text-align: left;
  cursor: pointer;
  transition: 0.3s;
  font-size: 14px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current "tab button" class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  float: left;
  padding: 0px 10px;
  width: 50%;
  border-left: none;
  

</style>

	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script>
		$(document).ready(function(){
			$('.head').load('admin_head.html');
			/* $('.footer').load('admin_footer.html'); */
		});
</script>
	
<title>Insert title here</title>
</head>
<body style = "margin: 50px">

<div>
<div class="head"></div>


<div class="split left">
  <div class="container">
    <h2>Available Room</h2>
  	<p></p>
  	
  	<div align="right" style="padding-right: 45px" >
  		<button onclick="sortFunction()">Sort</button>
  		
  	</div>
  
 
  
   </div>
   
 
  <div class="tab">
  <button class="tablinks" onclick="openTab(event, 'AllCampus', 0)" id="defaultOpen">All Campus</button>
  <button class="tablinks" onclick="openTab(event, 'CityLibrary', 1)">City Library</button>
  <button class="tablinks" onclick="openTab(event, 'Building1', 2)">Building 1</button>
</div>

<%

String id = request.getParameter("userID");
String driName = "com.mysql.jdbc.Driver";
String connectionURL = "jdbc:mysql://aagmqmvaq3h3zl.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/";
String dtbName = "uts_help";
String dtbId = "root";
String dtbPass = "rootroot";

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
		rSet = statement.executeQuery (dtb); %>
	
	

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
  <input type = "submit" name="action" value = "Delete" style = "float: right">
</div>



</form>

<p></p>





<form action = "roomServlet" method = "post">
<%
	try{
		connection = DriverManager.getConnection(connectionURL + dtbName, dtbId, dtbPass);
		statement = connection.createStatement();
		String dtb = "SELECT * FROM room";
		rSet = statement.executeQuery (dtb); %>


<div id="CityLibrary" class="tabcontent">
   <table id = "table" class = "table">
  <tr>
  	<th colspan="2">Room</th>
  </tr>
     <%
   while(rSet.next())
		{ if(rSet.getString("campus").equalsIgnoreCase("Lib")){
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
  <input type = "submit" name="action" value = "Delete" style = "float: right">
</div>
</form>


<form action = "roomServlet" method = "post">
<%
	try{
		connection = DriverManager.getConnection(connectionURL + dtbName, dtbId, dtbPass);
		statement = connection.createStatement();
		String dtb = "SELECT * FROM room";
		rSet = statement.executeQuery (dtb); %>

<div id="Building1" class="tabcontent">
    <table id = "table" class="table">
  <tr>
  	<th colspan="2">Room</th>
  </tr>
    <%
   while(rSet.next())
		{	if(rSet.getString("campus").equalsIgnoreCase("CB01")){
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
  <input type = "submit" name="action" value = "Delete" style = "float: right">
</div>  

</form>



   </div>
  
  <div class="split right">
  	<div class="container" align="center">
    <h2>Add Room</h2>
    
    
    <p>Campus</p>
    
    <form action = "roomServlet" method = "post">
    
	<select name = "selectedCampus">
	<option value = "default">Choose your Campus</option>
	<option value = "Lib">Lib</option>
	<option value = "CB01">CB01</option>
	</select>
	
    <p>Level</p>
    <select name = "selectedLevel">
	<option value = "default">Choose your level</option>
	<option value = "01">01</option>
	<option value = "02">02</option>
	<option value = "03">03</option>
	<option value = "03">03</option>
	</select>
	
    <p>Room</p>
	<select name = "selectedRoom">
	<option value = "default">Choose your room</option>
	<option value = "00">00</option>
	<option value = "01">01</option>
	<option value = "02">02</option>
	<option value = "03">03</option>
	<option value = "04">04</option>
	</select>
	
	<p></p>
		<input type="submit" name = "action" value="Add" > 
	</form>
	
	
  </div>
</div>




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
 
   </div>
   
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
