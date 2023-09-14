import 'dart:convert';

import 'package:location/location.dart';
import 'package:test_app/Utils/key.dart';
import 'package:test_app/models/forcast_result.dart';
import 'package:test_app/models/weather_result.dart';
import 'package:http/http.dart' as http;

class OpenWeatherMapClient {
  String apiKey = "585420bb3ae89fdadce65c77a0d76c34";

  Future<WeatherResult> getWeather(LocationData locationData) async {
    if (locationData.latitude != null && locationData.longitude != null) {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&units=metric&appid=$apiWeatherKey'));

      if (res.statusCode == 200) {
        return WeatherResult.fromJson(jsonDecode(res.body));
      } else {
        throw Exception("Bad request");
      }
    } else {
      throw Exception("Wrong Location ");
    }
  }

  Future<ForcastResult> getForcast(LocationData locationData) async {
    if (locationData.latitude != null && locationData.longitude != null) {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=${locationData.latitude}&lon=${locationData.longitude}&units=metric&appid=$apiWeatherKey'));

      if (res.statusCode == 200) {
        return ForcastResult.fromJson(jsonDecode(res.body));
      } else {
        throw Exception("Bad request");
      }
    } else {
      throw Exception("Wrong Location");
    }
  }
}
