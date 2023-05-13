class Movie {
  int id;
  bool video;
  bool adult;
  String title;
  int voteCount;
  num popularity;
  num voteAverage;
  String overview;
  String posterPath;
  List<int> genreIds;
  String backdropPath;
  String originalTitle;
  DateTime releaseDate;
  String originalLanguage;

  Movie({
    required this.id,
    required this.adult,
    required this.title,
    required this.video,
    required this.genreIds,
    required this.overview,
    required this.voteCount,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.backdropPath,
    required this.originalTitle,
    required this.originalLanguage,
  });

  Movie.fromJson(dynamic json)
      : id = json['id'],
        adult = json['adult'],
        title = json['title'],
        video = json['video'],
        overview = json['overview'],
        voteCount = json['vote_count'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        voteAverage = json['vote_average'],
        backdropPath = json['backdrop_path'],
        originalTitle = json['original_title'],
        originalLanguage = json['original_language'],
        genreIds = List<int>.from(json['genre_ids']),
        releaseDate = DateTime.parse(json['release_date']);

  static List<Movie> fromList(List list) {
    return list.map(Movie.fromJson).toList();
  }
}
