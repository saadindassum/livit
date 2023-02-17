import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livit/livit_icons.dart';
import 'package:livit/utils/colors.dart';
import 'package:livit/utils/global_var.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
              color: _page == 0 ? orangeColor : primaryColor,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Livit.livit_logo_v3,
              size: 29,
              color: _page == 1 ? orangeColor : primaryColor,
            ),
            label: 'EXPLORE',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              color: _page == 2 ? orangeColor : primaryColor,
            ),
            label: 'MESSAGE',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              size: 36,
              color: _page == 3 ? orangeColor : primaryColor,
            ),
            label: 'PROFILE',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
        activeColor: orangeColor,
        inactiveColor: primaryColor,
      ),
    );
  }
}
