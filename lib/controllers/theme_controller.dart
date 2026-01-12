import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  void toggle(bool value) => isDark.value = value;

  // Industrial Cobalt Palette Logic
  Color get primaryCobalt => const Color(0xFF1A237E);
  Color get bgColor => isDark.value ? const Color(0xFF121212) : const Color(0xFFECEFF1);
  Color get cardColor => isDark.value ? const Color(0xFF1E1E1E) : Colors.white;
  Color get textColor => isDark.value ? Colors.white : const Color(0xFF263238);
  Color get subTextColor => isDark.value ? Colors.white70 : Colors.grey.shade500;
}