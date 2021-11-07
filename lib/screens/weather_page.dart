import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/helper/image_provide.dart';
import 'package:weather_app/helper/weather_provider.dart';
import 'package:weather_app/screens/city_weather_page.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  final weatherData;
  WeatherPage(this.weatherData);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _timeString = '';
  String _dateString = '';
  @override
  void initState() {
    super.initState();
    print(widget.weatherData);
    // getDate();
    Timer.periodic(Duration(seconds: 1),
        (Timer t) => _getTime()); // to periodically update the current time
    updateUI(widget.weatherData);
  }

  var weatherDescription, weatherId, humidity, city;
  late int temp, feelslike, minTemp, maxTemp;
  late double windSpeed;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        weatherDescription = "Error Loading Weather Details";
        weatherId = 0;
        temp = 0;
        feelslike = 0;
        humidity = 0;
        windSpeed = 0.0;
        minTemp = 0;
        maxTemp = 0;
        return;
      }
      weatherDescription = weatherData['weather'][0]['description'];
      weatherId = weatherData['weather'][0]['id'];
      double temp1 = weatherData['main']['temp'];
      temp = temp1.toInt();
      double feelslike1 = weatherData['main']['feels_like'];
      feelslike = feelslike1.toInt();
      double minTemp1 = weatherData['main']['temp_min'];
      minTemp = minTemp1.toInt();
      double maxTemp1 = weatherData['main']['temp_max'];
      maxTemp = maxTemp1.toInt();
      humidity = weatherData['main']['humidity'];
      city = weatherData['name'];
      windSpeed = weatherData['wind']['speed'];
    });
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void _getTime() {
    final String formattedTime =
        DateFormat('kk:mm').format(DateTime.now()).toString();
    final String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedTime;
      _dateString = formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProvideImage imagePathProvider = ProvideImage(weatherId);
    String imagePath = imagePathProvider.getImagePath();
    //String imagePath = 'images/weather_bg.jpg';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: RefreshIndicator(
              displacement: 14,
              color: Colors.white,
              backgroundColor: Colors.blue,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                var jsonResponse =
                    await WeatherProvider().locationWeatherProvider();
                updateUI(jsonResponse);
              },
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child:
                        //Complete UI portion
                        Column(
                      // Has two children.  One for the upper portion, one for the lower part
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Upper Part
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Top Bar
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Icons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //City icon
                                    SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Icon(
                                        Icons.location_city_rounded,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                    ),
                                    // search button
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () async {
                                          // city name is fetched from the next page, i.e passed back by from the CityWeatherPage
                                          final cityName = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CityWeatherPage(),
                                            ),
                                          );
                                          // when the user entered a city name then get the weather data for that city and update the UI
                                          if (cityName != null) {
                                            var jsonResponse =
                                                await WeatherProvider()
                                                    .cityWeatherProvider(
                                                        cityName);
                                            updateUI(jsonResponse);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.search_rounded,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "$city",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 26),
                                  ),
                                ),
                                Text(
                                  _dateString,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                                Text(
                                  _timeString,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26),
                                ),
                              ],
                            ),

                            Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$temp\u2103", //\u2103 is the code for degree celcius
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 80),
                                ),
                                Text(
                                  '$minTemp\u2103 / $maxTemp\u2103',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  capitalize(weatherDescription),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //lower part including the divider and Real feel, Wind speed etc
                        Column(
                          children: [
                            Divider(color: Colors.white),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Real Feel',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '$feelslike\u2103',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(children: [
                                  Text(
                                    'Wind Speed',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '$windSpeed km/h',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  Text(
                                    'Humidity',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '$humidity%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                  //   Text(
                                  //   "Humidity: $humidity%",
                                  //   style: TextStyle(
                                  //       color: Colors.white, fontSize: 20),
                                  // ),
                                ]),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
  // String date = '';
  //String time = '';
  // void getDate() {
  //   var date = new DateTime.now().toString();
  //   var dateParse = DateTime.parse(date);
  //   var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  //   setState(() {
  //     date = formattedDate.toString();
  //   });
  // }

  // void getTime() {
  //   var time = new DateTime.now().toString();
  //   var timeParse = DateTime.parse(time);
  //   var formattedTime = "${timeParse.hour}:${timeParse.minute}";
  //   setState(() {
  //     time = formattedTime.toString();
  //   });
  // }

    //DateTime dateTime = DateTime().now();
  //dateTime.toIso8601String();

                        // Container(
                        //   height: 5,
                        //   width: 90,
                        //   color: Colors.white,
                        // ),