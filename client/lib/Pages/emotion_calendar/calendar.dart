import 'package:client/Pages/testpage.dart';
import 'package:flutter/material.dart';

import '../profile/profile.dart';
import '../select_talk/select_talk.dart';
import '../../component/buttons.dart';
import '../../component/navigation.dart';


void main() {
  runApp(const Calendar());
}

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          
        ),
        body: CalendarPage(),
        bottomNavigationBar: BottomNavigationBarApp(selectedIndex: 0, onItemTapped: (int value) {  },),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Center(
        child: ThaiCalendarWithTable(),
        ),
      );
  }
}
