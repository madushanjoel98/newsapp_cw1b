import 'package:newsapp/models/newsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async {
  return await SharedPreferences.getInstance();
}

Future<void> saveJson(String? response) async {
  final prefs = await getPrefs();
  print("Saved Data");
  await prefs.setString('news', response!);
}

Future<NewsModel?> getSavedJsonJSON() async {
  final prefs = await getPrefs();
  return parseNewsModel(prefs.getString('news')!);
}

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}