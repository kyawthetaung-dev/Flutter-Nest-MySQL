import 'dart:developer';

import 'package:flutter/foundation.dart';

void plog(String title, dynamic message) {
  if (kDebugMode) {
    log("$title: ${message.toString()}");
  }
}
