import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.blue, //primary dark
    primaryContainer: Colors.blue,
    secondary: Colors.blueAccent,
    secondaryContainer: Colors.blueAccent,
    error: Colors.red,
    brightness: Brightness.light,
  ),
  primarySwatch: Colors.blue,
);