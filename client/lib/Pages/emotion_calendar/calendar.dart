import 'package:client/Pages/emotion_calendar/calendar_table.dart';
import '../emotion_calendar/add_emotion_widget.dart';


import 'package:client/theme/color.dart';
import 'package:flutter/material.dart';

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
        appBar: //AppBar Widget
        AppBar(
          flexibleSpace: Container(
            margin: const EdgeInsets.only(
                top: 40, left: 16
                ), 
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/logos/medium_app_name.png',
                width: 200,
                height: 40,
              ),
            ),
          ),
        ),
        body: const CalendarPage(),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: ThaiCalendarWithTable(),
            ),
          ),
        ),
        const SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
                showCustomDialog(context);
            },
            style: ElevatedButton.styleFrom(
              primary: ColorTheme.primaryColor, 
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0), 
              child: Icon(
                Icons.add, 
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
