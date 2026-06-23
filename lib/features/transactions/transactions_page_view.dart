import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/supabase/supabase_client.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/transaction_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/transaction_provider.dart';
import 'filter_chip_label.dart';
import 'summary_card.dart';
import 'transaction_card.dart';
import 'transaction_date_header.dart';

class TransactionsPageView extends ConsumerWidget {
  const TransactionsPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = SupabaseService.I.auth.currentUser;
    final userIdAsync = ref.watch(currentUserIdProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                  FilterChipLabel(label: 'الكل', active: true),
                  FilterChipLabel(label: 'تحويل'),
                  FilterChipLabel(label: 'شراء'),
                ],
              ),
              const SizedBox(height: 18),
              userIdAsync.when(
                data: (userId) =>
                    _TransactionList(userId: userId),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (_, _) => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'حدث خطأ في تحميل المعاملات',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.danger),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionList extends ConsumerWidget {
  final int userId;
  const _TransactionList({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider(userId));
    return transactionsAsync.when(
      data: (txns) => _buildTransactionList(txns),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, _) => const Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'حدث خطأ في تحميل المعاملات',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.danger),
        ),
      ),
    );
  }

  Widget _buildTransactionList(List<TransactionModel> txns) {
    if (txns.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'لا توجد معاملات بعد',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.mutedText),
        ),
      );
    }

    double totalExpense = 0;
    double totalIncome = 0;

    final today = DateTime.now();
    final todayStr = 'اليوم - ${today.day} ${_monthName(today.month)} ${today.year}';
    final yesterday = today.subtract(const Duration(days: 1));
    final yesterdayStr =
        'أمس - ${yesterday.day} ${_monthName(yesterday.month)} ${yesterday.year}';

    List<Widget> items = [];
    List<TransactionModel> todayTxns = [];
    List<TransactionModel> yesterdayTxns = [];
    List<TransactionModel> olderTxns = [];

    for (final txn in txns) {
      final isToday = _isSameDay(txn.transactionDate, today);
      final isYesterday = _isSameDay(txn.transactionDate, yesterday);

      if (isToday) {
        todayTxns.add(txn);
      } else if (isYesterday) {
        yesterdayTxns.add(txn);
      } else {
        olderTxns.add(txn);
      }

      if (txn.transactionType == TransactionType.transfer) {
        totalIncome += txn.amount;
      } else {
        totalExpense += txn.amount;
      }
    }

    if (todayTxns.isNotEmpty) {
      items.add(TransactionDateHeader(label: todayStr));
      items.add(const SizedBox(height: 12));
      for (final txn in todayTxns) {
        items.add(_buildTransactionCard(txn));
        items.add(const SizedBox(height: 10));
      }
    }

    if (yesterdayTxns.isNotEmpty) {
      items.add(TransactionDateHeader(label: yesterdayStr));
      items.add(const SizedBox(height: 12));
      for (final txn in yesterdayTxns) {
        items.add(_buildTransactionCard(txn));
        items.add(const SizedBox(height: 10));
      }
    }

    if (olderTxns.isNotEmpty) {
      items.add(const SizedBox(height: 16));
      for (final txn in olderTxns) {
        items.add(_buildTransactionCard(txn));
        items.add(const SizedBox(height: 10));
      }
    }

    items.add(const SizedBox(height: 16));
    items.add(
      Row(
        children: [
          Expanded(
            child: SummaryCard(
              title: 'إجمالي المصروف',
              value: '${totalExpense.toStringAsFixed(0)} LYD',
              icon: Icons.arrow_downward_rounded,
              accent: AppColors.danger,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SummaryCard(
              title: 'إجمالي الدخل',
              value: '${totalIncome.toStringAsFixed(0)} LYD',
              icon: Icons.arrow_upward_rounded,
              accent: AppColors.mint,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SummaryCard(
              title: 'عدد المعاملات',
              value: '${txns.length}',
              icon: Icons.receipt_long_rounded,
              accent: AppColors.sky,
            ),
          ),
        ],
      ),
    );

    return Column(children: items);
  }

  Widget _buildTransactionCard(TransactionModel txn) {
    final isPositive = txn.transactionType == TransactionType.transfer;
    return TransactionCard(
      title: _titleForType(txn.transactionType),
      subtitle: txn.notes ?? '',
      amount:
          '${isPositive ? '+' : '-'} ${txn.amount.toStringAsFixed(0)} LYD',
      time: '${txn.transactionDate.hour.toString().padLeft(2, '0')}:${txn.transactionDate.minute.toString().padLeft(2, '0')}',
      icon: _iconForType(txn.transactionType),
      positive: isPositive,
    );
  }

  String _titleForType(TransactionType type) {
    switch (type) {
      case TransactionType.transfer:
        return 'تحويل مالي';
      case TransactionType.payment:
        return 'عملية شراء';
    }
  }

  IconData _iconForType(TransactionType type) {
    switch (type) {
      case TransactionType.transfer:
        return Icons.swap_horiz_rounded;
      case TransactionType.payment:
        return Icons.shopping_cart_outlined;
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _monthName(int month) {
    const names = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return names[month - 1];
  }
}
