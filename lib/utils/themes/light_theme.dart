import 'package:flutter/material.dart';

ThemeData createLightTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.grey,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      textTheme: ThemeData.light().textTheme,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.grey,
        textTheme: ButtonTextTheme.normal,
      ),
    );
