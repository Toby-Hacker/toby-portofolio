import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    final textTheme = GoogleFonts.spaceMonoTextTheme(base.textTheme).apply(
      bodyColor: AppColors.textOnDark,
      displayColor: AppColors.textOnDark,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.black,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primaryGreen,
        surface: AppColors.black,
      ),
      textTheme: textTheme,
      dividerColor: AppColors.borderOnDark,
      cardColor: AppColors.cardOnDark,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: const Color(0xFF9A9A9A)),
        labelStyle: textTheme.bodySmall?.copyWith(
          color: AppColors.textOnDark,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    final textTheme = GoogleFonts.spaceMonoTextTheme(base.textTheme).apply(
      bodyColor: const Color(0xFF111111),
      displayColor: const Color(0xFF111111),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.offWhite,
      colorScheme: base.colorScheme.copyWith(primary: AppColors.primaryGreen),
      textTheme: textTheme,
    );
  }
}
