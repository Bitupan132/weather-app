import 'package:weather_app/helper/location.dart';
import 'package:weather_app/helper/networking.dart';
import 'package:weather_app/secret_key.dart';

const apikey = api_key;
const unit = 'metric';
const openWatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherProvider {
  //this function is called on the home page. In this funtion the weather of the current device location is fetched form the API.
  Future<dynamic> locationWeatherProvider() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWatherUrl?lat=${location.lattitude}&lon=${location.longitude}&appid=$apikey&units=$unit');
    var jsonResponse = await networkHelper.getData();
    return jsonResponse;
  }

  // This function is called on the city weather page. This function returns the weather data (JSON format)
  Future<dynamic> cityWeatherProvider(String city) async {
    String cityName = city;
    NetworkHelper networkHelper =
        NetworkHelper('$openWatherUrl?q=$cityName&appid=$apikey&units=$unit');
    var jsonResponse = await networkHelper.getData();
    return jsonResponse;
  }
}
