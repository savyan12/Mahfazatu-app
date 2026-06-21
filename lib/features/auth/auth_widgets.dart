import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_background.dart';
import '../../shared/widgets/app_controls.dart';

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

class AuthLogoHeader extends StatelessWidget {
  const AuthLogoHeader({
    required this.title,
    this.subtitle,
    this.logoWidth = 104,
    this.titleTopPadding = 24,
    super.key,
  });

  final String title;
  final String? subtitle;
  final double logoWidth;
  final double titleTopPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.logo, width: logoWidth, fit: BoxFit.contain),
        SizedBox(height: titleTopPadding),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ],
    );
  }
}

class AuthField extends StatefulWidget {
  const AuthField({
    required this.hintText,
    required this.icon,
    this.trailingIcon,
    this.onTrailingTap,
    this.obscureText = false,
    this.keyboardType,
    super.key,
  });

  final String hintText;
  final IconData icon;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.mint.withValues(alpha: 0.72),
          width: 1.2,
        ),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          const SizedBox(width: 19),
          Icon(
            widget.icon,
            color: AppColors.mint.withValues(alpha: 0.86),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              cursorColor: AppColors.mint,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintTextDirection: TextDirection.rtl,
                hintStyle: const TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (widget.trailingIcon != null)
            InkResponse(
              radius: 22,
              onTap: widget.onTrailingTap,
              child: Icon(
                widget.trailingIcon,
                color: AppColors.mutedText,
                size: 22,
              ),
            ),
          SizedBox(width: widget.trailingIcon == null ? 20 : 18),
        ],
      ),
    );
  }
}

class InlineAuthPrompt extends StatelessWidget {
  const InlineAuthPrompt({
    required this.text,
    required this.actionText,
    required this.onTap,
    super.key,
  });

  final String text;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 5),
        LinkText(text: actionText, onTap: onTap),
      ],
    );
  }
}

class StepProgress extends StatelessWidget {
  const StepProgress({required this.currentStep, super.key});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final progress = currentStep == 1 ? 0.50 : 1.0;

    return Column(
      children: [
        SizedBox(
          height: 22,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                top: 9,
                bottom: 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.mint.withValues(alpha: 0.24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: (1 - progress) * MediaQuery.sizeOf(context).width,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.mint.withValues(alpha: 0.86),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: StepDot(filled: true),
              ),
              Align(
                alignment: Alignment.center,
                child: StepDot(filled: currentStep >= 1, small: true),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: StepDot(filled: currentStep == 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        Row(
          textDirection: TextDirection.ltr,
          children: [
            const Text(
              'الخطوة 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              'الخطوة $currentStep من 2',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StepDot extends StatelessWidget {
  const StepDot({required this.filled, this.small = false, super.key});

  final bool filled;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 12.0 : 22.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? AppColors.mint : AppColors.card,
        border: Border.all(
          color: AppColors.mint.withValues(alpha: 0.74),
          width: small ? 0 : 2,
        ),
      ),
      child: filled && !small
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.26),
                ),
              ),
            )
          : null,
    );
  }
}

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

class AuthCard extends StatelessWidget {
  const AuthCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: child,
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.title,
    required this.badgeText,
    super.key,
  });

  final String title;
  final String badgeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.mint.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            badgeText,
            style: const TextStyle(
              color: AppColors.card,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class SelectionField extends StatelessWidget {
  const SelectionField({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.mint.withValues(alpha: 0.62)),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 22,
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.badge_outlined, color: AppColors.mint, size: 20),
        ],
      ),
    );
  }
}

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
