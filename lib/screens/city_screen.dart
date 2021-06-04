import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A1FF),
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.arrow_back_ios_rounded), onTap: (){Navigator.pop(context);},),
        elevation: 0,
        backgroundColor: Color(0xFF00A1FF),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Please enter a search term",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                      ),
                    ),
                    onChanged: (value){
                      cityName = value;
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shadowColor: Colors.black54
                  ),
                  child: Text(
                      "Search",
                    style: TextStyle(
                      color: Colors.black
                    ),
                    ),
                  onPressed: (){
                    Navigator.pop(context, cityName);
                  },//TODO search button
                ),
                SizedBox(height: 80,),
                Container(
                  height: 240,
                  child: Image(image: AssetImage(
                    'images/weather_icons/search.png',
                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
