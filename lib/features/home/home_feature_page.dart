import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_controls.dart';

class HomeFeaturePage extends StatelessWidget {
  const HomeFeaturePage({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
            child: Column(
              children: [
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(AppAssets.logo, width: 58, fit: BoxFit.contain),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 98,
                  height: 98,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.card.withValues(alpha: 0.9),
                    border: Border.all(
                      color: AppColors.mint.withValues(alpha: 0.34),
                    ),
                  ),
                  child: Icon(icon, color: AppColors.mint, size: 46),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                PrimaryGradientButton(
                  label: 'العودة إلى الرئيسية',
                  onPressed: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openHomeFeaturePage(
  BuildContext context, {
  required String title,
  required String subtitle,
  IconData icon = Icons.grid_view_rounded,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) =>
          HomeFeaturePage(title: title, subtitle: subtitle, icon: icon),
    ),
  );
}
