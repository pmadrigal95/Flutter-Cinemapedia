import 'package:cinemapedia/infrastructure/models/themoviedb/dates_from_themoviedb.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_from_themoviedb.dart';

class MovieDbResponse {
    MovieDbResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    final DatesFromTheMovieDb? dates;
    final int page;
    final List<MovieFromTheMovieDB> results;
    final int totalPages;
    final int totalResults;

    factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(
        dates: json["dates"] != null ? DatesFromTheMovieDb.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieFromTheMovieDB>.from(json["results"].map((x) => MovieFromTheMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}
