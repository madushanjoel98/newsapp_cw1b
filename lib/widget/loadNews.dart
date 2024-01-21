import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/newsModel.dart';
import 'package:newsapp/provider/NewsProvider.dart';
import 'package:provider/provider.dart';

class LoadNews extends StatefulWidget {
  LoadNews({Key? key});
  String? query;
  String? sortby;
  String? date;
  bool? isSearch;

  LoadNews.withPram(this.query, this.sortby, this.date);
  LoadNews.forSearch(this.query, this.sortby, this.date, this.isSearch);

  @override
  State<LoadNews> createState() => _LoadNewsState();
}

class _LoadNewsState extends State<LoadNews> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, news, child) {
        return FutureBuilder<NewsModel?>(
          future: news.fetchData(widget.query!, widget.date, widget.sortby!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Use the NewsModel data to build your UI
              // Example: return Text(snapshot.data.status);
              return ListView.builder(
                itemCount: snapshot.data?.articles.length,
                itemBuilder: (context, int index) {
                  var article = snapshot.data?.articles.elementAt(index);
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        news.launchURL(article!.url);
                      },
                      child: Container(
                        color: Colors.amberAccent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: widget.isSearch != null && !widget.isSearch!
                                      ? CachedNetworkImage(
                                    imageUrl: article?.urlToImage ??
                                        "https://thumbs.dreamstime.com/b/newspaper-line-news-icon-press-article-paper-journal-212522658.jpg",
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/newsimage.png'),
                                  )
                                      : Container(),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      article?.title ?? "",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('No data available.');
            }
          },
        );
      },
    );
  }
}
