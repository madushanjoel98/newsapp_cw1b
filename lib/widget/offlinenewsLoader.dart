import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/newsModel.dart';
import 'package:newsapp/provider/NewsProvider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class OfflineNews extends StatelessWidget {
  const OfflineNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, news, child) {
        return FutureBuilder<NewsModel?>(
          future: news.offlines(),
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
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.articles.length,
                itemBuilder: (context, int index) {
                  var article = snapshot.data?.articles.elementAt(index);
                  return GestureDetector(
                    onLongPress: () {
                      Share.share(article!.title! + " " + article!.url!, subject: 'News');
                    },
                    onTap: () {
                      news.launchURL(article!.url);
                    },
                    child: Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 4.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: article?.urlToImage ??
                                  "https://thumbs.dreamstime.com/b/newspaper-line-news-icon-press-article-paper-journal-212522658.jpg",
                              placeholder: (context, url) => Container(
                                height: 200.0,
                                child: Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/newsimage.png',
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                              height: 200.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              article?.title ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              article?.description ?? "",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No data available.'),
              );
            }
          },
        );
      },
    );
  }
}
