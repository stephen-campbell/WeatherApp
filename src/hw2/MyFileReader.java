package hw2;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;
import com.google.gson.reflect.TypeToken;

public class MyFileReader {

	public static void main(String [] args) {
		/* for testing:
		ArrayList<CityNameInfo> cityNames = readCityNames();
		System.out.println(cityNames.get(500).getName());
		System.out.println(cityNames.size());
		System.out.println("done");
		*/
	}
	
	public ArrayList<CityNameInfo> readCityNames() {
		ArrayList<CityNameInfo> cityNameOutput = new ArrayList<CityNameInfo>();
		Gson gson = new Gson();
		try {
			URL urlH = getClass().getResource("/../../city.list.json");
			BufferedReader br = new BufferedReader(new InputStreamReader(urlH.openStream()));
			cityNameOutput = gson.fromJson(br, new TypeToken<List<CityNameInfo>>(){}.getType());
		} catch(FileNotFoundException fnfe) {
			System.out.println("The file " + fnfe.getMessage() + " could not be found.");
		} catch(IOException ioe) {
			System.out.println("IO Exception: " + ioe.getMessage());
		}
		return cityNameOutput;
	}
	
	public static boolean isNumerical(String input) { //returns true if a float or int
		//return input.matches("-?\\d+");
		return input.matches("[-+]?[0-9]*\\.?[0-9]+");
	}

	/*public static class City { //stores basic data about a city
		public String name; //0
		public String state; //1
		public String country; //2
		public float latitude; //3
		public float longitude; //4
		public String sunriseTime; //5
		public String sunsetTime; //6
		public int currentTemperature; //7
		public int dayLow; //8
		public int dayHigh; //9
		public int humidity; //10
		public float pressure; //11
		public float visibility; //12
		public float windspeed; //13
		public int windDirection; //14
		public Vector<String> conditionVector; //15
	}*/

	public class Coord {
		private Double lon;
		private Double lat;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Double getLon() {
		return lon;
		}
		public void setLon(Double lon) {
		this.lon = lon;
		}
		public Double getLat() {
		return lat;
		}
		public void setLat(Double lat) {
		this.lat = lat;
		}
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}
	}
	
	public class CityNameInfo {
		private Integer id;
		private String name;
		private String country;
		private Coord coord;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Integer getId() {
		return id;
		}
		public void setId(Integer id) {
		this.id = id;
		}
		public String getName() {
		return name;
		}
		public void setName(String name) {
		this.name = name;
		}
		public String getCountry() {
		return country;
		}
		public void setCountry(String country) {
		this.country = country;
		}
		public Coord getCoord() {
		return coord;
		}
		public void setCoord(Coord coord) {
		this.coord = coord;
		}
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}
	}	
	
	public class Clouds {
		private Integer all;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Integer getAll() {
			return all;
		}
		public void setAll(Integer all) {
			this.all = all;
		}
		public Map<String, Object> getAdditionalProperties() {
			return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
			this.additionalProperties.put(name, value);
		}
	}
	
	public class City {
		private Coord coord;
		private List<Weather> weather = null;
		private String base;
		private Main main;
		private Integer visibility;
		private Wind wind;
		private Clouds clouds;
		private Integer dt;
		private Sys sys;
		private Integer id;
		private String name;
		private Integer cod;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Coord getCoord() {
		return coord;
		}
		public void setCoord(Coord coord) {
		this.coord = coord;
		}
		public List<Weather> getWeather() {
		return weather;
		}
		public void setWeather(List<Weather> weather) {
		this.weather = weather;
		}
		public String getBase() {
		return base;
		}
		public void setBase(String base) {
		this.base = base;
		}
		public Main getMain() {
		return main;
		}
		public void setMain(Main main) {
		this.main = main;
		}
		public Integer getVisibility() {
		return visibility;
		}
		public void setVisibility(Integer visibility) {
		this.visibility = visibility;
		}
		public Wind getWind() {
		return wind;
		}
		public void setWind(Wind wind) {
		this.wind = wind;
		}
		public Clouds getClouds() {
		return clouds;
		}
		public void setClouds(Clouds clouds) {
		this.clouds = clouds;
		}
		public Integer getDt() {
		return dt;
		}
		public void setDt(Integer dt) {
		this.dt = dt;
		}
		public Sys getSys() {
		return sys;
		}
		public void setSys(Sys sys) {
		this.sys = sys;
		}
		public Integer getId() {
		return id;
		}
		public void setId(Integer id) {
		this.id = id;
		}
		public String getName() {
		return name;
		}
		public void setName(String name) {
		this.name = name;
		}
		public Integer getCod() {
		return cod;
		}
		public void setCod(Integer cod) {
		this.cod = cod;
		}
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}
	}

	public class Main {
		private Double temp;
		private Double pressure;
		private Integer humidity;
		@SerializedName("temp_min")
		private Double tempMin;
		@SerializedName("temp_max")
		private Double tempMax;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Double getTemp() {
		return temp;
		}
		public void setTemp(Double temp) {
		this.temp = temp;
		}
		public Double getPressure() {
		return pressure;
		}
		public void setPressure(Double pressure) {
		this.pressure = pressure;
		}
		public Integer getHumidity() {
		return humidity;
		}
		public void setHumidity(Integer humidity) {
		this.humidity = humidity;
		}
		public Double getTempMin() {
		return tempMin;
		}
		public void setTempMin(Double tempMin) {
		this.tempMin = tempMin;
		}
		public Double getTempMax() {
		return tempMax;
		}
		public void setTempMax(Double tempMax) {
		this.tempMax = tempMax;
		}
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}
	}

	public class Sys {
		private Integer type;
		private Integer id;
		private Double message;
		private String country;
		private Integer sunrise;
		private Integer sunset;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Integer getType() {
		return type;
		}
		public void setType(Integer type) {
		this.type = type;
		}
		public Integer getId() {
		return id;
		}
		public void setId(Integer id) {
		this.id = id;
		}
		public Double getMessage() {
		return message;
		}
		public void setMessage(Double message) {
		this.message = message;
		}
		public String getCountry() {
		return country;
		}
		public void setCountry(String country) {
		this.country = country;
		}
		public Integer getSunrise() {
		return sunrise;
		}
		public void setSunrise(Integer sunrise) {
		this.sunrise = sunrise;
		}
		public Integer getSunset() {
		return sunset;
		}
		public void setSunset(Integer sunset) {
		this.sunset = sunset;
		}
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}

		}

	public class Weather {
		private Integer id;
		private String main;
		private String description;
		private String icon;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Integer getId() {
		return id;
		}
		public void setId(Integer id) {
		this.id = id;
		}
		public String getMain() {
		return main;
		}
		public void setMain(String main) {
		this.main = main;
		}
		public String getDescription() {
		return description;
		}
		public void setDescription(String description) {
		this.description = description;
		}
		public String getIcon() {
		return icon;
		}
		public void setIcon(String icon) {
		this.icon = icon;
		}
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}

		}

	public class Wind {
		private Double speed;
		private Double deg;
		private Map<String, Object> additionalProperties = new HashMap<String, Object>();

		public Double getSpeed() {
		return speed;
		}
		public void setSpeed(Double speed) {
		this.speed = speed;
		}
		public Double getDeg() {
		return deg;
		}
		public void setDeg(Double deg) {
		this.deg = deg;
		}
		public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
		}
		public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
		}
	}
}

/*
To do:
-Fix search button
*/