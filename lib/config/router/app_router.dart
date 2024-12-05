import 'package:cinemapedia/presentation/widgets/home_screen.dart';
import 'package:cinemapedia/presentation/widgets/movie_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: '/detail-movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        )
      ],
    ),
    // GoRoute(
    //   path: '/detail-movie/:id',
    //   name: MovieScreen.name,
    //   builder: (context, state) {
    //     final movieId = state.pathParameters['id'] ?? 'no-id';
    //     return MovieScreen(movieId: movieId);
    //   },
    // )
  ],
);
