import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:moviex/models/movie_model.dart';

/// Handles all interactions with the local SQLite database. Movies are cached
/// per category so that trending and now playing lists can be stored
/// independently. Bookmarked movies are stored separately to allow quick
/// retrieval.

enum Category { NOW_PLAYING, TRENDING }

extension CategoryExtension on Category {
  String get value {
    switch (this) {
      case Category.NOW_PLAYING:
        return 'now_playing';
      case Category.TRENDING:
        return 'trending';
    }
  }
}

class DatabaseService {
  static const _dbName = 'moviex.db';
  static const _dbVersion = 1;

  static const String tableMovies = 'movies';
  static const String tableBookmarks = 'bookmarks';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableMovies (
            id INTEGER PRIMARY KEY,
            title TEXT,
            overview TEXT,
            posterPath TEXT,
            backdropPath TEXT,
            voteAverage REAL,
            releaseDate TEXT,
            originalLanguage TEXT,
            originalTitle TEXT,
            popularity REAL,
            voteCount INTEGER,
            category TEXT,
            orderIndex INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE $tableBookmarks (
            id INTEGER PRIMARY KEY,
            title TEXT,
            overview TEXT,
            posterPath TEXT,
            backdropPath TEXT,
            voteAverage REAL,
            releaseDate TEXT,
            originalLanguage TEXT,
            originalTitle TEXT,
            popularity REAL,
            voteCount INTEGER,
            category TEXT,
            orderIndex INTEGER

          )
        ''');
      },
    );
  }


  Future<void> cacheMovies(List<MovieModel> movies, Category category) async {
    final db = await database;
    await db.delete(tableMovies, where: 'category = ?', whereArgs: [category.value]);
    final batch = db.batch();
    for (int i = 0; i < movies.length; i++) {
      final movie = movies[i];
      final map = movie.toMap();
      map['category'] = category.value;
      map['orderIndex'] = i;
      batch.insert(tableMovies, map,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }


  Future<List<MovieModel>> getCachedMovies(Category category) async {
    final db = await database;
    final maps = await db.query(
      tableMovies,
      where: 'category = ?',
      whereArgs: [category.value],
      orderBy: 'orderIndex ASC',
    );
    return maps.map((map) => MovieModel.fromMap(map)).toList();
  }


  Future<void> addBookmark(MovieModel movie) async {
    final db = await database;
    await db.insert(
      tableBookmarks,
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<void> removeBookmark(int id) async {
    final db = await database;
    await db.delete(tableBookmarks, where: 'id = ?', whereArgs: [id]);
  }


  Future<List<MovieModel>> getBookmarks() async {
    final db = await database;
    final maps = await db.query(tableBookmarks);
    return maps.map((map) => MovieModel.fromMap(map)).toList();
  }


  Future<bool> isBookmarked(int id) async {
    final db = await database;
    final maps = await db.query(
      tableBookmarks,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.isNotEmpty;
  }
}