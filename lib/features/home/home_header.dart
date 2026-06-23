import 'package:flutter/material.dart';

import '../notifications/notifications_page_view.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  const HomeHeader({this.name = 'سفيان', super.key});

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();

    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              NotificationsPageView.routeName,
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
    if (hour < 18) return 'مساء الخير';
    return 'ليلاً';
  }
}
