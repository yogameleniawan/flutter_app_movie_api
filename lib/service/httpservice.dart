import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pemrograman_mobile_week9/models/movie.dart';

class HttpService {
  final String apiKey = 'e43f16ce5e217b8f281aeab6a0ca58d0';
  final String baseUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=e43f16ce5e217b8f281aeab6a0ca58d0&language=en-US';
  final String baseUrlTop =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=e43f16ce5e217b8f281aeab6a0ca58d0&language=en-US';
  final String baseUrlUpcoming =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=e43f16ce5e217b8f281aeab6a0ca58d0&language=en-US';

  Future<List> getPopularMovies() async {
    final String uri = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      print("Sukses");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print("Fail");
      return null;
    }
  }

  Future<List> getTopMovies() async {
    final String uri = baseUrlTop + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      print("Sukses");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print("Fail");
      return null;
    }
  }

  Future<List> getUpcomingMovies() async {
    final String uri = baseUrlUpcoming + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      print("Sukses");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print("Fail");
      return null;
    }
  }
}
