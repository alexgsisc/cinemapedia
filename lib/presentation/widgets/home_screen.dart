import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/provider/movies_providers.dart';
import 'package:cinemapedia/presentation/provider/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/buttom_bar/custom_buttom_navigation.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slide_show.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
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
    ref.read(popularMoviesProvider.notifier).loadNexPage();
    ref.read(upcomingMoviesProvider.notifier).loadNexPage();
    ref.read(topRatedMoviesProvider.notifier).loadNexPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(isLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayinMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlider = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRateMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _ColumSliverBody(
                moviesSlider: moviesSlider,
                nowPlayinMovies: nowPlayinMovies,
                popularMovies: popularMovies,
                upcomingMovies: upcomingMovies,
                topRateMovies: topRateMovies,
                ref: ref);
          }, childCount: 1),
        )
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final nowPlayinMovies = ref.watch(nowPlayingMoviesProvider);
  //   final moviesSlider = ref.watch(moviesSlideShowProvider);
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         const CustomAppbar(),
  //         MoviesSlideShow(movies: moviesSlider),
  //         MoviesHorizontalListview(
  //           movies: nowPlayinMovies,
  //           title: 'En cines',
  //           subtitle: 'Miercoles 27',
  //           loadNextPage: () {
  //             ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
  //           },
  //         ),
  //         MoviesHorizontalListview(
  //           movies: nowPlayinMovies,
  //           title: 'Proximamente',
  //           subtitle: 'en cine',
  //           loadNextPage: () {
  //             ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
  //           },
  //         ),
  //         MoviesHorizontalListview(
  //           movies: nowPlayinMovies,
  //           title: 'Populares',
  //           subtitle: 'Mes',
  //           loadNextPage: () {
  //             ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
  //           },
  //         ),
  //         MoviesHorizontalListview(
  //           movies: nowPlayinMovies,
  //           title: 'Mejor Calificadas',
  //           subtitle: 'Del mes',
  //           loadNextPage: () {
  //             ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
  //           },
  //         ),
  //         const SizedBox(
  //           height: 30,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class _ColumSliverBody extends StatelessWidget {
  final List<Movie> moviesSlider;
  final List<Movie> nowPlayinMovies;
  final List<Movie> popularMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> topRateMovies;
  final WidgetRef ref;

  const _ColumSliverBody({
    required this.moviesSlider,
    required this.nowPlayinMovies,
    required this.popularMovies,
    required this.upcomingMovies,
    required this.topRateMovies,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoviesSlideShow(movies: moviesSlider),
        MoviesHorizontalListview(
          movies: nowPlayinMovies,
          title: 'En cines',
          subtitle: 'Hoy',
          loadNextPage: () {
            ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
          },
        ),
        MoviesHorizontalListview(
          movies: upcomingMovies,
          title: 'Proximamente',
          subtitle: 'En cine',
          loadNextPage: () {
            ref.read(upcomingMoviesProvider.notifier).loadNexPage();
          },
        ),
        MoviesHorizontalListview(
          movies: popularMovies,
          title: 'Populares',
          subtitle: 'Del Mes',
          loadNextPage: () {
            ref.read(popularMoviesProvider.notifier).loadNexPage();
          },
        ),
        MoviesHorizontalListview(
          movies: topRateMovies,
          title: 'Mejor Calificadas',
          subtitle: 'Del Año',
          loadNextPage: () {
            ref.read(topRatedMoviesProvider.notifier).loadNexPage();
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
