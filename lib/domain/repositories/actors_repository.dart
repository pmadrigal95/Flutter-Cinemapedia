import 'package:cinemapedia/domain/entities/entities.dart';

abstract class ActorsRepository {

  Future<List<Actor>> getActorsByMovie( String movieId );

}