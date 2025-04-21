import './api_key.dart';

class Api {
  static final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR";

  static String movieDetailsApi(int movieId) =>
      "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=pt-BR&append_to_response=credits";
}
