import 'package:flutter/material.dart';
import 'package:weather_app/helper/image_provide.dart';
import 'package:weather_app/helper/weather_provider.dart';
import 'package:weather_app/screens/city_weather_page.dart';

class WeatherPage extends StatefulWidget {
  final weatherData;
  WeatherPage(this.weatherData);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    print(widget.weatherData);
    updateUI(widget.weatherData);
  }

  var weatherDescription, weatherId, humidity, city;
  late int temp, feelslike;
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        weatherDescription = "ERROR";
        weatherId = 0;
        temp = 0;
        feelslike = 0;
        humidity = 0;
        return;
      }
      weatherDescription = weatherData['weather'][0]['description'];
      weatherId = weatherData['weather'][0]['id'];
      double temp1 = weatherData['main']['temp'];
      temp = temp1.toInt();
      double feelslike1 = weatherData['main']['feels_like'];
      feelslike = feelslike1.toInt();
      humidity = weatherData['main']['humidity'];
      city = weatherData['name'];
    });
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    ProvideImage imagePathProvider = ProvideImage(weatherId);
    String imagePath = imagePathProvider.getImagePath();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Top Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Refresh Button
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            var jsonResponse = await WeatherProvider()
                                .locationWeatherProvider();
                            updateUI(jsonResponse);
                          },
                          icon: Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                            size: 55,
                          ),
                        ),
                      ),
                      //City Button
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            final cityName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CityWeatherPage(),
                              ),
                            );
                            if (cityName != null) {
                              var jsonResponse = await WeatherProvider()
                                  .cityWeatherProvider(cityName);
                              updateUI(jsonResponse);
                            }
                          },
                          icon: Icon(
                            Icons.location_city_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "$city",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),

              Column(
                //kam kora nai alignment e
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "$temp°",
                    style: TextStyle(color: Colors.white, fontSize: 80),
                  ),
                  Text(
                    capitalize(weatherDescription),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Real Feel: $feelslike°",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Humidity: $humidity%",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
