import 'package:cinemapedia/config/domain/datasources/actor_datasources.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/config/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl extends ActorRepository {
  final ActorDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) {
    return datasource.getActorsByMovieId(movieId);
  }
}
