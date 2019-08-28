<%@page 
import="java.sql.*" 
import="java.text.*"
%>

<p class="header_name" id="filter_sessions_header" style="width:90%; padding-top: 3%;" >Filter Sessions</p>
<form class="filter_sessions" action="Adm_Sessions_Home.jsp" method="POST">
	<p id="date_filter" class="input-group input-daterange">1. Date:&nbsp;&nbsp;
		<input type="text" name="dateRange" value="" />
	</p>
	<p id="type_filter">2. Type:&nbsp;&nbsp;
		<select name="typeDropbtn">
			<option value=""></option>
			<option value="UG/PG course work students">UG/PG course work students</option>
			<option value="UP/PG Others">UP/PG Others</option>
		</select>
	</p>
	<p id="room_filter">3. Room:&nbsp;&nbsp;
		<select name="roomDropbtn">
			<option value=""></option>
			<%
			try{
				String Query="SELECT * FROM room";
				String host = "jdbc:mysql://aagmqmvaq3h3zl.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection conn=DriverManager.getConnection(host, "root", "rootroot");
				Statement stm = conn.createStatement();
				ResultSet rs = stm.executeQuery(Query);
				while(rs.next()){
					%>
					<option value="<%=rs.getInt("roomId")%>"><%=rs.getString("roomId") %></option>
					<%
				}
			} catch(Exception ex){
				ex.printStackTrace();
			}
			%>
		</select>
	</p>
	<p id="advisor_filter">4. Advisor:&nbsp;&nbsp;
		<select name="advisorDropbtn">
			<option value=""></option>
			<%
			try{
				String Query="SELECT * FROM advisor";
				String host = "jdbc:mysql://aagmqmvaq3h3zl.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection conn=DriverManager.getConnection(host, "root", "rootroot");
				Statement stm = conn.createStatement();
				ResultSet rs = stm.executeQuery(Query);
				while(rs.next()){
					%>
					<option value="<%=rs.getInt("advisorId")%>"><%=rs.getString("firstName") %> <%=rs.getString("lastName") %></option>
					<%
				}
			} catch(Exception ex){
				ex.printStackTrace();
			}
			%>
		</select>
	</p>
	<div class="submitFilter" style="padding-bottom:1%">
		<input type="submit" name="btnSubmitFilter" value="Submit" id="btnSubmitFilter" style="float:left; margin-left: 30%"/>
		<input type="reset" value="Reset" style="float:right; margin-right: 30%">
	</div>
	<p><br></p>

</form>

<!-- Date Range Picker -->
<script type="text/javascript">
	$(function() {
		//DateRangePicker
		$('input[name="dateRange"]').daterangepicker();
	});
</script>