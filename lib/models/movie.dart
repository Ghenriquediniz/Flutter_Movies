// models/movie.dart
import '../core/genre.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final List<int> genreIds;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  final String overview;
  final int budget;
  final List<String> productionCompanies;
  final String? director;
  final List<String> cast;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.overview,
    required this.budget,
    required this.productionCompanies,
    this.director,
    required this.cast,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final crew = (json['credits']?['crew'] as List<dynamic>? ?? []);
    final directorName =
        crew.firstWhere(
          (member) => member['job'] == 'Director',
          orElse: () => null,
        )?['name'] ??
        'Desconhecido';
    final castList =
        (json['credits']?['cast'] as List<dynamic>? ?? [])
            .map((e) => e['name'] as String)
            .take(10)
            .toList();

    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      genreIds:
          (json['genre_ids'] as List<dynamic>? ?? [])
              .map((e) => e as int)
              .toList(),
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: (json['release_date'] ?? '') as String,
      runtime: json['runtime'] ?? 0,
      overview: json['overview'] ?? '',
      budget: json['budget'] ?? 0,
      productionCompanies:
          (json['production_companies'] as List<dynamic>? ?? [])
              .map((e) => e['name'] as String)
              .toList(),
      director: directorName,
      cast: castList,
    );
  }

  List<String> get genreNames =>
      genreIds.map((id) => genreMap[id] ?? 'Desconhecido').toList();
}
