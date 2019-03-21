<%@ page import="java.util.ArrayList, java.io.IOException, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.Array, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement, javax.servlet.RequestDispatcher, javax.servlet.ServletException, javax.servlet.annotation.WebServlet, javax.servlet.http.HttpServlet, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	int userID = (int)session.getAttribute("userID");
	String username = "";

	Connection conn = null;
	Statement st = null;
	Statement st2 = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	PreparedStatement ps = null;
	ArrayList<String> searches = new ArrayList<String>();
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost/LoginInfo?user=root&password=root");
		st = conn.createStatement();
		st2 = conn.createStatement();
		rs = st.executeQuery("SELECT un from Users where userID='" + userID + "'");
		if(rs.next())
			username = rs.getString("un");
		System.out.println("got to #1");
		rs2 = st2.executeQuery("SELECT searchQuery from Searches where userID='" + userID + "'");
		System.out.println("got to #2");
		//Array a = rs.getArray("searchQuery");
		//String[] nullable = (String[])a.getArray();
	    while(rs2.next()) {
			//System.out.println(rs2.next());
			//System.out.println(rs2.getString(1));
			
	    	searches.add(rs2.getString(1));
		}
		 
	} catch (SQLException sqle) {
		System.out.println (sqle.getMessage());
	} catch(ClassNotFoundException cnfe) {
		System.out.println (cnfe.getMessage());	
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
  			<a href="signOut.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Sign Out </div></a>
	  			<a href="profile.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Profile </div></a>
  			</div>
  		</div>
  		<div class="centerCluster">
  			<h1><%=username%>'s Search History</h1>
  			<table class="resultsTable" style="width:100%;" id="myTable">
				  <%
				  for(int i=searches.size()-1; i>=0; i--) {
				  %>
				  <tr>
				    <td class="resultsTD" style="text-align:center"><h2><%=searches.get(i) %></h2></td>
				  </tr>
				  <%} %>
				</table>
		</div>
	</body>
</html>

