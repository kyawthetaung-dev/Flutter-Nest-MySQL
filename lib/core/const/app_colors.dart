import 'package:flutter/material.dart';

class AppColors {
  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
  );
  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.blueAccent,
  );
}
