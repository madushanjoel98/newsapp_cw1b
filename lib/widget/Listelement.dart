import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/utils/categoryData.dart';
import 'package:newsapp/views/LoadCatPage.dart';

class TopCats extends StatelessWidget {
  const TopCats({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CatgoryItemModel>>(
      future: getCatlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          List<CatgoryItemModel> catList = snapshot.data ?? [];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: catList.length,
            itemExtent: MediaQuery.of(context).size.width / 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadCats(catList[index].name, catList[index].colors),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: catList[index].colors,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          catList[index].emoji,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          catList[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
