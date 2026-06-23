import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../data/profile.dart';
import '../../shared/widgets/app_background.dart';
import 'redeem_widgets.dart';

class RedeemPointsScreen extends StatefulWidget {
  const RedeemPointsScreen({super.key});

  static const routeName = '/redeem-points';

  @override
  State<RedeemPointsScreen> createState() => _RedeemPointsScreenState();
}

class _RedeemPointsScreenState extends State<RedeemPointsScreen> {
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/profile.json');
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
    final points = _profile?.points ?? 840;

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
                _buildPointsCard(points),
                const SizedBox(height: 28),
                const RedeemSectionTitle(text: 'اختر المتجر'),
                const SizedBox(height: 14),
                _buildMerchantStrip(),
                const SizedBox(height: 28),
                const RedeemSectionTitle(text: 'المكافآت المتاحة'),
                const SizedBox(height: 14),
                _buildRewardsList(),
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

  Widget _buildPointsCard(int points) {
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

  Widget _buildMerchantStrip() {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        separatorBuilder: (context, i) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const RedeemMerchantCircle(
              name: 'الكل',
              icon: Icons.grid_view_rounded,
              active: true,
            );
          }
          const merchants = [
            ('مقهى رواء', Icons.local_cafe_outlined),
            ('مطعم بيت الشاورما', Icons.restaurant_outlined),
            ('سوبر ماركت المدينة', Icons.shopping_cart_outlined),
          ];
          return RedeemMerchantCircle(
            name: merchants[index - 1].$1,
            icon: merchants[index - 1].$2,
            active: false,
          );
        },
      ),
    );
  }

  Widget _buildRewardsList() {
    return Column(
      children: [
        OfferCard(
          offer: OfferData(
            merchantName: '',
            title: 'خصم 10% على المشتريات',
            badge: 'خصم',
            discount: '10%',
            pointsRequired: 100,
            icon: Icons.diamond_outlined,
            accent: AppColors.mint,
          ),
        ),
        const SizedBox(height: 12),
        OfferCard(
          offer: OfferData(
            merchantName: '',
            title: 'قهوة مجانية',
            badge: 'جائزة',
            discount: 'مجاناً',
            pointsRequired: 200,
            icon: Icons.diamond_outlined,
            accent: AppColors.mint,
          ),
        ),
      ],
    );
  }
}
