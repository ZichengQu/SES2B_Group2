<%@ page import="com.dao.MessageDatabase"%>
<%@ page import="com.bean.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>MESSAGE EDIT TAB</title>
		<link rel="stylesheet" href="css/MessageEditTab.css" />
		<script src="https://cdn.ckeditor.com/4.11.3/standard/ckeditor.js"></script>
		<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	
		<script>

		$(window).load(function(){

			initiateView();
		});
			
		/* initiate the page */			
		function initiateView(){
			$('.head').load('admin_head.html');
			$('.footer').load('admin_footer.html');
			var choiceValue = localStorage.getItem("selectedOption");
			document.getElementById("messageTabSelectList").options[choiceValue].selected = "selected";
			var txtEditor = CKEDITOR.replace( 'textEditor');
			//this disable ACF of CKEDITOR
			CKEDITOR.config.allowedContent = true;
			
			var mess4 = "<%=MessageDatabase.getCurrentMessage(4).getMessageTempDetailed()%>";
			var mess5 = "<%=MessageDatabase.getCurrentMessage(5).getMessageTempDetailed()%>";
			var mess6 = "<%=MessageDatabase.getCurrentMessage(6).getMessageTempDetailed()%>";
			var mess8 = "<%=MessageDatabase.getCurrentMessage(8).getMessageTempDetailed()%>";
			var mess12 = "<%=MessageDatabase.getCurrentMessage(12).getMessageTempDetailed()%>";
			var loc4 = "<%=MessageDatabase.getCurrentMessage(4).getMessageLocation()%>";
			var loc5 = "<%=MessageDatabase.getCurrentMessage(5).getMessageLocation()%>";
			var loc6 = "<%=MessageDatabase.getCurrentMessage(6).getMessageLocation()%>";
			var loc8 = "<%=MessageDatabase.getCurrentMessage(8).getMessageLocation()%>";
			var loc12 = "<%=MessageDatabase.getCurrentMessage(12).getMessageLocation()%>";
			<%-- var mess1 = "<%=MessageDatabase.getCurrentMessage(1).getMessageTempDetailed()%>";
			var mess2 = "<%=MessageDatabase.getCurrentMessage(2).getMessageTempDetailed()%>";
			var mess3 = "<%=MessageDatabase.getCurrentMessage(3).getMessageTempDetailed()%>";
			var mess7 = "<%=MessageDatabase.getCurrentMessage(7).getMessageTempDetailed()%>";
			var mess9 = "<%=MessageDatabase.getCurrentMessage(9).getMessageTempDetailed()%>";
			var mess10 = "<%=MessageDatabase.getCurrentMessage(10).getMessageTempDetailed()%>";
			var mess11 = "<%=MessageDatabase.getCurrentMessage(11).getMessageTempDetailed()%>";
			var loc1 = "<%=MessageDatabase.getCurrentMessage(1).getMessageLocation()%>";
 			var loc2 = "<%=MessageDatabase.getCurrentMessage(2).getMessageLocation()%>";
			var loc3 = "<%=MessageDatabase.getCurrentMessage(3).getMessageLocation()%>";
			var loc7 = "<%=MessageDatabase.getCurrentMessage(7).getMessageLocation()%>";
			var loc9 = "<%=MessageDatabase.getCurrentMessage(9).getMessageLocation()%>";
			var loc10 = "<%=MessageDatabase.getCurrentMessage(10).getMessageLocation()%>";
			var loc11 = "<%=MessageDatabase.getCurrentMessage(11).getMessageLocation()%>"; --%>
			

			//TODO: if there is any way to directly use choiceValue for getCurrentMessage, it would be much less of hard-coding
			switch(choiceValue){
				case '4': txtEditor.setData(mess4); break;
				case '5': txtEditor.setData(mess5); break;
				case '6': txtEditor.setData(mess6); break;
				case '8': txtEditor.setData(mess8); break;
				case '12': txtEditor.setData(mess12); break;
				/* case '1': txtEditor.setData(mess1); break;
				case '2': txtEditor.setData(mess2); break;
				case '3': txtEditor.setData(mess3); break;
				case '7': txtEditor.setData(mess7); break;
				case '9': txtEditor.setData(mess9); break;
				case '10': txtEditor.setData(mess10); break;
				case '11': txtEditor.setData(mess11); break; */
				
				default: break;
			}
				
			/*text area change event*/
			txtEditor.on('change', function(){
				$("#cancelButton").show();
				$("#saveButton").show();
			}); 

			/*handle select list event*/
			$("#messageTabSelectList").change(function(){
				choiceValue = document.getElementById("messageTabSelectList").value;
				if(choiceValue != '0'){   
					$("#previewButton").hide();
					$("#publishButton").hide();
					$("#cancelButton").hide();
					$("#saveButton").hide();
					$("#updateMessage").hide();
					switch(choiceValue){
						case '4': txtEditor.setData(mess4); break;
						case '5': txtEditor.setData(mess5); break;
						case '6': txtEditor.setData(mess6); break;
						case '8': txtEditor.setData(mess8); break;
						case '12': txtEditor.setData(mess12); break;
						/* case '1': txtEditor.setData(mess1); break;
						case '2': txtEditor.setData(mess2); break;
						case '3': txtEditor.setData(mess3); break;
						case '7': txtEditor.setData(mess7); break;
						case '9': txtEditor.setData(mess9); break;
						case '10': txtEditor.setData(mess10); break;
						case '11': txtEditor.setData(mess11); break; */
						default: break;
					}	
				}
				else{
					window.location = "MessageTab.jsp";
				}
			});

			/*handle preview button click*/
			$("#previewButton").on('click', function(){
				//open preview window
				switch(choiceValue){
					case '4': window.open(loc4, "width=300,height=200"); break;
					case '5': window.open(loc5, "width=300,height=200"); break;
					case '6': window.open(loc6, "width=300,height=200"); break;
					case '8': window.open(loc8, "width=300,height=200"); break;
					case '12': window.open("Adm_Sessions_Home_Preview.jsp", "width=300,height=200"); break;
					/* case '1': window.open(loc1, "width=300,height=200"); break;
					case '2': window.open(loc2, "width=300,height=200"); break;
					case '3': window.open(loc3, "width=300,height=200"); break;
					case '7': window.open(loc7, "width=300,height=200"); break;
					case '9': window.open(loc9, "width=300,height=200"); break;
					case '10': window.open(loc10, "width=300,height=200"); break;
					case '11': window.open(loc11, "width=300,height=200"); break; */
					default: break;
				}	    
			});

			/*handle publish button click*/
			$("#publishButton").on('click', function(){
				//save changes made to the message into the database
				var m = "" + txtEditor.getSnapshot();
				
				$.ajax({
					url:"MessageServlet",
					type:"post",
					data:{message: m, index: document.getElementById("messageTabSelectList").value, type: "publish"},
					dataType:"text",
					success:function(data){
						$("#updateMessage").text("MESSAGE PUBLISHED").show();
					}
				});
			});
			
			/*handle cancel button click*/
			$("#cancelButton").on('click', function(){
				window.location = "MessageTab.jsp";
			});

			/*handle save button click*/
			$("#saveButton").on('click', function(){
				//save changes and enable preview and publish button
				var m = "" + txtEditor.getSnapshot();
				
				$.ajax({
					url:"MessageServlet",
					type:"post",
					data:{message: m, index: document.getElementById("messageTabSelectList").value, type: "save"},
					dataType:"text",
					success:function(data){
						$("#updateMessage").text("MESSAGE SAVED").show();
					}
				});
				
				$("#previewButton").show();
				$("#publishButton").show();
				$("#saveButton").hide();
				$("#cancelButton").hide();
			});
		}
		</script>
	</head>
	
	<body>
	
		<div class="head"></div>
		<div style="padding-left:40px">
			<h2>Edit Message</h2>
			<p id="updateMessage">Updated the message</p>
			
			<div id="div1">
				<select id="messageTabSelectList">
					<!--<option value="0"></option>
					<option value="1">FAQ in student interface</option>
					<option value="2">Instruction of file upload in student interface</option>
					<option value="3">Instruction of nav in student interface</option>
					<option value="4">Instruction of skill set in student interface</option>
					<option value="5">Instruction of student Profile in student interface</option>
					<option value="6">Instruction of student Profile in student interface - bottom</option>
					<option value="7">Instruction of workshops in attendance interface</option>
					<option value="8">Instruction of workshops in student interface</option>
					<option value="9">Logon page announcement in attendance interface</option>
					<option value="10">Logon page announcement in student interface</option>
					<option value="11">Logon page box on the right in student interface</option>
					<option value="12">Program in student interface</option>  -->
					<option value="0">
					<option value="4">Instruction of skill set in student interface</option>
					<option value="5">Instruction of student Profile in student interface</option>
					<option value="6">Instruction of student Profile in student interface - bottom</option>
					<option value="8">Instruction of workshops in student interface</option>
					<option value="12">Message in Adm_Sessions_Home for demo purpose</option>
				</select>
				<button id="previewButton" type="button">Preview</button>
				<button id="publishButton" type="button">Publish</button>
			</div>
			
			<textarea id="textEditor"></textarea>
			
			<div id="cancelSaveButton">
				<button id="cancelButton" type="button">Cancel</button>
				<button id="saveButton" type="button">Save</button>
			</div>
		</div>
		
		
		
		<div class="footer"></div>
              
		<!-- In case browser doesnot enable JS -->
		<noscript>Sorry, your browser does not support JavaScript!</noscript>
	</body>
</html>