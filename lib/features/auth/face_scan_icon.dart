import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class FaceScanIcon extends StatelessWidget {
  const FaceScanIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      height: 82,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.face_retouching_natural_outlined,
            color: AppColors.mint.withValues(alpha: 0.92),
            size: 58,
          ),
          Positioned(
            top: 2,
            left: 2,
            child: _CornerBorder(alignment: Alignment.topLeft),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: _CornerBorder(alignment: Alignment.topRight),
          ),
          Positioned(
            bottom: 2,
            left: 2,
            child: _CornerBorder(alignment: Alignment.bottomLeft),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: _CornerBorder(alignment: Alignment.bottomRight),
          ),
        ],
      ),
    );
  }
}

class _CornerBorder extends StatelessWidget {
  const _CornerBorder({required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: AppColors.mint.withValues(alpha: 0.82),
      width: 2,
    );

    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        border: Border(
          top: alignment.y < 0 ? borderSide : BorderSide.none,
          bottom: alignment.y > 0 ? borderSide : BorderSide.none,
          left: alignment.x < 0 ? borderSide : BorderSide.none,
          right: alignment.x > 0 ? borderSide : BorderSide.none,
        ),
      ),
    );
  }
}
