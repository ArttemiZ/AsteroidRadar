// lib/app/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Palette
  static const Color bgDeep = Color(0xFF050A0F);
  static const Color bgCard = Color(0xFF0C1520);
  static const Color bgSurface = Color(0xFF111E2B);
  static const Color amber = Color(0xFFE8A020);
  static const Color amberDim = Color(0xFF9A6A10);
  static const Color amberGlow = Color(0xFFFFBF40);
  static const Color danger = Color(0xFFE83535);
  static const Color dangerDim = Color(0xFF8B1A1A);
  static const Color safe = Color(0xFF1FD07A);
  static const Color safeDim = Color(0xFF0D5C35);
  static const Color medium = Color(0xFFE8A020);
  static const Color textPrimary = Color(0xFFE8EDF2);
  static const Color textSecondary = Color(0xFF7A90A4);
  static const Color textMuted = Color(0xFF3D5166);
  static const Color border = Color(0xFF1A2D3F);

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDeep,
      colorScheme: const ColorScheme.dark(
        primary: amber,
        secondary: amberGlow,
        surface: bgCard,
        error: danger,
      ),
      textTheme: GoogleFonts.rajdhaniTextTheme().copyWith(
        displayLarge: GoogleFonts.rajdhani(
          color: textPrimary,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
        displayMedium: GoogleFonts.rajdhani(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
        headlineMedium: GoogleFonts.rajdhani(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
        bodyLarge: GoogleFonts.sourceCodePro(
          color: textPrimary,
          fontSize: 14,
        ),
        bodyMedium: GoogleFonts.sourceCodePro(
          color: textSecondary,
          fontSize: 12,
        ),
        labelSmall: GoogleFonts.rajdhani(
          color: textMuted,
          fontSize: 10,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bgDeep,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.rajdhani(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
        ),
        iconTheme: const IconThemeData(color: amber),
      ),
      cardTheme: CardThemeData(
        color: bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: border, width: 1),
        ),
      ),
    );
  }
}
