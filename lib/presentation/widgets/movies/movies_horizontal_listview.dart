import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 350,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        children: [
          if (title != null || subtitle != null)
            _SectionHeader(
              title: title,
              subtitle: subtitle,
            ),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _ItemSlide(
                  movie: movies[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemSlide extends StatelessWidget {
  final Movie movie;

  const _ItemSlide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const CircularProgressIndicator(
                      strokeWidth: 2,
                    );
                  }
                  return FadeInRight(child: child);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //Title
          SizedBox(
            width: 150,
            height: 40,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleSmall,
            ),
          ),

          //Rating
          Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: Colors.yellow.shade800,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                '${movie.voteAverage}',
                style: textTheme.bodyMedium
                    ?.copyWith(color: Colors.yellow.shade800),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${movie.popularity}',
                style: textTheme.bodySmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _SectionHeader({
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(
                subtitle!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
        ],
      ),
    );
  }
}
