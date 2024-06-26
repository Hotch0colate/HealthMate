import 'package:client/Pages/emotion_calendar/calendar_table.dart';
import 'package:client/theme/font.dart';
import 'package:get/get.dart';
import '../emotion_calendar/add_emotion_widget.dart';

import 'package:client/theme/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calendar());
}

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: //AppBar Widget
      //     AppBar(
      //   flexibleSpace: Container(
      //     margin: const EdgeInsets.only(top: 80, left: 16),
      //     child: Align(
      //       alignment: Alignment.centerLeft,
      //       child: Image.asset(
      //         'assets/logos/medium_app_name.png',
      //         width: MediaQuery.of(context).size.width *
      //             2, // Adjust the factor as needed
      //         height: MediaQuery.of(context).size.width * 1,
      //       ),
      //     ),
      //   ),
      // ),
      body: const CalendarPage(),
      backgroundColor: ColorTheme.WhiteColor,
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  void refreshEmotionsCallback() {
    // Access the stateful widget and call the refresh function
    final state = calendarKey.currentState;
    state?.refreshEmotions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 40,),
        Image.asset('assets/logos/medium_app_name.png'),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Center(
              child: ThaiCalendarWithTable(key: calendarKey),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              showCustomDialog(context, refreshEmotionsCallback);
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
    ));
  }
}
