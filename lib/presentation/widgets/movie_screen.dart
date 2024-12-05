import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/movie_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = "movie-screen";
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailProvider)[widget.movieId];

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieId: ${widget.movieId}'),
      ),
      body: Text(movie != null ? movie.title : 'Not fount'),
    );
  }
}
