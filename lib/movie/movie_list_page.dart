import 'package:flutter/material.dart';
import '../service/movie_service.dart';
import '../models/movie.dart';
import 'movie_detal_page.dart'; 

class PopularMoviesPage extends StatelessWidget {
  final MovieService movieService = MovieService();

  Future<List<Movie>> _fetchMoviesWithDetails() async {
    final movies = await movieService.getPopularMovies();

    // Agora adiciona detalhes a cada filme
    final moviesWithDetails = await Future.wait(
      movies.map((movie) async {
        final detailedMovie = await movieService.getMovieDetails(movie.id);
        return detailedMovie;
      }),
    );

    return moviesWithDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Movie>>(
        future: _fetchMoviesWithDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum filme encontrado.'));
          }

          final movies = snapshot.data!.take(3).toList(); //Filmes exibidos

          return CustomScrollView(
            slivers: [
              // AppBar
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 18.0,
                backgroundColor: Colors.blue,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                  title: Text('Filmes'),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),

              //Barra de procura
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Pesquise filmes',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              //Lista
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final movie = movies[index];

                  //Clicar para no filme > Detalhes do filmes
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailPage(movie: movie),
                        ),
                      );
                    },

                    //Card do filme,
                    child: Card(
                      elevation: 4,

                      margin: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ), //Entre posts

                      child: ClipRRect(
                        //Arrendador bordas
                        borderRadius: BorderRadius.circular(13),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //Img do baner
                            Stack(
                              alignment: Alignment.bottomCenter,
                              //Imagem
                              children: [
                                Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),

                                //Cor gradiente
                                Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        const Color.fromARGB(255, 0, 0, 0),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  //Possição do texto
                                  bottom: 50,
                                  left: 20,
                                  right: 5,

                                  //Título do filme
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      //Genero do filme
                                      Text(
                                        movie.genreNames.join(' • '),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }, childCount: movies.length),
              ),
            ],
          );
        },
      ),
    );
  }
}
