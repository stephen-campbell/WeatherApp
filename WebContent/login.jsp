<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String error = (String)session.getAttribute("error");
	if(error == null) {
		error = "";
	}
%>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="styles.css">
		<title>WeatherMeister</title>
	</head>
	<script>
		
	</script>
	<body>
		<div class="blackBar">
  			<div style="margin-top:5px; margin-left:25px; font-family:Savoye LET; font-size: 40px;">
  			<a href="index.jsp" style="text-decoration: none; display:inline-block;"><div style="margin-left:25px; font-family:Savoye LET; font-size: 40px; color:white; display:inline-block;"> WeatherMeister </div></a>
  			<a href="register.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Register </div></a>
  			<a href="login.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Login </div></a>
  			</div>
  		</div>
  		<div class="centerCluster">
  			<img src="images/Keychain_Locked@2x.png" alt="Main logo" style="width: 400px;">
			<form action="loginServlet" method="POST" id="cityInputForm" style="background: #d9d9d9; opacity:0.9;">
				<input type="text" class="cityNameInput" name="username" placeholder="Username" style="background: #d9d9d9; opacity:0.9;"/>
				<br>
				<input type="text" class="cityNameInput" name="password" placeholder="Password" style="background: #d9d9d9; opacity:0.9;"/>
				<br>
				<%=error %>
				<br>
				<input type="submit" name="submit" value="Login" style="color:white; background-color:#ff9966;"/>
			</form>
		</div>
	</body>
</html>

