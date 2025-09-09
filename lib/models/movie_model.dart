
import 'package:moviex/models/trending_movies_response_model.dart' as trending;
import 'package:moviex/models/searched_movies_response_model.dart' as search;
import 'package:moviex/models/now_playing_movies_response_model.dart' as nowplaying;

/// The MovieModel DTO is designed to represent a movie in a consistent way, regardless of
/// which API endpoint the data comes from (trending, now playing, or search). This avoids
/// duplicating similar models for each API response and makes it easier to work with movie data
/// throughout the app.
///
/// Each API response (Trending, Now Playing, Search) has its own Result model, which may have
/// slight differences. The mapping functions (`fromTrendingResult`, `fromSearchResult`,
/// `fromNowPlayingResult`) convert those API-specific models into a single MovieModel format.
///
/// MovieListModel provides static helpers to map lists of results from each API into a list of
/// MovieModel, making it easy to display or process movies in a unified way.

class MovieListModel {
  final List<MovieModel> movies;

  MovieListModel({required this.movies});

  static MovieListModel fromTrendingResults(List<trending.Result> results) {
    return MovieListModel(
      movies: results.map((result) => MovieModel.fromTrendingResult(result)).toList(),
    );
  }

  static MovieListModel fromSearchResults(List<search.Result> results) {
    return MovieListModel(
      movies: results.map((result) => MovieModel.fromSearchResult(result)).toList(),
    );
  }

  static MovieListModel fromNowPlayingResults(List<nowplaying.Result> results) {
    return MovieListModel(
      movies: results.map((result) => MovieModel.fromNowPlayingResult(result)).toList(),
    );
  }
}

class MovieModel {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final int? orderIndex;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.orderIndex,
  });

  static MovieModel fromTrendingResult(trending.Result result) {
    return MovieModel(
      adult: result.adult,
      backdropPath: result.backdropPath,
      genreIds: result.genreIds,
      id: result.id,
      originalLanguage: result.originalLanguage,
      originalTitle: result.originalTitle,
      overview: result.overview,
      popularity: result.popularity,
      posterPath: result.posterPath,
      releaseDate: result.releaseDate,
      title: result.title,
      video: result.video,
      voteAverage: result.voteAverage,
      voteCount: result.voteCount,
    );
  }

  static MovieModel fromSearchResult(search.Result result) {
    return MovieModel(
      adult: result.adult,
      backdropPath: result.backdropPath,
      genreIds: result.genreIds,
      id: result.id,
      originalLanguage: result.originalLanguage,
      originalTitle: result.originalTitle,
      overview: result.overview,
      popularity: result.popularity,
      posterPath: result.posterPath,
      releaseDate: result.releaseDate,
      title: result.title,
      video: result.video,
      voteAverage: result.voteAverage,
      voteCount: result.voteCount,
    );
  }

  static MovieModel fromNowPlayingResult(nowplaying.Result result) {
    return MovieModel(
      adult: result.adult,
      backdropPath: result.backdropPath,
      genreIds: result.genreIds,
      id: result.id,
      originalLanguage: result.originalLanguage,
      originalTitle: result.originalTitle,
      overview: result.overview,
      popularity: result.popularity,
      posterPath: result.posterPath,
      releaseDate: result.releaseDate,
      title: result.title,
      video: result.video,
      voteAverage: result.voteAverage,
      voteCount: result.voteCount,
    );
  }


  static MovieModel fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int?,
      title: map['title'] as String?,
      overview: map['overview'] as String?,
      posterPath: map['posterPath'] as String?,
      backdropPath: map['backdropPath'] as String?,
      voteAverage: map['voteAverage'] is int
          ? (map['voteAverage'] as int).toDouble()
          : map['voteAverage'] as double?,
      releaseDate: map['releaseDate'] != null && map['releaseDate'] != ''
          ? DateTime.tryParse(map['releaseDate'])
          : null,
      originalLanguage: map['originalLanguage'] as String?,
      originalTitle: map['originalTitle'] as String?,
      popularity: map['popularity'] is int
          ? (map['popularity'] as int).toDouble()
          : map['popularity'] as double?,
      video: false,
      voteCount: map['voteCount'] as int?,
      orderIndex: map['orderIndex'] as int?,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'voteAverage': voteAverage,
      'releaseDate': releaseDate?.toIso8601String(),
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'popularity': popularity,
      'voteCount': voteCount,
      'orderIndex': orderIndex,
    };
  }
}
