import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '41418ab2ed48d84b4453cfdaed57b18a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  ///Optimizar

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);

    //Crear un mapa de un json para ser usadon en dart
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

//Method
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return  await _procesarRespuesta(url);
  }

  //Method Populares
  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });

    return  await _procesarRespuesta(url);
  }
}
