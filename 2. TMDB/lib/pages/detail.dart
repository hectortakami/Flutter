import 'package:flutter/material.dart';
import 'package:flutter_movies/models/actor.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/providers/tmdb_provider.dart';

class DetailPage extends StatelessWidget {
  final tmdb = new TMDBProvider();

  @override
  Widget build(BuildContext context) {
    // Receive parameters from the Navigator
    final param = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          sliverAppBar(param),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              posterDescription(context, param),
              SizedBox(
                height: 10.0,
              ),
              actorCardScroll(context, param)
            ]),
          ),
        ],
      ),
    );
  }

  sliverAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackdropPath()),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  posterDescription(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Hero(
                tag: movie.heroUniqueID,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    image: NetworkImage(movie.getPoster()),
                    placeholder: AssetImage('assets/no-poster.png'),
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20.0),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    movie.originalTitle,
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text(
                        movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
          Divider(
            height: 20.0,
          ),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  actorCardScroll(BuildContext context, Movie movie) {
    return FutureBuilder(
      future: tmdb.getCastActors(movie.id),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 250.0,
            child: PageView.builder(
                itemCount: snapshot.data!.length,
                pageSnapping: false,
                controller:
                    PageController(initialPage: 1, viewportFraction: 0.3),
                itemBuilder: (BuildContext context, int index) {
                  return actorCard(snapshot.data![index]);
                }),
          );
        } else {
          return Container(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }

  actorCard(Actor actor) {
    return Container(
      height: 250.0,
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-poster.png'),
              image: NetworkImage(actor.getPoster()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            actor.name,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
