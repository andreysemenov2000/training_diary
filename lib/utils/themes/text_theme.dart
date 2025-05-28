import 'package:flutter/material.dart';

TextTheme createTextTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    bodyMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  );
}
