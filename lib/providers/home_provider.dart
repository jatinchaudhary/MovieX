import 'package:flutter/material.dart';
import 'package:moviex/services/network/api_repository.dart';
import 'package:moviex/services/local_store/database_service.dart';
import 'package:moviex/services/connectivity/network_connectivity.dart';
import 'package:moviex/models/movie_model.dart';

class HomeProvider with ChangeNotifier {
	final ApiRepository _apiRepository;
	final DatabaseService _databaseService;
	final InternetConnectivity _connectivity;


		List<MovieModel> _trendingMovies = [];
		List<MovieModel> _nowPlayingMovies = [];
		bool _isLoading = false;
		String? _error;

		List<MovieModel> get trendingMovies => _trendingMovies;
		List<MovieModel> get nowPlayingMovies => _nowPlayingMovies;
		bool get isLoading => _isLoading;
		String? get error => _error;



	HomeProvider({
		ApiRepository? apiRepository,
		DatabaseService? databaseService,
		InternetConnectivity? connectivity,
	})  : _apiRepository = apiRepository ?? ApiRepository(),
				_databaseService = databaseService ?? DatabaseService(),
				_connectivity = connectivity ?? InternetConnectivity.instance;

			Future<void> fetchTrendingMovies() async {
				_isLoading = true;
				_error = null;
				notifyListeners();


				try {
					final online = await _connectivity.checkOnline();
          
          print('Online status: $online');

					if (online) {
						_trendingMovies = await _apiRepository.fetchTrendingMovies();
						await _databaseService.cacheMovies(_trendingMovies, Category.TRENDING);
					} else {
						_trendingMovies = await _databaseService.getCachedMovies(Category.TRENDING);
					}
				} catch (e) {
					_trendingMovies = [];
					_error = 'Failed to load trending movies.';
				}

				_isLoading = false;
				notifyListeners();
			}

			Future<void> fetchNowPlayingMovies() async {
				_isLoading = true;
				_error = null;
				notifyListeners();

						try {
							final online = await _connectivity.checkOnline();
							if (online) {
								_nowPlayingMovies = await _apiRepository.fetchNowPlayingMovies();
								await _databaseService.cacheMovies(_nowPlayingMovies, Category.NOW_PLAYING);
							} else {
								_nowPlayingMovies = await _databaseService.getCachedMovies(Category.NOW_PLAYING);
							}
						} catch (e) {
							_nowPlayingMovies = [];
							_error = 'Failed to load now playing movies.';
						}

				_isLoading = false;
				notifyListeners();
			}
}
