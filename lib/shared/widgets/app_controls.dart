import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PrimaryGradientButton extends StatelessWidget {
  const PrimaryGradientButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.compact = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: compact ? 48 : 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [AppColors.teal, Color(0xFF4FCB91)],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: compact ? 20 : 22),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 16 : 18,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  const LinkText({required this.text, required this.onTap, super.key});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.mint,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
