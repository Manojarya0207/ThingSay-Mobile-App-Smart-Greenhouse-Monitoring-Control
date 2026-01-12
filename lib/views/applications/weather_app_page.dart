import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/weather_controller.dart';

class WeatherAppPage extends StatelessWidget {
  const WeatherAppPage({super.key});

  // --- Static Color Palette ---
  static const Color kPrimaryDark = Color(0xFF1A1F38); // Background
  static const Color kCardBackground = Color(0xFF252A4A); // Cards
  static const Color kShimmerBase = Color(0xFF252A4A); // Skeleton Base
  static const Color kShimmerHighlight = Color(0xFF383E66); // Skeleton Shine
  static const Color kAccentColor = Color(0xFFFDBB2D);
  static const Color kTextColor = Colors.white;
  static const Color kSecondaryText = Color(0xFFB0B3C7);
  static const Color kIconBg = Color(0xFF31385C);

  @override
  Widget build(BuildContext context) {
    final WeatherController controller =
        Get.put(WeatherController(), permanent: false);

    return Scaffold(
      backgroundColor: kPrimaryDark,
      appBar: AppBar(
        title: const Text('Weather Station',
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: kTextColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildSkeletonLoader();
        }

        final weather = controller.weather.value;
        if (weather == null) {
          return const Center(
            child: Text(
              'No weather data available',
              style: TextStyle(color: kSecondaryText),
            ),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section with Slide Down Animation
              FadeInAnimation(
                delay: 100,
                child: _buildHeroSection(weather),
              ),

              const SizedBox(height: 25),

              FadeInAnimation(
                delay: 200,
                child: const Text(
                  "DETAILS",
                  style: TextStyle(
                    color: kSecondaryText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Grid with Staggered Animation
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  FadeInAnimation(
                    delay: 300,
                    child: _infoCard(
                      title: 'Humidity',
                      value: '${weather.humidity} %',
                      icon: Icons.water_drop_outlined,
                      iconColor: Colors.blueAccent,
                    ),
                  ),
                  FadeInAnimation(
                    delay: 400,
                    child: _infoCard(
                      title: 'Pressure',
                      value: '${weather.pressure} hPa',
                      icon: Icons.speed,
                      iconColor: Colors.purpleAccent,
                    ),
                  ),
                  FadeInAnimation(
                    delay: 500,
                    child: _infoCard(
                      title: 'Light Level',
                      value: '${weather.lux} lux',
                      icon: Icons.light_mode_outlined,
                      iconColor: kAccentColor,
                    ),
                  ),
                  FadeInAnimation(
                    delay: 600,
                    child: _infoCard(
                      title: 'Wind Speed',
                      value: '${weather.windSpeed} m/s',
                      icon: Icons.air,
                      iconColor: Colors.tealAccent,
                    ),
                  ),
                  FadeInAnimation(
                    delay: 700,
                    child: _infoCard(
                      title: 'Direction',
                      value: weather.windDirection,
                      icon: Icons.explore_outlined,
                      iconColor: Colors.redAccent,
                    ),
                  ),
                  FadeInAnimation(
                    delay: 800,
                    child: _infoCard(
                      title: 'Wind Level',
                      value: weather.windLevel,
                      icon: Icons.flag_outlined,
                      iconColor: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  // --- SKELETON LOADING VIEW ---
  Widget _buildSkeletonLoader() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Skeleton
          const ShimmerWidget(height: 200, width: double.infinity, radius: 30),
          const SizedBox(height: 25),
          // Title Skeleton
          const ShimmerWidget(height: 15, width: 80, radius: 4),
          const SizedBox(height: 15),
          // Grid Skeleton
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => const ShimmerWidget(
              height: 100,
              width: double.infinity,
              radius: 24,
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeroSection(dynamic weather) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4C6EF5),
            Color(0xFF3B5BDB)
          ], // Static Blue Gradient
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C6EF5).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date and Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  weather.date,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                weather.time,
                style: const TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.thermostat, color: Colors.white, size: 40),
              const SizedBox(width: 10),
              Text(
                weather.temperature.toString(),
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '°C',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Current Temperature",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kIconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kSecondaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              color: kTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// --- HELPER CLASSES (Animations) ---

// 1. Custom Shimmer Widget (No external package needed)
class ShimmerWidget extends StatefulWidget {
  final double height;
  final double width;
  final double radius;

  const ShimmerWidget({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              colors: const [
                WeatherAppPage.kShimmerBase,
                WeatherAppPage.kShimmerHighlight,
                WeatherAppPage.kShimmerBase,
              ],
              stops: const [0.1, 0.3, 0.4],
              begin: const Alignment(-1.0, -0.3),
              end: const Alignment(1.0, 0.3),
              transform: _SlidingGradientTransform(
                  slidePercent: _controller.value),
            ),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

// 2. Fade In Animation Wrapper
class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final int delay;

  const FadeInAnimation({super.key, required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)), // Slide up effect
            child: child,
          ),
        );
      },
      child: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: delay)),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? child
              : const SizedBox(); // Wait for delay
        },
      ),
    );
  }
}