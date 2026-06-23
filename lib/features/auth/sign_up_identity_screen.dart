import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/session.dart';
import '../../data/user.dart';
import '../../shared/widgets/app_controls.dart';
import '../home/home_screen.dart';
import 'auth_screens.dart';
import 'auth_widgets.dart';

class SignUpIdentityScreen extends StatelessWidget {
  const SignUpIdentityScreen({super.key});

  static const routeName = '/sign-up/identity';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return AuthScaffold(
      horizontalPadding: 36,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.052),
          const AuthLogoHeader(
            title: 'إنشاء حساب جديد',
            subtitle: 'اكتمال الملف الشخصي',
            logoWidth: 98,
            titleTopPadding: 22,
          ),
          const SizedBox(height: 22),
          const StepProgress(currentStep: 2),
          const SizedBox(height: 20),
          AuthCard(
            child: Column(
              children: [
                const SectionHeading(
                  title: 'التحقق من الهوية',
                  badgeText: 'مطلوب',
                ),
                const SizedBox(height: 14),
                const Text(
                  'اختر نوع الهوية التي ترغب في استخدامها',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 20),
                const SelectionField(label: 'اختر نوع الهوية'),
                const SizedBox(height: 16),
                PrimaryGradientButton(
                  label: 'التقاط صورة الهوية',
                  icon: Icons.photo_camera_outlined,
                  compact: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                const Text(
                  'الرجاء رفع صورة واضحة ومقروءة لوجه الهوية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AuthCard(
            child: Column(
              children: [
                const Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    FaceScanIcon(),
                    SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'مسح الوجه البيومتري',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'تحقق من هويتك باستخدام مسح الوجه',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                PrimaryGradientButton(
                  label: 'إبدأ مسح الوجه',
                  icon: Icons.fingerprint_rounded,
                  compact: true,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                const Text(
                  'الرجاء توجيه الكاميرا نحو وجهك في مكان مضاء جيداً',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PrimaryGradientButton(
            label: 'إتمام التسجيل',
            onPressed: () {
              if (args != null) {
                Session.register(User(
                  email: args['email'] as String,
                  password: args['password'] as String,
                  name: args['fullName'] as String,
                  phone: args['phone'] as String,
                ));
              }
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          const SizedBox(height: 18),
          InlineAuthPrompt(
            text: 'لديك حساب بالفعل؟',
            actionText: 'تسجيل الدخول',
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
