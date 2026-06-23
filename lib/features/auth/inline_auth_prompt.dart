import 'package:flutter/material.dart';

import '../../shared/widgets/app_controls.dart';

class InlineAuthPrompt extends StatelessWidget {
  const InlineAuthPrompt({
    required this.text,
    required this.actionText,
    required this.onTap,
    super.key,
  });

  final String text;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 5),
        LinkText(text: actionText, onTap: onTap),
      ],
    );
  }
}
