import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SettingsActionTile extends StatelessWidget {
  const SettingsActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: AppColors.mint, size: 24),
          trailing: const Icon(Icons.chevron_left_rounded, color: Colors.white),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, color: Color(0x1A8BE3B4)),
      ],
    );
  }
}
