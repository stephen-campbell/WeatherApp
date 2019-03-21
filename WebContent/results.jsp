<%@ page import="hw2.MyFileReader.City, java.util.ArrayList, java.util.Map, hw2.MyFileReader.*, java.util.Set, java.util.HashSet, java.util.Iterator, java.util.Collection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String cityName = request.getParameter("cityName");
	ArrayList<CityNameInfo> cityNames = (ArrayList<CityNameInfo>)session.getAttribute("cityNames");
	ArrayList<CityNameInfo> cityMatches = (ArrayList<CityNameInfo>)session.getAttribute("cityMatches");
	ArrayList<City> cityMatchesApiCall = (ArrayList<City>)session.getAttribute("cityMatchesApiCall");
	
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
	<body>
		<div id="outerMap" style="display: none;">
				<div id="map"></div>
		</div>
		<script>
			function cityInput() {
				document.getElementById('latLongInputForm').style.display ='none';
				document.getElementById('cityInputForm').style.display = 'block';
			}
			function latLongInput() {
				document.getElementById('latLongInputForm').style.display ='block';
				document.getElementById('cityInputForm').style.display = 'none';
			}
			function aToZSort(selectedValue) { //adapted from w3 schools https://www.w3schools.com/howto/howto_js_sort_table.asp
				if(selectedValue==1) { //aToZ
					var table, rows, switching, i, x, y, shouldSwitch;
					  table = document.getElementById("myTable");
					  switching = true;
					  while (switching) {
					    switching = false;
					    rows = table.rows;
					    for (i = 1; i < (rows.length - 1); i++) {
					      shouldSwitch = false;
					      x = rows[i].getElementsByTagName("TD")[0];
					      y = rows[i + 1].getElementsByTagName("TD")[0];
					      if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
					        shouldSwitch = true;
					        break;
					      }
					    }
					    if (shouldSwitch) {
					      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
					      switching = true;
					    }
					}
				}
				else if(selectedValue==2) {  //zToA
					var table, rows, switching, i, x, y, shouldSwitch;
					  table = document.getElementById("myTable");
					  switching = true;
					  while (switching) {
					    switching = false;
					    rows = table.rows;
					    for (i = 1; i < (rows.length - 1); i++) {
					      shouldSwitch = false;
					      x = rows[i].getElementsByTagName("TD")[0];
					      y = rows[i + 1].getElementsByTagName("TD")[0];
					      if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
					        shouldSwitch = true;
					        break;
					      }
					    }
					    if (shouldSwitch) {
					      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
					      switching = true;
					    }
					}
				}
				else if(selectedValue==3) { //temp low asc
					var table, rows, switching, i, x, y, shouldSwitch;
					  table = document.getElementById("myTable");
					  switching = true;
					  while (switching) {
					    switching = false;
					    rows = table.rows;
					    for (i = 1; i < (rows.length - 1); i++) {
					      shouldSwitch = false;
					      x = rows[i].getElementsByTagName("TD")[1];
					      y = rows[i + 1].getElementsByTagName("TD")[1];
					      if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
					        shouldSwitch = true;
					        break;
					      }
					    }
					    if (shouldSwitch) {
					      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
					      switching = true;
					    }
					}
				}
				else if(selectedValue==4) { //temp low desc
					var table, rows, switching, i, x, y, shouldSwitch;
					  table = document.getElementById("myTable");
					  switching = true;
					  while (switching) {
					    switching = false;
					    rows = table.rows;
					    for (i = 1; i < (rows.length - 1); i++) {
					      shouldSwitch = false;
					      x = rows[i].getElementsByTagName("TD")[1];
					      y = rows[i + 1].getElementsByTagName("TD")[1];
					      if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
					        shouldSwitch = true;
					        break;
					      }
					    }
					    if (shouldSwitch) {
					      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
					      switching = true;
					    }
					}
				}
				else if(selectedValue==5) { //temp high asc
					var table, rows, switching, i, x, y, shouldSwitch;
					  table = document.getElementById("myTable");
					  switching = true;
					  while (switching) {
					    switching = false;
					    rows = table.rows;
					    for (i = 1; i < (rows.length - 1); i++) {
					      shouldSwitch = false;
					      x = rows[i].getElementsByTagName("TD")[2];
					      y = rows[i + 1].getElementsByTagName("TD")[2];
					      if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
					        shouldSwitch = true;
					        break;
					      }
					    }
					    if (shouldSwitch) {
					      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
					      switching = true;
					    }
					}
				}
				else if(selectedValue==6) { //temp high desc
					var table, rows, switching, i, x, y, shouldSwitch;
					  table = document.getElementById("myTable");
					  switching = true;
					  while (switching) {
					    switching = false;
					    rows = table.rows;
					    for (i = 1; i < (rows.length - 1); i++) {
					      shouldSwitch = false;
					      x = rows[i].getElementsByTagName("TD")[2];
					      y = rows[i + 1].getElementsByTagName("TD")[2];
					      if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
					        shouldSwitch = true;
					        break;
					      }
					    }
					    if (shouldSwitch) {
					      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
					      switching = true;
					    }
					}
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
			<div style="margin-top:200px; margin-left:10%;">
				<div style="float:left; width:70%">
					<table class="resultsTable" style="width:100%;" id="myTable">
					  <tr class="resultsTR">
					    <th><h2 style="font-weight:bold;">City Name</h2></th>
					    <th><h2 style="font-weight:bold;">Temp. Low</h2></th> 
					    <th><h2 style="font-weight:bold;">Temp. High</h2></th>
					  </tr>
					  <%
					  if(cityMatchesApiCall.size()!=0) {
						  	for(int q=0; q<cityMatchesApiCall.size(); q++) {
						  	City currentCity = cityMatchesApiCall.get(q);
					  %>
					  <tr>
					    <td class="resultsTD" style="text-align:center">
					    	<form action="details.jsp" method="GET">
					    		<input type="hidden" name="cityArrayID" value="<%=q %>" />
								<input type="submit" name="cityName" class="resultsSubmit" value="<%=currentCity.getName()%>, <%=currentCity.getSys().getCountry() %>"/>
							</form>
					    </td>
					    <td class="resultsTD" style="text-align:center"><h2><%=currentCity.getMain().getTempMin() %></h2></td>
					    <td class="resultsTD" style="text-align:center"><h2><%=currentCity.getMain().getTempMax() %></h2></td>
					  </tr>
					  <% 
					  		}
					  }
					  else { //no city was found, output some error
					  %>
						<tr class="resultsTR">
							<td class="resultsTD" style="text-align:center"><h2 style="color:red;">No result found</h2></td>
							<td class="resultsTD" style="text-align:center"><h2></h2></td>
							<td class="resultsTD" style="text-align:center"><h2></h2></td>
						</tr>
					  <%				 
					  }
					  %>
					  <script>aToZSort(1);</script>
					</table>
				
				</div>
					<%
					System.out.println("in #1");
					if(cityMatchesApiCall.size()!=0) {
					System.out.println("in #2");%>
					<div style="padding-left:20px; float:left;">
						<h2>Sort by:</h2>
						<select onchange="aToZSort(this.value)" style="color: black; font-size: 35px;  background-color:white;">
						  <option value="1">City Name A-Z</option>
						  <option value="2">City Name Z-A</option>
						  <option value="3">Temp. Low ASC</option>
						  <option value="4">Temp. Low DESC</option>
						  <option value="5">Temp. High ASC</option>
						  <option value="6">Temp. High DESC</option>
						</select>
					</div>
					<% }%>
			</div>
		</div>
	</body>
</html>