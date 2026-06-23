import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MarketplaceCategoryTile extends StatelessWidget {
  const MarketplaceCategoryTile({
    required this.label,
    required this.icon,
    this.active = false,
    this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = active ? AppColors.mint : Colors.transparent;
    final foregroundColor = active ? AppColors.card : AppColors.mint;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.mint.withValues(alpha: 0.55)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foregroundColor, size: 18),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: foregroundColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
