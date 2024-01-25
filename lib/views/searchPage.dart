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
        actions: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context)
                .width, // Adjust the desired width of your search field
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 5, 8),
                child: TextField(
                  autocorrect: true,
                  style: TextStyle(color: Colors.black),
                  // Set text color to black
                  decoration: InputDecoration(

                    alignLabelWithHint: true,
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
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
