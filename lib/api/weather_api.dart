import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_weather_app/models/weather_forecast_daily.dart';
import '../utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_weather_app/utilities/locations.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      {required String cityName, bool? isCity}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String> parameters;

    if (isCity == true) {
      var queryParametrs = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
      };

      parameters = queryParametrs;
    } else {
      var queryParametrs = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };

      parameters = queryParametrs;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, parameters);

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    log('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Future.error('Error response');
    }
  }
}
