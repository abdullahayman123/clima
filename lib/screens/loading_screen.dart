import 'package:clima/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_screen.dart';
import 'package:http/http.dart';
import 'dart:convert';
const apikeys = '177b29835ff81c62ac0898f33df89505';
double longtude ;
double latitude;
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

void getlocation() async {
  Location l1 = Location();
  await l1.getcurrentlocation();
  latitude = l1.latitude;
  longtude = l1.longtude;
  getdata();
}

void getdata() async {
  Response response = await get(
      'https://samples.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtude&appid=$apikeys');
  if (response.statusCode == 200) {
    String data = response.body;
    var main1 = jsonDecode(data)['main']['temp'];
    print(main1);
    var weather = jsonDecode(data)['weather'][0]['id'];
    print(weather);
    var city = jsonDecode(data)['name'];
    print(city);
  } else
    print(response.statusCode);
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    print('this line of code is trigged ');
    getlocation();
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getlocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
