import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

const Color blueColor = Color.fromRGBO(5, 102, 165, 1);
const Color yellowColor = Color.fromRGBO(231, 157, 23, 1);

class AppThemes {
  static final Map<AppTheme, ThemeData> appThemeData = {
    /// Dark Theme
    AppTheme.darkTheme: ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(231, 157, 23, 1),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          )),
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      dividerColor: Colors.black54,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(blueColor))),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey, unselectedItemColor: Colors.white),
      fontFamily: 'Cairo-Regular',
    ),

    /// Light Theme
    AppTheme.lightTheme: ThemeData(
      cardColor: Colors.white,
      scaffoldBackgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(231, 157, 23, 1),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          )),
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFE5E5E5),
      dividerColor: const Color(0xff757575),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),
      textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white),
      fontFamily: 'Cairo-Regular',
    ),
  };
}
