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
}
