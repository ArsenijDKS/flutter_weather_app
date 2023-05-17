import 'package:flutter/material.dart';
import 'package:flutter_application_weather_app/models/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const TempView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var icon = forecastList![0].getIconUrl();
    var temp = forecastList[0].temp!.day!.toStringAsFixed(0);
    var desciption = forecastList[0].weather![0].description!.toUpperCase();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            icon,
            scale: 0.8,
            color: Colors.black,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Text(
                "$temp C",
                style: TextStyle(
                  fontSize: 54.0,
                  color: Colors.black,
                ),
              ),
              Text("$desciption",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
