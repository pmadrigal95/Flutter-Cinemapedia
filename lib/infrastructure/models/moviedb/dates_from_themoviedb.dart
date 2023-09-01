class DatesFromTheMovieDb {
    DatesFromTheMovieDb({
        required this.maximum,
        required this.minimum,
    });

    final DateTime maximum;
    final DateTime minimum;

    factory DatesFromTheMovieDb.fromJson(Map<String, dynamic> json) => DatesFromTheMovieDb(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}