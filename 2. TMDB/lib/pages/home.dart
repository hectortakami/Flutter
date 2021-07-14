import 'package:flutter/material.dart';
import 'package:flutter_movies/providers/tmdb_provider.dart';
import 'package:flutter_movies/search/search-delegate.dart';
import 'package:flutter_movies/widgets/card-scroll_widget.dart';
import 'package:flutter_movies/widgets/card-swiper_widget.dart';

class HomePage extends StatelessWidget {
  final tmdb = TMDBProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Flutter Movies'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchBar());
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardSwipe(context),
              cardScroll(context),
            ],
          ),
        ));
  }

  Widget cardSwipe(context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        height: MediaQuery.of(context).size.height * .5,
        child: FutureBuilder(
            future: tmdb.getNowPlaying(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return CardSwiper(
                  items: snapshot.data,
                );
              } else {
                return Container(
                    height: 400.0,
                    child: Center(child: CircularProgressIndicator()));
              }
            }),
      ),
    );
  }

  Widget cardScroll(context) {
    tmdb.getPopular();
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Top Popular Movies',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            StreamBuilder(
              stream: tmdb.moviesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return CardScroll(
                    items: snapshot.data,
                    nextPage: tmdb.getPopular,
                  );
                } else {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
          ],
        ));
  }
}
