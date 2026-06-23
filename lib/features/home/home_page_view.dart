import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/profile.dart';
import '../../shared/widgets/app_background.dart';
import 'home_widgets.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/profile.json');
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      if (!mounted) return;
      setState(() => _profile = Profile.fromJson(decoded));
    } catch (_) {
      if (!mounted) return;
      setState(() => _profile = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final bottomNavHeight = 104.0 + bottomInset;
    final name = _profile?.name ?? 'سفيان';
    final balance = _profile?.balance ?? 10000;
    final points = _profile?.points ?? 840;

    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(28, 22, 28, bottomNavHeight + 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeHeader(name: name),
                const SizedBox(height: 40),
                BankAccountCard(balance: balance),
                const SizedBox(height: 34),
                const CardCarouselIndicator(),
                const SizedBox(height: 24),
                PointsBanner(points: points),
                const SizedBox(height: 54),
                const QuickActionsRow(),
                const SizedBox(height: 48),
                const TransactionsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
