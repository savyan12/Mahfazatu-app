import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

enum Gender { male, female }

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    required this.selectedGender,
    required this.onChanged,
    super.key,
  });

  final Gender selectedGender;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: GenderOption(
            label: 'ذكر',
            icon: Icons.person_2_outlined,
            selected: selectedGender == Gender.male,
            onTap: () => onChanged(Gender.male),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GenderOption(
            label: 'أنثى',
            icon: Icons.person_3_outlined,
            selected: selectedGender == Gender.female,
            onTap: () => onChanged(Gender.female),
          ),
        ),
      ],
    );
  }
}

class GenderOption extends StatelessWidget {
  const GenderOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.mint.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.mint.withValues(alpha: 0.74),
            width: selected ? 1.7 : 1.2,
          ),
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Icon(icon, color: AppColors.mint, size: 27),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (selected)
              Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                  color: AppColors.mint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.card,
                  size: 13,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
