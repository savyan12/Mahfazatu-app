import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/app_colors.dart';
import 'app_routes.dart';

class MahfazatiApp extends StatelessWidget {
  const MahfazatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.mint,
        brightness: Brightness.dark,
        primary: AppColors.mint,
        surface: AppColors.card,
      ),
      scaffoldBackgroundColor: AppColors.backgroundBottom,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        filled: false,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'محفظتي',
      locale: const Locale('ar'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.almaraiTextTheme(baseTheme.textTheme),
        primaryTextTheme: GoogleFonts.almaraiTextTheme(
          baseTheme.primaryTextTheme,
        ),
      ),
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
