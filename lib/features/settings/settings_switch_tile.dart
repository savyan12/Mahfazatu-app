import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SettingsSwitchTile extends StatelessWidget {
  const SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.mint, size: 24),
          trailing: Switch.adaptive(
            value: value,
            activeTrackColor: AppColors.mint,
            onChanged: onChanged,
          ),
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
        const Divider(height: 1, thickness: 1, color: Color(0x1A8BE3B4)),
      ],
    );
  }
}
