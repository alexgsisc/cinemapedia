import 'package:cinemapedia/presentation/provider/movies_providers.dart';
import 'package:cinemapedia/presentation/provider/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/buttom_bar/custom_buttom_navigation.dart';
import 'package:cinemapedia/presentation/widgets/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slide_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtomNavigation(),
    );
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
    final nowPlayinMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlider = ref.watch(moviesSlideShowProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppbar(),
          MoviesSlideShow(movies: moviesSlider),
          MoviesHorizontalListview(
            movies: nowPlayinMovies,
            title: 'En cines',
            subtitle: 'Miercoles 27',
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
            },
          ),
          MoviesHorizontalListview(
            movies: nowPlayinMovies,
            title: 'Proximamente',
            subtitle: 'en cine',
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
            },
          ),
          MoviesHorizontalListview(
            movies: nowPlayinMovies,
            title: 'Populares',
            subtitle: 'Mes',
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
            },
          ),
          MoviesHorizontalListview(
            movies: nowPlayinMovies,
            title: 'Mejor Calificadas',
            subtitle: 'Del mes',
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
