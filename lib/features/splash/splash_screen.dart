import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/brand_widgets.dart';
import '../auth/auth_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleOffset;
  late final Animation<double> _patternOpacity;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1900),
      vsync: this,
    )..forward();

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.08, 0.48, curve: Curves.easeOut),
    );
    _logoScale =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.82, end: 1.08), weight: 62),
          TweenSequenceItem(tween: Tween(begin: 1.08, end: 1), weight: 38),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.08, 0.70, curve: Curves.easeOutCubic),
          ),
        );
    _titleOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.42, 0.88, curve: Curves.easeOut),
    );
    _titleOffset = Tween<Offset>(begin: const Offset(0, 0.22), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.42, 0.88, curve: Curves.easeOutCubic),
          ),
        );
    _patternOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.62, 1, curve: Curves.easeOut),
    );
    _navigationTimer = Timer(const Duration(milliseconds: 2400), () {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final logoWidth = (screenSize.shortestSide * 0.36)
        .clamp(118.0, 164.0)
        .toDouble();

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final glow = math.sin(_controller.value * math.pi);

          return AppBackground.splash(
            glowIntensity: 0.35 + (glow * 0.65),
            patternOpacity: _patternOpacity.value,
            child: Align(
              alignment: const Alignment(0, 0.08),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Image.asset(
                        AppAssets.logo,
                        width: logoWidth,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FadeTransition(
                    opacity: _titleOpacity,
                    child: SlideTransition(
                      position: _titleOffset,
                      child: const GradientTitle(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
