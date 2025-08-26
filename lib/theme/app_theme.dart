import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF7B1FA2),
      brightness: Brightness.light,
      primary: const Color(0xFF7B1FA2),
      secondary: const Color(0xFFFFC107),
      background: const Color(0xFFF8F6FF),
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F6FF),
    fontFamily: 'Poppins',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF7B1FA2),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        elevation: 6,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF7B1FA2),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      centerTitle: true,
      elevation: 4,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF7B1FA2),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4A148C),
      ),
      bodyLarge: TextStyle(fontSize: 18, color: Color(0xFF333333)),
      bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF333333)),
    ),
  );
}
