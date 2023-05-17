import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_weather_app/api/weather_api.dart';
import 'package:flutter_application_weather_app/screens/city_screen.dart';
import 'package:flutter_application_weather_app/widgets/city_view.dart';
import 'package:flutter_application_weather_app/widgets/temp_view.dart';
import 'package:flutter_application_weather_app/widgets/detail_view.dart';
import 'package:flutter_application_weather_app/widgets/bottom_list_view.dart';

import '../models/weather_forecast_daily.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherForecastScreen extends StatefulWidget {
  final WeatherForecast? locationWeather;
  const WeatherForecastScreen({Key? key, this.locationWeather})
      : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;

  late String _cityName;

  @override
  void initState() {
    super.initState();
    // forecastObject = WeatherApi().fetchWeatherForecast(cityName: _cityName);

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
      // forecastObject = WeatherApi().fetchWeatherForecast(cityName: '');
    }

    // forecastObject.then((weather) {
    //   log(weather.list![0].weather![0].main.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Weather forecast'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecast(cityName: "");
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_city),
            onPressed: () async {
              var tappedName = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return CityScreen();
              }));
              if (tappedName != null) {
                setState(() {
                  _cityName = tappedName;
                  forecastObject = WeatherApi()
                      .fetchWeatherForecast(cityName: _cityName, isCity: true);
                });
              }
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      CityView(snapshot: snapshot),
                      SizedBox(height: 50.0),
                      TempView(snapshot: snapshot),
                      SizedBox(height: 50.0),
                      DetailView(snapshot: snapshot),
                      SizedBox(height: 50.0),
                      BottomListView(snapshot: snapshot),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                      "city not found\nPlease, enter correct name of the city",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
