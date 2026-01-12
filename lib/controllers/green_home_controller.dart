import 'dart:async';
import 'package:get/get.dart';
import '../core/api_client.dart';
import '../models/green_home_model.dart';

class GreenHomeController extends GetxController {
  var isLoading = true.obs;
  var data = Rxn<GreenHomeModel>();

  var foggerOn = false.obs;
  var dripOn = false.obs;
  var exhaustOn = false.obs;

  Timer? timer;

  @override
  void onInit() {
    fetchData();
    timer = Timer.periodic(const Duration(seconds: 10), (_) => fetchData());
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      final json = await ApiClient.fetchGreenHome();
      final model = GreenHomeModel.fromJson(json);

      data.value = model;
      foggerOn.value = model.fogger == 'ON';
      dripOn.value = model.dripIrrigation == 'ON';
      exhaustOn.value = model.exhaustFan == 'ON';
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleFogger(bool value) async {
    await ApiClient.setFogger(value);
    fetchData();
  }

  Future<void> toggleDrip(bool value) async {
    await ApiClient.setDripIrrigation(value);
    fetchData();
  }

  Future<void> toggleExhaust(bool value) async {
    await ApiClient.setExhaustFan(value);
    fetchData();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
