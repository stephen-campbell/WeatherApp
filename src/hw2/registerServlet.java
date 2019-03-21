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

@WebServlet("/registerServlet")
public class registerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public registerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");
		int userID = 0;
		String nextPage = "/index.jsp";
		String errorMessage = "";
		boolean loggedIn = false;
		
		if(password.equals(passwordConfirm)) { //passwords match
			Connection conn = null;
			Statement st = null;
			ResultSet rs = null;
			PreparedStatement ps = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/LoginInfo?user=root&password=root");
				st = conn.createStatement();
				rs = st.executeQuery("SELECT UserID from Users where un='" + username + "'");
				if(rs.next())
					userID = rs.getInt("userID");
				if(userID == 0) { //the username doesn't currently exist, we're good
					//at this point the passwords match and the username is free, we can add the user
					String insertTableSQL = "INSERT INTO Users"
							+ "(un, pw) VALUES"
							+ "(?,?)";
					ps = conn.prepareStatement(insertTableSQL);
					ps.setString(1, username);
					ps.setString(2, password);
					// execute insert SQL statement
					ps.executeUpdate();
					
					//now log in the user, first we need userId
					rs = st.executeQuery("SELECT UserID from Users where un='" + username + "'");
					if(rs.next())
						userID = rs.getInt("userID");
					request.setAttribute("userID", userID);
					loggedIn = true;
				}
				else { //username already exists, we're in trouble
					errorMessage = "This username is already taken.";
					nextPage = "/login.jsp";
				}
	
			} catch (SQLException sqle) {
				System.out.println (sqle.getMessage());
			} catch(ClassNotFoundException cnfe) {
				System.out.println (cnfe.getMessage());
			}
		}
		else { //passwords do not match
			errorMessage = "The passwords do not match.";
			nextPage = "/register.jsp";
		}
		HttpSession session = request.getSession();
		session.setAttribute("userID", userID);
		request.setAttribute("error", errorMessage);
		request.setAttribute("userID", userID);
		session.setAttribute("loggedIn", loggedIn);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
