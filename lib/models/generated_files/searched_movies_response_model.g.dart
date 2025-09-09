// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../searched_movies_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchedMoviesResponseModel _$SearchedMoviesResponseModelFromJson(
  Map<String, dynamic> json,
) => SearchedMoviesResponseModel(
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
  genreIds:
      (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
  id: (json['id'] as num?)?.toInt(),
  originalLanguage: json['original_language'] as String?,
  originalTitle: json['original_title'] as String?,
  overview: json['overview'] as String?,
  popularity: (json['popularity'] as num?)?.toDouble(),
  posterPath: json['poster_path'] as String?,
  releaseDate:
      json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
  title: json['title'] as String?,
  video: json['video'] as bool?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  voteCount: (json['vote_count'] as num?)?.toInt(),
);
