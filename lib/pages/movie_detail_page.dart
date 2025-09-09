
import 'package:flutter/material.dart';
import 'package:moviex/models/movie_model.dart';
import 'package:moviex/constants/api_constants.dart';
import 'package:moviex/utils/custom_text_style.dart';
import 'package:provider/provider.dart';
import 'package:moviex/providers/bookmark_provider.dart';
import 'package:moviex/services/deeplink_service.dart';
import 'package:share_plus/share_plus.dart';



class MovieDetailPage extends StatefulWidget {
  final MovieModel movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailBodyState();
}

class _MovieDetailBodyState extends State<MovieDetailPage> {


  void _shareMovie() {
    final movieId = widget.movie.id?.toString();
    if (movieId != null) {
      final link = DeeplinkService.generateMovieLink(movieId);
      Share.share('Check out this movie on MovieX! $link');
    }
  }
  bool _isBookmarked = false;
  bool _loadingBookmark = true;

  @override
  void initState() {
    super.initState();
    _checkBookmark();
  }

  Future<void> _checkBookmark() async {
    final provider = context.read<BookmarkProvider>();
    final isBookmarked = await provider.isBookmarked(widget.movie.id ?? -1);
    setState(() {
      _isBookmarked = isBookmarked;
      _loadingBookmark = false;
    });
  }

  Future<void> _toggleBookmark() async {
    final provider = context.read<BookmarkProvider>();
    setState(() => _loadingBookmark = true);
    if (_isBookmarked) {
      await provider.removeBookmark(widget.movie.id ?? -1);
    } else {
      await provider.addBookmark(widget.movie);
    }
    await _checkBookmark();
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final posterUrl = movie.posterPath != null
        ? ApiConstants.imageBaseUrl + movie.posterPath!
        : null;
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 380,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  posterUrl != null
                      ? Image.network(
                          posterUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(color: Colors.grey[900]),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 32,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        movie.title ?? '',
                        style: CustomTextStyle.bold.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white, size: 26),
                tooltip: 'Share',
                onPressed: _shareMovie,
              ),
              _loadingBookmark
                  ? const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: _toggleBookmark,
                    ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movie.overview != null && movie.overview!.isNotEmpty) ...[
                    Text('Overview', style: CustomTextStyle.medium.copyWith(color: Colors.white70, fontSize: 18)),
                    const SizedBox(height: 8),
                    Text(
                      movie.overview!,
                      style: CustomTextStyle.regular.copyWith(color: Colors.white, fontSize: 10),
                    ),
                    const SizedBox(height: 20),
                  ],
                  Row(
                    children: [
                      if (movie.voteAverage != null)
                        _DetailChip(icon: Icons.star, label: movie.voteAverage!.toStringAsFixed(1)),
                      if (movie.releaseDate != null) ...[
                        const SizedBox(width: 12),
                        _DetailChip(icon: Icons.calendar_today, label: movie.releaseDate!.toLocal().toString().split(' ')[0]),
                      ],
                      if (movie.originalLanguage != null) ...[
                        const SizedBox(width: 12),
                        _DetailChip(icon: Icons.language, label: movie.originalLanguage!.toUpperCase()),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (movie.voteCount != null)
                    Text('Votes: ${movie.voteCount}', style: CustomTextStyle.regular.copyWith(color: Colors.white70, fontSize: 10)),
                  if (movie.popularity != null)
                    Text('Popularity: ${movie.popularity!.toStringAsFixed(1)}', style: CustomTextStyle.regular.copyWith(color: Colors.white70, fontSize: 10)),
                  if (movie.originalTitle != null && movie.originalTitle != movie.title)
                    Text('Original Title: ${movie.originalTitle}', style: CustomTextStyle.regular.copyWith(color: Colors.white70)),
                  if (movie.adult == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('18+ (Adult)', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _DetailChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 244, 212, 114), size: 18),
          const SizedBox(width: 6),
          Text(label, style:CustomTextStyle.regular.copyWith(color: Colors.white, fontSize: 8)),
        ],
      ),
    );
  }
}