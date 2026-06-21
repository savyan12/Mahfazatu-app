import 'package:flutter/material.dart';

import '../../shared/widgets/app_background.dart';
import 'home_widgets.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final bottomNavHeight = 104.0 + bottomInset;

    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(28, 22, 28, bottomNavHeight + 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                HomeHeader(),
                SizedBox(height: 40),
                BankAccountCard(),
                SizedBox(height: 34),
                CardCarouselIndicator(),
                SizedBox(height: 24),
                PointsBanner(),
                SizedBox(height: 54),
                QuickActionsRow(),
                SizedBox(height: 48),
                TransactionsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
