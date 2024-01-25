import 'package:flutter/material.dart';
import 'package:newsapp/widget/loadNews.dart';

class LoadCats extends StatefulWidget {
  LoadCats(this.catname,this.colors);

  final String? catname;
final Color? colors;
  @override
  _LoadCatsState createState() => _LoadCatsState();
}

class _LoadCatsState extends State<LoadCats> {
  String? currentSortOption = 'publishedAt'; // Default sort option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.colors,
        title: Text(widget.catname!),
        actions: [

          PopupMenuButton(
            icon: Icon(Icons.filter_list_rounded),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('Sort By Published At'),
                value: 'publishedAt',
              ),
              PopupMenuItem(
                child: Text('Sort By Popularity'),
                value: 'popularity',
              
              ),
              // Add more sorting options as needed
            ],
            onSelected: (String value) {
              // Handle the selected sort option
              setState(() {
                currentSortOption = value;
              });
              print('Selected sort option: $value');
              // You may want to call a function to reload news based on the selected sort option
            },
          ),
        ],
      ),
      body: Center(
        child: LoadNews.withPram(widget.catname!, currentSortOption, ""),
      ),
    );
  }
}
