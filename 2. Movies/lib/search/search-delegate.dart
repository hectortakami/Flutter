import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/providers/tmdb_provider.dart';

class SearchBar extends SearchDelegate {
  final tmdb = new TMDBProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return manageSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return manageSearchResults();
  }

  Widget manageSearchResults() {
    if (query.length <= 0) {
      return Container();
    } else {
      return FutureBuilder(
        future: tmdb.searchMovie(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  Movie item = snapshot.data![index];
                  item.heroUniqueID = 'search-bar-${item.id}';
                  return ListTile(
                      leading: Hero(
                        tag: item.heroUniqueID,
                        child: FadeInImage(
                          placeholder: AssetImage('assets/no-poster.png'),
                          image: NetworkImage(item.getPoster()),
                          width: 50.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(item.title),
                      subtitle: Text(item.originalTitle),
                      onTap: () {
                        close(context, null);
                        Navigator.pushNamed(context, 'detail', arguments: item);
                      });
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
