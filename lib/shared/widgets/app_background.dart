import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/theme/app_colors.dart';

enum AppBackgroundStyle { splash, dark }

class AppBackground extends StatelessWidget {
  const AppBackground.splash({
    required this.child,
    this.glowIntensity = 0.6,
    this.patternOpacity = 0.1,
    super.key,
  }) : style = AppBackgroundStyle.splash;

  const AppBackground.dark({required this.child, super.key})
    : glowIntensity = 0,
      patternOpacity = 0,
      style = AppBackgroundStyle.dark;

  final Widget child;
  final AppBackgroundStyle style;
  final double glowIntensity;
  final double patternOpacity;

  @override
  Widget build(BuildContext context) {
    final isSplash = style == AppBackgroundStyle.splash;
    final screenSize = MediaQuery.sizeOf(context);

    return ColoredBox(
      color: isSplash
          ? AppColors.splashBackgroundBottom
          : AppColors.backgroundBottom,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (isSplash) ...[
            CustomPaint(painter: SplashGlowPainter(intensity: glowIntensity)),
            Positioned(
              left: 0,
              right: 0,
              bottom: -8,
              height: math.max(128, screenSize.height * 0.18),
              child: Opacity(
                opacity: patternOpacity,
                child: const LogoPattern(assetPath: AppAssets.logo),
              ),
            ),
          ],
          if (!isSplash)
            const DecoratedBox(
              decoration: BoxDecoration(color: AppColors.backgroundBottom),
            ),
          child,
        ],
      ),
    );
  }
}

class LogoPattern extends StatelessWidget {
  const LogoPattern({required this.assetPath, super.key});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRect(
        child: OverflowBox(
          minWidth: 0,
          maxWidth: double.infinity,
          minHeight: 0,
          maxHeight: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 15,
            runSpacing: 8,
            children: List.generate(84, (index) {
              final opacity = index.isEven ? 0.11 : 0.065;

              return Transform.rotate(
                angle: -0.08,
                child: Opacity(
                  opacity: opacity,
                  child: Image.asset(
                    assetPath,
                    width: 26,
                    height: 28,
                    fit: BoxFit.contain,
                    color: AppColors.mint,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class SplashGlowPainter extends CustomPainter {
  const SplashGlowPainter({required this.intensity});

  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final primaryGlow = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.teal.withValues(alpha: 0.18 * intensity),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.45, size.height * 0.50),
              radius: size.shortestSide * 0.72,
            ),
          );

    final topGlow = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.sky.withValues(alpha: 0.10 * intensity),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.58, -size.height * 0.08),
              radius: size.shortestSide * 0.58,
            ),
          );

    canvas.drawRect(Offset.zero & size, primaryGlow);
    canvas.drawRect(Offset.zero & size, topGlow);
  }

  @override
  bool shouldRepaint(covariant SplashGlowPainter oldDelegate) {
    return oldDelegate.intensity != intensity;
  }
}
