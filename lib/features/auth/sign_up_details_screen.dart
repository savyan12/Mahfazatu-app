import 'package:flutter/material.dart';

import '../../shared/widgets/app_controls.dart';
import 'auth_screens.dart';
import 'auth_widgets.dart';

class SignUpDetailsScreen extends StatefulWidget {
  const SignUpDetailsScreen({super.key});

  static const routeName = '/sign-up/details';

  @override
  State<SignUpDetailsScreen> createState() => _SignUpDetailsScreenState();
}

class _SignUpDetailsScreenState extends State<SignUpDetailsScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _goToIdentity() {
    Navigator.of(context).pushNamed(
      SignUpIdentityScreen.routeName,
      arguments: {
        'fullName': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'password': _passwordController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      horizontalPadding: 36,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
          const AuthLogoHeader(
            title: 'إنشاء حساب جديد',
            logoWidth: 104,
            titleTopPadding: 26,
          ),
          const SizedBox(height: 28),
          const StepProgress(currentStep: 1),
          const SizedBox(height: 30),
          AuthField(
            hintText: 'الاسم الكامل',
            icon: Icons.person_outline_rounded,
            controller: _fullNameController,
          ),
          const SizedBox(height: 16),
          AuthField(
            hintText: 'البريد الإلكتروني',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 16),
          AuthField(
            hintText: 'رقم الهاتف',
            icon: Icons.phone_android_rounded,
            keyboardType: TextInputType.phone,
            controller: _phoneController,
          ),
          const SizedBox(height: 16),
          AuthField(
            hintText: 'كلمة السر',
            icon: Icons.lock_outline_rounded,
            obscureText: !_passwordVisible,
            controller: _passwordController,
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
            controller: _confirmPasswordController,
            trailingIcon: _confirmPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            onTrailingTap: () {
              setState(() {
                _confirmPasswordVisible = !_confirmPasswordVisible;
              });
            },
          ),
          const SizedBox(height: 26),
          PrimaryGradientButton(
            label: 'التالي',
            onPressed: _goToIdentity,
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
