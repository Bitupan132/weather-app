class ProvideImage {
  final int weatherId;

  ProvideImage(this.weatherId);
  String getImagePath() {
    //default
    String imagePath = 'images/location_background.png';
    //thunderstorm
    if (weatherId >= 200 && weatherId < 300) {
      imagePath = 'images/thunderstorm.png';
    }
    //Drizzle
    else if (weatherId >= 300 && weatherId < 400) {
      imagePath = 'images/rain.png';
    }
    //Rain
    else if (weatherId >= 500 && weatherId < 600) {
      imagePath = 'images/rain.png';
    }
    //snow
    else if (weatherId >= 600 && weatherId < 700) {
      imagePath = 'images/snow.jpg';
    }

    //clear
    else if (weatherId == 800) {
      imagePath = 'images/clear.png';
    }
    //overcast
    else if (weatherId == 804) {
      imagePath = 'images/cloudy.png';
    }
    //cloudy
    else if (weatherId > 800 && weatherId < 804) {
      imagePath = 'images/cloudy.png';
    }
    return imagePath;
  }
}
