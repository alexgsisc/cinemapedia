import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructura/response/movie_details.dart';
import 'package:cinemapedia/infraestructura/response/movie_remote.dart';

const String urlDefault =
    'https://www.wnpower.com/blog/wp-content/uploads/sites/3/2023/06/error-404-que-es.png';

class MovieMapper {
  static Movie moveRemoteToEntity(MoviewRemote movieRemote) => Movie(
        adult: movieRemote.adult,
        backdropPath: movieRemote.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movieRemote.backdropPath}'
            : urlDefault,
        genreIds: movieRemote.genreIds
            .map(
              (element) => element.toString(),
            )
            .toList(),
        id: movieRemote.id,
        originalLanguage: movieRemote.originalLanguage,
        originalTitle: movieRemote.originalTitle,
        overview: movieRemote.overview,
        popularity: movieRemote.popularity,
        posterPath: movieRemote.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movieRemote.posterPath}'
            : urlDefault,
        releaseDate: movieRemote.releaseDate,
        title: movieRemote.title,
        video: movieRemote.video,
        voteAverage: movieRemote.voteAverage,
        voteCount: movieRemote.voteCount,
      );

  static Movie movieDetailRemoteToEntity(MovieDetails movieRemote) => Movie(
        adult: movieRemote.adult,
        backdropPath: movieRemote.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movieRemote.backdropPath}'
            : urlDefault,
        genreIds: movieRemote.genres
            .map(
              (element) => element.name,
            )
            .toList(),
        id: movieRemote.id,
        originalLanguage: movieRemote.originalLanguage,
        originalTitle: movieRemote.originalTitle,
        overview: movieRemote.overview,
        popularity: movieRemote.popularity,
        posterPath: movieRemote.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movieRemote.posterPath}'
            : urlDefault,
        releaseDate: movieRemote.releaseDate,
        title: movieRemote.title,
        video: movieRemote.video,
        voteAverage: movieRemote.voteAverage,
        voteCount: movieRemote.voteCount,
      );
}
