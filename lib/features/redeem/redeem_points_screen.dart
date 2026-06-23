import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/supabase/supabase_client.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/reward_model.dart';
import '../../data/models/merchant_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/merchant_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../providers/reward_provider.dart';
import '../../shared/widgets/app_background.dart';
import 'redeem_widgets.dart';

class RedeemPointsScreen extends ConsumerWidget {
  const RedeemPointsScreen({super.key});

  static const routeName = '/redeem-points';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = SupabaseService.I.auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final userIdAsync = ref.watch(currentUserIdProvider);
    final merchantsAsync = ref.watch(merchantsProvider);
    final rewardsAsync = ref.watch(rewardsProvider);

    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                userIdAsync.when(
                  data: (userId) => _PointsCard(userId: userId),
                  loading: () => _PointsCard(userId: 0),
                  error: (_, _) => _PointsCard(userId: 0),
                ),
                const SizedBox(height: 28),
                const RedeemSectionTitle(text: 'اختر المتجر'),
                const SizedBox(height: 14),
                merchantsAsync.when(
                  data: (merchants) => _buildMerchantStrip(merchants),
                  loading: () => const SizedBox(height: 84),
                  error: (_, _) => const SizedBox(height: 84),
                ),
                const SizedBox(height: 28),
                const RedeemSectionTitle(text: 'المكافآت المتاحة'),
                const SizedBox(height: 14),
                rewardsAsync.when(
                  data: (rewards) => _buildRewardsList(rewards, ref),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, _) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'حدث خطأ في تحميل المكافآت',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.danger),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const Spacer(),
        const Text(
          'استبدال النقاط',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildMerchantStrip(List<MerchantModel> merchants) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: merchants.length + 1,
        separatorBuilder: (context, i) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const RedeemMerchantCircle(
              name: 'الكل',
              icon: Icons.grid_view_rounded,
              active: true,
            );
          }
          final m = merchants[index - 1];
          return RedeemMerchantCircle(
            name: m.name ?? m.merchantCode,
            icon: _iconForService(m.serviceType),
            active: false,
          );
        },
      ),
    );
  }

  Widget _buildRewardsList(List<RewardModel> rewards, WidgetRef ref) {
    if (rewards.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'لا توجد مكافآت متاحة حالياً',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.mutedText),
        ),
      );
    }

    return Column(
      children: rewards.map((reward) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OfferCard(
            offer: OfferData(
              merchantName: '',
              title: reward.description ?? 'مكافأة',
              badge: reward.isDiscount ? 'خصم' : 'جائزة',
              discount: reward.discountText ?? '',
              pointsRequired: reward.requiredPoints,
              icon: Icons.diamond_outlined,
              accent: AppColors.mint,
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _iconForService(String serviceType) {
    switch (serviceType) {
      case 'cafe':
        return Icons.local_cafe_outlined;
      case 'shopping':
        return Icons.shopping_cart_outlined;
      case 'restaurant':
        return Icons.restaurant_outlined;
      case 'services':
        return Icons.work_outline_rounded;
      default:
        return Icons.store_outlined;
    }
  }
}

class _PointsCard extends ConsumerWidget {
  final int userId;
  const _PointsCard({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletProvider(userId));
    return walletAsync.when(
      data: (wallet) => _buildCard(wallet.points),
      loading: () => _buildCard(0),
      error: (_, _) => _buildCard(0),
    );
  }

  Widget _buildCard(int points) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mint.withValues(alpha: 0.12),
            AppColors.teal.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.mint.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.mint.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.diamond_outlined,
              color: AppColors.mint,
              size: 32,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$points',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'رصيد النقاط',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
