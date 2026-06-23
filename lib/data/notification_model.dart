import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class AppNotification {
  final int id;
  final String title;
  final String body;
  final String time;
  final String type;
  final bool read;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    required this.read,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
      read: json['read'] as bool,
    );
  }

  IconData get icon {
    switch (type) {
      case 'income':
        return Icons.arrow_downward_rounded;
      case 'expense':
        return Icons.arrow_upward_rounded;
      case 'promo':
        return Icons.card_giftcard_rounded;
      case 'info':
        return Icons.info_outline_rounded;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color get color {
    switch (type) {
      case 'income':
        return AppColors.mint;
      case 'expense':
        return AppColors.danger;
      case 'promo':
        return AppColors.teal;
      case 'info':
        return AppColors.sky;
      default:
        return AppColors.mutedText;
    }
  }
}
