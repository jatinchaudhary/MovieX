import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviex/pages/movie_detail_page.dart';
import 'package:moviex/utils/custom_text_style.dart';
import 'package:provider/provider.dart';
import 'package:moviex/providers/search_provider.dart';
import 'package:moviex/constants/api_constants.dart';
import 'package:moviex/models/movie_model.dart';
import 'package:moviex/pages/shimmers/shimmer_search_list.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = context.read<SearchProvider>().controller;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text(
              'Search',
              style: CustomTextStyle.bold.copyWith(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies',
                hintStyle: CustomTextStyle.regular.copyWith(color: Colors.white54,fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white24, width: 1),
                ),
                prefixIcon: const Icon(CupertinoIcons.search, color: Colors.white54),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () {
                          provider.clearSearch();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[900],
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              onChanged: (value) {
                provider.searchMovies(value);
              },
            ),
          ],
        ),
        toolbarHeight: 130,
      ),
    body: provider.isLoading
      ? const ShimmerSearchList()
          : provider.error != null
              ? Center(child: Text(provider.error!, style: const TextStyle(color: Colors.white)))
              : _controller.text.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: Colors.white24, size: 64),
                          const SizedBox(height: 16),
                          Text(
                            'Start typing to search for movies',
                            style: CustomTextStyle.regular.copyWith(color: Colors.white54, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Find your next favorite film!',
                            style: CustomTextStyle.regular.copyWith(color: Colors.white38, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : provider.searchResults.isEmpty
                      ? Center(child: Text('No movies found.', style: CustomTextStyle.regular.copyWith(color: Colors.white60, fontSize: 12)))
                      : ListView.separated(
                          itemCount: provider.searchResults.length,
                          itemBuilder: (context, index) {
                            final movie = provider.searchResults[index];
                            return _MovieListTile(movie: movie);
                          },
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Divider(color: Colors.white12, height: 1,)),
                        ),
    );
  }
}

class _MovieListTile extends StatelessWidget {
  final MovieModel movie;
  const _MovieListTile({required this.movie});

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
          style:  CustomTextStyle.medium.copyWith(color: Colors.white, fontSize: 14,),
        ),
        subtitle: Text(
          movie.overview ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.regular.copyWith(color: Colors.white70, fontSize: 8,),
        ),
      ),
    );
  }
}