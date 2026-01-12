import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Timer timer;
  DateTime now = DateTime.now();
  final theme = Get.find<ThemeController>();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => now = DateTime.now());
    });
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: theme.bgColor,
      body: Stack(
        children: [
          Positioned(
            top: -100, left: -50,
            child: Container(width: 300, height: 300, 
              decoration: BoxDecoration(shape: BoxShape.circle, color: theme.primaryCobalt.withOpacity(0.04))),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('DASHBOARD', style: TextStyle(color: theme.primaryCobalt, letterSpacing: 2, fontWeight: FontWeight.w900)),
                      
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(color: theme.primaryCobalt.withOpacity(0.1), borderRadius: BorderRadius.circular(30)),
                          child: Text(['SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY'][now.weekday % 7],
                            style: TextStyle(color: theme.primaryCobalt, fontWeight: FontWeight.w800, letterSpacing: 3, fontSize: 12)),
                        ),
                        const SizedBox(height: 40),
                        ScaleTransition(
                          scale: _pulseAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(width: 290, height: 290,
                                child: CircularProgressIndicator(value: now.second / 60, strokeWidth: 3, color: theme.primaryCobalt, backgroundColor: theme.primaryCobalt.withOpacity(0.05))),
                              Container(
                                width: 250, height: 250,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: theme.cardColor,
                                  boxShadow: [BoxShadow(color: theme.primaryCobalt.withOpacity(0.1), blurRadius: 30, offset: const Offset(0, 15))],
                                  border: Border.all(color: theme.cardColor.withOpacity(0.5), width: 4)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}',
                                      style: TextStyle(fontSize: 72, fontWeight: FontWeight.w900, color: theme.textColor, letterSpacing: -2)),
                                    Text(now.second.toString().padLeft(2,'0'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: theme.primaryCobalt, letterSpacing: 2)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text('${now.day}.${now.month}.${now.year}', 
                          style: TextStyle(color: theme.textColor.withOpacity(0.6), fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}