import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_controls.dart';
import '../home/home_screen.dart';
import 'auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      horizontalPadding: 36,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.12),
          const AuthLogoHeader(
            title: 'مرحباً بعودتك',
            logoWidth: 108,
            titleTopPadding: 26,
          ),
          const SizedBox(height: 62),
          const AuthField(
            hintText: 'رقم الهاتف',
            icon: Icons.phone_android_rounded,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          AuthField(
            hintText: 'كلمة السر',
            icon: Icons.lock_outline_rounded,
            obscureText: !_passwordVisible,
            trailingIcon: _passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            onTrailingTap: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          const SizedBox(height: 34),
          PrimaryGradientButton(
            label: 'تسجيل الدخول',
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          const SizedBox(height: 20),
          Row(
            textDirection: TextDirection.ltr,
            children: [
              LinkText(text: 'نسيت كلمة السر؟', onTap: () {}),
              const Spacer(),
              InlineAuthPrompt(
                text: 'ليس لديك حساب؟',
                actionText: 'سجل الآن',
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(SignUpDetailsScreen.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpDetailsScreen extends StatefulWidget {
  const SignUpDetailsScreen({super.key});

  static const routeName = '/sign-up/details';

  @override
  State<SignUpDetailsScreen> createState() => _SignUpDetailsScreenState();
}

class _SignUpDetailsScreenState extends State<SignUpDetailsScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  Gender _selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      horizontalPadding: 36,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.065),
          const AuthLogoHeader(
            title: 'إنشاء حساب جديد',
            logoWidth: 104,
            titleTopPadding: 26,
          ),
          const SizedBox(height: 28),
          const StepProgress(currentStep: 1),
          const SizedBox(height: 40),
          const Row(
            textDirection: TextDirection.ltr,
            children: [
              Expanded(
                child: AuthField(
                  hintText: 'الاسم الأخير',
                  icon: Icons.person_outline_rounded,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AuthField(
                  hintText: 'الاسم الأول',
                  icon: Icons.person_outline_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AuthField(
            hintText: 'رقم الهاتف',
            icon: Icons.phone_android_rounded,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          AuthField(
            hintText: 'كلمة السر',
            icon: Icons.lock_outline_rounded,
            obscureText: !_passwordVisible,
            trailingIcon: _passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            onTrailingTap: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          const SizedBox(height: 16),
          AuthField(
            hintText: 'تأكيد كلمة السر',
            icon: Icons.lock_outline_rounded,
            obscureText: !_confirmPasswordVisible,
            trailingIcon: _confirmPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            onTrailingTap: () {
              setState(() {
                _confirmPasswordVisible = !_confirmPasswordVisible;
              });
            },
          ),
          const SizedBox(height: 16),
          GenderSelector(
            selectedGender: _selectedGender,
            onChanged: (gender) {
              setState(() {
                _selectedGender = gender;
              });
            },
          ),
          const SizedBox(height: 26),
          PrimaryGradientButton(
            label: 'التالي',
            onPressed: () {
              Navigator.of(context).pushNamed(SignUpIdentityScreen.routeName);
            },
          ),
          const SizedBox(height: 20),
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

class SignUpIdentityScreen extends StatelessWidget {
  const SignUpIdentityScreen({super.key});

  static const routeName = '/sign-up/identity';

  @override
  Widget build(BuildContext context) {
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
            label: 'إرسال للتحقق وإتمام التسجيل',
            onPressed: () {
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
