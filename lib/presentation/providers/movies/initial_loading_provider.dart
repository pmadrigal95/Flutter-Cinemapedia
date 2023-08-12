import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlaying = ref.watch(nowPlayingMoviesProvider).isEmpty;

  final popular = ref.watch(popularMoviesProvider).isEmpty;

  final upComing = ref.watch(upComingMoviesProvider).isEmpty;

  final topRated = ref.watch(topRatedMoviesProvider).isEmpty;

  if (nowPlaying || popular || upComing || topRated) return true;

  return false; // Terminamos de cargar
});
