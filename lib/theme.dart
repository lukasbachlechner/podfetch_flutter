import 'package:flutter/material.dart';

const darkBlue = Color(0xff0C0921);
const mediumBlue = Color(0xff151039);
const lightBlue = Color(0xff191345);

const accentRed = Color(0xfff24162);
const white = Colors.white;

const kPagePadding = 16.0;

final pfDefaultTheme = ThemeData(
  fontFamily: 'Satoshi',
  primaryColor: mediumBlue,
  primaryColorDark: darkBlue,
  primaryColorLight: lightBlue,
  highlightColor: accentRed,
  backgroundColor: darkBlue,
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
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide(color: white)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: white)),
    filled: true,
    fillColor: white.withOpacity(.05),
    prefixIconColor: white,
    suffixIconColor: white,
  ),
);
