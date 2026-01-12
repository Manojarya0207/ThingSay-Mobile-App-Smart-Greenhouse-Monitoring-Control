import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() => Scaffold(
      backgroundColor: theme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('SETTINGS', 
          style: TextStyle(color: theme.primaryCobalt, fontWeight: FontWeight.w900, letterSpacing: 2)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
              ),
              child: SwitchListTile(
                secondary: Icon(Icons.dark_mode_rounded, color: theme.primaryCobalt),
                title: Text('Dark Mode', style: TextStyle(color: theme.textColor, fontWeight: FontWeight.bold)),
                subtitle: Text('Industrial night theme', style: TextStyle(color: theme.subTextColor)),
                value: theme.isDark.value,
                activeColor: theme.primaryCobalt,
                onChanged: theme.toggle,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}