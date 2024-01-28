import 'package:flutter/material.dart';
import 'package:client/theme/theme.dart';

import 'package:client/page/calendar.dart';
import 'package:client/page/select_talk.dart';
import 'package:client/page/chatlog.dart';
import 'package:client/page/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    Calendar(),
    SelectTalk(),
    Chatlog(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buttom Navigation Bar Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,  // Set the selected item color
          type: BottomNavigationBarType.fixed, // Set the type to fixed
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month,size: 35,),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people,size: 35,),
              label: 'Talk',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message,size: 35,),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 35,),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}