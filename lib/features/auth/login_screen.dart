import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../shared/widgets/app_controls.dart';
import '../home/home_screen.dart';
import 'auth_screens.dart';
import 'auth_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'يرجى إدخال البريد الإلكتروني وكلمة السر');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.signIn(email: email, password: password);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (e) {
      setState(() => _error = 'فشل تسجيل الدخول: تحقق من البريد وكلمة السر');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      horizontalPadding: 36,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
          const AuthLogoHeader(
            title: 'مرحباً بعودتك',
            logoWidth: 108,
            titleTopPadding: 26,
          ),
          const SizedBox(height: 42),
          AuthField(
            hintText: 'البريد الإلكتروني',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
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
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 13,
              ),
            ),
          ],
          const SizedBox(height: 24),
          PrimaryGradientButton(
            label: _loading ? 'جارٍ تسجيل الدخول...' : 'تسجيل الدخول',
            onPressed: _loading ? null : _login,
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
