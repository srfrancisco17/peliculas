// ignore_for_file: non_constant_identifier_names, unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey = '3abda9fd858703f76cffd5745bed678e';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [page = 1]) async{
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body; 
  }

  getOnDisplayMovies() async{

    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);  
    
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async{

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);  
    
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
  
  Future<List<Cast>>getMovieCast(int movieId) async{
    //TODO revisar el mapa

    final jsonData = await this._getJsonData('3/movie/{$movieId}/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);  

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

}