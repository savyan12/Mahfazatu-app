import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'home_feature_page.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickActionTile(
            icon: Icons.account_balance_wallet_outlined,
            label: 'تحويل مالي',
            onTap: () {
              openHomeFeaturePage(
                context,
                title: 'التحويل المالي',
                subtitle:
                    'واجهة التحويلات المالية أصبحت جاهزة للربط الحقيقي لاحقاً.',
                icon: Icons.account_balance_wallet_outlined,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickActionTile(
            icon: Icons.shopping_basket_outlined,
            label: 'عملية دفع',
            onTap: () {
              openHomeFeaturePage(
                context,
                title: 'عملية دفع',
                subtitle: 'هنا يمكن ربط الدفع المباشر أو فواتير المشتريات.',
                icon: Icons.shopping_basket_outlined,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickActionTile(
            icon: Icons.diamond_outlined,
            label: 'استبدال النقاط',
            onTap: () {
              openHomeFeaturePage(
                context,
                title: 'استبدال النقاط',
                subtitle:
                    'صفحة استبدال النقاط تحتاج ربطاً بخادم النقاط لاحقاً.',
                icon: Icons.diamond_outlined,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickActionTile(
            icon: Icons.savings_outlined,
            label: 'شحن الرصيد',
            onTap: () {
              openHomeFeaturePage(
                context,
                title: 'شحن الرصيد',
                subtitle:
                    'يمكن ربط هذا المسار بخدمة الشحن أو التحويل من البطاقة.',
                icon: Icons.savings_outlined,
              );
            },
          ),
        ),
      ],
    );
  }
}

class QuickActionTile extends StatelessWidget {
  const QuickActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.95,
      child: Material(
        color: AppColors.card.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.mint.withValues(alpha: 0.70),
                width: 1.2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.mint, size: 31),
                const SizedBox(height: 10),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.mint,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
