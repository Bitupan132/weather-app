import 'package:weather_app/helper/location.dart';
import 'package:weather_app/helper/networking.dart';

const apikey = "b7350744b14e94c546ae066e177c5b51";
const unit = 'metric';
const openWatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherProvider {
  Future<dynamic> locationWeatherProvider() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWatherUrl?lat=${location.lattitude}&lon=${location.longitude}&appid=$apikey&units=$unit');
    var jsonResponse = await networkHelper.getData();
    return jsonResponse;
  }

  Future<dynamic> cityWeatherProvider(String city) async {
    String cityName = city;
    NetworkHelper networkHelper =
        NetworkHelper('$openWatherUrl?q=$cityName&appid=$apikey&units=$unit');
    var jsonResponse = await networkHelper.getData();
    return jsonResponse;
  }
}
