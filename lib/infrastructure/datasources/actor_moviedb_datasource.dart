import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/config/domain/datasources/actor_datasources.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/credits_response.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';

/// dio === axios

class ActorMovieDbDatasource extends ActorDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    if (response.statusCode != 200) {
      throw Exception('Actors with movie id: $movieId not found!');
    }

    return CreditsResponse.fromJson(response.data)
        .cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
  }
}
