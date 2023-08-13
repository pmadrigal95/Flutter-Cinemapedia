import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  static const name = 'movie_screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('MovieID: $movieId'),
    );
  }
}
