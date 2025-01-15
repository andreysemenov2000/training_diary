import 'package:flutter/material.dart';
import 'package:training_diary/utils/themes/text_theme.dart';

ThemeData createDarkTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.white,
        textTheme: ButtonTextTheme.normal,
      ),
      extensions: [
        CalendarTextThemeExtension.dark(),
      ],
    );
