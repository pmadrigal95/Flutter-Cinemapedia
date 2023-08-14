

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorRepository = ref.watch(actorRepositoryProvider).getActorsByMovieId;

  return ActorsByMovieNotifier(getActors: actorRepository);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

///
/// {
///  '505642' : <Actor> []
/// }

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors  = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
