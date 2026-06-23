import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class FilterChipLabel extends StatelessWidget {
  const FilterChipLabel({required this.label, this.active = false, super.key});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = active ? AppColors.mint : Colors.transparent;
    final foregroundColor = active ? AppColors.card : AppColors.mint;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mint.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
