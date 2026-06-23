import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/transaction_model.dart';
import '../../shared/widgets/app_controls.dart';
import '../transactions/transactions_screen.dart';

class TransactionsSection extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionsSection({this.transactions = const [], super.key});

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
        if (transactions.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'لا توجد معاملات بعد',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mutedText),
            ),
          )
        else
          ...transactions.map((txn) {
            final isPositive = txn.transactionType == TransactionType.transfer;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TransactionRow(
                title: txn.notes ?? txn.transactionType.name,
                subtitle: _formatDate(txn.transactionDate),
                amount:
                    '${isPositive ? '+' : '-'} ${txn.amount.toStringAsFixed(0)} LYD',
                positive: isPositive,
                icon: _iconForType(txn.transactionType),
              ),
            );
          }),
      ],
    );
  }

  IconData _iconForType(TransactionType type) {
    switch (type) {
      case TransactionType.transfer:
        return Icons.swap_horiz_rounded;
      case TransactionType.payment:
        return Icons.shopping_cart_outlined;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'اليوم';
    if (diff.inDays == 1) return 'أمس';
    return '${date.day}/${date.month}/${date.year}';
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
