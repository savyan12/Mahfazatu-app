import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../redeem/redeem_points_screen.dart';

class PointsBanner extends StatelessWidget {
  final int points;
  const PointsBanner({this.points = 840, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardRaised.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).pushNamed(RedeemPointsScreen.routeName);
        },
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.mint,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  'اكتشف العروض',
                  style: TextStyle(
                    color: AppColors.card,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'لديك $points نقطة  استبدلها الآن',
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(AppAssets.logo, width: 24, height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
