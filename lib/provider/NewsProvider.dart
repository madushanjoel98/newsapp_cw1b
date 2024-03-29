import 'package:country_ip/country_ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/newsModel.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'package:newsapp/models/newsModel.dart';
import 'package:newsapp/utils/SharesPre.dart';
import 'package:newsapp/utils/categoryData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsProvider with ChangeNotifier {
  //final String? apiKey = "ae75c2bc6b604a93af4e8fbd7f5d8c18";
//final String? apiKey = "ae75c2bc6b604a93af4e8fbd7f5d8c18";
  String? apiKey = "5725171cf62e4093aec183723cc77a82";
  String? apiKey2 = "ae75c2bc6b604a93af4e8fbd7f5d8c18";
  int count_calls = 0;

  Future<NewsModel?> fetchData(
      String? query, String? from, String sortBy) async {
    try {
      final url = Uri.parse(
          'https://newsapi.org/v2/everything?q=$query&from=$from&sortBy=$sortBy&apiKey=$apiKey');
      print(url);
      dev.log(url.toString());
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Successful response
        // print('Response data: ${response.body}');
        saveJson(response.body); //Save response
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

  String getDate() {
    DateTime today = DateTime.now();

    // Format the date as a string using the desired format
    String formattedDate =
        "${today.year}-${_twoDigits(today.month)}-${_twoDigits(today.day - 1)}";
    print(formattedDate);
    return formattedDate;
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    } else {
      return "0$n";
    }
  }

  void launchURL(String? url) {
    _launchUrl(url);
  }

  Future<void> _launchUrl(String? url) async {
    if (!await launchUrl(Uri.parse(url!))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<NewsModel?> offlines() {
    return getSavedJsonJSON();
  }
}

String getTodayDate() {
  DateTime today = DateTime.now();

  // Format the date as a string using the desired format
  String formattedDate =
      "${today.year}-${_twoDigits(today.month)}-${_twoDigits(today.day - 1)}";
  print(formattedDate);
  return formattedDate;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  } else {
    return "0$n";
  }
}
