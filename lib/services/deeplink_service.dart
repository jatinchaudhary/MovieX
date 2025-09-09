import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:moviex/pages/movie_detail_page.dart';
import 'package:moviex/services/network/api_repository.dart';

class DeeplinkService {
  static const String _baseUrl = 'https://moviex.app/movie';

  static String generateMovieLink(String movieId) {
    return '$_baseUrl?id=$movieId';
  }



  static StreamSubscription? listenForMovieLinks(BuildContext context, void Function(String movieId) onMovieLink) {
    final appLinks = AppLinks();
    return appLinks.uriLinkStream.listen((Uri uri) {
      final movieId = _parseMovieId(uri.toString());
      if (movieId != null) {
        onMovieLink(movieId);
      }
    });
  }

  static Future<void> handleInitialLink(BuildContext context, void Function(String movieId) onMovieLink) async {
    final appLinks = AppLinks();
    final Uri? initialUri = await appLinks.getInitialAppLink();
    final movieId = _parseMovieId(initialUri?.toString());
    if (movieId != null) {
      onMovieLink(movieId);
    }
  }

  static String? _parseMovieId(String? link) {
    if (link == null) return null;
    try {
      final uri = Uri.parse(link);
      if (uri.path == '/movie' && uri.queryParameters.containsKey('id')) {
        return uri.queryParameters['id'];
      }
    } catch (_) {}
    return null;
  }
}


/// Widget to handle deep links and navigate to MovieDetailPage
class DeeplinkHandler extends StatefulWidget {
  final Widget child;
  const DeeplinkHandler({required this.child});

  @override
  State<DeeplinkHandler> createState() => _DeeplinkHandlerState();
}

class _DeeplinkHandlerState extends State<DeeplinkHandler> {
  StreamSubscription? _sub;
  final ApiRepository _apiRepository = ApiRepository();

  @override
  void initState() {
    super.initState();
    DeeplinkService.handleInitialLink(context, _onMovieLink);
    _sub = DeeplinkService.listenForMovieLinks(context, _onMovieLink);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _onMovieLink(String movieId) async {
    if (movieId.isEmpty) return;
    final id = int.tryParse(movieId);
    if (id == null) return;
    final movie = await _apiRepository.fetchMovieDetails(id);
    if (!mounted || movie == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MovieDetailPage(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

