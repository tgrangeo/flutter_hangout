import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../style/styles.dart' as s;
import '../main.dart';
import '../model/themeModels.dart';

class Preferences {
  static const COLOR_KEY = "color_key";
  static const THEME_KEY = "system";
  static const LOCALE_KEY = "locale_key";

  static Future setLocale(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(LOCALE_KEY, value);
  }

  static Future<String> getLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String locale = sharedPreferences.getString(LOCALE_KEY)!;
    return locale;
  }

  static Future setColor(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(COLOR_KEY, value);
  }

  static Future getColor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var stringe = sharedPreferences.getString(COLOR_KEY);
    print("in pref $stringe");
    return sharedPreferences.getString(COLOR_KEY) ?? 0;
  }

  static Future setTheme(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(THEME_KEY, value);
  }

  static Future<String> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String theme = sharedPreferences.getString(THEME_KEY)!;
    return theme;
  }
}

class ThemeProvider extends ChangeNotifier {
  late ThemeMode selectedThemeMode;
  late Color selectedPrimaryColor = AppColors.primaryColors[0];
  late String _locale;
  String get locale => _locale;
  ThemeMode get themeMode => selectedThemeMode;

  ThemeProvider() {
    _locale = "en";
    selectedThemeMode = ThemeMode.system;
    getPreferences();
  }

  getPreferences() async {
    _locale = await Preferences.getLocale();

    String prefColor = await Preferences.getColor();
    String valueString = prefColor.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    selectedPrimaryColor = Color(value);

    var tempTheme = await Preferences.getTheme();
    if (tempTheme == "dark") {
      selectedThemeMode = ThemeMode.dark;
    } else if (tempTheme == "light") {
      selectedThemeMode = ThemeMode.light;
    } else {
      selectedThemeMode = ThemeMode.system;
    }

    return notifyListeners();
  }

  setSelectedPrimaryColor(Color _color) {
    selectedPrimaryColor = _color;
    var string = _color.toString();
    print("set color $string");
    Preferences.setColor(_color.toString());
    notifyListeners();
  }

  setSelectedThemeMode(ThemeMode _themeMode) {
    selectedThemeMode = _themeMode;
    if (_themeMode == ThemeMode.dark) {
      Preferences.setTheme("dark");
    } else if (_themeMode == ThemeMode.light) {
      Preferences.setTheme("light");
    } else {
      Preferences.setTheme("auto");
    }
    notifyListeners();
  }

  seSelectedLocale(String locale) {
    _locale = locale;
    Preferences.setLocale(locale);
    notifyListeners();
  }
}
