import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailProvider =
    StateNotifierProvider<GetMovieNotifier, Map<String, Movie>>((ref) {
  final getMovieById = ref.watch(movieRepositoryProvider).getMovieById;
  return GetMovieNotifier(getMovie: getMovieById);
});

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class GetMovieNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;

  GetMovieNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
