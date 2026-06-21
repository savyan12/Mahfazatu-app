import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CardCarouselIndicator extends StatelessWidget {
  const CardCarouselIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: const [
        _CardDot(active: true),
        SizedBox(width: 8),
        _CardDot(active: false),
        SizedBox(width: 8),
        _CardDot(active: false),
      ],
    );
  }
}

class _CardDot extends StatelessWidget {
  const _CardDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: active ? 22 : 13,
      height: 8,
      decoration: BoxDecoration(
        color: active
            ? AppColors.mint
            : AppColors.mutedText.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}
