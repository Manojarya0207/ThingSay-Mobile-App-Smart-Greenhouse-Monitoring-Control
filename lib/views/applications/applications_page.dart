import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import 'weather_app_page.dart';
import 'green_home_page.dart';

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(() => Scaffold(
      backgroundColor: theme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('APPLICATIONS', style: TextStyle(color: theme.primaryCobalt, fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 18)),
        actions: [IconButton(icon: Icon(Icons.search_rounded, color: theme.primaryCobalt), onPressed: () {})],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: theme.primaryCobalt.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text("Connected Devices", style: TextStyle(color: theme.primaryCobalt, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAppCard(theme, 'Weather App', 'Real-time local tracking', Icons.cloud_queue_rounded, theme.primaryCobalt, 
                () => Get.to(() => const WeatherAppPage()), 2),
                const SizedBox(height: 20),
                _buildAppCard(theme, 'Green Home', 'Smart eco-system control', Icons.eco_outlined, Colors.teal, () => Get.to(() => const GreenHomePage()), 2),
                
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    ));
  }

  Widget _buildAppCard(ThemeController theme, String title, String subtitle, IconData icon, Color color, VoidCallback onTap, int index) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))],
          border: Border.all(color: theme.cardColor.withOpacity(0.5), width: 2),
        ),
        child: Row(
          children: [
            Container(height: 60, width: 60, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(18)),
              child: Icon(icon, color: color, size: 30)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: theme.textColor, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: theme.subTextColor, fontSize: 13)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.subTextColor.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}