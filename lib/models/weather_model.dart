class WeatherModel {
  final String date;
  final String time;
  final String temperature;
  final String humidity;
  final String pressure;
  final String lux;
  final String windSpeed;
  final String windDirection;
  final String windLevel;     
      
  WeatherModel({
    required this.date,   
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.lux,
    required this.windSpeed,
    required this.windDirection,
    required this.windLevel,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      temperature: json['temperature'] ?? '',
      humidity: json['humidity'] ?? '',
      pressure: json['pressure'] ?? '',
      lux: json['lux'] ?? '',
      windSpeed: json['wind_speed'] ?? '',
      windDirection: json['wind_direction'] ?? '',
      windLevel: json['wind_level'] ?? '',
    );
  }
}
