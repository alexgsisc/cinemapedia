import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructura/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructura/response/movie_tmdb_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MoviesDatasourceImpl extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      },
    ),
  );

  Future<List<Movie>> _jsonToMovie(Map<String, dynamic> json) async {
    final dataResponse = MovieTmdbResponse.fromJson(json);

    final List<Movie> movies = dataResponse.results
        .where((movie) => movie.title.isNotEmpty)
        .map((movieRemote) => MovieMapper.moveRemoteToEntity(movieRemote))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    debugPrint('${response.statusCode}');

    return _jsonToMovie(response.data);
  }
}
