import 'package:flutter/material.dart';

import '../feat_core.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        // fontFamily: 'Pyidaungsu',

        // color
        colorScheme: AppColors.lightColorScheme,

        // TextFormField
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          isDense: true,
          fillColor: Colors.white70,
          errorStyle: TextStyle(
            color: AppColors.lightColorScheme.error,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black12,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black12,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.black12,
            ),
          ),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gapPadding: 0,
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.solid,
              color: Colors.black12,
            ),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: AppColors.darkColorScheme,
        // fontFamily: 'Pyidaungsu',

        // TextFormField
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          isDense: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          disabledBorder: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gapPadding: 0,
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      );
}
