import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../data/session.dart';
import '../../data/user.dart';
import '../../shared/widgets/app_controls.dart';
import '../home/home_screen.dart';
import 'auth_screens.dart';
import 'auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/users.json');
      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
      if (!mounted) return;
      Session.users = decoded
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
      setState(() => _loading = false);
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'يرجى إدخال البريد الإلكتروني وكلمة السر');
      return;
    }

    if (Session.login(email, password)) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      setState(() => _error = 'البريد الإلكتروني أو كلمة السر غير صحيحة');
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
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ],
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(color: AppColors.mint),
            )
          else ...[
            const SizedBox(height: 24),
            PrimaryGradientButton(
              label: 'تسجيل الدخول',
              onPressed: _login,
            ),
          ],
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
                  Navigator.of(context).pushNamed(
                    SignUpDetailsScreen.routeName,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
