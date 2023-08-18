import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();

    ref.read(popularMoviesProvider.notifier).loadNextPage();

    ref.read(upComingMoviesProvider.notifier).loadNextPage();

    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    final popularMovies = ref.watch(popularMoviesProvider);

    final upComingMovies = ref.watch(upComingMoviesProvider);

    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final slideShowMovies = ref.watch(moviesSlideShowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: CustomAppbar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideShow(movies: slideShowMovies),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En Cines',
              subTitle: DateFormat.yMMMMd('es').format(DateTime.now()),
              loadNextPage:
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
            ),
            MovieHorizontalListview(
              movies: upComingMovies,
              title: 'Próximamente',
              subTitle: 'Este mes',
              loadNextPage:
                  ref.read(upComingMoviesProvider.notifier).loadNextPage,
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              loadNextPage:
                  ref.read(popularMoviesProvider.notifier).loadNextPage,
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor Calificadas',
              subTitle: 'Desde Siempre',
              loadNextPage:
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      }, childCount: 1))
    ]);

    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       const CustomAppbar(),

    //       MoviesSlideShow(movies: slideShowMovies),

    //       MovieHorizontalListview(
    //         movies: nowPlayingMovies,
    //         title: 'En Cines',
    //         subTitle: DateFormat.yMMMMd('es').format(DateTime.now()),
    //         loadNextPage:
    //             ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
    //       ),

    //       MovieHorizontalListview(
    //         movies: nowPlayingMovies,
    //         title: 'Próximamente',
    //         subTitle: 'Este mes',
    //         loadNextPage:
    //             ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
    //       ),

    //       MovieHorizontalListview(
    //         movies: nowPlayingMovies,
    //         title: 'Populares',
    //         loadNextPage:
    //             ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
    //       ),

    //       MovieHorizontalListview(
    //         movies: nowPlayingMovies,
    //         title: 'Mejor Calificadas',
    //         subTitle: 'Desde Siempre',
    //         loadNextPage:
    //             ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
    //       ),

    //       const SizedBox(height: 10,),

    //       // Expanded(
    //       //   child: ListView.builder(
    //       //     itemCount: nowPlayingMovies.length,
    //       //     itemBuilder: (context, index) {
    //       //       final movie = nowPlayingMovies[index];
    //       //       return ListTile(
    //       //         title: Text(movie.title),
    //       //       );
    //       //     },
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}