import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:subscription_mobile_app/HomePage/FirstScreen.dart';
import 'package:subscription_mobile_app/LastPage/ColourSelector.dart';
import 'package:subscription_mobile_app/SecondPage/Second_Main.dart';
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
    SecondPage(),
    Center(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Second Data',
              style: Style.title.copyWith(
                color: Style.prime[50],
              ),
            ),
            Text(
              'Second Data',
              style: Style.title.copyWith(
                color: Style.prime[100],
              ),
            ),
            Text(
              'Second Data',
              style: Style.title.copyWith(
                color: Style.prime[200],
              ),
            ),
            Text(
              'Second Data',
              style: Style.title.copyWith(
                color: Style.prime[300],
              ),
            ),
            Text(
              'Second Data',
              style: Style.title.copyWith(
                color: Style.prime[400],
              ),
            ),
            Text(
              'Second Data primary dark 500',
              style: Style.title.copyWith(
                color: Style.prime[500],
              ),
            ),
            Text(
              'Second Data Normal Primary',
              style: Style.title.copyWith(
                color: Style.prime[500],
              ),
            ),
            Text(
              'Second Data',
              style: Style.title.copyWith(
                color: Style.prime[700],
              ),
            ),
            Text(
              'Second Data',
              style: Style.title.copyWith(
                color: Style.prime[900],
              ),
            ),
          ],
        ),
      ),
    ),
    Center(
      child: Container(
        child: Text('Third Data'),
      ),
    ),
    ColourPicker(),
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
        selectedItemColor: Style.prime.withOpacity(0.87),
        backgroundColor: Style.white,
        unselectedItemColor: Style.accent.withOpacity(0.32),
        paddingR: const EdgeInsets.only(bottom: 8, top: 8),
        onTap: (i) => setState(() => _currentIndex = i),
        dotIndicatorColor: Style.prime[700],
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
