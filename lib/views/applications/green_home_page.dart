import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // Ensure this is in your pubspec.yaml
import '../../controllers/green_home_controller.dart';

class GreenHomePage extends StatelessWidget {
  const GreenHomePage({super.key});

  // --- Premium Aesthetic Palette ---
  static const Color spaceBlack = Color(0xFF0D1B1E); // Deep Background
  static const Color emeraldNeon = Color(0xFF00FF88); // Primary Accent
  static const Color darkSlate = Color(0xFF1B2D2F); // Card Background
  static const Color mutedText = Color(0xFF94A3B8); // Subtitles
  static const Color glassWhite = Color(0x1AFFFFFF); // Border/Glass effect

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GreenHomeController());

    return Scaffold(
      backgroundColor: spaceBlack,
      appBar: AppBar(
        backgroundColor: spaceBlack,
        elevation: 0,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GreenHome',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            Text('Live System Dashboard',
                style: TextStyle(color: emeraldNeon, fontSize: 11, letterSpacing: 1.2)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => controller.fetchData(),
            icon: const Icon(Icons.sync_rounded, color: emeraldNeon),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        color: emeraldNeon,
        backgroundColor: darkSlate,
        onRefresh: () async => await controller.fetchData(),
        child: Obx(() {
          // --- Skeleton Loading State ---
          if (controller.isLoading.value) {
            return _buildSkeletonLoading();
          }

          final d = controller.data.value;
          if (d == null) {
            return _buildEmptyState(controller);
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              _sectionHeader('Atmospheric'),
              _buildBentoRow([
                _statBox('Temp', '${d.temperature}°', Icons.thermostat_rounded, Colors.orangeAccent),
                _statBox('Humidity', '${d.humidity}%', Icons.water_drop_rounded, Colors.cyanAccent),
              ]),
              const SizedBox(height: 12),
              _buildBentoRow([
                _statBox('CO2', '${d.co2}', Icons.air_rounded, emeraldNeon),
                _statBox('Pressure', d.pressure, Icons.speed, Colors.amberAccent),
              ]),
              
              _sectionHeader('Soil Composition'),
              _buildBentoRow([
                _statBox('Soil Temp', '${d.soilTemp}°', Icons.sensors, Colors.deepOrangeAccent),
                _statBox('Moisture', '${d.soilHumidity}%', Icons.grass_rounded, Colors.lightGreenAccent),
              ]),

              _sectionHeader('Hardware Controls'),
              _controlCard('Fogger Unit', controller.foggerOn.value, 
                  controller.toggleFogger, Icons.cloud_circle_outlined),
              _controlCard('Drip System', controller.dripOn.value, 
                  controller.toggleDrip, Icons.opacity_rounded),
              _controlCard('Exhaust Fan', controller.exhaustOn.value, 
                  controller.toggleExhaust, Icons.cyclone),
              
              const SizedBox(height: 30),
            ],
          );
        }),
      ),
    );
  }

  // --- UI Components ---

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12, left: 4),
      child: Text(title.toUpperCase(),
          style: const TextStyle(
              color: mutedText, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2)),
    );
  }

  Widget _buildBentoRow(List<Widget> children) {
    return Row(
      children: children.map((child) => Expanded(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: child,
      ))).toList(),
    );
  }

  Widget _statBox(String label, String value, IconData icon, [Color accent = emeraldNeon]) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: darkSlate,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: glassWhite, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 28),
          const SizedBox(height: 15),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: mutedText, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _controlCard(String title, bool isOn, Function(bool) toggle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isOn ? emeraldNeon.withOpacity(0.05) : darkSlate,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isOn ? emeraldNeon.withOpacity(0.5) : glassWhite),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: isOn ? emeraldNeon : mutedText),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        subtitle: Text(isOn ? 'ACTIVE' : 'STANDBY', 
            style: TextStyle(color: isOn ? emeraldNeon : mutedText, fontSize: 10, fontWeight: FontWeight.bold)),
        value: isOn,
        activeColor: emeraldNeon,
        onChanged: toggle,
      ),
    );
  }

  // --- Skeleton Loading Animation ---

  Widget _buildSkeletonLoading() {
    return Shimmer.fromColors(
      baseColor: darkSlate,
      highlightColor: const Color(0xFF2D3E40),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _skeletonHeader(),
          _skeletonGridRow(),
          const SizedBox(height: 12),
          _skeletonGridRow(),
          _skeletonHeader(),
          _skeletonControlCard(),
          _skeletonControlCard(),
        ],
      ),
    );
  }

  Widget _skeletonHeader() => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 12, width: 100,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      );

  Widget _skeletonGridRow() => Row(
        children: [
          Expanded(child: Container(height: 120, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)))),
          Expanded(child: Container(height: 120, margin: const EdgeInsets.symmetric(horizontal: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)))),
        ],
      );

  Widget _skeletonControlCard() => Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 80,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      );

  Widget _buildEmptyState(GreenHomeController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded, size: 64, color: mutedText.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text('Connection Lost', style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => controller.fetchData(),
            child: const Text('RETRY SYNC', style: TextStyle(color: emeraldNeon)),
          )
        ],
      ),
    );
  }
}