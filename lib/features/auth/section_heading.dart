import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.title,
    required this.badgeText,
    super.key,
  });

  final String title;
  final String badgeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.mint.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            badgeText,
            style: const TextStyle(
              color: AppColors.card,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
