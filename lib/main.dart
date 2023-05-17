import 'package:flutter/material.dart';
import 'package:flutter_application_weather_app/models/weather_forecast_daily.dart';
import 'package:flutter_application_weather_app/screens/location_screen.dart';
import 'screens/weather_forecast_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen(),
    );
  }
}
