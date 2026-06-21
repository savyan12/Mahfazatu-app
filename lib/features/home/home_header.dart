import 'package:flutter/material.dart';

import 'home_feature_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
        const Text(
          'مساء الخير،\nسفيان',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
            height: 1.18,
          ),
        ),
      ],
    );
  }
}
