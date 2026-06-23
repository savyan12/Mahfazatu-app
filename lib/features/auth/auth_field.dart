import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    required this.hintText,
    required this.icon,
    this.trailingIcon,
    this.onTrailingTap,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    super.key,
  });

  final String hintText;
  final IconData icon;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.mint.withValues(alpha: 0.72),
          width: 1.2,
        ),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          const SizedBox(width: 19),
          Icon(
            widget.icon,
            color: AppColors.mint.withValues(alpha: 0.86),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              cursorColor: AppColors.mint,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintTextDirection: TextDirection.rtl,
                hintStyle: const TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (widget.trailingIcon != null)
            InkResponse(
              radius: 22,
              onTap: widget.onTrailingTap,
              child: Icon(
                widget.trailingIcon,
                color: AppColors.mutedText,
                size: 22,
              ),
            ),
          SizedBox(width: widget.trailingIcon == null ? 20 : 18),
        ],
      ),
    );
  }
}
