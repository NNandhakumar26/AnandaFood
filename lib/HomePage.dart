import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:subscription_mobile_app/HomePage/FirstScreen.dart';
import 'package:subscription_mobile_app/Theme.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _currentIndex = 0;
  List screen = [
    FirstScreen(),
    Center(
      child: Container(
        child: Text('Second Data'),
      ),
    ),
    Center(
      child: Container(
        child: Text('Third Data'),
      ),
    ),
    Center(
      child: Container(
        child: Text('Third Data'),
      ),
    ),
    Center(
      child: Container(
        child: Text('Third Data'),
      ),
    ),
    // FirstScreen(),
    // MainScreen(),
    // // SearchScreen(),
    // MealPlan(),
    // ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_currentIndex],
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _currentIndex,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Style.accent.withOpacity(0.2),
            spreadRadius: 0.05,
            offset: Offset(2.5, 3),
          )
        ],
        marginR: EdgeInsets.only(bottom: 16, top: 8, right: 16, left: 16),
        borderRadius: 8,
        selectedItemColor: Style.prime500.withOpacity(0.87),
        backgroundColor: Colors.white,
        unselectedItemColor: Style.accentDark.withOpacity(0.32),
        paddingR: const EdgeInsets.only(bottom: 8, top: 8),
        onTap: (i) => setState(() => _currentIndex = i),
        dotIndicatorColor: Style.prime700,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: Icon(Icons.home),
          ),

          /// Likes
          DotNavigationBarItem(
            icon: Icon(Icons.favorite_border),
          ),
          DotNavigationBarItem(
            icon: Icon(
              Icons.circle_notifications_outlined,
            ),
          ),

          /// Search
          DotNavigationBarItem(
            icon: Icon(Icons.search),
          ),

          /// Profile
          DotNavigationBarItem(
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
