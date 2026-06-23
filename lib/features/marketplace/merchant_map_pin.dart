import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MerchantMapPin extends StatelessWidget {
  const MerchantMapPin({
    required this.icon,
    required this.accent,
    super.key,
  });

  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.5),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.backgroundBottom, size: 18),
    );
  }
}
