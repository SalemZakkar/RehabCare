import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: "Cairo",
    primaryColor: const Color(0xFFE79D17),
    primarySwatch: Colors.yellow,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
      centerTitle: true,
      backgroundColor: Color(0xFFE79D17),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    errorColor: Colors.red,
    cardColor: Colors.white,
    scaffoldBackgroundColor: const Color(0XFFF6F6F6),
    listTileTheme: const ListTileThemeData(iconColor: Color(0xFF0566A5)),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0566A5))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0566A5))),
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0566A5))),
    ),
    textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: Colors.grey,
        selectionHandleColor: Colors.grey),
    dividerColor: Colors.grey,
    radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF0566A5))),
    textTheme: const TextTheme(
        headline2: TextStyle(color: Colors.grey),
        headline3: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.grey),
        bodyText2: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black),
        caption: TextStyle(color: Color(0xFF0566A5))),
    iconTheme: const IconThemeData(color: Color(0xFF0566A5)));
