import 'dart:io';

import 'package:country_ip/country_ip.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/provider/NewsProvider.dart';
import 'package:newsapp/views/webview.dart';
import 'package:newsapp/widget/loadNews.dart';
import 'package:newsapp/widget/offlinenewsLoader.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsHomePage extends StatelessWidget {
   NewsHomePage({Key? key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<bool>(
          future: checkConnectivity(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              bool isOnline = snapshot.data ?? false;
              String query = "World", from = "", sortBy = "publishedAt";

              if (isOnline) {
                return LoadNews.withPram(query, sortBy, getTodayDate());
              } else {
                // Show offline UI here
                return Center(
                  child: OfflineNews(),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> checkConnectivity(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      // Show SnackBar here
      final snackBar = SnackBar(
        content: Text("No internet connection"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
}

Future<void> launchUrl(String? url) async {
  if (url != null && await canLaunch(url)) {
    await launch(url);
  } else {
    throw Exception('Could not launch $url');
  }
}
