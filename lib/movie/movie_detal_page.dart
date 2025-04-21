import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão de Voltar + Título
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context, movie.title),
                        icon: Icon(Icons.arrow_back),
                        label: Text('Voltar'),
                      ),
                    ),
                    Center(
                      child: Text(
                        movie.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              //Poster
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 318,
                  ),
                ),
              ),
              SizedBox(height: 25),
              // Nota
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    children: [
                      TextSpan(
                        text: '${movie.voteAverage.toStringAsFixed(2)} ',
                      ),
                      TextSpan(
                        text: '/ 10',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ), // menor e um pouco mais suave
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              //Título
              Center(
                child: Column(
                  children: [
                    Text(
                      movie.title.toUpperCase(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    label: Text('Ano: ${movie.releaseDate.substring(0, 4)}'),
                  ),
                  SizedBox(width: 8),
                  Chip(
                    label: Text(
                      'Duração: ${movie.runtime ~/ 60}h ${movie.runtime % 60}m',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              //Genero
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Wrap(
                    spacing: 8,
                    children:
                        movie.genreNames
                            .map((g) => Chip(label: Text(g)))
                            .toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descrição', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text('${movie.overview} ', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ORÇAMENTO: ${movie.budget}'),
                      SizedBox(height: 8),
                      Text('Produtora:  ${movie.productionCompanies.first}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              //Diretor e Elenco
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Diretor', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text('${movie.director}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Elenco', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text(movie.cast.join(', '), style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
