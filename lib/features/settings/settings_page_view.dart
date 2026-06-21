import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_background.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  bool _darkModeEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground.dark(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 124),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.card.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const Spacer(),
                    const Row(
                      children: [
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'الإعدادات',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card.withValues(alpha: 0.78),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundBottom,
                              border: Border.all(
                                color: AppColors.mint.withValues(alpha: 0.7),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: AppColors.mint,
                              size: 42,
                            ),
                          ),
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.mint,
                                border: Border.all(
                                  color: AppColors.backgroundBottom,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: AppColors.card,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'سفيان محمد',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'sufyan@email.com',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.mint,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'رقم الحساب: 1234 5678 9012',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.mutedText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const _SectionTitle(label: 'الحساب'),
                const SizedBox(height: 10),
                _SectionCard(
                  children: [
                    _ActionTile(
                      icon: Icons.manage_accounts_rounded,
                      title: 'تعديل البيانات الشخصية',
                      onTap: () {},
                    ),
                    _ActionTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'تغيير كلمة المرور',
                      onTap: () {},
                    ),
                    _ActionTile(
                      icon: Icons.verified_user_outlined,
                      title: 'التحقق الثنائي',
                      onTap: () {},
                    ),
                    _ActionTile(
                      icon: Icons.phone_android_rounded,
                      title: 'إدارة الأجهزة',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const _SectionTitle(label: 'التفضيلات'),
                const SizedBox(height: 10),
                _SectionCard(
                  children: [
                    _ActionTile(
                      icon: Icons.notifications_outlined,
                      title: 'الإشعارات',
                      onTap: () {},
                    ),
                    _LanguageTile(value: 'العربية', onTap: () {}),
                    _SwitchTile(
                      title: 'الوضع الداكن',
                      icon: Icons.dark_mode_outlined,
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      },
                    ),
                    _ActionTile(
                      icon: Icons.attach_money_rounded,
                      title: 'العملات المفضلة',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const _SectionTitle(label: 'الدعم والمساعدة'),
                const SizedBox(height: 10),
                _SectionCard(
                  children: [
                    _ActionTile(
                      icon: Icons.help_outline_rounded,
                      title: 'مركز المساعدة',
                      onTap: () {},
                    ),
                    _ActionTile(
                      icon: Icons.headset_mic_outlined,
                      title: 'تواصل معنا',
                      onTap: () {},
                    ),
                    _ActionTile(
                      icon: Icons.info_outline_rounded,
                      title: 'عن التطبيق',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.danger),
                  ),
                  child: const Center(
                    child: Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        color: AppColors.danger,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 21,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(children: children),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: AppColors.mint, size: 24),
          trailing: const Icon(Icons.chevron_left_rounded, color: Colors.white),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, color: Color(0x1A8BE3B4)),
      ],
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.value, required this.onTap});

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: const Icon(
            Icons.language_rounded,
            color: AppColors.mint,
            size: 24,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.mint,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_left_rounded, color: Colors.white),
            ],
          ),
          title: const Text(
            'اللغة',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0x1A8BE3B4)),
      ],
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.mint, size: 24),
          trailing: Switch.adaptive(
            value: value,
            activeColor: AppColors.mint,
            onChanged: onChanged,
          ),
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0x1A8BE3B4)),
      ],
    );
  }
}
