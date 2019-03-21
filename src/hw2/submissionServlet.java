package hw2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import hw2.MyFileReader.*;
import hw2.MyFileReader.CityNameInfo;
import hw2.MyFileReader.City;

@WebServlet("/submissionServlet")
public class submissionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public submissionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    //things added to session:
    //cityNames: list of total city names from the city.list.json file
    //cityMatches: a subset of cityNames with matching city names
    //cityMatchesApiCall: city data from matching city names
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		boolean loggedIn = false;
		if(session!=null) {
			if(session.getAttribute("loggedIn")!=null)
				loggedIn = (boolean)session.getAttribute("loggedIn");
		}
		
		MyFileReader bob = new MyFileReader();
		ArrayList<CityNameInfo> cityNames = bob.readCityNames();
		ArrayList<CityNameInfo> cityMatches = new ArrayList<CityNameInfo>();
		ArrayList<City> cityMatchesApiCall = new ArrayList<City>();
		if(request.getParameter("cityName")!=null) { //cityname entered
			if(loggedIn) {
				addToSearchHistory(request.getParameter("cityName"),(int)session.getAttribute("userID"));
			}
			for(int i=0; i<cityNames.size(); i++) {
				if(cityNames.get(i).getName().equalsIgnoreCase(request.getParameter("cityName"))) {
					cityMatches.add(cityNames.get(i));
				}
			}
			for(int i=0; i<cityMatches.size(); i++) {
				int currentCityId = cityMatches.get(i).getId();
				URL openWeatherURL = new URL("https://api.openweathermap.org/data/2.5/weather?id=" + currentCityId + "&units=imperial&APPID=7e761c992d888f44fc6144708278c024");
				HttpURLConnection currentConnection = (HttpURLConnection) openWeatherURL.openConnection();
				currentConnection.setRequestMethod("GET");
				currentConnection.connect();
				
				BufferedReader jsonReader = new BufferedReader(new InputStreamReader(currentConnection.getInputStream()));
				
				Gson gson = new Gson();
				City currentCity = gson.fromJson(jsonReader, City.class);
				
				cityMatchesApiCall.add(currentCity);
			}
		}
		else { //lat and long given
			float latitude = Float.parseFloat(request.getParameter("latitude"));
			float longitude = Float.parseFloat(request.getParameter("longitude"));
			if(loggedIn) {
				String latLongString = "(" + latitude + ", " + longitude + ")";
				addToSearchHistory(latLongString,(int)session.getAttribute("userID"));
			}
			URL openWeatherURL = new URL("https://api.openweathermap.org/data/2.5/weather?lat=" + latitude + "&lon=" + longitude + "&units=imperial&APPID=7e761c992d888f44fc6144708278c024");
			HttpURLConnection currentConnection = (HttpURLConnection) openWeatherURL.openConnection();
			currentConnection.setRequestMethod("GET");
			currentConnection.connect();
			
			BufferedReader jsonReader = new BufferedReader(new InputStreamReader(currentConnection.getInputStream()));
			
			Gson gson = new Gson();
			City currentCity = gson.fromJson(jsonReader, City.class);
			
			cityMatchesApiCall.add(currentCity);
		}
		
		
		
		//HttpSession session = request.getSession();
		session.setAttribute("cityNames", cityNames);
		session.setAttribute("cityMatches", cityMatches);
		session.setAttribute("cityMatchesApiCall", cityMatchesApiCall);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/results.jsp");
		dispatch.forward(request, response);
		
		/* not needed anymore
		MyFileReader bob = new MyFileReader();
		CityOutput myOutput = bob.readData();
		String cityName = request.getParameter("cityName");
		String nextPage = "/results.jsp";
		if(!myOutput.errorMessage.equals("")) {
			nextPage = "/index.jsp";
		}
		HttpSession session = request.getSession();
		session.setAttribute("cityMap", myOutput.cityMap);
		//session.setAttribute("error", myOutput.errorMessage);
		request.setAttribute("error", myOutput.errorMessage);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
		*/

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	void addToSearchHistory(String searchTerm, int userID) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/LoginInfo?user=root&password=root");
			String insertTableSQL = "INSERT INTO Searches" //put into searches table
						+ "(userID, searchQuery) VALUES"
						+ "(?,?)";
				ps = conn.prepareStatement(insertTableSQL);
				ps.setInt(1, userID);
				ps.setString(2, searchTerm);
				// execute insert SQL statement
				ps.executeUpdate();
		} catch (SQLException sqle) {
			System.out.println (sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println (cnfe.getMessage());
		}
	}

}
