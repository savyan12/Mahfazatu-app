import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_controls.dart';
import '../../shared/widgets/scanner_action_button.dart';
import 'payment_widgets.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  static const routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _amountController = TextEditingController();
  final _balance = 10000.00;
  final _rewardPoints = 840;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildPointsBanner(),
                const SizedBox(height: 28),
                _buildQrScanner(),
                const SizedBox(height: 28),
                _buildAmountSection(),
                const SizedBox(height: 24),
                PrimaryGradientButton(
                  label: 'ادفع الآن',
                  icon: Icons.payments_outlined,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
          'عملية دفع',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildPointsBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.mint.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.diamond_outlined,
              color: AppColors.mint,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'ستحصل على ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: '$_rewardPoints',
                    style: const TextStyle(
                      color: AppColors.mint,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(
                    text: ' نقطة مكافأة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrScanner() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter: const PaymentScannerFramePainter(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.qr_code_scanner_rounded,
                color: AppColors.mint,
                size: 64,
              ),
              const SizedBox(height: 12),
              const Text(
                'مسح رمز QR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'وجّه الكاميرا نحو رمز QR\nالخاص بالمتجر',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mutedText.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScannerActionButton(
                  icon: Icons.photo_library_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                ScannerActionButton(
                  icon: Icons.flashlight_on_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                'LYD $_balance',
                style: const TextStyle(
                  color: AppColors.mint,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Text(
                'المبلغ',
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundBottom.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.mint.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                const Text(
                  'LYD',
                  style: TextStyle(
                    color: AppColors.mint,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    cursorColor: AppColors.mint,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    decoration: const InputDecoration(
                      hintText: '0.00',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
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
