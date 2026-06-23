import 'package:flutter/material.dart';

class Merchant {
  final String name;
  final String type;
  final String category;
  final double rating;
  final double latitude;
  final double longitude;

  const Merchant({
    required this.name,
    required this.type,
    required this.category,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  IconData get icon => _iconForType(type);

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      name: json['name'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  static IconData _iconForType(String type) {
    switch (type) {
      case 'مقهى':
        return Icons.local_cafe;
      case 'سوبر ماركت':
        return Icons.shopping_cart;
      case 'مطعم':
        return Icons.restaurant;
      case 'مستشفى':
        return Icons.local_hospital;
      case 'إلكترونيات':
        return Icons.smartphone;
      case 'مكتبة':
        return Icons.library_books;
      case 'صيدلية':
        return Icons.medication;
      case 'عيادة':
        return Icons.medical_services;
      default:
        return Icons.store_outlined;
    }
  }
}
