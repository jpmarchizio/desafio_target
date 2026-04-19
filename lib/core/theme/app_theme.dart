import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, brightness: Brightness.light),
    textTheme: _textTheme(AppColors.textPrimaryLight),
    inputDecorationTheme: _inputTheme(fill: AppColors.surfaceLight, border: AppColors.borderLight),
    elevatedButtonTheme: _elevatedButtonTheme(AppColors.primary),
    outlinedButtonTheme: _outlinedButtonTheme(AppColors.borderLight),
    textButtonTheme: _textButtonTheme(AppColors.primary),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryDark, brightness: Brightness.dark),
    textTheme: _textTheme(AppColors.textPrimaryDark),
    inputDecorationTheme: _inputTheme(fill: AppColors.surfaceDark, border: AppColors.borderDark),
    elevatedButtonTheme: _elevatedButtonTheme(AppColors.primaryDark),
    outlinedButtonTheme: _outlinedButtonTheme(AppColors.borderDark),
    textButtonTheme: _textButtonTheme(AppColors.primaryDark),
  );

  static TextTheme _textTheme(Color color) => TextTheme(
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
      color: color,
    ),
    displayMedium: GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      color: color,
    ),
    titleMedium: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w600, color: color),
    bodyLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: color),
    bodyMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: color),
    labelSmall: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.04, color: color),
  );

  static InputDecorationTheme _inputTheme({required Color fill, required Color border}) => InputDecorationTheme(
    filled: true,
    fillColor: fill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: _inputBorder(border),
    enabledBorder: _inputBorder(border),
    focusedBorder: _inputBorder(AppColors.primary, width: 1.5),
    errorBorder: _inputBorder(AppColors.error),
    focusedErrorBorder: _inputBorder(AppColors.error, width: 1.5),
  );

  static OutlineInputBorder _inputBorder(Color color, {double width = 1.0}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: width),
  );

  static ElevatedButtonThemeData _elevatedButtonTheme(Color color) => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600),
      elevation: 0,
    ),
  );

  static OutlinedButtonThemeData _outlinedButtonTheme(Color border) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: border),
      textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
      elevation: 0,
    ),
  );

  static TextButtonThemeData _textButtonTheme(Color color) => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: color,
      textStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
    ),
  );
}
