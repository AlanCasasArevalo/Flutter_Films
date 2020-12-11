import 'dart:convert';

import 'package:films/src/models/film_model.dart';
import 'package:http/http.dart' as http;

class FilmsProvider {
  String _apiKey = 'eb3289f4bb07a4659a97025942a3c2b7';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Film>> _responseProcess(Uri uri) async {
    final response = await http.get(uri);
    final decodedData = json.decode(response.body);
    final films = new Films.fromJsonList(decodedData['results']);
    return films.films;
  }

  Future<List<Film>> getNowPlaying() async {
    final uri = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _responseProcess(uri);
  }

  Future<List<Film>> getPopular() async {
    final uri = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': _language});
    return await _responseProcess(uri);
  }
}
