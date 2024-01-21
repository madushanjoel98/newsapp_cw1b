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
