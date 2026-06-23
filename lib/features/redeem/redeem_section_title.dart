import 'package:flutter/material.dart';

class RedeemSectionTitle extends StatelessWidget {
  const RedeemSectionTitle({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 21,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
