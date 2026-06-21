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
        const TransactionRow(
          title: 'كافيه ديوان',
          subtitle: 'أمس',
          amount: '+ \$50.00',
          positive: true,
          icon: Icons.credit_card_rounded,
        ),
        const SizedBox(height: 12),
        const TransactionRow(
          title: 'متجر الأجهزة',
          subtitle: 'اليوم',
          amount: '- \$120.00',
          positive: false,
          icon: Icons.remove_rounded,
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
