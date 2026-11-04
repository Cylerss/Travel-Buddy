import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Sunset Coastal Terracotta Palette (from revamped design)
  static const Color primaryColor = Color(0xFFF05423); // Sunset Orange
  static const Color primaryLight = Color(0xFFFF7A45); // Warm Coral Light
  static const Color primaryDark = Color(0xFFD34113); // Deep Terracotta
  static const Color accentCoral = Color(0xFFFF6F3C); // Warm Coral Accent
  static const Color accentGold = Color(0xFFF59E0B); // Amber / Rating Gold
  static const Color backgroundLight = Color(0xFFFAF4EE); // Warm Sand / Cream Ivory
  static const Color surfaceLight = Colors.white;
  static const Color cardLight = Colors.white;
  static const Color cardBorderColor = Color(0xFFEFE4DA); // Subtle Warm Biscuit Border
  static const Color chipBackground = Color(0xFFF6ECE2);
  static const Color chipBorder = Color(0xFFEBD9C8);

  // Status & Actions
  static const Color sosRed = Color(0xFFDC2626); // Emergency SOS Crimson
  static const Color sosLight = Color(0xFFFEE2E2);
  static const Color successGreen = Color(0xFF16A34A); // Verified Emerald
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color pendingAmber = Color(0xFFD97706);
  static const Color pendingLight = Color(0xFFFEF3C7);

  // Dark Palette
  static const Color backgroundDark = Color(0xFF191412); // Deep Espresso Navy
  static const Color surfaceDark = Color(0xFF261F1C);
  static const Color cardDark = Color(0xFF332A26);
  static const Color cardBorderDark = Color(0xFF4A3E39);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF231815); // Rich Espresso
  static const Color textSecondaryLight = Color(0xFF7A6E69); // Warm Slate Gray
  static const Color textPrimaryDark = Color(0xFFFAF4EE);
  static const Color textSecondaryDark = Color(0xFFA89C97);

  // Gradient helper
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF25A2A), Color(0xFFFF7E47)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xCC000000), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  // Typography helper functions
  static TextStyle serifTitle({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w600,
    Color color = textPrimaryLight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle sansBody({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = textPrimaryLight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: accentCoral,
      surface: surfaceLight,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundLight,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.light().textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundLight,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: textPrimaryLight),
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textPrimaryLight,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: const Color(0x1A231815),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: cardBorderColor, width: 1),
      ),
      color: surfaceLight,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryLight,
      primary: primaryLight,
      secondary: accentCoral,
      surface: surfaceDark,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: backgroundDark,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.dark().textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: textPrimaryDark),
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: cardBorderDark, width: 1),
      ),
      color: surfaceDark,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: backgroundDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
