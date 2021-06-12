class Movies {
  List<Movie> movieList = [];

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      final movie = new Movie.fromJson2Map(item);
      movieList.add(movie);
    }
  }
}

class Movie {
  // Used to identify unique items in the Hero animation (even when repeated in same screen)
  late String heroUniqueID;
  late bool adult;
  late String backdropPath;
  late List<int> genreIds;
  late int id;
  late dynamic originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  String getPoster() {
    // ignore: unnecessary_null_comparison
    if (this.posterPath == null || this.posterPath.length <= 0) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
    }
    return 'https://image.tmdb.org/t/p/w500' + this.posterPath;
  }

  String getBackdropPath() {
    // ignore: unnecessary_null_comparison
    if (this.backdropPath == null || this.backdropPath.length <= 0) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
    }
    return 'https://image.tmdb.org/t/p/w500' + this.backdropPath;
  }

  Movie.fromJson2Map(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }
}
