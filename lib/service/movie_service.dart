import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../api/api_page.dart';

class MovieService {
  // 1. Método para buscar filmes populares
  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(Api.popularApi));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('Erro ao carregar filmes populares');
    }
  }

  // 2. Método para buscar detalhes de um filme específico
  Future<Movie> getMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(Api.movieDetailsApi(movieId)));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Extrai os IDs dos gêneros a partir da lista de objetos 'genres'
      final List<int> genreIds =
          (data['genres'] as List<dynamic>)
              .map((genre) => genre['id'] as int)
              .toList();

      // Adiciona os 'genre_ids' ao JSON antes de criar o objeto Movie
      final Map<String, dynamic> modifiedData = {
        ...data,
        'genre_ids': genreIds,
      };

      return Movie.fromJson(modifiedData);
    } else {
      throw Exception('Erro ao carregar detalhes do filme');
    }
  }
}
