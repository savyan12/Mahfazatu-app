import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahfazati_app/app/mahfazati_app.dart';
import 'package:mahfazati_app/features/auth/auth_screens.dart';
import 'package:mahfazati_app/features/home/home_screen.dart';
import 'package:mahfazati_app/features/splash/splash_screen.dart';

void main() {
  testWidgets('Mahfazati splash renders brand identity', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MahfazatiApp());
    await tester.pump();

    expect(find.text('محفظتي'), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('auth routes render login and signup steps', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MahfazatiApp());

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushReplacementNamed(LoginScreen.routeName);
    await tester.pumpAndSettle();
    expect(find.text('مرحباً بعودتك'), findsOneWidget);

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushNamed(SignUpDetailsScreen.routeName);
    await tester.pumpAndSettle();
    expect(find.text('إنشاء حساب جديد'), findsOneWidget);
    expect(find.text('الخطوة 1 من 2'), findsOneWidget);

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushNamed(SignUpIdentityScreen.routeName);
    await tester.pumpAndSettle();
    expect(find.text('اكتمال الملف الشخصي'), findsOneWidget);
    expect(find.text('التحقق من الهوية'), findsOneWidget);
  });

  testWidgets('home route renders wallet overview', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MahfazatiApp());

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushReplacementNamed(HomeScreen.routeName);
    await tester.pumpAndSettle();

    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.text('مساء الخير،\nسفيان'), findsOneWidget);
    expect(find.text('10,000 LYD'), findsOneWidget);
    expect(find.text('آخر المعاملات'), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);
  });
}
