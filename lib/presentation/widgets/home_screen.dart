import 'package:cinemapedia/presentation/provider/movies_providers.dart';
import 'package:cinemapedia/presentation/provider/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slide_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
  }

  @override
  Widget build(BuildContext context) {
    //final nowPlayinMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlider = ref.watch(moviesSlideShowProvider);
    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideShow(movies: moviesSlider),
      ],
    );
  }
}
