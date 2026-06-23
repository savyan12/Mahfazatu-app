import 'package:flutter/material.dart';

import '../../data/models/profile_model.dart';
import 'home_feature_page.dart';

class HomeHeader extends StatelessWidget {
  final ProfileModel? profile;
  const HomeHeader({this.profile, super.key});

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();
    final name = profile?.firstName ?? 'سفيان';

    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            openHomeFeaturePage(
              context,
              title: 'الإشعارات',
              subtitle: 'هنا ستظهر التنبيهات والتنبيهات المالية المهمة.',
              icon: Icons.notifications_none_rounded,
            );
          },
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        const Spacer(),
        Text(
          '$greeting،\n$name',
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
            height: 1.18,
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير';
    if (hour < 17) return 'مساء الخير';
    return 'مساء الخير';
  }
}
