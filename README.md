# Desafio Flutter - App de Filmes

## Descrição

Este projeto é um desafio técnico em Flutter que consiste em consumir a API do The Movie DB e exibir os filmes populares em uma interface baseada no layout do Figma.

## Funcionalidades

- Tela de listagem de filmes populares:
  - Exibe imagem do pôster, título e nota.
  - Navegação para a tela de detalhes.
- Tela de detalhes do filme:
  - Exibe pôster grande, título, sinopse, data de lançamento, nota média e gêneros.

## API

- Base URL: `https://api.themoviedb.org/3`
- Endpoints utilizados:
  - Listar filmes populares: `/movie/popular`
  - Detalhes do filme: `/movie/{movie_id}`
- Parâmetros obrigatórios:  
  `?api_key=YOUR_API_KEY&language=pt-BR`

Crie uma conta gratuita em [The Movie DB](https://www.themoviedb.org/) para obter sua API key.

## Tecnologias Utilizadas

- Flutter
- `http` (requisições)
- `provider` ou `riverpod` (gerenciamento de estado)
- `cached_network_image` (carregamento de imagens)
- `flutter_dotenv` (variáveis de ambiente)

## Extras (opcional)

- Paginação infinita
- Animações entre telas
- Placeholder e carregamento de dados
- Testes unitários e de widget

## Layout

- Figma: [Desafio Flutter Traux](https://www.figma.com/file/b1qcGS8n2NJ3koOlgu0EnF/Desafio-Flutter-Traux?node-id=0%3A1)
