import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringUtilityX on String {
  String? get ddMMyyyy => DateFormat("dd-MM-yyyy").format(DateTime.parse(this));
}

extension ContextX on BuildContext {
  ColorScheme get color => Theme.of(this).colorScheme;
}
