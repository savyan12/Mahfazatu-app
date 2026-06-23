import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../data/profile.dart';
import '../notifications/notifications_page_view.dart';
import '../../shared/widgets/app_background.dart';
import '../auth/auth_screens.dart';
import 'settings_widgets.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  bool _darkModeEnabled = true;
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/profile.json');
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      if (!mounted) return;
      setState(() => _profile = Profile.fromJson(decoded));
    } catch (_) {
      if (!mounted) return;
      setState(() => _profile = null);
    }
  }

  void _logout() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final name = _profile?.name ?? 'سفيان الترهوني';
    final email = _profile?.email ?? 'sufyan@test.com';
    final phone = _profile?.phone ?? '+218912345678';

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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          NotificationsPageView.routeName,
                        );
                      },
                      child: Container(
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
                _buildProfileCard(name, email, phone),
                const SizedBox(height: 18),
                const SettingsSectionTitle(label: 'الحساب'),
                const SizedBox(height: 10),
                SettingsSectionCard(
                  children: [
                    SettingsActionTile(
                      icon: Icons.manage_accounts_rounded,
                      title: 'تعديل البيانات الشخصية',
                      onTap: () {},
                    ),
                    SettingsActionTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'تغيير كلمة المرور',
                      onTap: () {},
                    ),
                    SettingsActionTile(
                      icon: Icons.verified_user_outlined,
                      title: 'التحقق الثنائي',
                      onTap: () {},
                    ),
                    SettingsActionTile(
                      icon: Icons.phone_android_rounded,
                      title: 'إدارة الأجهزة',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const SettingsSectionTitle(label: 'التفضيلات'),
                const SizedBox(height: 10),
                SettingsSectionCard(
                  children: [
                    SettingsActionTile(
                      icon: Icons.notifications_outlined,
                      title: 'الإشعارات',
                      onTap: () {},
                    ),
                    SettingsLanguageTile(value: 'العربية', onTap: () {}),
                    SettingsSwitchTile(
                      title: 'الوضع الداكن',
                      icon: Icons.dark_mode_outlined,
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                      },
                    ),
                    SettingsActionTile(
                      icon: Icons.attach_money_rounded,
                      title: 'العملات المفضلة',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const SettingsSectionTitle(label: 'الدعم والمساعدة'),
                const SizedBox(height: 10),
                SettingsSectionCard(
                  children: [
                    SettingsActionTile(
                      icon: Icons.help_outline_rounded,
                      title: 'مركز المساعدة',
                      onTap: () {},
                    ),
                    SettingsActionTile(
                      icon: Icons.headset_mic_outlined,
                      title: 'تواصل معنا',
                      onTap: () {},
                    ),
                    SettingsActionTile(
                      icon: Icons.info_outline_rounded,
                      title: 'عن التطبيق',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: _logout,
                  child: Container(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(String name, String email, String phone) {
    return Container(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  email,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.mint,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (phone.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'رقم الهاتف: $phone',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
