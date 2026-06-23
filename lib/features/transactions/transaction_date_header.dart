import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class TransactionDateHeader extends StatelessWidget {
  const TransactionDateHeader({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: AppColors.mutedText,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
