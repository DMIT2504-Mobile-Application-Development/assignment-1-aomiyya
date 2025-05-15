import 'dart:convert';
import 'package:http/http.dart' as http;

const weatherApiKey = '6409e49730290a446ecac59662045f3b';

const currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

Future<dynamic> getWeatherForCity({required String city}) async {
  final res = await http.get(Uri.parse('${currentWeatherEndpoint}?units=metric&q=${city}&appid=$weatherApiKey'));
  final data = jsonDecode(res.body);
  return data;
}