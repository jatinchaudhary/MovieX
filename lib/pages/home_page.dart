
import 'package:flutter/material.dart';
import 'package:moviex/constants/api_constants.dart';
import 'package:moviex/providers/home_provider.dart';
import 'package:moviex/utils/custom_text_style.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moviex/pages/movie_detail_page.dart';
import 'dart:ui';
import 'package:moviex/pages/shimmers/shimmer_home_page_loader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _preloadedBackdrops = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheTrendingBackdrops();
  }

  void _precacheTrendingBackdrops() {
    final homeProvider = context.read<HomeProvider>();
    final trendingMovies = homeProvider.trendingMovies;
    for (final movie in trendingMovies) {
      if (movie.backdropPath != null) {
        final url = ApiConstants.imageLowQualityBaseUrl + movie.backdropPath!;
        if (!_preloadedBackdrops.contains(url)) {
          precacheImage(NetworkImage(url), context);
          _preloadedBackdrops.add(url);
        }
      }
    }
  }
  int _trendingIndex = 0;



  @override
  Widget build(BuildContext context) {
  final homeProvider = context.watch<HomeProvider>();
  final trendingMovies = homeProvider.trendingMovies;
  final backdropUrl = (trendingMovies.isNotEmpty && trendingMovies[_trendingIndex].backdropPath != null)
    ? ApiConstants.imageLowQualityBaseUrl + trendingMovies[_trendingIndex].backdropPath!
    : null;
  WidgetsBinding.instance.addPostFrameCallback((_) => _precacheTrendingBackdrops());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 700),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            layoutBuilder: (widget, list) => Stack(children: [if (widget != null) widget, ...list]),
            child: backdropUrl != null
                ? Stack(
                    key: ValueKey(backdropUrl),
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          backdropUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.black),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: Container(color: Colors.black.withOpacity(0.3)),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(color: Colors.black),
          ),
          SafeArea(
            child: homeProvider.isLoading
                ? ShimmerHomePageLoader()
                : homeProvider.error != null
                    ? Center(child: Text(homeProvider.error!, style: TextStyle(color: Colors.white)))
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,


                          children: [
                            SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Trending movies', style: CustomTextStyle.medium.copyWith(fontSize: 14, color: const Color.fromARGB(255, 255, 255, 255),letterSpacing: 1),),
                            ),
                            SizedBox(height: 12),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: MediaQuery.of(context).size.height * 0.58,
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.height,
                                enlargeFactor: 0.40,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.80,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 10),
                                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                                autoPlayCurve: Curves.easeInOut,
                                pauseAutoPlayOnTouch: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _trendingIndex = index;
                                  });
                                },
                              ),
                              items: trendingMovies.map((movie) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => MovieDetailPage(movie: movie),
                                          ),
                                        );
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        margin: EdgeInsets.only(left: 8, right: 8, bottom: 30),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black87,
                                              blurRadius: 18,
                                              offset: Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(24),
                                          child: movie.posterPath != null
                                              ? Image.network(
                                                  ApiConstants.imageBaseUrl + movie.posterPath!,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  errorBuilder: (context, error, stackTrace) => Container(
                                                    color: Colors.grey[800],
                                                    child: Icon(Icons.broken_image, color: Colors.white),
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.grey[800],
                                                  child: Icon(Icons.broken_image, color: Colors.white),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Now playing', style: CustomTextStyle.medium.copyWith(fontSize: 14, color: const Color.fromARGB(255, 255, 255, 255),letterSpacing: 1),),
                                  Spacer(),
                                  Text('See all', style: CustomTextStyle.regular.copyWith(fontSize: 10, color: const Color.fromARGB(255, 255, 255, 255),letterSpacing: 1),),

                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 150,
                                enlargeCenterPage: false,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.7,
                                initialPage: 1,
                              ),
                              items: homeProvider.nowPlayingMovies.map((movie) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () {
                                       Navigator.of(context).push(
                                         MaterialPageRoute(
                                         builder: (_) => MovieDetailPage(movie: movie),
                                            ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black54,
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: movie.posterPath != null
                                              ? Image.network(
                                                  ApiConstants.imageBaseUrl + movie.posterPath!,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  errorBuilder: (context, error, stackTrace) => Container(
                                                    color: Colors.grey[800],
                                                    child: Icon(Icons.broken_image, color: Colors.white),
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.grey[800],
                                                  child: Icon(Icons.broken_image, color: Colors.white),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}