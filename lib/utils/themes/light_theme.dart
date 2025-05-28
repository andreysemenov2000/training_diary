import 'package:flutter/material.dart';
import 'package:training_diary/utils/themes/colors.dart';
import 'package:training_diary/utils/themes/extensions/calendar_theme_extension.dart';
import 'package:training_diary/utils/themes/extensions/train_block_theme_extension.dart';
import 'package:training_diary/utils/themes/text_theme.dart';

ThemeData createLightTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      highlightColor: highlightColor,
      fontFamily: 'Montserrat',
      textTheme: createTextTheme(),
      shadowColor: Colors.grey.withValues(alpha: 0.3),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.grey,
        textTheme: ButtonTextTheme.normal,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        extendedTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      extensions: [
        CalendarThemeExtension.light(),
        TrainBlockThemeExtension(),
      ],
    );
