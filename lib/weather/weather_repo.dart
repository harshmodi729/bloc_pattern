import 'package:http/http.dart';
import 'dart:convert';

import '../weather/weather_item.dart';

class WeatherRepo {
  Future<WeatherItem> getWeather(String city) async {
    final result = await get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?appid=43ea6baaad7663dc17637e22ee6f78f2&q=$city"));

    if (result.statusCode != 200) throw Exception();

    return parseResponse(result.body);
  }

  WeatherItem parseResponse(final response) {
    final jsonDecode = json.decode(response);
    WeatherItem item = WeatherItem.fromJson(jsonDecode);

    return item;
  }
}
