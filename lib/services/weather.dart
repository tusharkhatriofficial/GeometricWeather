import '../services/location.dart';
import 'package:clima/services/networking.dart';
String apiKey = '1b452766cd8d01ddcfb4a3500331dce5';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(url: 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=1b452766cd8d01ddcfb4a3500331dce5&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    // latitude = location.latitude;
    // longitude = location.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        url:
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'images/weather_icons/thunder.png';
    } else if (condition < 400) {
      return 'images/weather_icons/dizzle.png';
    } else if (condition < 600) {
      return 'images/weather_icons/rainy.png';
    } else if (condition < 700) {
      return 'images/weather_icons/snow.png';
    } else if (condition < 800) {
      return 'images/weather_icons/mist.png';
    } else if (condition == 800) {
      return 'images/weather_icons/sunny.png';
    } else if (condition <= 804) {
      return 'images/weather_icons/cloudy.png';
    } else {
      return 'images/weather_icons/shrug.png';
    }
  }
  // String getWeatherIcon(int condition) {
  //   if (condition < 300) {
  //     return '🌩';
  //   } else if (condition < 400) {
  //     return '🌧';
  //   } else if (condition < 600) {
  //     return '☔️';
  //   } else if (condition < 700) {
  //     return '☃️';
  //   } else if (condition < 800) {
  //     return '🌫';
  //   } else if (condition == 800) {
  //     return '☀️';
  //   } else if (condition <= 804) {
  //     return '☁️';
  //   } else {
  //     return '🤷‍';
  //   }
  // }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
