import 'package:newsapp/models/newsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPrefs() async {
  //GetData
  return await SharedPreferences.getInstance();
}

Future<void> saveJson(String? response) async {
  //Saving
  final prefs = await getPrefs();
  print("Saved Data");
  await prefs.setString('news', response!);
}

Future<NewsModel?> getSavedJsonJSON() async {
  //Convert saved Json to NewsModel Model
  final prefs = await getPrefs();
  return parseNewsModel(prefs.getString('news')!);
}

