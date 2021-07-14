import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie.dart';

class CardScroll extends StatelessWidget {
  final List<dynamic> items;
  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);
  final Function nextPage;

  CardScroll({required this.items, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return pageViewItem(context, items[index]);
        },
      ),
    );
  }

  Widget pageViewItem(BuildContext context, Movie item) {
    item.heroUniqueID = 'card-scroll-${item.id}';

    final pageItem = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: item.heroUniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-poster.png'),
                image: NetworkImage(item.getPoster()),
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            item.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: pageItem,
      onTap: () {
        Navigator.pushNamed(
          context,
          'detail',
          arguments: item,
        );
      },
    );
  }
}
