import 'package:flutter/material.dart';
import 'package:moviex/services/network/api_repository.dart';
import 'package:moviex/models/movie_model.dart';

import 'package:moviex/utils/debouncer.dart';

class SearchProvider with ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
	final ApiRepository _apiRepository;
	final Debouncer _debouncer = Debouncer(duration: const Duration(milliseconds: 400));
	List<MovieModel> _searchResults = [];
	bool _isLoading = false;
	String? _error;

	List<MovieModel> get searchResults => _searchResults;
	bool get isLoading => _isLoading;
	String? get error => _error;
  TextEditingController get controller => _controller;

	SearchProvider({ApiRepository? apiRepository})
			: _apiRepository = apiRepository ?? ApiRepository();

	void searchMovies(String query) {
		_debouncer.cancel();
		if (query.isEmpty) {
			_searchResults = [];
			_error = null;
			notifyListeners();
			return;
		}
		_debouncer.run(() async {
			_isLoading = true;
			_error = null;
			notifyListeners();
			try {
				final results = await _apiRepository.searchMovies(query);
				_searchResults = results;
			} catch (e) {
				_searchResults = [];
				_error = 'Failed to fetch search results.';
			}
			_isLoading = false;
			notifyListeners();
		});
	}


  void clearSearch() {
    _controller.text = "";
    _searchResults = [];
    _error = null;
    notifyListeners();
  }

	@override
	void dispose() {
		_debouncer.cancel();
		super.dispose();
	}
}
