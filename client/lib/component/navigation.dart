import 'package:flutter/material.dart';
import 'package:client/theme/theme.dart';

import 'package:client/Pages/calendar.dart';
import 'package:client/Pages/select_talk.dart';
import 'package:client/Pages/profile.dart';
import 'package:client/Pages/chat_log.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedPage = 0;
  final List<Widget> _pageOptions = [
    Calendar(),
    SelectTalk(),
    ChatLog(
      uid: "pTw4p0fFpvRQAGlabQhHB47yUQr2",
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Demo',
      home: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBarApp(
          selectedIndex: _selectedPage,
          onItemTapped: (index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}

class BottomNavigationBarApp extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  BottomNavigationBarApp({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: ColorTheme.primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month,
            size: 35,
          ),
          label: 'อารมณ์',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
            size: 35,
          ),
          label: 'ปรึกษา',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message,
            size: 35,
          ),
          label: 'ข้อความ',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 35,
          ),
          label: 'โปรไฟล์',
        ),
      ],
    );
  }
}
