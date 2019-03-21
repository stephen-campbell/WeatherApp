<%@ page import="java.util.ArrayList, java.io.IOException, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.Array, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement, javax.servlet.RequestDispatcher, javax.servlet.ServletException, javax.servlet.annotation.WebServlet, javax.servlet.http.HttpServlet, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String nextPage = "/index.jsp";
session.setAttribute("userID", null);
session.setAttribute("loggedIn", false);
session.setAttribute("error", null);
request.setAttribute("userID", null);
RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
dispatch.forward(request, response);

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>