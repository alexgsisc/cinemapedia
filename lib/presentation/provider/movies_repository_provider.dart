import 'package:cinemapedia/infraestructura/movies_datasource_impl.dart';
import 'package:cinemapedia/infraestructura/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio en in mutable, es solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(MoviesDatasourceImpl());
});
