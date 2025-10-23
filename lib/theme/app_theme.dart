import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.nunitoSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.nunitoSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.nunitoSans(
        fontSize: 18,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.nunitoSans(
        fontSize: 16,
        color: Colors.black54,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.blueAccent,
    ),
  );
}