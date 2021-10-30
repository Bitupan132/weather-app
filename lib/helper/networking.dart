import 'package:http/http.dart' as http;
import 'dart:convert';
//this class calls openweather api and returns the decoded json  weather data
class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  //get weather data from openweathermap api
  Future getData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }
}
