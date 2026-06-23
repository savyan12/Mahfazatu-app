import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.icon,
    required this.positive,
    super.key,
  });

  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final IconData icon;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    final accent = positive ? AppColors.mint : AppColors.danger;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.card.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: const Text(
                        'مكتملة',
                        style: TextStyle(
                          color: AppColors.mint,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: accent,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.mint,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
