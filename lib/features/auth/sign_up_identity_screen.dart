import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../shared/widgets/app_controls.dart';
import '../home/home_screen.dart';
import 'auth_screens.dart';
import 'auth_widgets.dart';

class SignUpIdentityScreen extends ConsumerWidget {
  const SignUpIdentityScreen({super.key});

  static const routeName = '/sign-up/identity';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          _SubmitButton(args: args),
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

class _SubmitButton extends ConsumerStatefulWidget {
  final Map<String, dynamic>? args;
  const _SubmitButton({this.args});

  @override
  ConsumerState<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<_SubmitButton> {
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    final args = widget.args;
    if (args == null) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.signUp(
        email: args['email'] as String,
        password: args['password'] as String,
        firstName: args['firstName'] as String,
        lastName: args['lastName'] as String,
        phone: args['phone'] as String?,
        gender: args['gender'] as String?,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (e) {
      setState(() => _error = 'فشل إنشاء الحساب: ${e.toString()}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ),
        PrimaryGradientButton(
          label: _loading
              ? 'جارٍ إنشاء الحساب...'
              : 'إرسال للتحقق وإتمام التسجيل',
          onPressed: _loading ? null : _submit,
        ),
      ],
    );
  }
}
