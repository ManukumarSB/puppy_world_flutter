import 'dart:io';

import 'package:flutter/material.dart';

class CustomThemeData {
  static const ocPrimaryTextColor = Color(0xff2a2a2a);
  static const pageBgColor = Color(0xfff1f1f1);
}

final Color _primaryColor = Color(0xFFFB3F00);

ThemeData appTheme() {
  final Map<int, Color> _color = {
    50: Color.fromRGBO(0, 190, 110, .1),
    100: Color.fromRGBO(0, 190, 110, .2),
    200: Color.fromRGBO(0, 190, 110, .3),
    300: Color.fromRGBO(0, 190, 110, .4),
    400: Color.fromRGBO(0, 190, 110, .5),
    500: Color.fromRGBO(0, 190, 110, .6),
    600: Color.fromRGBO(0, 190, 110, .7),
    700: Color.fromRGBO(0, 190, 110, .8),
    800: Color.fromRGBO(0, 190, 110, .9),
    900: Color.fromRGBO(0, 190, 110, 1),
  };

  return ThemeData(
    primarySwatch: MaterialColor(0xFFFB3F00, _color),
    accentColor: Colors.orange[400],
    primaryColorLight: Color(0xfff8f8f8),
    primaryColorDark: Color(0xFF09AD68),
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: TextStyle(
        color: Color(0xff777777),
      ),
      labelStyle: TextStyle(
        color: Color(0xff777777),
      ),
      hintStyle: TextStyle(
        color: Color(0xffbfbfbf),
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: _primaryColor,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: _primaryColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: _primaryColor,
          width: 1,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline4: TextStyle(
        color: Color(0xff2a2a2a),
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        color: Color(0xff2a2a2a),
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: Color(0xff2a2a2a),
      ),
      bodyText1: TextStyle(
        color: Color(0xff2a2a2a),
        fontWeight: FontWeight.w700,
      ),
      bodyText2: TextStyle(
        color: Color(0xff2a2a2a),
      ),
      subtitle1: TextStyle(
        color: Color(0xff2a2a2a),
      ),
      subtitle2: TextStyle(
        color: Color(0xff2a2a2a),
      ),
      caption: TextStyle(color: Color(0xff2a2a2a), fontWeight: FontWeight.w300),
      overline: TextStyle(
        color: Color(0xff2a2a2a),
        fontWeight: FontWeight.w300,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    disabledColor: Color(0xFFD2D1CE),
    hintColor: Color(0xff777777),
    fontFamily: Platform.isIOS ? 'SFPro' : 'Opensans',
    // scaffold's default background color
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
    buttonColor: _primaryColor,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    unselectedWidgetColor: Color(0xFF999999),
    iconTheme: IconThemeData(color: Color(0xff777777)),
  );
}

ThemeData underlinedInputFieldTheme() {
  return ThemeData(
    primaryColor: _primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.orange[400],
          width: 2,
        ),
      ),
    ),
  );
}
