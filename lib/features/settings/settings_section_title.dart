import 'package:flutter/material.dart';

class SettingsSectionTitle extends StatelessWidget {
  const SettingsSectionTitle({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 21,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
