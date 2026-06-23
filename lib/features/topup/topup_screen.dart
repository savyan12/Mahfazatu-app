import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_controls.dart';
import '../../shared/widgets/scanner_action_button.dart';
import 'topup_widgets.dart';

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  static const routeName = '/topup';

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  TopupMethod _method = TopupMethod.code;
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
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
                const SizedBox(height: 28),
                _buildMethodTabs(),
                const SizedBox(height: 32),
                if (_method == TopupMethod.code)
                  _buildCodeInput()
                else
                  _buildQrScanner(),
                const SizedBox(height: 32),
                _buildInfoCard(),
                const SizedBox(height: 28),
                PrimaryGradientButton(
                  label: 'شحن الرصيد',
                  icon: Icons.savings_outlined,
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
          'شحن الرصيد',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildMethodTabs() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _method = TopupMethod.code),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _method == TopupMethod.code
                      ? AppColors.mint.withValues(alpha: 0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_outlined,
                      color: _method == TopupMethod.code
                          ? AppColors.mint
                          : AppColors.mutedText,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'رمز الكرت',
                      style: TextStyle(
                        color: _method == TopupMethod.code
                            ? AppColors.mint
                            : AppColors.mutedText,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _method = TopupMethod.qr),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _method == TopupMethod.qr
                      ? AppColors.mint.withValues(alpha: 0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner_rounded,
                      color: _method == TopupMethod.qr
                          ? AppColors.mint
                          : AppColors.mutedText,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'مسح QR',
                      style: TextStyle(
                        color: _method == TopupMethod.qr
                            ? AppColors.mint
                            : AppColors.mutedText,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInput() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mint.withValues(alpha: 0.10),
              border: Border.all(
                color: AppColors.mint.withValues(alpha: 0.30),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.card_giftcard_outlined,
              color: AppColors.mint,
              size: 36,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'أدخل رمز الكرت مسبق الدفع',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'مثال: MHF-XXXX-XXXX-XXXX',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
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
                const Icon(
                  Icons.qr_code_outlined,
                  color: AppColors.mutedText,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _codeController,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    textCapitalization: TextCapitalization.characters,
                    cursorColor: AppColors.mint,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'MHF-XXXX-XXXX-XXXX',
                      hintStyle: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (_codeController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() => _codeController.clear()),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.mutedText,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrScanner() {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 220),
            painter: const TopupQrFramePainter(),
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
                'امسح رمز QR الموجود على الكرت',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'وجّه الكاميرا نحو رمز QR\nالمطبوع على الكرت مسبق الدفع',
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

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardRaised.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.sky.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppColors.sky,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'تتوفر كروت الشحن لدى جميع المتاجر\nوالموزعين المعتمدين.',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.mutedText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
