import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:films/src/models/film_model.dart';

class FilmsProvider {
  String _apiKey = 'eb3289f4bb07a4659a97025942a3c2b7';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Film>> getNowPlaying() async {
    
    final uri = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    final response = await http.get(uri);

    final decodedData = json.decode(response.body);

    final films = new Films.fromJsonList(decodedData['results']);
    return films.films;
  }
}