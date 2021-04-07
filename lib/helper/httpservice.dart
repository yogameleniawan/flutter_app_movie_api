import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService {
  final String apiKey = 'e43f16ce5e217b8f281aeab6a0ca58d0';
  final String baseUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=e43f16ce5e217b8f281aeab6a0ca58d0&language=en-US';

  Future<String> getPopularMovies() async {
    final String uri = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      print("Sukses");
      String response = result.body;
      return response;
    } else {
      print("Fail");
      return null;
    }
  }
}
