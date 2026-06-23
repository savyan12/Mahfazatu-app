import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../data/transaction.dart';
import '../notifications/notifications_page_view.dart';
import 'filter_chip_label.dart';
import 'summary_card.dart';
import 'transaction_card.dart';
import 'transaction_date_header.dart';

class TransactionsPageView extends StatefulWidget {
  const TransactionsPageView({super.key});

  @override
  State<TransactionsPageView> createState() => _TransactionsPageViewState();
}

class _TransactionsPageViewState extends State<TransactionsPageView> {
  final _searchController = TextEditingController();
  List<Transaction> _transactions = [];
  bool _loading = true;
  String _searchQuery = '';
  String _selectedFilter = 'الكل';

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Transaction> get _filteredTransactions {
    var result = _transactions;
    if (_selectedFilter == 'تحويل') {
      result = result.where((t) => t.type == 'income').toList();
    } else if (_selectedFilter == 'شراء') {
      result = result.where((t) => t.type == 'expense').toList();
    }
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((t) => t.description.contains(_searchQuery))
          .toList();
    }
    return result;
  }

  Future<void> _loadTransactions() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/transactions.json');
      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
      if (!mounted) return;
      setState(() {
        _transactions = decoded
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        NotificationsPageView.routeName,
                      );
                    },
                    child: Container(
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
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      const Icon(Icons.tune_rounded, color: AppColors.mint),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'بحث عن معاملة',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                              color: AppColors.mutedText.withValues(alpha: 0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => _searchQuery = value.trim());
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: AppColors.mutedText,
                            size: 20,
                          ),
                        )
                      else
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _selectedFilter = 'الكل'),
                    child: FilterChipLabel(
                      label: 'الكل',
                      active: _selectedFilter == 'الكل',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _selectedFilter = 'تحويل'),
                    child: FilterChipLabel(
                      label: 'تحويل',
                      active: _selectedFilter == 'تحويل',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _selectedFilter = 'شراء'),
                    child: FilterChipLabel(
                      label: 'شراء',
                      active: _selectedFilter == 'شراء',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child:
                        CircularProgressIndicator(color: AppColors.mint),
                  ),
                )
              else
                _buildTransactionList(),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return names[month - 1];
  }

  Widget _buildTransactionList() {
    final filtered = _filteredTransactions;

    if (filtered.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'لا توجد معاملات',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.mutedText),
        ),
      );
    }

    final grouped = <String, List<Transaction>>{};
    for (final txn in filtered) {
      final key = '${txn.date.year}-${txn.date.month}-${txn.date.day}';
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(txn);
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    final now = DateTime.now();
    final todayKey = '${now.year}-${now.month}-${now.day}';
    final yesterday =
        now.subtract(const Duration(days: 1));
    final yesterdayKey =
        '${yesterday.year}-${yesterday.month}-${yesterday.day}';

    double totalExpense = 0;
    double totalIncome = 0;

    final items = <Widget>[];
    for (final key in sortedKeys) {
      final txnList = grouped[key]!;
      String label;
      if (key == todayKey) {
        final t = now;
        label = 'اليوم - ${t.day} ${_monthName(t.month)} ${t.year}';
      } else if (key == yesterdayKey) {
        final t = yesterday;
        label = 'أمس - ${t.day} ${_monthName(t.month)} ${t.year}';
      } else {
        final parts = key.split('-');
        final d = DateTime(int.parse(parts[0]), int.parse(parts[1]),
            int.parse(parts[2]));
        label =
            '${d.day} ${_monthName(d.month)} ${d.year}';
      }

      items.add(TransactionDateHeader(label: label));
      items.add(const SizedBox(height: 12));

      for (final txn in txnList) {
        if (txn.isIncome) {
          totalIncome += txn.amount;
        } else {
          totalExpense += txn.amount;
        }

        items.add(
          TransactionCard(
            title: txn.title,
            subtitle: txn.description,
            amount:
                '${txn.isIncome ? '+' : '-'} ${txn.amount.toStringAsFixed(0)} LYD',
            time: txn.time,
            icon: txn.icon,
            positive: txn.isIncome,
          ),
        );
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
              value: '${filtered.length}',
              icon: Icons.receipt_long_rounded,
              accent: AppColors.sky,
            ),
          ),
        ],
      ),
    );

    return Column(children: items);
  }
}
