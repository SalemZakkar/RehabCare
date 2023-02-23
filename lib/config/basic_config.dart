import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

getDirection(bool languageIsEnglish) {
  if (languageIsEnglish == true) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}

late SharedPreferences pref;
