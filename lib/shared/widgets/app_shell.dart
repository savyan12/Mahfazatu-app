import 'package:flutter/material.dart';

import '../../features/home/home_bottom_navigation.dart';
import '../../features/home/home_feature_page.dart';
import '../../features/home/home_page_view.dart';
import '../../features/marketplace/marketplace_page_view.dart';
import '../../features/settings/settings_page_view.dart';
import '../../features/transactions/transactions_page_view.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 4});

  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex = widget.initialIndex;

  late final List<Widget> _pages = [
    const SettingsPageView(),
    const TransactionsPageView(),
    const HomeFeaturePage(
      title: 'إضافة عملية جديدة',
      subtitle: 'من هنا يمكن لاحقاً إنشاء تحويل أو دفع أو عملية شحن جديدة.',
      icon: Icons.add_rounded,
    ),
    const MarketplacePageView(),
    const HomePageView(),
  ];

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _pages),
          Align(
            alignment: Alignment.bottomCenter,
            child: HomeBottomNavigation(
              currentIndex: _currentIndex,
              bottomInset: bottomInset,
              onChanged: _setIndex,
            ),
          ),
        ],
      ),
    );
  }
}
