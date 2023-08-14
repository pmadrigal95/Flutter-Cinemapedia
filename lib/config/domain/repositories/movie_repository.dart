import 'package:cinemapedia/config/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getSimilar({ required String id, int page = 1});

  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getRecommendations({ required String id, int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovies( String query);
}
