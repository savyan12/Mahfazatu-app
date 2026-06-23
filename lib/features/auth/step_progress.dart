import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class StepProgress extends StatelessWidget {
  const StepProgress({required this.currentStep, super.key});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final progress = currentStep == 1 ? 0.50 : 1.0;

    return Column(
      children: [
        SizedBox(
          height: 22,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                top: 9,
                bottom: 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.mint.withValues(alpha: 0.24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: (1 - progress) * MediaQuery.sizeOf(context).width,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.mint.withValues(alpha: 0.86),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: _StepDot(filled: true),
              ),
              Align(
                alignment: Alignment.center,
                child: _StepDot(filled: currentStep >= 1, small: true),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _StepDot(filled: currentStep == 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        Row(
          textDirection: TextDirection.ltr,
          children: [
            const Text(
              'الخطوة 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              'الخطوة $currentStep من 2',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({required this.filled, this.small = false});

  final bool filled;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 12.0 : 22.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.mint : AppColors.card,
        border: Border.all(
          color: AppColors.mint.withValues(alpha: 0.74),
          width: small ? 0 : 2,
        ),
      ),
      child: filled && !small
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.26),
                ),
              ),
            )
          : null,
    );
  }
}
