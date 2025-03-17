import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../feat_core.dart';

final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((ref) {
  final isDart = sharedPreferences.getBool(AppKeys.theme) ?? false;
  return isDart ? ThemeMode.dark : ThemeMode.light;
});
