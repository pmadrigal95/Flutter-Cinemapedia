import 'package:cinemapedia/config/domain/entities/actor.dart';

abstract class ActorDatasource {

   Future<List<Actor>> getActorsByMovieId(String movieId);
}
