import 'package:flutter/material.dart';
import 'package:client/theme/theme.dart';

import 'package:client/Pages/calendar.dart';
import 'package:client/Pages/select_talk.dart';
import 'package:client/Pages/profile.dart';
import 'package:client/Pages/chatlog.dart';

class MainApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    Calendar(),
    SelectTalk(),
    ChatLog(
      uid: "pTw4p0fFpvRQAGlabQhHB47yUQr2",
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Note: Removed MaterialApp, directly returning the Scaffold now.
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        selectedItemColor: ColorTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month, size: 35),
            label: 'อารมณ์',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 35),
            label: 'ปรึกษา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 35),
            label: 'ข้อความ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: 'โปรไฟล์',
          ),
        ],
      ),
    );
  }
}
