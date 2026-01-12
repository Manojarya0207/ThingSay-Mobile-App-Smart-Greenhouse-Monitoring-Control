import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'core/app_theme.dart';
import 'views/splash/splash_page.dart';

class ThingsSayApp extends StatelessWidget {
  const ThingsSayApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'thingssay',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
          home: const SplashPage(),
        ));
  }
}
