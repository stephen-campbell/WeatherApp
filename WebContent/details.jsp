<%@ page import="java.util.ArrayList, java.util.Map, hw2.MyFileReader.*, java.util.Set, java.util.HashSet, java.util.Iterator" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	ArrayList<CityNameInfo> cityNames = (ArrayList<CityNameInfo>)session.getAttribute("cityNames");
	ArrayList<CityNameInfo> cityMatches = (ArrayList<CityNameInfo>)session.getAttribute("cityMatches");
	ArrayList<City> cityMatchesApiCall = (ArrayList<City>)session.getAttribute("cityMatchesApiCall");
	int cityArrayID = Integer.parseInt(request.getParameter("cityArrayID"));
	City currentCity = cityMatchesApiCall.get(cityArrayID);
%>





<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="styles.css">
		<title>WeatherMeister</title>
		<style>
		#map {
        height: 100%;
     	}
     	#outerMap {
     	padding-top: 100px;
      	height: 80%;
      	width: 80%;
      	margin: auto;
      	}
      	html, body {
        height: 100%;
        margin: 0;
        padding: 0;
     	}
     	</style>
		<script>
			function cityInput() {
				document.getElementById('latLongInputForm').style.display ='none';
				document.getElementById('cityInputForm').style.display = 'block';
			}
			function latLongInput() {
				document.getElementById('latLongInputForm').style.display ='block';
				document.getElementById('cityInputForm').style.display = 'none';
			}
		
			var locationShowed = false;
			function showLocation() {
				if(locationShowed==false) {
					document.getElementById('locationInitial').style.display ='none';
					document.getElementById('locationSecondary').style.display = 'block';
					locationShowed=true;
				}
				else {
					document.getElementById('locationInitial').style.display ='block';
					document.getElementById('locationSecondary').style.display = 'none';
					locationShowed=false;
				}
			}
			var tempLowShowed = false;
			function showTempLow() {
				if(tempLowShowed==false) {
					document.getElementById('tempLowInitial').style.display ='none';
					document.getElementById('tempLowSecondary').style.display = 'block';
					tempLowShowed=true;
				}
				else {
					document.getElementById('tempLowInitial').style.display ='block';
					document.getElementById('tempLowSecondary').style.display = 'none';
					tempLowShowed=false;
				}
			}
			var tempHighShowed = false;
			function showTempHigh() {
				if(tempHighShowed==false) {
					document.getElementById('tempHighInitial').style.display ='none';
					document.getElementById('tempHighSecondary').style.display = 'block';
					tempHighShowed=true;
				}
				else {
					document.getElementById('tempHighInitial').style.display ='block';
					document.getElementById('tempHighSecondary').style.display = 'none';
					tempHighShowed=false;
				}
			}
			var windShowed = false;
			function showWind() {
				if(windShowed==false) {
					document.getElementById('windInitial').style.display ='none';
					document.getElementById('windSecondary').style.display = 'block';
					windShowed=true;
				}
				else {
					document.getElementById('windInitial').style.display ='block';
					document.getElementById('windSecondary').style.display = 'none';
					windShowed=false;
				}
			}
			var humidityShowed = false;
			function showHumidity() {
				if(humidityShowed==false) {
					document.getElementById('humidityInitial').style.display ='none';
					document.getElementById('humiditySecondary').style.display = 'block';
					humidityShowed=true;
				}
				else {
					document.getElementById('humidityInitial').style.display ='block';
					document.getElementById('humiditySecondary').style.display = 'none';
					humidityShowed=false;
				}
			}
			var coordinatesShowed = false;
			function showCoordinates() {
				if(coordinatesShowed==false) {
					document.getElementById('coordinatesInitial').style.display ='none';
					document.getElementById('coordinatesSecondary').style.display = 'block';
					coordinatesShowed=true;
				}
				else {
					document.getElementById('coordinatesInitial').style.display ='block';
					document.getElementById('coordinatesSecondary').style.display = 'none';
					coordinatesShowed=false;
				}
			}
			var tempShowed = false;
			function showTemp() {
				if(tempShowed==false) {
					document.getElementById('tempInitial').style.display ='none';
					document.getElementById('tempSecondary').style.display = 'block';
					tempShowed=true;
				}
				else {
					document.getElementById('tempInitial').style.display ='block';
					document.getElementById('tempSecondary').style.display = 'none';
					tempShowed=false;
				}
			}
			var sunShowed = false;
			function showSun() {
				if(sunShowed==false) {
					document.getElementById('sunInitial').style.display ='none';
					document.getElementById('sunSecondary').style.display = 'block';
					sunShowed=true;
				}
				else {
					document.getElementById('sunInitial').style.display ='block';
					document.getElementById('sunSecondary').style.display = 'none';
					sunShowed=false;
				}
			}
			var map;
		      function initMap() {
		        map = new google.maps.Map(document.getElementById('map'), {
		          center: {lat: 39, lng: -98},
		          zoom: 4
		        });
		        google.maps.event.addListener(map, 'click', function(event) {
		        	var latInput = Math.round(event.latLng.lat() * 100) /100;
		        	var lngInput = Math.round(event.latLng.lng() * 100) /100;
		        	document.getElementById('lat').value =latInput;
		        	document.getElementById('lng').value = lngInput;
		        	hideMap();
		        });
		      }
		      function showMap() {
					document.getElementById('outerMap').style.display ='block';
					document.getElementById('otherStuff').style.display ='none';
					initMap();
				}
				function hideMap() {
					document.getElementById('outerMap').style.display ='none';
					document.getElementById('otherStuff').style.display ='block';
					initMap();
				}
		
		</script>
	</head>
	<body>
	<div id="outerMap" style="display: none;">
			<div id="map"></div>
	</div>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCho1Qghl22DGUfNxOY7zA8i3u3msGnurw&callback"
    		async defer></script>
		<div id="otherStuff">
			<div class="blackBar">
				<a href="index.jsp" style="text-decoration: none; display:inline-block;"><div style="margin-top:25px; margin-left:25px; font-family:Savoye LET; font-size: 40px; color:white; display:inline-block;"> WeatherMeister </div></a>
				<div style="display:inline-block;">
					<form action="submissionServlet" method="POST" id="cityInputForm" style="display:inline-block; left-margin:auto;">
						<input type="text" class="cityNameInput" name="cityName" placeholder="Los Angeles" style="margin-left:800px;"/>
						<input type="submit" class="cityNameSubmit" name="submit" value=""/>
					</form>
					<form action="submissionServlet" method="POST" id="latLongInputForm" style="display:none; margin-left:800px;">
						<input type="text" name="latitude" placeholder="Latitude" id="lat" style="height: 20px;"/>
						<input type="text" class="cityNameInput" name="longitude" id="lng" placeholder="Longitude"/>
						<input type="submit" class="cityNameSubmit" name="submit" value=""/>
						<button type="button" onclick="showMap()" style="float: right; z-index: 10; position:relative;"><img src="images/MapIcon.png" style="width:20px;height:20px; border:none;"></img></button>
					</form>
					<div>
						<input type="radio" name="selectorRadio" onclick="cityInput()" checked="checked" style="margin-left:800px;"/><label>City</label>
						<input type="radio" name="selectorRadio" onclick="latLongInput()"/><label>Location (Lat./Long.)</label>
					</div>
				</div>
			</div>
		<div class="centerCluster">
			<h1 style="margin-right:auto; margin-left:7%;"><%=currentCity.getName() %></h1>
			<table style="width:90%">
				<tr>
					<th>
						<button class="centerButton" onclick="showLocation()">
							<div id="locationInitial">
								<img src="images/planet-earth.png" alt="location" style="width: 150px;">
							</div>
							<div id="locationSecondary" style="display:none">
								<h3><%=currentCity.getSys().getCountry() %></h3>
							</div>
							<h3>Location</h3>
						</button>
					</th>
					<th>
						<button class="centerButton" onclick="showTempLow()">
							<div id="tempLowInitial">
								<img src="images/snowflake.png" alt="snowflake" style="width: 150px;">
							</div>
							<div id="tempLowSecondary" style="display:none">
								<h3><%=currentCity.getMain().getTempMin()%> degrees Fahrenheit</h3>
							</div>
							<h3>Temp Low</h3>
						</button>
					</th> 
					<th>
						<button class="centerButton" onclick="showTempHigh()">
							<div id="tempHighInitial">
								<img src="images/sun.png" alt="sun" style="width: 150px;">
							</div>
							<div id="tempHighSecondary" style="display:none">
								<h3><%=currentCity.getMain().getTempMax()%> degrees Fahrenheit</h3>
							</div>
							<h3>Temp High</h3>
						</button>
					</th>
					<th>
						<button class="centerButton" onclick="showWind()">
							<div id="windInitial">
								<img src="images/wind.png" alt="wind" style="width: 150px;">
							</div>
							<div id="windSecondary" style="display:none">
								<h3><%=currentCity.getWind().getSpeed()%> miles/hour</h3>
							</div>
							<h3>Wind</h3>
						</button>
					</th>
				 </tr>
				 <tr>
				 	<th>
				 		<button class="centerButton" onclick="showHumidity()">
				 			<div id="humidityInitial">
				 				<img src="images/drop.png" alt="drop" style="width: 150px;">
				 			</div>
				 			<div id="humiditySecondary" style="display:none">
				 				<h3><%=currentCity.getMain().getHumidity()%>%</h3>
				 			</div>
				 			<h3>Humidity</h3>
				 		</button>
				 	</th>
				 	<th>
				 		<button class="centerButton" onclick="showCoordinates()">
				 			<div id="coordinatesInitial">
				 				<img src="images/LocationIcon.png" alt="location" style="width: 150px;">
				 			</div>
				 			<div id="coordinatesSecondary" style="display:none">
				 				<h3>(<%=currentCity.getCoord().getLat()%>, <%=currentCity.getCoord().getLon()%>)</h3>
				 			</div>
				 			<h3>Coordinates</h3>
				 		</button>
				 	</th>
				 	<th>
				 		<button class="centerButton" onclick="showTemp()">
				 			<div id="tempInitial">
				 				<img src="images/thermometer.png" alt="thermometer" style="width: 150px;">
				 			</div>
				 			<div id="tempSecondary" style="display:none">
				 				<h3><%=currentCity.getMain().getTemp()%> degrees Fahrenheit</h3>
				 			</div>
				 			<h3>Current Temp</h3>
				 		</button>
				 	</th>
				 	<th>
				 		<button class="centerButton" onclick="showSun()">
				 			<div id="sunInitial">
				 				<img src="images/sunrise-icon.png" alt="sunrise" style="width: 150px;">
				 			</div>
				 			<div id="sunSecondary" style="display:none">
				 				<h3><%=currentCity.getSys().getSunrise()%>, <%=currentCity.getSys().getSunset()%></h3>
				 			</div>
				 			<h3>Sunrise/set</h3>
				 		</button>
				 	</th>
				</tr>
			</table>
		</div>
	</div>
	</body>
</html>