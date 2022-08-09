import 'package:flutter/material.dart';

const darkBlue = Color(0xff0C0921);
const mediumBlue = Color(0xff151039);
const lightBlue = Color(0xff191345);

const accentRed = Color(0xfff24162);
const white = Colors.white;

const uiError = Colors.red;
const uiSuccess = Colors.green;
const uiWarning = Colors.amber;

const kPagePadding = 16.0;

final pfDefaultTheme = ThemeData(
  fontFamily: 'Satoshi',
  primaryColor: mediumBlue,
  primaryColorDark: darkBlue,
  primaryColorLight: lightBlue,
  highlightColor: accentRed,
  backgroundColor: darkBlue,
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: white),
  scaffoldBackgroundColor: darkBlue,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: mediumBlue,
    selectedItemColor: accentRed,
    unselectedItemColor: white,
  ),
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
  ).apply(
    displayColor: white,
    bodyColor: white,
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 16.0, fontFamily: 'Satoshi'),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return accentRed;
      }

      return white;
    }),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    modalBackgroundColor: Colors.transparent,
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: accentRed,
    thumbColor: accentRed,
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    border: const OutlineInputBorder(borderSide: BorderSide(color: white)),
    focusedBorder:
        const OutlineInputBorder(borderSide: BorderSide(color: white)),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent)),
    filled: true,
    fillColor: white.withOpacity(.05),
    prefixIconColor: white,
    suffixIconColor: white,
    labelStyle: const TextStyle(color: white),
  ),
);
