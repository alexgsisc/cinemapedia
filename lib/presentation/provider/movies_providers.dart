import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
    return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies,
    );
  },
);

typedef MoviesCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MoviesCallBack fetchMoreMovies;
  //it is the first state
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNexPage() async {
    currentPage++;
    //add all movie in list
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    //
  }
}