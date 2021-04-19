import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuve/widgets/movies/discover_movie.dart';
import 'package:yuve/widgets/movies/home.dart';

class HomeMovie extends StatefulWidget {
  @override
  _HomeMovieState createState() => _HomeMovieState();
}

class _HomeMovieState extends State<HomeMovie> {
  int selectIndex = 0;

  final List<Widget> childWidget = [
    Home(),
    DiscoverMovie(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childWidget[selectIndex],
      bottomSheet: customBottomBar(context),
    );
  }

  Widget customBottomBar(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: selectIndex,
        backgroundColor: Colors.black26,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.brown,
        onTap: _onTapChangeWidget,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_view_day), label: "Coming soon"),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "Account"),
        ]);
  }

  void _onTapChangeWidget(int value) {
    setState(() {
      selectIndex = value;
    });
  }
}
