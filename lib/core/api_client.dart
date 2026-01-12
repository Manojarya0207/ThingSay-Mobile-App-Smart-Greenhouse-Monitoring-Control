import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  // Base URL
  static const String baseUrl = 'https://gttc.thingsay.com/student';

  // ------------------- DATA APIs -------------------

  static const String weatherUrl =
      '$baseUrl/weather/data/GTTC-MAGADI';

  static const String greenHomeUrl =
      '$baseUrl/greenhouse/data/GTTC-MAGADI';

  static Future<Map<String, dynamic>> fetchWeather() async {
    final response = await http.get(Uri.parse(weatherUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Weather API error');
    }
  }

  static Future<Map<String, dynamic>> fetchGreenHome() async {
    final response = await http.get(Uri.parse(greenHomeUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Green Home API error');
    }
  }

  // ------------------- CONTROL APIs (POST) -------------------

  static Future<void> setFogger(bool on) async {
    final url =
        '$baseUrl/greenhouse/control/GTTC-MAGADI/fogger/${on ? "ON" : "OFF"}';
    await http.post(Uri.parse(url));
  }

  static Future<void> setDripIrrigation(bool on) async {
    final url =
        '$baseUrl/greenhouse/control/GTTC-MAGADI/drip_irrigation/${on ? "ON" : "OFF"}';
    await http.post(Uri.parse(url));
  }

  static Future<void> setExhaustFan(bool on) async {
    final url =
        '$baseUrl/greenhouse/control/GTTC-MAGADI/exhaust_fan/${on ? "ON" : "OFF"}';
    await http.post(Uri.parse(url));
  }
}
