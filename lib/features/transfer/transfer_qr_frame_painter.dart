import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class TransferQrFramePainter extends CustomPainter {
  const TransferQrFramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.mint.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    const cornerLength = 28.0;
    final s = size;

    canvas.drawPath(
      Path()
        ..moveTo(0, cornerLength)
        ..lineTo(0, 0)
        ..lineTo(cornerLength, 0),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(s.width - cornerLength, 0)
        ..lineTo(s.width, 0)
        ..lineTo(s.width, cornerLength),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(s.width, s.height - cornerLength)
        ..lineTo(s.width, s.height)
        ..lineTo(s.width - cornerLength, s.height),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(cornerLength, s.height)
        ..lineTo(0, s.height)
        ..lineTo(0, s.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
