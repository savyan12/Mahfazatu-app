import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_controls.dart';
import '../transactions/transactions_screen.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          textDirection: TextDirection.ltr,
          children: [
            LinkText(
              text: 'عرض الكل ←',
              onTap: () {
                Navigator.of(context).pushNamed(TransactionsScreen.routeName);
              },
            ),
            const Spacer(),
            const Text(
              'آخر المعاملات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        TransactionRow(
          title: 'تحويل وارد',
          subtitle: 'اليوم',
          amount: '+ 1500 LYD',
          positive: true,
          icon: Icons.swap_horiz_rounded,
        ),
        const SizedBox(height: 12),
        TransactionRow(
          title: 'مشتريات سوبر ماركت',
          subtitle: 'أمس',
          amount: '- 234 LYD',
          positive: false,
          icon: Icons.shopping_cart_outlined,
        ),
        const SizedBox(height: 12),
        TransactionRow(
          title: 'فواتير',
          subtitle: '20/6/2026',
          amount: '- 120 LYD',
          positive: false,
          icon: Icons.receipt_long_outlined,
        ),
      ],
    );
  }
}

class TransactionRow extends StatelessWidget {
  const TransactionRow({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.positive,
    required this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final String amount;
  final bool positive;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final accentColor = positive ? AppColors.mint : AppColors.danger;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Text(
            amount,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: accentColor,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Column(
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
              const SizedBox(height: 3),
              Text(
                subtitle,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: 23),
          ),
          const SizedBox(width: 11),
          Container(
            width: 4,
            height: 46,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
