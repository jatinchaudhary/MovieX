
import 'package:flutter/material.dart';
import 'package:moviex/pages/movie_detail_page.dart';
import 'package:moviex/utils/custom_text_style.dart';
import 'package:provider/provider.dart';
import 'package:moviex/providers/bookmark_provider.dart';
import 'package:moviex/constants/api_constants.dart';
import 'package:moviex/models/movie_model.dart';


class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<BookmarkProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 24.0,),
          child: Text('Bookmarks', style: CustomTextStyle.bold.copyWith(color: Colors.white, fontSize: 22),
              ),
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
              ? Center(child: Text(provider.error!, style: const TextStyle(color: Colors.white)))
              : provider.bookmarks.isEmpty
                  ? Center(child: Text('No bookmarks yet.', style: CustomTextStyle.regular.copyWith(color: Colors.white, fontSize: 12),
            ),)
                  : Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: ListView.builder(
                        itemCount: provider.bookmarks.length,
                        itemBuilder: (context, index) {
                          final movie = provider.bookmarks[index];
                          return Dismissible(
                            key: ValueKey(movie.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              color: Colors.red[700],
                              child: const Icon(Icons.delete, color: Colors.white, size: 32),
                            ),
                            onDismissed: (_) {
                              provider.removeBookmark(movie.id!);
                            },
                            child: _BookmarkListTile(
                              movie: movie,
                              onRemove: () => provider.removeBookmark(movie.id!),
                            ),
                          );
                        },
                      ),
                  ),
    );
  }
}

class _BookmarkListTile extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onRemove;
  const _BookmarkListTile({required this.movie, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailPage(movie: movie),
           ),
         );
      },
      child: ListTile(
        leading: movie.posterPath != null
            ? Image.network(
                ApiConstants.imageLowQualityBaseUrl + movie.posterPath!,
                width: 48,
                fit: BoxFit.cover,
              )
            : Container(
                width: 48,
                color: Colors.grey[800],
                child: const Icon(Icons.broken_image, color: Colors.white),
              ),
        title: Text(
          movie.title ?? 'No Title',
          style: CustomTextStyle.medium.copyWith(color: Colors.white, fontSize: 14,),
          
        ),
        subtitle: Text(
          movie.overview ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.regular.copyWith(color: Colors.white70, fontSize: 8,),
        ),
        trailing: InkWell(
          onTap: () {
            context.read<BookmarkProvider>().removeBookmark(movie.id!);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white54, size: 12,),
              onPressed: onRemove,
            ),
          ),
        ),
      ),
    );
  }
}