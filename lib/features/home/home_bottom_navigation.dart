import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    required this.currentIndex,
    required this.onChanged,
    required this.bottomInset,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104 + bottomInset,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomInset,
            height: 86,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.backgroundBottom.withValues(alpha: 0.96),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 22, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textDirection: TextDirection.ltr,
                  children: [
                    BottomNavItem(
                      active: currentIndex == 0,
                      icon: Icons.person_outline_rounded,
                      label: 'الملف الشخصي',
                      onTap: () => onChanged(0),
                    ),
                    BottomNavItem(
                      active: currentIndex == 1,
                      icon: Icons.list_rounded,
                      label: 'المعاملات',
                      onTap: () => onChanged(1),
                    ),
                    BottomNavItem(
                      active: currentIndex == 2,
                      icon: Icons.add_rounded,
                      label: 'إضافة',
                      onTap: () => onChanged(2),
                    ),
                    BottomNavItem(
                      active: currentIndex == 3,
                      icon: Icons.shopping_bag_outlined,
                      label: 'المتاجر',
                      onTap: () => onChanged(3),
                    ),
                    BottomNavItem(
                      active: currentIndex == 4,
                      icon: Icons.home_outlined,
                      label: 'الرئيسية',
                      onTap: () => onChanged(4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mint.withValues(alpha: 0.94),
                border: Border.all(color: AppColors.backgroundBottom, width: 5),
              ),
              child: IconButton(
                onPressed: () {
                  onChanged(2);
                },
                icon: const Icon(
                  Icons.add_rounded,
                  color: AppColors.card,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    required this.icon,
    this.onTap,
    this.label,
    this.active = false,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final String? label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.mint : Colors.white;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: active ? null : onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 29),
            if (label != null) ...[
              const SizedBox(height: 3),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label!,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
