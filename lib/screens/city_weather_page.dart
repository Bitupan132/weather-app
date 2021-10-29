import 'package:flutter/material.dart';

class CityWeatherPage extends StatefulWidget {
  const CityWeatherPage({Key? key}) : super(key: key);

  @override
  _CityWeatherPageState createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  late String _cityname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/city_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), BlendMode.dstATop),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    _cityname = value;
                  },
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    hintText: 'Enter City Name',
                    fillColor: Color(0xffFFFFFF),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      //color: Colors.green,
                    ),
                    //icon: Icon(Icons.location_city),
                    //focusColor: Color(0xff008080),
                    //hoverColor: Color(0xff008080),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white12),
                      onPressed: () {
                        Navigator.pop(context, _cityname);
                      },
                      child: Text(
                        'Get Weather',
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// TextFormField(
//   onChanged: (value) {
//     _cityname = value;
//   },
//   style: TextStyle(
//     fontSize: 20,
//   ),
//   textAlign: TextAlign.center,
//   //initialValue: "London",
//   decoration: InputDecoration(
//     hintText: "Enter City Name",
//     icon: Icon(
//       Icons.location_city_outlined,
//       //color: Colors.white,
//     ),
//     hintStyle: TextStyle(color: Colors.white54),
//   ),
//   cursorColor: Color(0xff008080),
// ),
