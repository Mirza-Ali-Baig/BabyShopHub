import 'package:flutter/material.dart';

class MyColors {
  MyColors._();
  // Light Theme Colors (Baby Colors)
  static const Color _lightTextColor = Color(0xFF4A4A4A); // Soft dark gray
  static const Color _lightBgPrimaryColor = Color(0xFFFDFDFD); // Very light gray
  static const Color _lightBgSecondaryColor = Color(0xFFB3E5FC); // Light blue
  static const Color _lightPrimaryColor = Color(0xFF81D4FA); // Sky blue
  static const Color _lightSecondaryColor = Color(0xFFFFAB91); // Light orange
  static const Color _lightAccentColor = Color(0xFFFFE082); // Light yellow
  static const Color _lightFillColor = Color(0xFFFFFFFF); // White for input fields
  static const Color _lightBorderColor = Color(0xFFD1C4E9); // Light lavender
  static const Color _lightHintColor = Color(0xFFB0BEC5); // Light gray for hints
  static const Color _lightSurfaceColor = Color(0xFFFFFFFF); // Card background
  static const Color _lightErrorColor = Color(0xFFEF5350); // Soft red for errors

  // Dark Theme Colors (Baby Colors)
  static const Color _darkTextColor = Color(0xFFFAFAFA); // Light gray
  static const Color _darkBgPrimaryColor = Color(0xFF212121); // Dark gray
  static const Color _darkBgSecondaryColor = Color(0xFF424242); // Slightly lighter gray
  static const Color _darkPrimaryColor = Color(0xFF64B5F6); // Light blue
  static const Color _darkSecondaryColor = Color(0xFFFFAB91); // Light orange
  static const Color _darkAccentColor = Color(0xFFFFE082); // Light yellow
  static const Color _darkFillColor = Color(0xFF2C2C2C); // Dark fill for input fields
  static const Color _darkBorderColor = Color(0xFF757575); // Darker border color
  static const Color _darkHintColor = Color(0xFFB0BEC5); // Hint text color
  static const Color _darkSurfaceColor = Color(0xFF424242); // Dark card background
  static const Color _darkErrorColor = Color(0xFFE57373); // Softer red for errors

  // Getters for Light Theme Colors
  static Color get lightTextColor => _lightTextColor;
  static Color get lightBgPrimaryColor => _lightBgPrimaryColor;
  static Color get lightBgSecondaryColor => _lightBgSecondaryColor;
  static Color get lightPrimaryColor => _lightPrimaryColor;
  static Color get lightSecondaryColor => _lightSecondaryColor;
  static Color get lightAccentColor => _lightAccentColor;
  static Color get lightFillColor => _lightFillColor;
  static Color get lightBorderColor => _lightBorderColor;
  static Color get lightHintColor => _lightHintColor;
  static Color get lightSurfaceColor => _lightSurfaceColor;
  static Color get lightErrorColor => _lightErrorColor;

  // Getters for Dark Theme Colors
  static Color get darkTextColor => _darkTextColor;
  static Color get darkBgPrimaryColor => _darkBgPrimaryColor;
  static Color get darkBgSecondaryColor => _darkBgSecondaryColor;
  static Color get darkPrimaryColor => _darkPrimaryColor;
  static Color get darkSecondaryColor => _darkSecondaryColor;
  static Color get darkAccentColor => _darkAccentColor;
  static Color get darkFillColor => _darkFillColor;
  static Color get darkBorderColor => _darkBorderColor;
  static Color get darkHintColor => _darkHintColor;
  static Color get darkSurfaceColor => _darkSurfaceColor;
  static Color get darkErrorColor => _darkErrorColor;

  // Methods to get colors based on the current theme
  static Color textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextColor
        : lightTextColor;
  }

  static Color bgPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBgPrimaryColor
        : lightBgPrimaryColor;
  }

  static Color bgSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBgSecondaryColor
        : lightBgSecondaryColor;
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimaryColor
        : lightPrimaryColor;
  }

  static Color secondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSecondaryColor
        : lightSecondaryColor;
  }

  static Color accentColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkAccentColor
        : lightAccentColor;
  }

  static Color fillColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkFillColor
        : lightFillColor;
  }

  static Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderColor
        : lightBorderColor;
  }

  static Color hintColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkHintColor
        : lightHintColor;
  }

  static Color surfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceColor
        : lightSurfaceColor;
  }

  static Color errorColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkErrorColor
        : lightErrorColor;
  }
}