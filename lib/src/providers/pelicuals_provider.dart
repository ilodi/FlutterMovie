import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '41418ab2ed48d84b4453cfdaed57b18a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

//Method
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);

    //Crear un mapa de un json para ser usadon en dart
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return [];
  }
}
