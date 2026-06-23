import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_controls.dart';
import '../../shared/widgets/scanner_action_button.dart';
import 'transfer_widgets.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  static const routeName = '/transfer';

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TransferMethod _method = TransferMethod.nfc;
  final _amountController = TextEditingController();
  String _selectedCurrency = 'LYD';

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
                const SizedBox(height: 28),
                _buildMethodTabs(),
                const SizedBox(height: 32),
                if (_method == TransferMethod.nfc)
                  _buildNfcView()
                else
                  _buildQrView(),
                const SizedBox(height: 32),
                _buildAmountSection(),
                const SizedBox(height: 28),
                PrimaryGradientButton(
                  label: 'تحويل الآن',
                  icon: Icons.swap_horiz_rounded,
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
          'تحويل مالي',
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
              onTap: () => setState(() => _method = TransferMethod.nfc),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _method == TransferMethod.nfc
                      ? AppColors.mint.withValues(alpha: 0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.nfc_rounded,
                      color: _method == TransferMethod.nfc
                          ? AppColors.mint
                          : AppColors.mutedText,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'NFC',
                      style: TextStyle(
                        color: _method == TransferMethod.nfc
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
              onTap: () => setState(() => _method = TransferMethod.qr),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _method == TransferMethod.qr
                      ? AppColors.mint.withValues(alpha: 0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner_rounded,
                      color: _method == TransferMethod.qr
                          ? AppColors.mint
                          : AppColors.mutedText,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'QR Code',
                      style: TextStyle(
                        color: _method == TransferMethod.qr
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

  Widget _buildNfcView() {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mint.withValues(alpha: 0.10),
              border: Border.all(
                color: AppColors.mint.withValues(alpha: 0.30),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.nfc_rounded,
              color: AppColors.mint,
              size: 52,
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'قرّب جهازك',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'قم بتقريب هاتفك من جهاز المستلم\nلبدء التحويل عبر NFC',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView() {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(180, 180),
            painter: const TransferQrFramePainter(),
          ),
          const Icon(
            Icons.qr_code_scanner_rounded,
            color: AppColors.mint,
            size: 72,
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
          const Text(
            'المبلغ',
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.backgroundBottom.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.mint.withValues(alpha: 0.4),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCurrency,
                    dropdownColor: AppColors.card,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'LYD', child: Text('LYD')),
                      DropdownMenuItem(value: 'SAR', child: Text('SAR')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCurrency = value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundBottom.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.mint.withValues(alpha: 0.4),
                    ),
                  ),
                  child: TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    cursorColor: AppColors.mint,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    decoration: const InputDecoration(
                      hintText: '0.00',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
