import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

final recommendationsMoviesProvider =
    StateNotifierProvider<MoviesNotifier, Map<String, List<Movie>>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getRecommendations;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final similarMoviesProvider =
    StateNotifierProvider<MoviesNotifier, Map<String, List<Movie>>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getSimilar;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function(
    {required String id, int page});

class MoviesNotifier extends StateNotifier<Map<String, List<Movie>>> {
  // int currentPage = 1;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super({});

  Future<void> loadNextPage(String movieId) async {
    if (isLoading) return;
    if (state[movieId] != null) return;

    isLoading = true;

    final List<Movie> movies = await fetchMoreMovies(id: movieId, page: 1);

    state = {...state, movieId: movies};

    await Future.delayed(const Duration(milliseconds: 300));

    isLoading = false;
  }
}
