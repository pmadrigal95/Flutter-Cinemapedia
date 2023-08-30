import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>(
  (ref) {
    final localStorageRepository = ref.watch(localStorageRepositoryProvider);

    return StorageMoviesNotifier(
        localStorageRepository: localStorageRepository);
  },
);

///
/// {
///   1234: Movie,
///   5678: Movie,
/// }
///

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;

  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMoviesMap = <int, Movie>{};

    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {
      ...state,
      ...tempMoviesMap,
    };

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);

    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);

      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }

  // Future<List<Movie>> loadNextPage() async {
  //   final movies = await localStorageRepository.loadMovies(
  //       offset: page * 10); //TODO Limit 20

  //   page++;

  //   final tempMoviesMap = <int, Movie>{};

  //   for (final movie in movies) {
  //     tempMoviesMap[movie.id] = movie;
  //   }

  //   state = {
  //     ...state,
  //     ...tempMoviesMap,
  //   };

  //   return movies;
  // }
}
