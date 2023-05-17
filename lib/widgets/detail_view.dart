import 'package:flutter/material.dart';
import 'package:flutter_application_weather_app/models/weather_forecast_daily.dart';
import 'package:flutter_application_weather_app/utilities/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var pressure = forecastList![0].pressure! * 0.750062;
    var humidity = forecastList[0].humidity;
    var windSpeed = forecastList[0].speed;

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Util.getItem(FontAwesomeIcons.temperatureThreeQuarters,
              pressure.round(), "mm Hg"),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity!, "%"),
          Util.getItem(FontAwesomeIcons.wind, windSpeed!.toInt(), "m/s"),
        ],
      ),
    );
  }
}
