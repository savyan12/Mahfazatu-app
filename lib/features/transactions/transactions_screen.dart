import 'package:flutter/material.dart';

import '../../shared/widgets/app_shell.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  static const routeName = '/transactions';

  @override
  Widget build(BuildContext context) {
    return const AppShell(initialIndex: 1);
  }
}
