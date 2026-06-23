import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/supabase/supabase_client.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../shared/widgets/app_background.dart';
import '../auth/auth_screens.dart';
import 'settings_widgets.dart';

class SettingsPageView extends ConsumerStatefulWidget {
  const SettingsPageView({super.key});

  static const routeName = '/settings';

  @override
  ConsumerState<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends ConsumerState<SettingsPageView> {
  bool _darkModeEnabled = true;

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0A1C2A),
        title: const Text('تسجيل الخروج',
            style: TextStyle(color: Colors.white)),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟',
            style: TextStyle(color: AppColors.mutedText)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء',
                style: TextStyle(color: AppColors.mutedText)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('تسجيل الخروج',
                style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(authRepositoryProvider).signOut();
        if (!mounted) return;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تسجيل الخروج')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = SupabaseService.I.auth.currentUser;
    final authUid = user?.id ?? '';
    final profileAsync = ref.watch(profileProvider(authUid));

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
                profileAsync.when(
                  data: (profile) => _buildProfileCard(
                      profile.name, user?.email ?? '', profile.phoneNumber),
                  loading: () => _buildProfileCard('...', '...', '...'),
                  error: (_, _) =>
                      _buildProfileCard(user?.email ?? '', user?.email ?? '', ''),
                ),
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
