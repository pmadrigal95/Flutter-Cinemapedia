import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/config/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_from_movie_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie_screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);

    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);

    ref
        .read(recommendationsMoviesProvider.notifier)
        .loadNextPage(widget.movieId);

    ref.read(similarMoviesProvider.notifier).loadNextPage(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) return const Scaffold(body: FullScreenLoader());

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1,
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) return const SizedBox();

                    return FadeIn(child: child);
                  },
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              // Descripcion
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleLarge,
                    ),
                    Text(
                      movie.overview,
                      style: textStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        _ActorsByMovieId(
          movieId: movie.id.toString(),
        ),
        _MovieList(
          movieId: movie.id.toString(),
        ),
        const SizedBox(
          width: 50,
        ),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      // shadowColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: _CustomStackSliverAppBar(
          moviePosterUrl: movie.posterPath,
        ),
      ),
    );
  }
}

class _CustomStackSliverAppBar extends StatelessWidget {
  final String moviePosterUrl;

  const _CustomStackSliverAppBar({required this.moviePosterUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            moviePosterUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) return const SizedBox();

              return FadeIn(child: child);
            },
          ),
        ),
        const _CustomGradientBox(
          isTop: false,
        ),
        const _CustomGradientBox(
          isTop: true,
        ),
      ],
    );
  }
}

class _CustomGradientBox extends StatelessWidget {
  final bool isTop;
  const _CustomGradientBox({required this.isTop});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: isTop ? Alignment.topLeft : Alignment.topCenter,
                  end: isTop ? Alignment.bottomLeft : Alignment.bottomCenter,
                  stops: isTop ? [0.0, 0.3] : [0.7, 1.0],
                  colors: isTop
                      ? [Colors.black87, Colors.transparent]
                      : [Colors.transparent, Colors.black87]))),
    );
  }
}

class _ActorsByMovieId extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovieId({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Actor>? actorsByMovieId =
        ref.watch(actorsByMovieProvider)[movieId];

    if (actorsByMovieId == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsByMovieId;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor Photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    actor.profilePath,
                    fit: BoxFit.cover,
                    height: 180,
                    width: 135,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) return const SizedBox();

                      return FadeInRight(child: child);
                    },
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                // Name

                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MovieList extends ConsumerWidget {
  final String movieId;

  const _MovieList({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Movie>? recommendationsMovies =
        ref.watch(recommendationsMoviesProvider)[movieId];

    final List<Movie>? similarMovies = ref.watch(similarMoviesProvider)[movieId];

    if (recommendationsMovies == null && similarMovies == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    return Column(
      children: [
        if (similarMovies != null)
          MovieHorizontalListview(
            movies: similarMovies,
            title: 'Películas Similares',
          ),
        if (recommendationsMovies != null)
          MovieHorizontalListview(
            movies: recommendationsMovies,
            title: 'Nuestra selección',
          ),
      ],
    );
  }
}
