import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'package:newsapp/models/newsModel.dart';


final String? apiKey = "ae75c2bc6b604a93af4e8fbd7f5d8c18";

Future<NewsModel?> fetchData(String? query, String? from, String sortBy) async {
  try {
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$query&from=$from&sortBy=$sortBy&apiKey=$apiKey');
    print(url);
    dev.log(url.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successful response
      print('Response data: ${response.body}');
      return parseNewsModel(response.body);
    } else {
      // Error handling
      print(response.body);
      print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    // Exception handling
    print('Exception: $e');
    return null;
  }
}
