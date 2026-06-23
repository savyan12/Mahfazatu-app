import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/theme/app_colors.dart';

class AuthLogoHeader extends StatelessWidget {
  const AuthLogoHeader({
    required this.title,
    this.subtitle,
    this.logoWidth = 104,
    this.titleTopPadding = 24,
    super.key,
  });

  final String title;
  final String? subtitle;
  final double logoWidth;
  final double titleTopPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.logo, width: logoWidth, fit: BoxFit.contain),
        SizedBox(height: titleTopPadding),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ],
    );
  }
}
