import 'package:geolocator/geolocator.dart';
//this class uses geolocator to get the current location of the user.
class Location {
  var lattitude;
  var longitude;
  Future<void> getCurrentLocation() async {
    //check if location service are enabled
    //bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!isServiceEnabled) {
    //   //Geolocator.openLocationSettings();
    //   return Future.error("Location Service Disabled");
    // }
    //if permission denied
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission Denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are Permanently Denied");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    longitude = position.longitude;
    lattitude = position.latitude;
  }
}
