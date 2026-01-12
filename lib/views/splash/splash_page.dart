import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui';
import '../navigation/main_navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _blurAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Main entrance controller
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Subtle background pulse controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.2, 0.8, curve: Curves.easeIn)),
    );

    _blurAnimation = Tween<double>(begin: 15.0, end: 0.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutQuart),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutBack),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );

    _mainController.forward();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.offAll(
      () => MainNavigation(),
      transition: Transition.fade,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Static Premium Palette
    const Color kBgColor = Color(0xFFFDFCFB); 
    const Color kAccentColor = Color(0xFF6A8EAE); // Slate Blue
    const Color kSubtleColor = Color(0xFFE2E8F0);

    return Scaffold(
      backgroundColor: kBgColor,
      body: Stack(
        children: [
          // Background Decorative Elements (Static colors, animated scale)
          Positioned(
            top: -50,
            right: -50,
            child: ScaleTransition(
              scale: _pulseAnimation,
              child: _buildOrb(200, kSubtleColor.withOpacity(0.5)),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: ScaleTransition(
              scale: _pulseAnimation,
              child: _buildOrb(150, kAccentColor.withOpacity(0.1)),
            ),
          ),

          // Main Glass Content
          Center(
            child: AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: _blurAnimation.value,
                    sigmaY: _blurAnimation.value,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Frosted Glass Container
                          Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.spa_rounded,
                              size: 70,
                              color: kAccentColor,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Minimalist Brand Text
                          const Text(
                            'thingsay',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w200, // Light weight for "organic" feel
                              color: kAccentColor,
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Modern Dot Indicator
                          Container(
                            height: 4,
                            width: 20,
                            decoration: BoxDecoration(
                              color: kAccentColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}