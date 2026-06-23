import 'package:flutter/material.dart';

class RedeemMerchantData {
  const RedeemMerchantData({
    required this.name,
    required this.icon,
    this.active = false,
  });

  final String name;
  final IconData icon;
  final bool active;
}
