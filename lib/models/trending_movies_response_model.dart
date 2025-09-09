import 'package:json_annotation/json_annotation.dart';

part 'generated_files/trending_movies_response_model.g.dart';

@JsonSerializable()
class TrendingMoviesResponseModel {
  TrendingMoviesResponseModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int? page;
  final List<Result>? results;

  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @JsonKey(name: 'total_results')
  final int? totalResults;

  factory TrendingMoviesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingMoviesResponseModelFromJson(json);
}

@JsonSerializable()
class Result {
  Result({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  @JsonKey(name: 'adult')
  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'media_type')
  final String? mediaType;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  @JsonKey(name: 'popularity')
  final double? popularity;

  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;

  @JsonKey(name: 'video')
  final bool? video;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
