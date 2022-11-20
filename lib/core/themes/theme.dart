import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:local_library/core/themes/palette.dart';

/// Main application theme
class MyTheme {
  static final ThemeData myTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18.0,
        color: Palette.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Palette.black,
      ),
      subtitle1: TextStyle(fontSize: 16),
    ),
    primaryColorLight: Palette.lightGreenSalad,
    primaryColorDark: Palette.lightGreenSalad,
    fontFamily: 'Muli',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Palette.black,
      floatingLabelStyle: TextStyle(color: Palette.green),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Palette.lightGreenSalad, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.lightGreenSalad, width: 2),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.red, width: 2),
      ),
      errorStyle: TextStyle(fontSize: 14.0),
      focusColor: Palette.black,
    ),
    iconTheme: const IconThemeData(color: Palette.orange, size: 30.0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.lightGreenSalad,
    ),
  );
}
