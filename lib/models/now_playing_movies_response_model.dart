import 'package:json_annotation/json_annotation.dart';

part 'generated_files/now_playing_movies_response_model.g.dart';

@JsonSerializable()
class NowPlayingMoviesResponseModel {
    NowPlayingMoviesResponseModel({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    final Dates? dates;
    final int? page;
    final List<Result>? results;

    @JsonKey(name: 'total_pages') 
    final int? totalPages;

    @JsonKey(name: 'total_results') 
    final int? totalResults;

    factory NowPlayingMoviesResponseModel.fromJson(Map<String, dynamic> json) => _$NowPlayingMoviesResponseModelFromJson(json);

}

@JsonSerializable()
class Dates {
    Dates({
        required this.maximum,
        required this.minimum,
    });

    final DateTime? maximum;
    final DateTime? minimum;

    factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

}

@JsonSerializable()
class Result {
    Result({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
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
