import 'package:flutter/material.dart';

class UColors {
  UColors._();

  // 🌟 Image ka Main Accent Color (Rich & Soft Color)
  static const Color primary = Color(0xFF4CAF50); // Soothing green primary shade

  // Text colors (Pure black aankhon ko chubhta hai, isliye image ka darkest slate/charcoal)
  static const Color textPrimary = Color(0xFF2C3238);
  static const Color textSecondary = Color(0xFF828A91);
  static const Color textWhite = Colors.white;

  // Background colors (Image ke sabse light aur dark base colors)
  static const Color light = Color(0xFFF6F3EB); // Ekdum soft creamy background
  static const Color dark = Color(0xFF000000);  // Deep slate dark background

  // Button colors
  static const Color buttonPrimary = Color(0xFF388E3C); // Darker soothing green for buttons
  static const Color buttonDisabled = Color(0xFFD6D3C9);

  // Border colors (Soft borders jo cream background ke saath ghul jayein)
  static const Color borderPrimary = Color(0xFFE3DFD5);
  static const Color borderSecondary = Color(0xFFEAE7DF);

  // Error and validation colors
  static const Color error = Color(0xFFD9534F);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFF0AD4E);
  static const Color info = Color(0xFF5BC0DE);

  static const Color yellow = Color(0xFFE8C37C);

  // 🌟 Neutral Shades (Image ke aesthetic ke hisaab se tint kiye gaye hain)
  static const Color black = Color(0xFF1E2226); // Dark mode ka base
  static const Color darkerGrey = Color(0xFF4C555C);
  static const Color darkGrey = Color(0xFF828A91);
  static const Color grey = Color(0xFFD6D3C9);
  static const Color lightGrey = Color(0xFFEAE7DF);

  // 🔥 Ninja Hack: Pure white ki jagah image ka sabse light pastel cream color
  static const Color white = Color(0xFFF6F3EB);
}