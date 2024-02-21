import 'package:flutter/material.dart';
import 'package:client/component/button.dart';

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
        body: CalendarPageBody(),
        
      ),
    );
  }
}

class CalendarPageBody extends StatelessWidget {
  const CalendarPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SecondaryButton(
            text: 'สวัสดี',
            onPressed: () {
              // Your button click logic here
              print('Button clicked');
            },
          ),
    );
  }
}
