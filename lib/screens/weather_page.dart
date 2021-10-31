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
    //getDate();
    //print(date);
    updateUI(widget.weatherData);
  }

  var weatherDescription, weatherId, humidity, city;
  late int temp, feelslike;
  // String date = '';
  // void getDate() {
  //   var date = new DateTime.now().toString();
  //   var dateParse = DateTime.parse(date);
  //   var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  //   setState(() {
  //     date = formattedDate.toString();
  //   });
  // }

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
  //DateTime dateTime = DateTime().now();
  //dateTime.toIso8601String();

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
            padding: const EdgeInsets.all(15.0),
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
                    //height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Top Bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //City Name
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child:
                                      // IconButton(
                                      //   padding: EdgeInsets.zero,
                                      //   onPressed: () async {
                                      //     final cityName = await Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) => CityWeatherPage(),
                                      //       ),
                                      //     );
                                      //     if (cityName != null) {
                                      //       var jsonResponse = await WeatherProvider()
                                      //           .cityWeatherProvider(cityName);
                                      //       updateUI(jsonResponse);
                                      //     }
                                      //   },
                                      //icon:
                                      Icon(
                                    Icons.location_city_rounded,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                                //),
                                //Refresh Button
                                // SizedBox(
                                //   width: 60,
                                //   height: 60,
                                //   child: IconButton(
                                //     padding: EdgeInsets.zero,
                                //     onPressed: () async {
                                //       var jsonResponse = await WeatherProvider()
                                //           .locationWeatherProvider();
                                //       updateUI(jsonResponse);
                                //     },
                                //     icon: Icon(
                                //       Icons.refresh_rounded,
                                //       color: Colors.white,
                                //       size: 55,
                                //     ),
                                //   ),
                                // ),

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
                                                .cityWeatherProvider(cityName);
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
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "$city",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 26),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 80),
                            ),
                            Text(
                              capitalize(weatherDescription),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "Real Feel: $feelslike°",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "Humidity: $humidity%",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
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
