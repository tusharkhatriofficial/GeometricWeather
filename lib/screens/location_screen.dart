import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_glow/flutter_glow.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String weatherDescription;
  String weatherMain;
  double wind;
  int humidity;
  double visibility;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget
        .locationWeather); // using this widget.locationWeather we get hold of the locationWeather which is defined in class LocationScreen
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ErrorScreen();
        }));
      }
      temperature = weatherData['main']['temp'].floor();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
      weatherDescription = weatherData['weather'][0]['description'];
      weatherMain = weatherData['weather'][0]['main'];
      wind = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];
      visibility = weatherData['visibility']/1000;
      weatherMessage = weather.getMessage(temperature);
      print(temperature.floor());
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GlowContainer(height: MediaQuery.of(context).size.height -100,
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.only(top: 50,left: 30,right: 30),
            glowColor: Color(0xFF00A1FF).withOpacity(0.5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)
            ),
            color: Color(0xFF00A1FF),
            spreadRadius: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: Icon(Icons.refresh, color: Colors.white,),
                      onTap: () async {
                        try{

                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        }catch(e){
                          print(e);
                        }
                      },
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white,),
                          Text(' '+'$cityName',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white
                          ),
                          ),
                        ],
                      ),
                      GestureDetector(
                          child: Icon(
                            Icons.search, color: Colors.white,
                          ),
                        onTap: () async {
                            var typedCityName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                              return CityScreen();
                            }));
                            print(typedCityName);
                            if (typedCityName != null){
                                var weatherData = await weather.getCityWeather(
                                    typedCityName);
                                updateUI(weatherData);
                            }
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){},//TODO add the add functionality here
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Watch Add',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: 450,
                    child: Stack(
                      children: [
                        Image(image: AssetImage('$weatherIcon'),),
                        SizedBox(height: 450,),
                        Positioned(bottom: 0,left: 0,right: 0,
                        child: Center(
                          child: Column(
                            children: [
                              GlowText('$temperature',
                              style: TextStyle(
                                height: 0.1,
                                fontSize: 150,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                              ),
                              SizedBox(height: 10,),
                              Text('$weatherMain',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white
                                ),
                              ),
                              Text('$weatherDescription',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.white,),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //TODO first Item
                      Column(
                        children: [
                          Icon(CupertinoIcons.wind, color: Colors.white,),
                          SizedBox(height: 10,),
                          Text('$wind'+' Km/h',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white
                          ),
                          ),
                          SizedBox(height: 10,),
                          Text('Wind',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 16 //TODO
                            ),
                          )
                        ],
                      ),
                      //TODO secondItem
                      Column(
                        children: [
                          Icon(CupertinoIcons.drop, color: Colors.white,),
                          SizedBox(height: 10,),
                          Text('$humidity'+' %',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('Humidity',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 16 //TODO
                            ),
                          )
                        ],
                      ),
                      //TODO third item
                      Column(
                        children: [
                          Icon(CupertinoIcons.eye_fill, color: Colors.white,),
                          SizedBox(height: 10,),
                          Text('$visibility'+' Km',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text('Visibility',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 16 //TODO
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                    child: Image(image: AssetImage('images/weather_icons/backdrop.png',), height: 80,)),
                GlowText('By developersonline'),
                Align(
                    alignment: Alignment.centerRight,
                    child: Image(image: AssetImage('images/weather_icons/backdrop2.png',), height: 80,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF000B19),
//       body: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height - 140,
//
//         padding: EdgeInsets.only(top: 50, left: 30, right: 30),
//         decoration: new BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xFF15C0F6),
//               spreadRadius: 6,
//               blurRadius: 10,
//             ),
//             BoxShadow(
//               color: Color(0xFF15C0F6),
//               spreadRadius: -6,
//               blurRadius: 5,
//             )
//           ],
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
//           gradient: new LinearGradient(
//             colors: [
//               Color(0xFF116DF7),
//               Color(0xFF15C0F6),
//               // Color(0xFF7F7FD5),
//               // Color(0xFF86A8E7),
//               // Color(0xFF91EAE4),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             AppBar(
//               centerTitle: true,
//               title: Text(
//                   '$cityName',
//                 style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 22.0,
//                     color: Colors.white,
//                   fontWeight: FontWeight.bold
//                 )
//               ),
//               leading: Icon(Icons.refresh, size: 30.0,),
//               actions: [
//                 Icon(Icons.search, size: 30.0,),
//               ],
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//             ),
//             Row(
//               children: [
//                 Text('$temperature°c' ,
//                   style: kTempTextStyle,
//                 ),
//               ],
//             ),
//             Center(
//               child: Text(
//                 '$weatherIcon',
//                 style: TextStyle(
//                     fontSize: 200
//                 ),
//               ),
//             ),
//             Text('$weatherDescription',
//             style: kMessageTextStyle,
//             ),
//             SizedBox(),
//           ],
//         ),
//       ),//Here ends the first screen
//     );
//   }
// }


// Scaffold(
// body: Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage('images/location_background.jpg'),
// fit: BoxFit.cover,
// colorFilter: ColorFilter.mode(
// Colors.white.withOpacity(0.8), BlendMode.dstATop),
// ),
// ),
// constraints: BoxConstraints.expand(),
// child: SafeArea(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: <Widget>[
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// FlatButton(
// onPressed: () async {
// var weatherData = await weather.getLocationWeather();
// updateUI(weatherData);
// },
// child: Icon(
// Icons.refresh,
// size: 50.0,
// ),
// ),
// FlatButton(
// onPressed: () {
// Navigator.push(context, MaterialPageRoute(builder: (context){
// return CityScreen();
// }));
// },
// child: Icon(
// Icons.search,
// size: 50.0,
// ),
// ),
// ],
// ),
// Padding(
// padding: EdgeInsets.only(left: 15.0),
// child: Row(
// children: <Widget>[
// Text(
// '$temperature°',
// style: kTempTextStyle,
// ),
// Text(
// weatherIcon,
// style: kConditionTextStyle,
// ),
// ],
// ),
// ),
// Padding(
// padding: EdgeInsets.only(right: 15.0),
// child: Text(
// weatherMessage+" "+cityName,
// textAlign: TextAlign.right,
// style: kMessageTextStyle,
// ),
// ),
// ],
// ),
// ),
// ),
// );
