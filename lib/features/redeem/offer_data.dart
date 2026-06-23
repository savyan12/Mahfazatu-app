import 'package:flutter/material.dart';

class OfferData {
  const OfferData({
    required this.merchantName,
    this.category = '',
    required this.title,
    this.badge = 'عرض مميز',
    required this.discount,
    required this.pointsRequired,
    this.distance = '',
    required this.icon,
    required this.accent,
  });

  final String merchantName;
  final String category;
  final String title;
  final String badge;
  final String discount;
  final int pointsRequired;
  final String distance;
  final IconData icon;
  final Color accent;
}
