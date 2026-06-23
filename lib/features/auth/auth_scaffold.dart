import 'package:flutter/material.dart';

import '../../shared/widgets/app_background.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.child,
    this.horizontalPadding = 36,
    super.key,
  });

  final Widget child;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ).copyWith(bottom: 28),
                    child: child,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
