import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/supabase/supabase_client.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../shared/widgets/app_background.dart';
import 'home_widgets.dart';

class HomePageView extends ConsumerWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final bottomNavHeight = 104.0 + bottomInset;
    final user = SupabaseService.I.auth.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final authUid = user.id;
    final profileAsync = ref.watch(profileProvider(authUid));
    final userIdAsync = ref.watch(currentUserIdProvider);

    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(28, 22, 28, bottomNavHeight + 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                profileAsync.when(
                  data: (profile) => HomeHeader(profile: profile),
                  loading: () => const HomeHeader(),
                  error: (_, _) => const HomeHeader(),
                ),
                const SizedBox(height: 40),
                userIdAsync.when(
                  data: (userId) => _HomeWalletSection(userId: userId),
                  loading: () => const Column(children: [
                    BankAccountCard(),
                    SizedBox(height: 34),
                    CardCarouselIndicator(),
                    SizedBox(height: 24),
                    PointsBanner(),
                    SizedBox(height: 54),
                    QuickActionsRow(),
                    SizedBox(height: 48),
                  ]),
                  error: (_, _) => const Column(children: [
                    BankAccountCard(),
                    SizedBox(height: 34),
                    CardCarouselIndicator(),
                    SizedBox(height: 24),
                    PointsBanner(),
                    SizedBox(height: 54),
                    QuickActionsRow(),
                    SizedBox(height: 48),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeWalletSection extends ConsumerWidget {
  final int userId;
  const _HomeWalletSection({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletProvider(userId));
    final balanceAsync = ref.watch(balanceProvider(userId));
    final transactionsAsync = ref.watch(transactionsProvider(userId));

    return Column(children: [
      balanceAsync.when(
        data: (balance) => BankAccountCard(balance: balance),
        loading: () => const BankAccountCard(),
        error: (_, _) => const BankAccountCard(),
      ),
      const SizedBox(height: 34),
      const CardCarouselIndicator(),
      const SizedBox(height: 24),
      walletAsync.when(
        data: (wallet) => PointsBanner(points: wallet.points),
        loading: () => const PointsBanner(),
        error: (_, _) => const PointsBanner(),
      ),
      const SizedBox(height: 54),
      const QuickActionsRow(),
      const SizedBox(height: 48),
      transactionsAsync.when(
        data: (txns) =>
            TransactionsSection(transactions: txns.take(2).toList()),
        loading: () => const TransactionsSection(),
        error: (_, _) => const TransactionsSection(),
      ),
    ]);
  }
}
