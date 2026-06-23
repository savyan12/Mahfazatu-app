import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MarketplaceStoreCard extends StatelessWidget {
  const MarketplaceStoreCard({
    required this.name,
    required this.category,
    this.rating,
    required this.distance,
    required this.icon,
    required this.accent,
    super.key,
  });

  final String name;
  final String category;
  final String? rating;
  final String distance;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
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
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent, size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
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
                    if (rating != null)
                      Text(
                        rating!,
                        style: const TextStyle(
                          color: AppColors.mint,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    Text(
                      distance,
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
          const SizedBox(width: 8),
          const Icon(Icons.chevron_left_rounded, color: Colors.white),
        ],
      ),
    );
  }
}
