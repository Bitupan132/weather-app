import 'package:flutter/material.dart';
import 'package:weather_app/helper/weather_provider.dart';
import 'package:weather_app/screens/weather_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getLocationAndWeather() async {
    var jsonResponse = await WeatherProvider().locationWeatherProvider();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WeatherPage(jsonResponse)));
  }

  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Container(child: Center(child: SpinKitPouringHourGlassRefined(color: Colors.orange,size: 90.0,),),),
      body: Container(
        child: Center(
          child: Image.asset('icons/splash_icon.png'),
          // SpinKitFadingFour(
          //   color: Colors.black,
          //   size: 80,
          // ),
        ),
      ),
    );
  }
}
