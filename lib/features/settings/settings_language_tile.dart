import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SettingsLanguageTile extends StatelessWidget {
  const SettingsLanguageTile({
    required this.value,
    required this.onTap,
    super.key,
  });

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: const Icon(
            Icons.language_rounded,
            color: AppColors.mint,
            size: 24,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.mint,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_left_rounded, color: Colors.white),
            ],
          ),
          title: const Text(
            'اللغة',
            textAlign: TextAlign.right,
            style: TextStyle(
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
