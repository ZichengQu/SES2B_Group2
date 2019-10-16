<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.bean.ConfirmationEmail"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Change Email Template</title>
	<link rel="stylesheet" href="css/emailTemplate.css" />
	<link rel="stylesheet" href="css/adminMenu.css">
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	
	
		$(function(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
			
			$("#select_email").change(function(){
				/* alert(this.value); */
				var emailId = this.value;
				var emailTitle = $('option:eq('+emailId+')').get(0).innerHTML;
				var emailHeader = emailTitle.slice(3);
				/* alert(emailHeader); */ 
		        var emailSubject = emailTitle.slice(3,-13);
		        $("h3").html(emailHeader);
		        $("#current_subject,#new_subject").val(emailSubject);
				/* if(confirm("confirm cancel?")){ */
					$.ajax({
						url: "EmailServlet", 
						type: "post",
						data: "emailId="+emailId,
						dataType: "text", 
						//async: false,
						success: function(data){
							/* alert(data); */
							<%-- <%
							ConfirmationEmail email = (ConfirmationEmail)session.getAttribute("emailq");
							System.out.println(email);
							if(email!=null){%>
							var id = <%=email.getConfirmationId()%>;
							alert("qqq");
							<%
							}
							%>
							alert("www");
							alert(id); --%>	
							
							var splitArray = new Array();
							var string = data;
							splitArray=string.split(/[$]/);
							
							/* for(i=0; i < splitArray.length; i++){
							 document.write(splitArray[i] + "<br>");
							}  */
							
							/* alert(splitArray[0]);
							alert(splitArray[1]);
							alert(splitArray[2]); */ 
							$("#current_body, #new_body").val(splitArray[0]);
							$("table tr:eq(3) th:eq(1)").html("last published on "+splitArray[1]); 
							$("table tr:eq(3) th:eq(2)").html("last updated on "+splitArray[2]);  
						}	
					}); 
			});
			
			$("#update_email").click(function(){
				var id =$("#select_email").val(); 
				var emailTemplate = $("#new_body").val();
				$("#current_body").val(emailTemplate);
				alert("Update Successfully");
				$.ajax({
					url: "EmailServlet_update",
					type: "post",
					data: "emailId="+id,
					dataType: "text",
					success: function(data){
						/* alert(data); */
						$("table tr:eq(3) th:eq(2)").html("last updated on "+data); 
					}
				});
			});

			
			$("#publish_email").click(function(){
				var emailTemplate = $("#new_body").val();
				var id =$("#select_email").val();
				$(this).data('clicked', true);
				$("#current_body").val(emailTemplate);
				alert("Publish Successfully"); 
				$.ajax({
					url: "EmailServlet_publish", 
					type: "post",
					data: {
			            emailId: id,
			            emailTemplate: emailTemplate
			         },
					dataType: "text", 
					success: function(data){
						//alert(data);  
						var publishTime=$("table tr:eq(3) th:eq(1)").html("last published on "+data);
					}
					
				});
				
			});
			
			$("#send_email").click(function(){
				var emailTemplate = $("#new_body").val();
				var emailSubject=$("select").find("option:selected").val();
				$.ajax({
					url: "EmailServlet_sendEmail", 
					type: "post",
					data: {
						emailSubject: emailSubject,
						emailTemplate: emailTemplate
			         },
					dataType: "text", 
					success: function(data){
						/* alert(data); */
						alert("Test Email Has Been Sent Successfully");
					}
				}); 
				
			})
			
			
		});
		
	</script>
	<style type="text/css">
	.hide{
		display: none;
	}
	</style>
</head>
<body>
	<div class="head"></div>
	<div class="wrapper">
			<!-- <nav>
				<a href="/list/">List</a> |
				<a href="/send email/">Send Email</a> 
			</nav> -->
		<h2>Change Email Template</h2>
		<div class="selectArea">
			<div class="emailType">Select an email:&nbsp;</div>
			<select name= "emailTempSelection" id="select_email" value="">
				<option value="0">-select-</option>
				<option value="1">1 - Confirmation of booking (to student)</option>
				<option value="2">2 - Confirmation of booking (to lecturer)</option>
				<option value="3">3 - Confirmation of cancellation (to student)</option>
				<option value="4">4 - Confirmation of cancellation (to lecturer)</option>
				<option value="5">5 - Student on waiting list is booked for a session automatically (to student)</option>
				<option value="6">6 - Student on waiting list is booked for a session automatically (to lecturer)</option>
				<option value="7">7 - Student registers for waiting list (to student)</option>
				<option value="8">8 - Confirmation of workshop booking (to student)</option>
				<option value="9">9 - Confirmation of waiting list (to student)</option>
			</select>
		</div>
		
			<div id="changeTemplate" class="hide">
				<h3></h3>
				<table>
					<tr>
						<th></th>
						<th style="font-weight:bold;">Current content</th>
						<th style="font-weight:bold;">New content</th>
					</tr>
					<tr>
						<th>Subject</th>
						<th>
							<textarea id="current_subject" class="publishArea" id="" rows="" cols="20" readonly="readonly" name="subject"></textarea>
						</th>
						<th>
							<textarea id="new_subject" rows="" cols="20" readonly="readonly" name="subject"></textarea>
						</th>
					</tr>
					<tr>
						<th>Body</th>
						<th>
							<textarea class="publishArea" id="current_body" rows="" cols="" style="height: 100px;" readonly="readonly" name="template"></textarea>
						</th>
						
						<th>
							<textarea id="new_body" rows="" cols="" style="height: 100px;" name="template"></textarea>
						</th>
					</tr>
					<tr>
						<th></th>
						<th>Never publishes</th>
						<th>Never updates</th>
					</tr>
					<tr>
						<th></th>
						<th></th>
						<th>
							<button id="update_email">Update</button>
							<button id="send_email">Send Test Email</button>
							<button id="publish_email" onclick="publish">Publish</button>
						</th>
					</tr>
				</table>
			</div>
			<div class="instruction">
				<div>Instructions:</div>
				<div class="bullet">
					<div>• Update button: changes content of the email for preview/testing purposes. Will not affect
					the current live email(s).</p>
					• Send Test Email button: sends the user an email with the updated content (with random
					values from the database) for testing purposes. The email is sent to the UTS account of the
					administrator who is currently logged into the system.</p>
					• Publish button: publishes the updated content to the live system and replaces the live
					email(s) with the new version.</p>
					</div>
				</div>
				<div>Available data fields: to use these fields, enter [% fieldname %] within the email content where you
				want it to appear</p></div>
				<div>Common data fields</div>
				<div class="bullet">
					• [% student_givenname %]: inserts student's given name</p>
					• [% student_surname %]: inserts student's surname</p>
					• [% datetime %]: inserts appointment's date and time</p>
					• [% date %]: inserts appointment's date</p>
					• [% start_time %]: inserts appointment's start time</p>
					• [% end_time %]: inserts appointment's end time</p>
					• [% campus %]: inserts campus/ room location</p>
				</div>
				<div>For 1:1 session</div>
				<div class="bullet">
					• [% lecturer_givenname %]: inserts lecturer's given name</p>
					• [% lecturer_surname %]: inserts lecturer's surname</p>
					• [% lecturer_email %]: inserts lecturer's email address</p>
				</div>
				<div>For workshop</div>
				<div class="bullet">
					• [% skillset %]: inserts workshop skill-set</p>
					• [% topic %]: inserts workshop topic</p>
					• [% description %]: inserts workshop description</p>
					• [% targetingGroup %]: inserts workshop's targeting group</p>
					• [% recurring_sessions %]: inserts workshop's recurring-session list (date - location).</p>
				</div>
			</div>
	</div>
	<div class="footer"></div>
	<script type="text/javascript">
		$(document).ready(function(){
			$('select').change(function(){
				var value=$("select").find("option:selected").val();
				
				if(value!="0"){
					$(changeTemplate).removeClass('hide');
				}else{
					$(changeTemplate).addClass('hide');
				}
			})
			
		})
	</script>

	
	<script type="text/javascript">
		$(document).ready(function(){
			$('select').change(function(){
			
				var template1 = "Dear [% student_givenname %], \n\n " +
				"Your appointment detail: \n " +
				"- When:		 [% date %] \n " +
				"- Start time:[% start_time %] \n" +
				"- End time:	 [% end_time %] \n" +
				"- Where:	 [% campus %] \n\n" +
				"<u> Upload your document </u> \n" +
				"To make this session helpful, is is essential that you " +
				"upload* any material that is relevant to the assignment " +
				"(your draft, assignment question, marking criteria). " +
				"You must do this by 12 midnight the day before your " +
				"appointment. \n" +
				"* To upload, logon onto <a href='http://helps- "+
				"booking.uts.edu.au'> HELPS booking system</a> and click " +
				"on 'My Bookings' tab. \n\n" +
				"kind regards, \n HELPS";
				var template2 = "[% student_givenname %] [% student_surname %] has " +
				"booked a one-to-one appointment with you. \n" +
				"Appointment time: [% datetime %]";
				var template3 = "Dear [% student_givenname %], \n\n" +
				"This message is to confirm that you have cancelled " +
				"an indvidual consultation appointment on " +
				"[% datetime %] at [% campus %]. \n\n" +
				"King regards, \n" +
				"HELPS";
				var template4 = "[% student_givenname %] [% student_surname %] has " +
				"cancelled a one-to-one appointment with you on " +
				"[% datetime %]. \n";
				var template5 = "Dear [% student_givenname %] [% student_surname %] you have " +
				"been automatically booked for a session at [% datetime %]\n\n" +
				"Kind regards, \nHELPS";
				var template6 = "[% student_givenname %] [% student_surname %] has \
					been automatically booked for a session with you at \
					[% datetime %].";
				var template7 = "Dear [% student_givenname %], \n\n" +
				"you have registered for the [% topic %] workshop " +
				"at [% datetime %].\n\n" +
				"Kind regards, \n HELPS";
				var template8 = "Dear [% student_givenname %],\n\n" +
				"Your appointment details: \n \n" +
				"- When:      [% date %] \n" +
				"- Start time:[% start_time %] \n" +
				"- End time:  [% end_time %] \n" +
				"- Where:     [% campus %] \n\n" +
				"Kind regards, \n HELPS";
				var template9 = "Dear [% student_givenname %], \n\n" +
				"you have been added to the waiting list " +
				"of the [% topic %] workshop. \n\n" +
				"Kind regards, \n HELPS";
				
				var value=$("select").find("option:selected").val();
				
				if(value == "1"){
					$('#current_body').val(template1); 
					$('#new_body').val(template1);
				}else if (value == "2"){
					$('#current_body').val(template2);
					$('#new_body').val(template2);
				}else if (value == "3"){
					$('#current_body').val(template3);
					$('#new_body').val(template3);
				}else if (value == "4"){
					$('#current_body').val(template4);
					$('#new_body').val(template4);
				}else if (value == "5"){
					$('#current_body').val(template5);
					$('#new_body').val(template5);
				}else if (value == "6"){
					$('#current_body').val(template6);
					$('#new_body').val(template6);
				}else if (value == "7"){
					$('#current_body').val(template7);
					$('#new_body').val(template7);
				}else if (value == "8"){
					$('#current_body').val(template8);
					$('#new_body').val(template8);
				}else if (value == "9"){
					$('#current_body').val(template9);
					$('#new_body').val(template9);
				}
				else {
					$('#current_body').val('');
					$('#new_body').val('');	
				}			
					
				  
			})
		})
	</script>
</body>
</html>