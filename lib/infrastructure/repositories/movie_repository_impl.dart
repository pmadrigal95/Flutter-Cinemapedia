import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/datasources/movie_datasources.dart';
import 'package:cinemapedia/config/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> getRecommendations({required String id, int page = 1}) {
    return datasource.getRecommendations(id: id, page: page);
  }

  @override
  Future<List<Movie>> getSimilar({required String id, int page = 1}) {
    return datasource.getSimilar(id: id, page: page);
  }
}
