package hw2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public loginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		int userID = 0;
		String nextPage = "/index.jsp";
		String errorMessage = "";
		boolean loggedIn = false;
		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/LoginInfo?user=root&password=root");
			st = conn.createStatement();
			rs = st.executeQuery("SELECT UserID from Users where un='" + username + "'" + "AND pw='" + password + "'");
			if(rs.next()) {
				userID = rs.getInt("userID");
			}
			if(userID == 0) { //either the user doesn't exist or wrong password
				rs = st.executeQuery("SELECT UserID from Users where un='" + username + "'");
				if(rs.next()) {
					errorMessage = "Incorrect password.";
				}
				else {
				errorMessage = "This user does not exist.";
				}
				nextPage = "/login.jsp";
				/*
				nextPage = "/login.jsp";
				rs = st.executeQuery("SELECT UserID from Users where un='" + username + "'");
				System.out.println("at #2");
				if(rs.getString("un")!=null) { //user exists but wrong password
					errorMessage = "This user does not exist.";
				}
				else { //user doesn't exist
					errorMessage = "Incorrect password.";
				}
				System.out.println("at #3");
				*/
			}
			else {
				//now log in the user, first we need userId
				rs = st.executeQuery("SELECT UserID from Users where un='" + username + "'");
				if(rs.next())
					userID = rs.getInt("userID");
				request.setAttribute("userID", userID);
				loggedIn = true;
			}
			rs.close();

		} catch (SQLException sqle) {
			System.out.println ("sqle " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println ("cnfe" + cnfe.getMessage());
		}
		HttpSession session = request.getSession();
		session.setAttribute("userID", userID);
		session.setAttribute("loggedIn", loggedIn);
		session.setAttribute("error", errorMessage);
		request.setAttribute("userID", userID);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
