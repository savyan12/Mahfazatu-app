import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class TopupQrFramePainter extends CustomPainter {
  const TopupQrFramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.mint.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    const cl = 30.0;
    final s = size;

    canvas.drawPath(
      Path()..moveTo(0, cl)..lineTo(0, 0)..lineTo(cl, 0), paint,
    );
    canvas.drawPath(
      Path()..moveTo(s.width - cl, 0)..lineTo(s.width, 0)..lineTo(s.width, cl), paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(s.width, s.height - cl)
        ..lineTo(s.width, s.height)
        ..lineTo(s.width - cl, s.height),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(cl, s.height)
        ..lineTo(0, s.height)
        ..lineTo(0, s.height - cl),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
