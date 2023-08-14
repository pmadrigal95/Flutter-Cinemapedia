import 'package:cinemapedia/config/domain/entities/actor.dart';

abstract class ActorRepository {

   Future<List<Actor>> getActorsByMovieId(String movieId);
}
