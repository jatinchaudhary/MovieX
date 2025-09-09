import 'package:flutter/material.dart';
import 'package:moviex/home_screen.dart';
import 'package:moviex/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:moviex/providers/home_provider.dart';
import 'package:moviex/providers/bookmark_provider.dart';
import 'package:moviex/services/deeplink_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()..fetchNowPlayingMovies()..fetchTrendingMovies()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()..loadBookmarks()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        title: 'MovieX',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: DeeplinkHandler(child: const HomeScreen()),
      ),
    );
  }
}

