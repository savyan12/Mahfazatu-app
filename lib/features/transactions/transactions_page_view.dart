import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class TransactionsPageView extends StatelessWidget {
  const TransactionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 124),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.card.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'المعاملات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.card.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: const Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Icon(Icons.tune_rounded, color: AppColors.mint),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'بحث عن معاملة',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.mutedText,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.search_rounded, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  _FilterChipLabel(label: 'الكل', active: true),
                  _FilterChipLabel(label: 'شحن'),
                  _FilterChipLabel(label: 'تحويل'),
                  _FilterChipLabel(label: 'شراء'),
                  _FilterChipLabel(label: 'استبدال نقاط'),
                ],
              ),
              const SizedBox(height: 18),
              const _TransactionDateHeader(label: 'اليوم - 24 مايو 2024'),
              const SizedBox(height: 12),
              const _TransactionCard(
                title: 'شحن محفظة',
                subtitle: 'شحن الرصيد من بطاقة مدى',
                amount: '+\$500.00',
                time: '10:30 م',
                icon: Icons.outbox_rounded,
                positive: true,
              ),
              const SizedBox(height: 10),
              const _TransactionCard(
                title: 'استبدال نقاط',
                subtitle: 'استبدال نقاط بمبلغ نقدي',
                amount: '-100 نقطة',
                time: '09:15 م',
                icon: Icons.hexagon_outlined,
                positive: true,
              ),
              const SizedBox(height: 10),
              const _TransactionCard(
                title: 'تحويل مالي',
                subtitle: 'تحويل إلى حساب محمد',
                amount: '-\$250.00',
                time: '08:45 م',
                icon: Icons.swap_horiz_rounded,
                positive: false,
              ),
              const SizedBox(height: 10),
              const _TransactionCard(
                title: 'عملية شراء',
                subtitle: 'شراء من متجر إلكتروني',
                amount: '-\$120.00',
                time: '07:20 م',
                icon: Icons.shopping_cart_outlined,
                positive: false,
              ),
              const SizedBox(height: 16),
              const _TransactionDateHeader(label: 'أمس - 23 مايو 2024'),
              const SizedBox(height: 12),
              const _TransactionCard(
                title: 'شحن محفظة',
                subtitle: 'شحن عبر التحويل البنكي',
                amount: '+\$300.00',
                time: '11:40 م',
                icon: Icons.outbox_rounded,
                positive: true,
              ),
              const SizedBox(height: 10),
              const _TransactionCard(
                title: 'استبدال نقاط',
                subtitle: 'استبدال نقاط مقابل نقدي',
                amount: '-200 نقطة',
                time: '06:30 م',
                icon: Icons.hexagon_outlined,
                positive: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(
                    child: _SummaryCard(
                      title: 'إجمالي المصروف',
                      value: '\$370.00',
                      icon: Icons.arrow_downward_rounded,
                      accent: AppColors.danger,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _SummaryCard(
                      title: 'إجمالي الدخل',
                      value: '\$800.00',
                      icon: Icons.arrow_upward_rounded,
                      accent: AppColors.mint,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _SummaryCard(
                      title: 'عدد المعاملات',
                      value: '12',
                      icon: Icons.receipt_long_rounded,
                      accent: AppColors.sky,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionDateHeader extends StatelessWidget {
  const _TransactionDateHeader({required this.label});

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

class _FilterChipLabel extends StatelessWidget {
  const _FilterChipLabel({required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = active ? AppColors.mint : Colors.transparent;
    final foregroundColor = active ? AppColors.card : AppColors.mint;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mint.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  const _TransactionCard({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.icon,
    required this.positive,
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 14),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 24),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
