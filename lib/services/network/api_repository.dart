import 'package:dio/dio.dart';
import 'package:moviex/services/network/retrofit.dart';
import 'package:moviex/constants/api_constants.dart';
import 'package:moviex/models/movie_model.dart';

class ApiRepository {
  late final RetrofitService _retrofitService;

  ApiRepository() {
    final dio = Dio();
    dio.options.queryParameters = {
      'api_key': ApiConstants.tmdbApiKey,
    };
    _retrofitService = RetrofitService(dio);
  }


  Future<List<MovieModel>> fetchTrendingMovies() async {
    try {
      final response = await _retrofitService.getTrendingMovies();
  final results = response.data.results ?? [];
      return MovieListModel.fromTrendingResults(results).movies;
    } catch (e) {
      // handle error
      return [];
    }
  }


  Future<List<MovieModel>> fetchNowPlayingMovies() async {
    try {
      final response = await _retrofitService.getNowPlayingMovies();
      final results = response.data.results ?? [];
      return MovieListModel.fromNowPlayingResults(results).movies;
    } catch (e) {
      // handle error
      return [];
    }
  }


  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await _retrofitService.searchMovies(query);
  final results = response.data.results ?? [];
      return MovieListModel.fromSearchResults(results).movies;
    } catch (e) {
      // handle error
      return [];
    }
  }

  Future<MovieModel?> fetchMovieDetails(int movieId) async {
    try {
      final response = await _retrofitService.getMovieDetails(movieId);
      final data = response.data;
      return MovieModel.fromMap({
        'id': data.id,
        'title': data.title,
        'overview': data.overview,
        'posterPath': data.posterPath,
        'releaseDate': data.releaseDate?.toIso8601String(),
        'voteAverage': data.voteAverage,
        'voteCount': data.voteCount,
        'backdropPath': data.backdropPath,
        'originalLanguage': data.originalLanguage,
        'originalTitle': data.originalTitle,
        'popularity': data.popularity,    
      });
    } catch (e) {
      // handle error
      return null;
    }
  }
}
