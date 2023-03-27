// ignore_for_file: dead_code

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:movie_update/models/movies_details.dart';

class GetMovies {
  static String baseUrl = 'https://api.themoviedb.org/3';
  static String apiKey = 'a230630bbc58e1a0e2da2e984b3da0e5';
  static String imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';

  static Future<List<MoviesDetails>> getLatestMovies(
      {required String mediaType}) async {
    try {
      var url = Uri.parse('$baseUrl/trending/$mediaType/week?api_key=$apiKey');
      Response response = await get(
        url,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> body = await jsonDecode(response.body);
        List results = await body['results'];
        return List.generate(
          results.length,
          (index) => MoviesDetails(
            overView: results[index]['overview'],
            name: mediaType == 'movie'
                ? results[index]['title']
                : results[index]['name'],
            rating: results[index]['vote_average'],
            image:
                "https://image.tmdb.org/t/p/w500/${results[index]['poster_path']}",
          ),
        );
      } else if (response.statusCode == 401) {
        return Future.error(
          'Invalid api key',
        );
      } else if (response.statusCode == 404) {
        return Future.error(
          'Invalid request',
        );
      } else {
        return Future.error(
          response.statusCode,
        );
      }
    } catch (erorr) {
      return Future.error(
        erorr,
      );
    }
  }

  static Future<List<MoviesDetails>> searchMovie(
      {required String searchWord}) async {
    try {
      Uri uri = Uri.parse(
          '$baseUrl/search/movie?api_key=$apiKey&language=en-US&query=$searchWord&page=1&adult=false');
      Response response = await get(
        uri,
      );
      switch (response.statusCode) {
        case 200:
          Map result = await jsonDecode(response.body);
          List movieList = await result['results'];
          log(movieList.toString());
          return List.generate(
            movieList.length,
            (index) => MoviesDetails(
              overView: movieList[index]['overview'],
              name: movieList[index]['original_title'],
              rating: movieList[index]['vote_average'],
              image: movieList[index]['poster_path'],
            ),
          );
          break;
        case 401:
          return Future.error('invalid key');
          break;
        case 404:
          return Future.error('invalid request ');
          break;
        default:
          return Future.error('Something went wrong');
          break;
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
