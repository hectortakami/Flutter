import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> items;

  CardSwiper({required this.items});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: this.items.length,
        itemWidth: _screenSize.width * 0.55,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          items[index].heroUniqueID = 'card-swiper-${items[index].id}';
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'detail',
                arguments: items[index],
              );
            },
            child: Hero(
              tag: items[index].heroUniqueID,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-poster.png'),
                    image: NetworkImage(items[index].getPoster()),
                    fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
