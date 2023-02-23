import 'config_export.dart';

class LanguageManager {
  static String getLang() {
    return pref.getString("lang") ?? "en";
  }

  static void setLang(String lang) {
    pref.setString("lang", lang);
  }
}
