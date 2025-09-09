// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../trending_movies_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingMoviesResponseModel _$TrendingMoviesResponseModelFromJson(
  Map<String, dynamic> json,
) => TrendingMoviesResponseModel(
  page: (json['page'] as num?)?.toInt(),
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
  totalPages: (json['total_pages'] as num?)?.toInt(),
  totalResults: (json['total_results'] as num?)?.toInt(),
);

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  adult: json['adult'] as bool?,
  backdropPath: json['backdrop_path'] as String?,
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  originalTitle: json['original_title'] as String?,
  overview: json['overview'] as String?,
  posterPath: json['poster_path'] as String?,
  mediaType: json['media_type'] as String?,
  originalLanguage: json['original_language'] as String?,
  genreIds:
      (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
  popularity: (json['popularity'] as num?)?.toDouble(),
  releaseDate:
      json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
  video: json['video'] as bool?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  voteCount: (json['vote_count'] as num?)?.toInt(),
);
