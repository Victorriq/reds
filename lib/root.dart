import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:reds/screens/events.dart';
import 'package:reds/screens/home.dart';
import 'package:reds/screens/notifications.dart';
import 'package:reds/screens/profile.dart';
import 'package:reds/screens/upload.dart';


class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    EventsPage(),
    UploadPage(),
    NotisPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        index: _currentIndex,
        backgroundColor: Colors.black,
        items: const [
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
