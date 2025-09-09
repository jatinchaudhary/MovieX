import 'package:flutter/material.dart';
import 'package:moviex/services/local_store/database_service.dart';
import 'package:moviex/models/movie_model.dart';

class BookmarkProvider with ChangeNotifier {
	final DatabaseService _databaseService;
	List<MovieModel> _bookmarks = [];
	bool _isLoading = false;
	String? _error;

	List<MovieModel> get bookmarks => _bookmarks;
	bool get isLoading => _isLoading;
	String? get error => _error;

	BookmarkProvider({DatabaseService? databaseService})
			: _databaseService = databaseService ?? DatabaseService();

	Future<void> loadBookmarks() async {
    print('Loading bookmarks...');
		_isLoading = true;
		_error = null;
		notifyListeners();
		try {
			_bookmarks = await _databaseService.getBookmarks();
		} catch (e) {
			_bookmarks = [];
			_error = 'Failed to load bookmarks.';
		}
		_isLoading = false;
		notifyListeners();
	}

	Future<void> addBookmark(MovieModel movie) async {
		try {
			await _databaseService.addBookmark(movie);
			await loadBookmarks();
		} catch (e) {
			_error = 'Failed to add bookmark.';
			notifyListeners();
		}
	}

	Future<void> removeBookmark(int id) async {
		try {
			await _databaseService.removeBookmark(id);
			await loadBookmarks();
		} catch (e) {
			_error = 'Failed to remove bookmark.';
			notifyListeners();
		}
	}

	Future<bool> isBookmarked(int id) async {
		try {
			return await _databaseService.isBookmarked(id);
		} catch (e) {
			_error = 'Failed to check bookmark.';
			notifyListeners();
			return false;
		}
	}
}
