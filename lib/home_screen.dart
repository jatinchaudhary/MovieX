import 'package:moviex/pages/bookmark_page.dart';
import 'package:moviex/services/connectivity/connection_banner.dart';
import 'package:flutter/material.dart';
import 'package:moviex/pages/home_page.dart';
import 'dart:ui';
import 'package:moviex/pages/search_page.dart';
import 'package:moviex/providers/search_provider.dart';
import 'package:moviex/utils/custom_nav_icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final pages = [
    _KeepAlivePage(child: HomePage()),
    _KeepAlivePage(child: SearchPage()),
    _KeepAlivePage(child: BookmarkPage()),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: Stack(
        
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: pages,
            onPageChanged: (value) {
              FocusScope.of(context).unfocus();
              context.read<SearchProvider>().clearSearch();            },
          ),
          ConnectionBanner(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: BottomNavigationBar(
              enableFeedback: false,
              backgroundColor: const Color.fromARGB(20, 0, 0, 0),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              currentIndex: _currentIndex,
              onTap: _onTap,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: CustomNavIcon(
                    icon: Icons.home_filled,
                    isActive: _currentIndex == 0,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: CustomNavIcon(
                    icon: Icons.search,
                    isActive: _currentIndex == 1,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: CustomNavIcon(
                    icon: Icons.bookmark,
                    isActive: _currentIndex == 2,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KeepAlivePage extends StatefulWidget {
  final Widget child;
  const _KeepAlivePage({required this.child});

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
