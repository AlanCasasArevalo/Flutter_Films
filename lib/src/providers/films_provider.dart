import 'dart:async';
import 'dart:convert';

import 'package:films/src/models/film_model.dart';
import 'package:http/http.dart' as http;

class FilmsProvider {
  String _apiKey = 'eb3289f4bb07a4659a97025942a3c2b7';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _isLoading = false;

  // Stream parte de React
  List<Film> _populars = new List();

  // Si no pones el broadcast NO SE PODRA ESCUCHAR POR OTROS WIDGETS
  final _popularsStreamController = StreamController<List<Film>>.broadcast();

  // Con agregamos la escucha de las peliculas
  Function(List<Film>) get popularsSink => _popularsStreamController.sink.add;

  // Con esto agregamos la escucha de los cambios de las peliculas recibidas
  Stream<List<Film>> get popularsStream => _popularsStreamController.stream;

  // Se necesita cerrar la conexion una vez que el popular se destrulla si no podriamos tener memory leaks, que otros widgets NO podran escuchar este stream etc
  void disposeStreams() {
    _popularsStreamController?.close();
  }

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

    if(_isLoading) return [];
    _isLoading = true;

    final uri = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final response = await _responseProcess(uri);

    // Agregamos las peliculas al Stream para que TODOS los Widgets pueden escuchar las pelis
    _populars.addAll(response);
    popularsSink(_populars);

    _isLoading = false;
    _popularPage++;
    
    return response;
  }
}
