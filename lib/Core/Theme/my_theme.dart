import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_colors.dart';

class MyTheme {
  // Light Theme
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColors.lightBgPrimaryColor,
      colorScheme: ColorScheme.light(
        primary: MyColors.lightPrimaryColor,
        secondary: MyColors.lightBgSecondaryColor,
        onPrimary: Colors.white, // White text for buttons on primary
        onSecondary: MyColors.lightTextColor,
        surface: MyColors.lightSurfaceColor,
        error: MyColors.lightErrorColor,
        onSurface: MyColors.lightTextColor,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          color: MyColors.lightTextColor,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: MyColors.lightTextColor,
          fontSize: 14,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: MyColors.lightTextColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        color: MyColors.lightBgPrimaryColor,
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.lightTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: MyColors.lightTextColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // Text color for buttons
          backgroundColor: MyColors.lightPrimaryColor, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MyColors.lightFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColors.lightBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColors.lightPrimaryColor),
        ),
        labelStyle: TextStyle(color: MyColors.lightTextColor),
        hintStyle: TextStyle(color: MyColors.lightHintColor), // Hint text color
      ),
    );
  }

  // Dark Theme
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: MyColors.darkBgPrimaryColor,
      colorScheme: ColorScheme.dark(
        primary: MyColors.darkPrimaryColor,
        secondary: MyColors.darkBgSecondaryColor,
        onPrimary: Colors.white,
        onSecondary: MyColors.darkTextColor,
        surface: MyColors.darkSurfaceColor,
        error: MyColors.darkErrorColor,
        onSurface: MyColors.darkTextColor,
        onError: Colors.black,
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 14,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: MyColors.darkTextColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        color: MyColors.darkBgPrimaryColor,
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: MyColors.darkTextColor),
      ),
      scaffoldBackgroundColor: MyColors.darkBgPrimaryColor,
      dialogBackgroundColor: MyColors.darkBgPrimaryColor,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: MyColors.darkBgPrimaryColor,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: MyColors.darkBgPrimaryColor,
        titleTextStyle: GoogleFonts.poppins(
          color: MyColors.darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardTheme(
        color: MyColors.darkSurfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // Text color for buttons
          backgroundColor: MyColors.darkPrimaryColor, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MyColors.darkFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColors.darkBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColors.darkBorderColor),
        ),
        labelStyle: TextStyle(color: MyColors.darkTextColor),
        hintStyle: TextStyle(color: MyColors.darkHintColor),
        prefixIconColor: MyColors.darkTextColor // Hint text color
      ),
    );
  }
}