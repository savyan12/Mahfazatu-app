import 'package:flutter/material.dart';

import '../../shared/widgets/app_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const AppShell(initialIndex: 4);
  }
}
