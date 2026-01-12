import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/navigation_controller.dart';
import '../home/home_page.dart';
import '../applications/applications_page.dart';
import '../settings/settings_page.dart';

class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final nav = Get.put(NavigationController());

  final pages = [
    const HomePage(),
    const ApplicationsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Industrial Cobalt Palette
    const Color kPrimaryCobalt = Color(0xFF1A237E); 
    const Color kSoftGrey = Color(0xFF90A4AE);
    const Color kBgColor = Color(0xFFECEFF1);

    return Scaffold(
      backgroundColor: kBgColor,
      extendBody: true, // Content flows behind the curved dock
      body: Obx(() => pages[nav.index.value]),
      
      bottomNavigationBar: Obx(() {
        return Container(
          height: 110,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // The Glass Base Bar
              Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: kPrimaryCobalt.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSideItem(0, Icons.home_rounded, "HOME", nav.index.value, kPrimaryCobalt, kSoftGrey),
                        const SizedBox(width: 60), // Space for the floating center item
                        _buildSideItem(2, Icons.settings_suggest_rounded, "SETUP", nav.index.value, kPrimaryCobalt, kSoftGrey),
                      ],
                    ),
                  ),
                ),
              ),

              // The Floating Center "Apps" Button
              Positioned(
                bottom: 40, // High center position
                child: _buildCenterItem(1, Icons.grid_view_rounded, nav.index.value, kPrimaryCobalt),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Side Navigation Items (Home & Settings)
  Widget _buildSideItem(int index, IconData icon, String label, int currentIdx, Color active, Color inactive) {
    bool isSelected = currentIdx == index;
    return GestureDetector(
      onTap: () => nav.index.value = index,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? active : inactive,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: isSelected ? active : inactive,
            ),
          ),
        ],
      ),
    );
  }

  // The Elevated Center Item (Apps)
  Widget _buildCenterItem(int index, IconData icon, int currentIdx, Color active) {
    bool isSelected = currentIdx == index;
    return GestureDetector(
      onTap: () => nav.index.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        height: isSelected ? 75 : 65,
        width: isSelected ? 75 : 65,
        decoration: BoxDecoration(
          color: active,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: active.withOpacity(0.4),
              blurRadius: isSelected ? 20 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: isSelected ? 35 : 30,
        ),
      ),
    );
  }
}