import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class GradientTitle extends StatelessWidget {
  const GradientTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [AppColors.sky, AppColors.mint],
        ).createShader(bounds);
      },
      child: Text(
        'محفظتي',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.w800,
          height: 1,
        ),
      ),
    );
  }
}
