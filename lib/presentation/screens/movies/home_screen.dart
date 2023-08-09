
import 'package:flutter/material.dart';

import 'package:cinemapedia/config/constants/enviroment.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(Environment.theMovieDbKey),
      ),
    );
  }
}
