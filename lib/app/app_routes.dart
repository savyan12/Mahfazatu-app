import 'package:flutter/widgets.dart';

import '../features/auth/auth_screens.dart';
import '../features/home/home_screen.dart';
import '../features/transactions/transactions_screen.dart';
import '../features/settings/settings_page_view.dart';
import '../features/splash/splash_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static const initialRoute = SplashScreen.routeName;

  static Map<String, WidgetBuilder> get routes {
    return {
      SplashScreen.routeName: (_) => const SplashScreen(),
      LoginScreen.routeName: (_) => const LoginScreen(),
      SignUpDetailsScreen.routeName: (_) => const SignUpDetailsScreen(),
      SignUpIdentityScreen.routeName: (_) => const SignUpIdentityScreen(),
      HomeScreen.routeName: (_) => const HomeScreen(),
      SettingsPageView.routeName: (_) => const SettingsPageView(),
      TransactionsScreen.routeName: (_) => const TransactionsScreen(),
    };
  }
}
