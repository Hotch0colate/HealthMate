import 'package:client/Pages/testpage.dart';
import 'package:flutter/material.dart';

import '../Pages/profile.dart';
import '../Pages/select_talk.dart';
import '../controllers/button.dart';
import 'package:client/controllers/navigation.dart';


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
          title: const Text("Calendar Page"),
        ),
        body: CalendarPage(),
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
        ),
      );
  }
}
