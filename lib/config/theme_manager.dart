import 'package:flutter/material.dart';

import 'config_export.dart';

class ThemeManage {
  static List<ThemeData> appThemes = [lightTheme, darkTheme];

  static Future<void> setTheme(int i) async {
    await pref.setInt("theme", i);
  }

  static int getTheme() {
    return pref.getInt("theme") ?? 0;
  }
}
