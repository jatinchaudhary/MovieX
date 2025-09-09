// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../movie_detailed_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailedResponseModel _$MovieDetailedResponseModelFromJson(
  Map<String, dynamic> json,
) => MovieDetailedResponseModel(
  adult: json['adult'] as bool?,
  backdropPath: json['backdrop_path'] as String?,
  belongsToCollection:
      json['belongs_to_collection'] == null
          ? null
          : BelongsToCollection.fromJson(
            json['belongs_to_collection'] as Map<String, dynamic>,
          ),
  budget: (json['budget'] as num?)?.toInt(),
  genres:
      (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
  homepage: json['homepage'] as String?,
  id: (json['id'] as num?)?.toInt(),
  imdbId: json['imdb_id'] as String?,
  originCountry:
      (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  originalLanguage: json['original_language'] as String?,
  originalTitle: json['original_title'] as String?,
  overview: json['overview'] as String?,
  popularity: (json['popularity'] as num?)?.toDouble(),
  posterPath: json['poster_path'] as String?,
  productionCompanies:
      (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
  productionCountries:
      (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
  releaseDate:
      json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
  revenue: (json['revenue'] as num?)?.toInt(),
  runtime: (json['runtime'] as num?)?.toInt(),
  spokenLanguages:
      (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
  status: json['status'] as String?,
  tagline: json['tagline'] as String?,
  title: json['title'] as String?,
  video: json['video'] as bool?,
  voteAverage: (json['vote_average'] as num?)?.toDouble(),
  voteCount: (json['vote_count'] as num?)?.toInt(),
);

BelongsToCollection _$BelongsToCollectionFromJson(Map<String, dynamic> json) =>
    BelongsToCollection(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
    );

Genre _$GenreFromJson(Map<String, dynamic> json) =>
    Genre(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) =>
    ProductionCompany(
      id: (json['id'] as num?)?.toInt(),
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String?,
      originCountry: json['origin_country'] as String?,
    );

ProductionCountry _$ProductionCountryFromJson(Map<String, dynamic> json) =>
    ProductionCountry(
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      englishName: json['english_name'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );
