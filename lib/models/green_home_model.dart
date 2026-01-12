class GreenHomeModel {
  final String temperature;
  final String humidity;
  final String co2;
  final String soilTemp;
  final String soilHumidity;
  final String moisture;
  final String pressure;
  final String pH;
  final String soilConduct;
  final String nitrogen;
  final String phosphorus;
  final String potassium;

  final String dripIrrigation;
  final String exhaustFan;
  final String fogger;
  final int waterLevel;

  GreenHomeModel({
    required this.temperature,
    required this.humidity,
    required this.co2,
    required this.soilTemp,
    required this.soilHumidity,
    required this.moisture,
    required this.pressure,
    required this.pH,
    required this.soilConduct,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.dripIrrigation,
    required this.exhaustFan,
    required this.fogger,
    required this.waterLevel,
  });

  factory GreenHomeModel.fromJson(Map<String, dynamic> json) {
    return GreenHomeModel(
      temperature: json['temp'] ?? '',
      humidity: json['humi'] ?? '',
      co2: json['co2'] ?? '',
      soilTemp: json['soil_temp'] ?? '',
      soilHumidity: json['soil_humi'] ?? '',
      moisture: json['moisture'] ?? '',
      pressure: json['pressure'] ?? '',
      pH: json['pH'] ?? '',
      soilConduct: json['soil_conduct'] ?? '',
      nitrogen: json['N'] ?? '',
      phosphorus: json['P'] ?? '',
      potassium: json['K'] ?? '',
      dripIrrigation: json['drip_irrigation'] ?? 'OFF',
      exhaustFan: json['exhaust_fan'] ?? 'OFF',
      fogger: json['fogger'] ?? 'OFF',
      waterLevel: json['water_level'] ?? 0,
    );
  }
}
