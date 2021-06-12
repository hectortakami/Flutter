import 'dart:async';
import 'dart:convert';
import 'package:flutter_movies/models/actor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movies/models/movie.dart';

class TMDBProvider {
  String _apiKey = '3562a77d8968c9e30b3d1410e3812018';
  String _baseURL = 'api.themoviedb.org';
  String _language = 'en-EN';

  int _pageNumber = 0;
  List<Movie> _popularMovies = [];
  bool _isLoading = false;

  final _moviesStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get moviesSink => _moviesStreamController.sink.add;
  Stream<List<Movie>> get moviesStream => _moviesStreamController.stream;

  void disposeStreams() {
    _moviesStreamController.close();
  }

  // Process the HTTP request and parse it to the desired result model
  Future<List<Movie>> fetchResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final data = new Movies.fromJsonList(decodedData['results']);
    return data.movieList;
  }

  // Get a list of movies in theatres.
  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_baseURL, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    return fetchResponse(url);
  }

  // Get a list of the current popular movies on TMDB. This list updates daily.
  Future<List<Movie>> getPopular() async {
    if (_isLoading || _pageNumber >= 999) return [];
    _isLoading = true;

    _pageNumber++;

    final url = Uri.https(_baseURL, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '$_pageNumber'});

    final response = await fetchResponse(url);
    _popularMovies.addAll(response);
    moviesSink(_popularMovies);

    _isLoading = false;
    return response;
  }

  // Get a list of the actors from a particular movie
  Future<List<Actor>> getCastActors(int movieID) async {
    final url = Uri.https(_baseURL, '3/movie/$movieID/credits',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final data = new Actors.fromJsonList(decodedData['cast']);
    return data.actorList;
  }

  // Get a list of movies that match the searching parameter
  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseURL, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    return fetchResponse(url);
  }
}
