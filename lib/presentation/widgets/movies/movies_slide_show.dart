import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideShow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      //height: MediaQuery.of(context).size.height * 0.25,
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.7,
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _ItemSlide(
          movie: movies[index],
        ),
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
      ),
    );
  }
}

class _ItemSlide extends StatelessWidget {
  final Movie movie;
  const _ItemSlide({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 10,
          offset: Offset(0, 10),
        )
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black54),
                );
              }
              return child;
            },
            errorBuilder: (_, __, ___) {
              return const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black54),
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white54,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
