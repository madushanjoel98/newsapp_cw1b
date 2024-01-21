import 'package:flutter/material.dart';
import 'package:newsapp/provider/NewsProvider.dart';
import 'package:newsapp/widget/loadNews.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "", from = "", sortBy = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
centerTitle: true,
        actions: [
          Center(
            child: Container(
              color: Colors.white,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width, // Set the desired width of your search field
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Search"),
                  onChanged: (value) {
                    // Update the query when the user types
                    setState(() {
                      query = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: LoadNews.withPram(query, sortBy, getTodayDate()),
    );
  }
}
