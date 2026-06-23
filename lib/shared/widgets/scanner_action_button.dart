import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ScannerActionButton extends StatelessWidget {
  const ScannerActionButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.cardRaised.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
