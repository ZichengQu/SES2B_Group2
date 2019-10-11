<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page 
import="java.sql.*" 
import="java.text.*"
import="java.util.*"
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>HELPS Booking System</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
		});
	</script>
</head>
<body>
	<div class="head"></div>

	<% 
	int dlt = Integer.parseInt(request.getParameter("get_dltSessId"));
	String host = "jdbc:mysql://utshelpdb.cvdpbjinsegf.us-east-2.rds.amazonaws.com:3306/uts_help?useSSL=false";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(host, "admin", "thisadmin");
    String d = "01/10/2019";
    Statement st = con.createStatement();
    
    int i = st.executeUpdate("DELETE FROM session WHERE sessionId=" + dlt);
    if (i != 0) {
        response.sendRedirect("OneToOneSessions.jsp");
    } else {
        out.print("Data not deleted successfully");
        
    }
	%>
	<br>
	<a href="OneToOneSessions.jsp">Back to One To One Session Page</a>
	<div class="footer" style="width:100%; float:left"></div>
</body>
</html>