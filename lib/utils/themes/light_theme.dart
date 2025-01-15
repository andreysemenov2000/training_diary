import 'package:flutter/material.dart';
import 'package:training_diary/utils/themes/text_theme.dart';

ThemeData createLightTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFFCC0605),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      textTheme: createTextTheme(),
      shadowColor: Colors.grey.withOpacity(0.3),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.grey,
        textTheme: ButtonTextTheme.normal,
      ),
      extensions: [
        CalendarTextThemeExtension.light(),
      ],
    );
