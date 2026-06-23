import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(children: children),
    );
  }
}
