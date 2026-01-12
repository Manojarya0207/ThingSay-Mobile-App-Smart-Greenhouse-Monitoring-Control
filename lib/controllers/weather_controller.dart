import 'dart:async';
import 'package:get/get.dart';
import '../core/api_client.dart';
import '../models/weather_model.dart';

class WeatherController extends GetxController {
  var isLoading = true.obs;
  var weather = Rxn<WeatherModel>();
  Timer? timer;

  @override
  void onInit() {
    fetchWeather();
    timer = Timer.periodic(const Duration(seconds: 10), (_) => fetchWeather());
    super.onInit();
  }

  Future<void> fetchWeather() async {
    try {
      isLoading(true);
      final data = await ApiClient.fetchWeather();
      weather.value = WeatherModel.fromJson(data);
    } catch (e) {
      Get.snackbar('Error', 'Unable to load weather data');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
