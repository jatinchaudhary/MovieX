import 'package:dio/dio.dart';
import 'package:moviex/models/movie_detailed_response_model.dart';
import 'package:moviex/models/now_playing_movies_response_model.dart';
import 'package:moviex/models/searched_movies_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:moviex/constants/api_constants.dart';
import 'package:moviex/models/trending_movies_response_model.dart';

part 'retrofit.g.dart';


@RestApi(baseUrl: ApiConstants.tmdbBaseUrl)
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String baseUrl}) = _RetrofitService;

  @GET(ApiConstants.trendingMoviesPath)
  Future<HttpResponse<TrendingMoviesResponseModel>> getTrendingMovies();

  @GET(ApiConstants.nowPlayingMoviesPath)
  Future<HttpResponse<NowPlayingMoviesResponseModel>> getNowPlayingMovies();

  @GET(ApiConstants.searchedMoviesPath)
  Future<HttpResponse<SearchedMoviesResponseModel>> searchMovies(@Query('query') String query);

  @GET('${ApiConstants.movieDetailsPath}/{movie_id}')
  Future<HttpResponse<MovieDetailedResponseModel>> getMovieDetails(@Path('movie_id') int movieId);
}
