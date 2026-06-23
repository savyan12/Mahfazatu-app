import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SelectionField extends StatelessWidget {
  const SelectionField({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.mint.withValues(alpha: 0.62)),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 22,
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.badge_outlined, color: AppColors.mint, size: 20),
        ],
      ),
    );
  }
}
