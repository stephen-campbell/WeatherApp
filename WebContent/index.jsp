<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	boolean loggedIn = false;
	if(session!=null) {
		if(session.getAttribute("loggedIn")!=null)
			loggedIn = (boolean)session.getAttribute("loggedIn");
	}
	
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
	</head>
	<script>
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
		function cityInput() {
			document.getElementById('latLongInputForm').style.display ='none';
			document.getElementById('cityInputForm').style.display = 'block';
		}
		function latLongInput() {
			document.getElementById('latLongInputForm').style.display ='block';
			document.getElementById('cityInputForm').style.display = 'none';
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
		
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCho1Qghl22DGUfNxOY7zA8i3u3msGnurw&callback"
    async defer></script>
	<body>
		<div id="outerMap" style="display: none;">
			<div id="map"></div>
		</div>
		<div id="otherStuff"  style="display: block;">
			<div class="blackBar">
	  			<div style="margin-top:5px; margin-left:25px; font-family:Savoye LET; font-size: 40px;">
	  			WeatherMeister
	  			<% if(!loggedIn) { %>
	  			<a href="register.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Register </div></a>
	  			<a href="login.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Login </div></a>
	  			 <% } else {%>
	  			 <a href="signOut.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Sign Out </div></a>
	  			<a href="profile.jsp" style="text-decoration: none; display:inline-block; margin-right:5px; float: right;"><div style="color:white; display:inline-block; font-size: 20px; text-align: right;"> Profile </div></a>
	  			 <%} %>
	  			</div>
	  		</div>
	  		<div class="centerCluster">
	  			<img src="images/logo.png" alt="Main logo" style="width: 400px;">
				<form action="submissionServlet" method="POST" id="cityInputForm" style="background: #d9d9d9; opacity:0.9;">
					<input type="text" class="cityNameInput" name="cityName" placeholder="Los Angeles" style="background: #d9d9d9; opacity:0.9; z-index: 1; position:relative;"/>
					<input type="submit" class="cityNameSubmit" name="submit" value="" style="z-index: 10; position:relative;"/>
				</form>
				<form action="submissionServlet" method="POST" id="latLongInputForm" style="z-index: 1; position:relative; display:none;">
					<input type="text" id="lat" name="latitude" placeholder="Latitude" style="height: 20px; background: #d9d9d9; opacity:0.9; z-index: -1;"/>
					<input type="text" id="lng" class="cityNameInput" name="longitude" style="background: #d9d9d9; opacity:0.9; z-index: -1;" placeholder="Longitude"/>
					<input type="submit" class="cityNameSubmit" name="submit" value="" style="z-index: 10; position:relative;"/>
					<button type="button" onclick="showMap()" style="float: right;"><img src="images/MapIcon.png" style="width:20px;height:20px; border:none;"></img></button>
				</form>
				<div>
					<input type="radio" name="selectorRadio" onclick="cityInput()" checked="checked"/><label style="color:white">City</label>
					<input type="radio" name="selectorRadio" onclick="latLongInput()"/><label style="color:white">Location (Lat./Long.)</label>
				</div>
			</div>
		</div>
	</body>
</html>

<!-- 
To do:
change pw in 3 places
readme
 -->