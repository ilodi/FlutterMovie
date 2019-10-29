import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '41418ab2ed48d84b4453cfdaed57b18a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPages = 0;
  bool _cargando = false;

  //dinamica lista
  List<Pelicula> _populares = new List();

//Brodcast multiples widget lo van a escuchar
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

// Function de inicio

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

// Funcion de cierre/ESCuchar
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

//Metodo para cerrar Streams
  void disposeStreams() {
    _popularesStreamController?.close();
  }

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

    return await _procesarRespuesta(url);
  }

  //Method Populares
  Future<List<Pelicula>> getPopulares() async {

    if(_cargando) return [];


    _cargando = true;
    
    _popularesPages++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPages.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;
  }
}
