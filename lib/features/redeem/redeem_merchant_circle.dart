import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class RedeemMerchantCircle extends StatelessWidget {
  const RedeemMerchantCircle({
    required this.name,
    required this.icon,
    this.active = false,
    super.key,
  });

  final String name;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? AppColors.mint.withValues(alpha: 0.18)
                  : AppColors.card.withValues(alpha: 0.82),
              border: Border.all(
                color: active
                    ? AppColors.mint
                    : AppColors.cardBorder,
                width: active ? 2 : 1.2,
              ),
            ),
            child: Icon(
              icon,
              color: active ? AppColors.mint : AppColors.mutedText,
              size: 26,
            ),
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: active ? AppColors.mint : AppColors.mutedText,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
