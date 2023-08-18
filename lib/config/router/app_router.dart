import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/views/views.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) => HomeScreen(childView: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeView(),
          routes: [
             GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';
              return MovieScreen(
                movieId: movieId,
              );
            }),
          ]
        ),

        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesView(),
        ),
      ]),

  // Rutas padre / hijo
  // GoRoute(
  //     path: '/',
  //     name: HomeScreen.name,
  //     builder: (context, state) => const HomeScreen(childView: HomeView()),
  //     routes: [
  //       GoRoute(
  //           path: 'movie/:id',
  //           name: MovieScreen.name,
  //           builder: (context, state) {
  //             final movieId = state.pathParameters['id'] ?? 'no-id';
  //             return MovieScreen(
  //               movieId: movieId,
  //             );
  //           }),
  //     ]
  //     ),
]);
