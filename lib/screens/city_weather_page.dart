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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   height: 20,
                // ),
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
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      color: Colors.blue,
                    ),
                    //icon: Icon(Icons.location_city),
                    //focusColor: Color(0xff008080),
                    //hoverColor: Color(0xff008080),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue[200],
                          elevation: 10,
                          minimumSize: Size(160, 50)),
                      onPressed: () {
                        Navigator.pop(context,
                            _cityname); // the name of the city is passed back to the previous page
                      },
                      child: Text(
                        'Get Weather',
                        style: TextStyle(
                          color: Colors.blueGrey[900],
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
