import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
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
    cardColor: const Color(0xFF202020),
    scaffoldBackgroundColor: const Color(0xFF171717),
    listTileTheme: const ListTileThemeData(iconColor: Colors.blueAccent),
    inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        counterStyle: TextStyle(color: Colors.white)),
    textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: Colors.grey,
        selectionHandleColor: Colors.grey),
    dividerColor: Colors.white,
    radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(const Color(0xFF0566A5))),
    textTheme: const TextTheme(
        headline2: TextStyle(color: Colors.grey),
        headline3: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.grey),
        bodyText2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
        caption: TextStyle(color: Colors.blueAccent)),
    iconTheme: const IconThemeData(color: Colors.blueAccent));
