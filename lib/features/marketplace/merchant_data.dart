import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MerchantData {
  const MerchantData({
    required this.name,
    required this.category,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.icon,
    required this.accent,
  });

  final String name;
  final String category;
  final double rating;
  final double latitude;
  final double longitude;
  final IconData icon;
  final Color accent;
}

const merchants = [
  MerchantData(
    name: 'مقهى رواء',
    category: 'مقاهي',
    rating: 4.8,
    latitude: 32.8872,
    longitude: 13.1913,
    icon: Icons.local_cafe,
    accent: AppColors.card,
  ),
  MerchantData(
    name: 'سوبر ماركت المدينة',
    category: 'تسوق',
    rating: 4.6,
    latitude: 32.8895,
    longitude: 13.1800,
    icon: Icons.shopping_cart,
    accent: AppColors.teal,
  ),
  MerchantData(
    name: 'مطعم بيت الشاورما',
    category: 'مطاعم',
    rating: 4.5,
    latitude: 32.8840,
    longitude: 13.1990,
    icon: Icons.restaurant,
    accent: AppColors.danger,
  ),
  MerchantData(
    name: 'عيادة النهدي',
    category: 'خدمات',
    rating: 4.7,
    latitude: 32.8860,
    longitude: 13.1940,
    icon: Icons.favorite,
    accent: AppColors.sky,
  ),
];
